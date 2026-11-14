package com.teacode.service;

import com.teacode.dto.AttemptDto;
import com.teacode.dto.AttemptFinishedDto;
import com.teacode.entity.Attempt;
import com.teacode.entity.Problem;
import com.teacode.enums.Visibility;
import com.teacode.exception.NotFoundException;
import com.teacode.repository.AttemptRepository;
import com.teacode.repository.ProblemRepository;
import java.time.Clock;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

/**
 * Server-side solve timer. All times come from the server clock, so reloads and second tabs agree.
 * The unique index on (user, problem, active_flag) guarantees one open attempt even under races.
 */
@Service
public class AttemptService {

    private final AttemptRepository attempts;
    private final ProblemRepository problems;
    private final RateLimiter limiter;
    private final TransactionTemplate tx;
    private final Clock clock;

    public AttemptService(AttemptRepository attempts, ProblemRepository problems, RateLimiter limiter,
                          TransactionTemplate tx, Clock clock) {
        this.attempts = attempts;
        this.problems = problems;
        this.limiter = limiter;
        this.tx = tx;
        this.clock = clock;
    }

    private LocalDateTime now() {
        return LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
    }

    /** Idempotent: returns the open attempt, creating one if there is none. */
    public AttemptDto start(long userId, String slug) {
        limiter.check("attempt-start", Long.toString(userId), 120, Duration.ofMinutes(10));
        Problem problem = problems.findBySlugAndVisibility(slug, Visibility.PUBLISHED.name())
                .orElseThrow(() -> new NotFoundException("Problem not found."));
        Attempt attempt = attempts.findActive(userId, problem.getId()).orElse(null);
        if (attempt == null) {
            try {
                attempt = tx.execute(status -> attempts.saveAndFlush(new Attempt(userId, problem.getId(), now())));
            } catch (DataIntegrityViolationException e) {
                // Another request opened the attempt first: use that one.
                attempt = attempts.findActive(userId, problem.getId()).orElseThrow();
            }
        }
        return new AttemptDto(attempt.getId(), attempt.getStartedAt().toInstant(ZoneOffset.UTC), clock.instant());
    }

    /** Idempotent: finishing a finished attempt returns the stored elapsed time. */
    public AttemptFinishedDto finish(long userId, long attemptId) {
        Attempt a = attempts.findByIdAndUserId(attemptId, userId).orElseThrow(() -> new NotFoundException("Attempt not found."));
        if (a.getFinishedAt() != null) {
            return new AttemptFinishedDto(a.getElapsedMs() == null ? 0 : a.getElapsedMs());
        }
        LocalDateTime now = now();
        long elapsed = Math.max(0, Duration.between(a.getStartedAt(), now).toMillis());
        if (attempts.finish(attemptId, userId, now, elapsed) == 0) {
            // Finished concurrently: report the stored value.
            Attempt fresh = attempts.findByIdAndUserId(attemptId, userId).orElseThrow();
            return new AttemptFinishedDto(fresh.getElapsedMs() == null ? elapsed : fresh.getElapsedMs());
        }
        return new AttemptFinishedDto(elapsed);
    }
}
