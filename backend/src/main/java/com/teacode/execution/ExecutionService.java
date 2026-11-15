package com.teacode.execution;

import com.teacode.config.AppProperties;
import com.teacode.entity.Problem;
import com.teacode.entity.Submission;
import com.teacode.entity.SubmissionJob;
import com.teacode.entity.TestCase;
import com.teacode.entity.User;
import com.teacode.enums.Visibility;
import com.teacode.exception.ApiException;
import com.teacode.exception.BadRequestException;
import com.teacode.exception.ForbiddenException;
import com.teacode.exception.NotFoundException;
import com.teacode.exception.ServiceUnavailableException;
import com.teacode.exception.TooManyRequestsException;
import com.teacode.exception.UnauthorizedException;
import com.teacode.repository.ProblemRepository;
import com.teacode.repository.SubmissionJobRepository;
import com.teacode.repository.SubmissionRepository;
import com.teacode.repository.TestCaseRepository;
import com.teacode.repository.UserRepository;
import com.teacode.service.RateLimiter;
import org.springframework.http.HttpStatus;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Clock;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.RejectedExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

/**
 * Runs user code through JDoodle. A request creates a durable job and returns its id; a bounded worker pool
 * executes it and stores the verdict. Nothing is simulated: if JDoodle is unavailable the job fails with a
 * stable error code and is never turned into Wrong Answer or Accepted.
 *
 * <p>Cost model: JDoodle has no batch API, so each test case is one call (one credit). Judging stops at the
 * first failing case (the remaining cases are reported as NOT_RUN) and compiled languages spend one extra
 * compile-only call so compile errors are reported as such. Calls are never retried automatically.
 *
 * <p>Hidden test data never leaves this class: only sample cases get input, expected output, actual output
 * and error text in the stored result. JDoodle returns compile errors, runtime failures and time-outs as
 * ordinary text in {@code output}; labels other than the compile step and the CPU-time limit are therefore
 * heuristics (see {@link OutputSignals}) and are applied only to output that did not match.
 */
@Service
public class ExecutionService {

    private static final Logger log = LoggerFactory.getLogger(ExecutionService.class);

    public enum Mode { RUN, SUBMIT, TERMINAL }

    static final int MAX_ACTIVE_JOBS_PER_USER = 2;
    private static final int CAP_STREAM = 10_000;
    private static final int CAP_CASE_TEXT = 4_000;
    private static final int CAP_COMPILE = 5_000;

    /** Everything the worker needs, copied so no JPA entity crosses threads. */
    private record ProblemSpec(long id, String comparisonMode, Double tolerance, double timeLimit, int memoryLimitKb,
                               int hiddenCount) {
    }

    /** Failure that ends a job with a stable error code. */
    static final class JobFailure extends RuntimeException {
        final String code;

        JobFailure(String code) {
            super(code);
            this.code = code;
        }
    }

    private final JdoodleClient jdoodle;
    private final LanguageRegistry languages;
    private final ProblemRepository problems;
    private final TestCaseRepository testCases;
    private final SubmissionRepository submissions;
    private final SubmissionJobRepository jobs;
    private final UserRepository users;
    private final RateLimiter limiter;
    private final ExecutorService executor;
    private final ObjectMapper json;
    private final TransactionTemplate tx;
    private final AppProperties props;
    private final Clock clock;

    public ExecutionService(JdoodleClient jdoodle, LanguageRegistry languages, ProblemRepository problems,
                            TestCaseRepository testCases, SubmissionRepository submissions, SubmissionJobRepository jobs,
                            UserRepository users, RateLimiter limiter,
                            @Qualifier("executionExecutor") ExecutorService executor, ObjectMapper json,
                            TransactionTemplate tx, AppProperties props, Clock clock) {
        this.jdoodle = jdoodle;
        this.languages = languages;
        this.problems = problems;
        this.testCases = testCases;
        this.submissions = submissions;
        this.jobs = jobs;
        this.users = users;
        this.limiter = limiter;
        this.executor = executor;
        this.json = json;
        this.tx = tx;
        this.props = props;
        this.clock = clock;
    }

    private LocalDateTime now() {
        return LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
    }

    private static ApiException unprocessable(String code, String message) {
        return new ApiException(HttpStatus.UNPROCESSABLE_ENTITY, code, message);
    }

    // ---------------------------------------------------------------- request side

    /** Validates, enforces limits, stores a QUEUED job and hands it to the worker pool. Returns the job id. */
    public String start(Long userId, Mode mode, String problemSlug, String languageKey, String source, String stdin) {
        User user = userId == null ? null : users.findById(userId).filter(User::isActive)
                .orElseThrow(() -> new UnauthorizedException("Not signed in."));
        if (mode != Mode.TERMINAL && user == null) {
            throw new UnauthorizedException("Not signed in.");
        }
        if (mode != Mode.TERMINAL && !"false".equalsIgnoreCase(System.getenv("TEACODE_REQUIRE_EMAIL_VERIFICATION")) && !user.isEmailVerified()) {
            throw new ForbiddenException("EMAIL_NOT_VERIFIED", "Verify your email address to run code.");
        }
        if (!languages.isConfigured()) {
            throw new ServiceUnavailableException(JdoodleClient.NOT_CONFIGURED,
                    "Code execution is not configured on this server.");
        }
        LanguageRegistry.Lang lang = languages.find(languageKey)
                .orElseThrow(() -> new BadRequestException("That language is not available."));

        ProblemSpec spec = null;
        if (mode != Mode.TERMINAL) {
            Problem p = problems.findBySlugAndVisibility(problemSlug, Visibility.PUBLISHED.name())
                    .orElseThrow(() -> new NotFoundException("Problem not found."));
            if (!lang.judgeable()) {
                throw unprocessable("LANGUAGE_NOT_SUPPORTED_FOR_PROBLEMS",
                        "This language can only be used in the free-form compiler, not for problems.");
            }
            if (!"STDIN".equals(p.getExecutionModel())) {
                throw unprocessable("EXECUTION_MODEL_UNSUPPORTED",
                        "This problem needs a function-based harness, which is not available for it.");
            }
            long samples = testCases.countByProblemIdAndSampleCase(p.getId(), true);
            long hidden = testCases.countByProblemIdAndSampleCase(p.getId(), false);
            long needed = mode == Mode.SUBMIT ? samples + hidden : samples;
            if (needed == 0) {
                throw unprocessable("TEST_DATA_UNAVAILABLE", mode == Mode.SUBMIT
                        ? "No test data is available for this problem, so it cannot be judged."
                        : "No sample tests are available for this problem.");
            }
            if (needed > props.jdoodle().maxTestsPerSubmission()) {
                throw unprocessable("TEST_SUITE_TOO_LARGE",
                        "This problem has more tests than this server is configured to run in one submission.");
            }
            spec = new ProblemSpec(p.getId(), p.getComparisonMode(), p.getFloatTolerance(),
                    p.getTimeLimitSeconds().doubleValue(), p.getMemoryLimitKb(), (int) hidden);
        }

        // Anonymous compiler use has a shared conservative rate bucket and a shared active-job cap.
        // This prevents account creation from being a prerequisite while still limiting unauthenticated abuse.
        limiter.check("exec-" + mode, userId == null ? "anonymous" : Long.toString(userId), mode == Mode.SUBMIT ? 10 : 20, Duration.ofMinutes(1));
        long activeJobs = userId == null
                ? jobs.countByUserIdIsNullAndStateIn(List.of(SubmissionJob.QUEUED, SubmissionJob.RUNNING))
                : jobs.countActive(userId);
        if (activeJobs >= MAX_ACTIVE_JOBS_PER_USER) {
            throw new TooManyRequestsException();
        }

        String jobId = UUID.randomUUID().toString();
        jobs.saveAndFlush(new SubmissionJob(jobId, userId, mode.name()));

        final ProblemSpec finalSpec = spec;
        try {
            executor.execute(() -> work(jobId, userId, mode, finalSpec, lang, source, stdin));
        } catch (RejectedExecutionException e) {
            jobs.finish(jobId, SubmissionJob.FAILED, null, "EXECUTION_BUSY", null);
            throw new ServiceUnavailableException("EXECUTION_BUSY", "The execution queue is full. Please try again shortly.");
        }
        return jobId;
    }

    /** Owner-only. Another user's job id looks exactly like a missing one. */
    public JobResponse job(Long userId, String jobId) {
        SubmissionJob job = jobs.findByIdAndUserId(jobId, userId).orElseThrow(() -> new NotFoundException("Job not found."));
        JobResult result = null;
        if (job.getResultJson() != null) {
            try {
                result = json.readValue(job.getResultJson(), JobResult.class);
            } catch (JsonProcessingException e) {
                log.error("Stored result of job {} is unreadable", jobId);
            }
        }
        return JobResponse.of(job.getState(), job.getErrorCode(), result);
    }

    // ---------------------------------------------------------------- worker side

    private void work(String jobId, Long userId, Mode mode, ProblemSpec spec, LanguageRegistry.Lang lang, String source, String stdin) {
        try {
            if (jobs.markRunning(jobId) == 0) {
                return; // already failed by the stale-job sweep
            }
            long deadline = System.nanoTime() + Duration.ofSeconds(props.jdoodle().jobDeadlineSeconds()).toNanos();
            JobResult result = mode == Mode.TERMINAL
                    ? runTerminal(lang, source, stdin, deadline)
                    : judge(spec, lang, source, mode == Mode.SUBMIT, deadline);
            String body = json.writeValueAsString(result);
            if (mode == Mode.SUBMIT) {
                tx.executeWithoutResult(status -> {
                    Submission saved = submissions.save(new Submission(userId, spec.id(), lang.key(), source, result.status(),
                            result.executionTimeMs() == null ? null : BigDecimal.valueOf(result.executionTimeMs()).movePointLeft(3).setScale(3, RoundingMode.HALF_UP),
                            result.memoryKb(), result.passedTests() == null ? 0 : result.passedTests(),
                            result.totalTests() == null ? 0 : result.totalTests()));
                    jobs.finish(jobId, SubmissionJob.COMPLETED, body, null, saved.getId());
                });
            } else {
                jobs.finish(jobId, SubmissionJob.COMPLETED, body, null, null);
            }
        } catch (JobFailure e) {
            jobs.finish(jobId, SubmissionJob.FAILED, null, e.code, null);
        } catch (ServiceUnavailableException e) {
            jobs.finish(jobId, SubmissionJob.FAILED, null, e.getCode(), null);
        } catch (Exception e) {
            log.error("Job {} failed unexpectedly: {}", jobId, e.getClass().getSimpleName());
            jobs.finish(jobId, SubmissionJob.FAILED, null, "INTERNAL_ERROR", null);
        }
    }

    private static void checkDeadline(long deadlineNanos) {
        if (System.nanoTime() > deadlineNanos) {
            throw new JobFailure("EXECUTION_TIMEOUT");
        }
    }

    /** Compile-only call for compiled languages. Returns the compiler output when compilation failed, else null. */
    private String compileError(LanguageRegistry.Lang lang, String source) {
        if (!lang.compiled()) {
            return null;
        }
        JdoodleClient.Result c = jdoodle.execute(new JdoodleClient.RunSpec(lang.jdoodleLanguage(), lang.versionIndex(), source, null, true));
        if (c.compilationStatus() != null && c.compilationStatus() == 1) {
            return cap(c.output(), CAP_COMPILE);
        }
        return null;
    }

    private JobResult runTerminal(LanguageRegistry.Lang lang, String source, String stdin, long deadline) {
        String compileOutput = compileError(lang, source);
        if (compileOutput != null) {
            return new JobResult("COMPILATION_ERROR", null, null, null, null, compileOutput, null, null, null);
        }
        checkDeadline(deadline);
        JdoodleClient.Result r = jdoodle.execute(new JdoodleClient.RunSpec(lang.jdoodleLanguage(), lang.versionIndex(), source, stdin, false));
        String status = switch (OutputSignals.classify(r.output())) {
            case TIME_LIMIT -> "TIME_LIMIT_EXCEEDED";
            case RUNTIME_ERROR -> "RUNTIME_ERROR";
            case NONE -> "FINISHED"; // JDoodle reports no exit status: "finished" means it returned output
        };
        // JDoodle merges stdout and stderr into one stream, so the whole stream is returned as output.
        return new JobResult(status, null, null, toMs(r.cpuSeconds()), r.memory(), null, cap(r.output(), CAP_STREAM), null, null);
    }

    private JobResult judge(ProblemSpec spec, LanguageRegistry.Lang lang, String source, boolean all, long deadline) {
        List<TestCase> cases = all
                ? testCases.findAllForJudging(spec.id())
                : testCases.findSamplesByProblemId(spec.id());
        if (cases.isEmpty()) {
            throw new JobFailure("TEST_DATA_UNAVAILABLE");
        }
        String compileOutput = compileError(lang, source);
        if (compileOutput != null) {
            return new JobResult("COMPILATION_ERROR", 0, cases.size(), null, null, compileOutput, null, null, List.of());
        }

        List<JobResult.CaseResult> views = new ArrayList<>();
        int sampleIdx = 0;
        int hiddenIdx = 0;
        int passed = 0;
        int maxMs = 0;
        int maxMem = 0;
        String overall = null;
        for (TestCase tc : cases) {
            boolean sample = tc.isSampleCase();
            int index = sample ? ++sampleIdx : ++hiddenIdx;
            if (overall != null) {
                // Stopped at the first failing case to save JDoodle credits.
                views.add(new JobResult.CaseResult(index, sample, "NOT_RUN", null, null, null, null, null, null));
                continue;
            }
            checkDeadline(deadline);
            JdoodleClient.Result r = jdoodle.execute(new JdoodleClient.RunSpec(
                    lang.jdoodleLanguage(), lang.versionIndex(), source, tc.getInputData(), false));
            String verdict = verdict(r, tc, spec);
            Integer ms = toMs(r.cpuSeconds());
            maxMs = Math.max(maxMs, ms == null ? 0 : ms);
            maxMem = Math.max(maxMem, r.memory() == null ? 0 : r.memory());
            if ("ACCEPTED".equals(verdict)) {
                passed++;
            } else {
                overall = verdict;
            }
            views.add(sample
                    ? new JobResult.CaseResult(index, true, verdict, ms, r.memory(), cap(tc.getInputData(), CAP_CASE_TEXT),
                            cap(tc.getExpectedOutput(), CAP_CASE_TEXT), cap(r.output(), CAP_CASE_TEXT), null)
                    // Hidden case: verdict and resource use only.
                    : new JobResult.CaseResult(index, false, verdict, ms, r.memory(), null, null, null, null));
        }
        if (overall == null) {
            // Every executed case passed. Only a submission checked against hidden tests can be Accepted.
            overall = all
                    ? (spec.hiddenCount() > 0 ? "ACCEPTED" : "INSUFFICIENT_VERIFICATION")
                    : "SAMPLES_PASSED";
        }
        return new JobResult(overall, passed, cases.size(), maxMs, maxMem, null, null, null, views);
    }

    private String verdict(JdoodleClient.Result r, TestCase tc, ProblemSpec spec) {
        if (r.cpuSeconds() != null && r.cpuSeconds() > spec.timeLimit()) {
            return "TIME_LIMIT_EXCEEDED";
        }
        if (OutputComparator.matches(spec.comparisonMode(), tc.getExpectedOutput(), r.output(), spec.tolerance())) {
            return "ACCEPTED";
        }
        return switch (OutputSignals.classify(r.output())) {
            case TIME_LIMIT -> "TIME_LIMIT_EXCEEDED";
            case RUNTIME_ERROR -> "RUNTIME_ERROR";
            case NONE -> "WRONG_ANSWER";
        };
    }

    private static Integer toMs(Double seconds) {
        return seconds == null ? null : (int) Math.round(seconds * 1000);
    }

    static String cap(String s, int max) {
        if (s == null) {
            return null;
        }
        return s.length() <= max ? s : s.substring(0, max) + "\n… (output truncated)";
    }
}
