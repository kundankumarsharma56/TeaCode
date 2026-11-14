package com.teacode;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.authentication;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.teacode.security.AuthUser;
import com.teacode.service.AuthMailer;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;
import okhttp3.mockwebserver.Dispatcher;
import okhttp3.mockwebserver.MockResponse;
import okhttp3.mockwebserver.MockWebServer;
import okhttp3.mockwebserver.RecordedRequest;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.RequestPostProcessor;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/**
 * Execution flow against real MySQL (Flyway schema) and a local stand-in for the JDoodle HTTP API.
 * The stand-in is a TEST DOUBLE at the network boundary only: it picks its "program output" from a marker in the
 * submitted script (UPPER, WRONG, CE, RTE_ECHO) because no real code runs here, and it uses fake credentials.
 * What is under test is what TeaCode does with JDoodle's answers: verdicts, hidden-case redaction, ownership,
 * limits, honest failure and persistence. Nothing here proves JDoodle itself behaves this way.
 */
@Testcontainers
@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource(properties = {
        "teacode.public-url=http://localhost",
        "teacode.security.jwt-secret=test-only-secret-that-is-long-enough-0123456789",
        "teacode.security.cookie-secure=false",
        "teacode.jdoodle.client-id=fake-client-id",
        "teacode.jdoodle.client-secret=fake-client-secret",
        "teacode.jdoodle.read-timeout-seconds=5"
})
class ExecutionApiIT {

    private static final String HIDDEN_INPUT = "hiddenSECRETinput";
    private static final ObjectMapper JSON = new ObjectMapper();

    @Container
    static final MySQLContainer<?> MYSQL = new MySQLContainer<>("mysql:8.4")
            .withCommand("--character-set-server=utf8mb4", "--collation-server=utf8mb4_0900_ai_ci");

    static final MockWebServer JDOODLE = new MockWebServer();
    static final List<JsonNode> CALLS = new CopyOnWriteArrayList<>();
    static volatile boolean jdoodleDown;

    @BeforeAll
    static void startJdoodle() throws Exception {
        JDOODLE.setDispatcher(new Dispatcher() {
            @Override
            public MockResponse dispatch(RecordedRequest r) {
                try {
                    if (jdoodleDown) {
                        return new MockResponse().setResponseCode(503);
                    }
                    JsonNode body = JSON.readTree(r.getBody().readUtf8());
                    CALLS.add(body);
                    String src = body.get("script").asText();
                    String stdin = body.hasNonNull("stdin") ? body.get("stdin").asText() : "";
                    boolean compileOnly = body.hasNonNull("compileOnly") && body.get("compileOnly").asBoolean();
                    if (compileOnly) {
                        boolean bad = src.contains("CE");
                        return json(JSON.writeValueAsString(Map.of("output", bad ? "Main.java:1: error: ';' expected" : "",
                                "statusCode", 200, "compilationStatus", bad ? 1 : 0)));
                    }
                    String out = stdin.toUpperCase();
                    if (src.contains("WRONG")) {
                        out = "nope";
                    } else if (src.contains("RTE_HIDDEN") && stdin.equals(HIDDEN_INPUT)) {
                        out = "Traceback (most recent call last)\ncrash while reading " + stdin; // would leak the input if forwarded
                    }
                    return json(JSON.writeValueAsString(Map.of("output", out, "statusCode", 200, "memory", "1024", "cpuTime", "0.01")));
                } catch (Exception e) {
                    return new MockResponse().setResponseCode(500);
                }
            }
        });
        JDOODLE.start();
    }

    @AfterAll
    static void stopJdoodle() throws Exception {
        JDOODLE.shutdown();
    }

    private static MockResponse json(String body) {
        return new MockResponse().setHeader("Content-Type", "application/json").setBody(body);
    }

    @DynamicPropertySource
    static void props(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", MYSQL::getJdbcUrl);
        registry.add("spring.datasource.username", MYSQL::getUsername);
        registry.add("spring.datasource.password", MYSQL::getPassword);
        registry.add("teacode.jdoodle.base-url", () -> JDOODLE.url("/").toString());
    }

    @MockitoBean
    AuthMailer mailer;

    @Autowired
    MockMvc mvc;

    @Autowired
    JdbcTemplate jdbc;

    long verifiedUser;
    long otherUser;
    long unverifiedUser;

    @BeforeEach
    void seed() {
        jdoodleDown = false;
        CALLS.clear();
        for (String t : new String[] {"problem_timers", "attempts", "user_problem_progress", "submission_jobs", "submissions", "test_cases", "problems", "users"}) {
            jdbc.update("delete from " + t);
        }
        verifiedUser = user("ada", "ada@example.com", true);
        otherUser = user("bob", "bob@example.com", true);
        unverifiedUser = user("eve", "eve@example.com", false);

        jdbc.update("insert into problems (title, slug, description, difficulty, visibility) values ('Shout','shout','Upper-case it','EASY','PUBLISHED')");
        long p = jdbc.queryForObject("select id from problems where slug='shout'", Long.class);
        testCase(p, "abc", "ABC", true, 1);
        testCase(p, HIDDEN_INPUT, HIDDEN_INPUT.toUpperCase(), false, 2);
        jdbc.update("insert into problems (title, slug, description, difficulty, visibility) values ('Draft','draft','x','EASY','DRAFT')");
    }

    private long user(String name, String email, boolean verified) {
        jdbc.update("insert into users (username, email, password_hash, email_verified) values (?,?,?,?)", name, email, "x", verified);
        return jdbc.queryForObject("select id from users where username=?", Long.class, name);
    }

    private void testCase(long problem, String in, String out, boolean sample, int order) {
        jdbc.update("insert into test_cases (problem_id, input_data, expected_output, sample_case, sort_order) values (?,?,?,?,?)",
                problem, in, out, sample, order);
    }

    private static RequestPostProcessor as(long id, String name) {
        return authentication(new UsernamePasswordAuthenticationToken(new AuthUser(id, name, "USER", 1L), null, List.of()));
    }

    private String start(String path, long uid, String name, String body) throws Exception {
        String res = mvc.perform(post(path).with(as(uid, name)).with(csrf()).contentType(MediaType.APPLICATION_JSON).content(body))
                .andExpect(status().isAccepted()).andReturn().getResponse().getContentAsString();
        return JSON.readTree(res).get("jobId").asText();
    }

    private JsonNode await(String jobId, long uid, String name) throws Exception {
        long end = System.currentTimeMillis() + 15_000;
        while (System.currentTimeMillis() < end) {
            String res = mvc.perform(get("/api/v1/submissions/jobs/" + jobId).with(as(uid, name)))
                    .andExpect(status().isOk()).andReturn().getResponse().getContentAsString();
            JsonNode n = JSON.readTree(res);
            if (n.get("state").asText().equals("COMPLETED") || n.get("state").asText().equals("FAILED")) {
                return n;
            }
            Thread.sleep(25);
        }
        throw new AssertionError("job did not finish");
    }

    private static String body(String slug, String lang, String source) {
        return "{\"problemSlug\":\"" + slug + "\",\"language\":\"" + lang + "\",\"sourceCode\":\"" + source + "\"}";
    }

    // ------------------------------------------------------------------ languages

    @Test
    void fifteenJudgeableLanguagesAndSqlPlaygroundAreOfferedWhenCredentialsAreConfigured() throws Exception {
        mvc.perform(get("/api/v1/execution/languages"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(16))
                .andExpect(jsonPath("$[?(@.key=='dart')].extension").value(".dart"))
                .andExpect(jsonPath("$[?(@.key=='java')].name").value("Java"))
                .andExpect(jsonPath("$[?(@.key=='sql')].kind").value("DATABASE"))
                .andExpect(content().string(org.hamcrest.Matchers.not(org.hamcrest.Matchers.containsString("fake-client"))));
    }

    // ------------------------------------------------------------------ run / submit

    @Test
    void runJudgesSamplesOnlyStoresNothingAndNeverSaysAccepted() throws Exception {
        JsonNode job = await(start("/api/v1/submissions/run", verifiedUser, "ada", body("shout", "python", "UPPER")), verifiedUser, "ada");
        assertThat(job.get("state").asText()).isEqualTo("COMPLETED");
        assertThat(job.get("status").asText()).isEqualTo("SAMPLES_PASSED");
        assertThat(job.get("totalTests").asInt()).isEqualTo(1);
        assertThat(job.get("cases").get(0).get("input").asText()).isEqualTo("abc");
        assertThat(job.toString()).doesNotContain(HIDDEN_INPUT);
        assertThat(jdbc.queryForObject("select count(*) from submissions", Integer.class)).isZero();
        assertThat(CALLS).noneMatch(c -> c.path("stdin").asText().equals(HIDDEN_INPUT));
    }

    @Test
    void jdoodleReceivesTheConfiguredLanguageIdentifierAndVersionIndex() throws Exception {
        await(start("/api/v1/submissions/run", verifiedUser, "ada", body("shout", "python", "UPPER")), verifiedUser, "ada");
        assertThat(CALLS).isNotEmpty();
        assertThat(CALLS.get(0).get("language").asText()).isEqualTo("python3");
        assertThat(CALLS.get(0).get("versionIndex").asText()).isEqualTo("6");
        assertThat(CALLS.get(0).get("clientId").asText()).isEqualTo("fake-client-id");
    }

    @Test
    void submitJudgesAllCasesRedactsHiddenOnesAndProgressComesFromSubmissions() throws Exception {
        JsonNode job = await(start("/api/v1/submissions/submit", verifiedUser, "ada", body("shout", "python", "UPPER")), verifiedUser, "ada");
        assertThat(job.get("status").asText()).isEqualTo("ACCEPTED");
        assertThat(job.get("passedTests").asInt()).isEqualTo(2);
        JsonNode hidden = job.get("cases").get(1);
        assertThat(hidden.get("sample").asBoolean()).isFalse();
        assertThat(hidden.has("input")).isFalse();
        assertThat(hidden.has("expected")).isFalse();
        assertThat(hidden.has("actual")).isFalse();
        assertThat(job.toString()).doesNotContain(HIDDEN_INPUT).doesNotContain(HIDDEN_INPUT.toUpperCase());

        assertThat(jdbc.queryForObject("select status from submissions", String.class)).isEqualTo("ACCEPTED");
        mvc.perform(get("/api/v1/dashboard/summary").with(as(verifiedUser, "ada")))
                .andExpect(jsonPath("$.solvedCount").value(1)).andExpect(jsonPath("$.totalSubmissions").value(1))
                .andExpect(jsonPath("$.acceptedSubmissions").value(1)).andExpect(jsonPath("$.acceptanceRate").value(100.0));
        mvc.perform(get("/api/v1/problems").with(as(verifiedUser, "ada"))).andExpect(jsonPath("$.items[0].solved").value(true));
        mvc.perform(get("/api/v1/problems").with(as(otherUser, "bob"))).andExpect(jsonPath("$.items[0].solved").value(false));
        mvc.perform(get("/api/v1/dashboard/languages").with(as(verifiedUser, "ada")))
                .andExpect(jsonPath("$[0].language").value("python")).andExpect(jsonPath("$[0].accepted").value(1));
    }

    @Test
    void aProblemWithOnlySampleTestsCanNeverBeAccepted() throws Exception {
        jdbc.update("insert into problems (title, slug, description, difficulty, visibility) values ('Echo','echo','x','EASY','PUBLISHED')");
        long p = jdbc.queryForObject("select id from problems where slug='echo'", Long.class);
        testCase(p, "abc", "ABC", true, 1);
        JsonNode job = await(start("/api/v1/submissions/submit", verifiedUser, "ada", body("echo", "python", "UPPER")), verifiedUser, "ada");
        assertThat(job.get("status").asText()).isEqualTo("INSUFFICIENT_VERIFICATION");
        mvc.perform(get("/api/v1/dashboard/summary").with(as(verifiedUser, "ada")))
                .andExpect(jsonPath("$.solvedCount").value(0)).andExpect(jsonPath("$.acceptedSubmissions").value(0))
                .andExpect(jsonPath("$.totalSubmissions").value(1)).andExpect(jsonPath("$.acceptanceRate").doesNotExist());
        mvc.perform(get("/api/v1/problems/echo")).andExpect(jsonPath("$.testDataStatus").value("SAMPLES_ONLY"));
    }

    @Test
    void wrongAnswerStopsAtTheFirstFailureToSaveCredits() throws Exception {
        JsonNode job = await(start("/api/v1/submissions/submit", verifiedUser, "ada", body("shout", "python", "WRONG")), verifiedUser, "ada");
        assertThat(job.get("status").asText()).isEqualTo("WRONG_ANSWER");
        assertThat(job.get("passedTests").asInt()).isZero();
        assertThat(job.get("cases").get(1).get("status").asText()).isEqualTo("NOT_RUN");
        assertThat(CALLS).hasSize(1);
        assertThat(job.toString()).doesNotContain(HIDDEN_INPUT);
        mvc.perform(get("/api/v1/dashboard/summary").with(as(verifiedUser, "ada")))
                .andExpect(jsonPath("$.solvedCount").value(0)).andExpect(jsonPath("$.acceptanceRate").value(0.0));
    }

    @Test
    void runtimeErrorOutputIsNeverReturnedForHiddenCases() throws Exception {
        JsonNode job = await(start("/api/v1/submissions/submit", verifiedUser, "ada", body("shout", "python", "UPPER RTE_HIDDEN")), verifiedUser, "ada");
        assertThat(job.get("status").asText()).isEqualTo("RUNTIME_ERROR");
        JsonNode hidden = job.get("cases").get(1);
        assertThat(hidden.get("status").asText()).isEqualTo("RUNTIME_ERROR");
        assertThat(hidden.has("actual")).isFalse();
        assertThat(job.toString()).doesNotContain(HIDDEN_INPUT);
    }

    @Test
    void compilationErrorIsDetectedWithOneCompileOnlyCallAndNoTestRuns() throws Exception {
        JsonNode job = await(start("/api/v1/submissions/submit", verifiedUser, "ada", body("shout", "java", "CE")), verifiedUser, "ada");
        assertThat(job.get("status").asText()).isEqualTo("COMPILATION_ERROR");
        assertThat(job.get("compileOutput").asText()).contains("expected");
        assertThat(CALLS).hasSize(1);
        assertThat(CALLS.get(0).get("compileOnly").asBoolean()).isTrue();
    }

    @Test
    void sqlCannotBeUsedForProblemsButWorksInTheFreeFormCompiler() throws Exception {
        mvc.perform(post("/api/v1/submissions/run").with(as(verifiedUser, "ada")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content(body("shout", "sql", "UPPER")))
                .andExpect(status().isUnprocessableEntity()).andExpect(jsonPath("$.code").value("LANGUAGE_NOT_SUPPORTED_FOR_PROBLEMS"));
        JsonNode job = await(start("/api/v1/terminal/run", verifiedUser, "ada",
                "{\"language\":\"sql\",\"sourceCode\":\"UPPER\",\"stdin\":\"\"}"), verifiedUser, "ada");
        assertThat(job.get("state").asText()).isEqualTo("COMPLETED");
    }

    @Test
    void functionBasedProblemsWithoutATrustedHarnessAreRefused() throws Exception {
        jdbc.update("update problems set execution_model = 'FUNCTION' where slug = 'shout'");
        mvc.perform(post("/api/v1/submissions/submit").with(as(verifiedUser, "ada")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content(body("shout", "python", "UPPER")))
                .andExpect(status().isUnprocessableEntity()).andExpect(jsonPath("$.code").value("EXECUTION_MODEL_UNSUPPORTED"));
        assertThat(CALLS).isEmpty();
    }

    @Test
    void terminalRunsWithStdinAndReturnsTheOutput() throws Exception {
        JsonNode job = await(start("/api/v1/terminal/run", verifiedUser, "ada",
                "{\"language\":\"python\",\"sourceCode\":\"UPPER\",\"stdin\":\"hello\"}"), verifiedUser, "ada");
        assertThat(job.get("state").asText()).isEqualTo("COMPLETED");
        assertThat(job.get("status").asText()).isEqualTo("FINISHED");
        assertThat(job.get("stdout").asText()).isEqualTo("HELLO");
        assertThat(jdbc.queryForObject("select count(*) from submissions", Integer.class)).isZero();
    }

    @Test
    void terminalLanguagesAreListedAnonymouslyAndOnlyWhatCanRun() throws Exception {
        // No terminal runner credential is configured in this test, so program languages must NOT be advertised;
        // SQL (one-shot compiler, JDoodle configured) is the only entry. No version is claimed for the runner.
        mvc.perform(get("/api/v1/terminal/languages"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(1))
                .andExpect(jsonPath("$[0].key").value("sql"));
    }

    @Test
    void interactiveSessionIsRefusedWhenTheRunnerIsNotConfigured() throws Exception {
        mvc.perform(post("/api/v1/terminal/sessions").contentType(MediaType.APPLICATION_JSON).content("{\"language\":\"python\"}"))
                .andExpect(status().isServiceUnavailable())
                .andExpect(jsonPath("$.code").value("TERMINAL_RUNNER_NOT_CONFIGURED"));
        mvc.perform(post("/api/v1/terminal/sessions").contentType(MediaType.APPLICATION_JSON).content("{\"language\":\"sql\"}"))
                .andExpect(status().isBadRequest());
        mvc.perform(post("/api/v1/terminal/sessions").contentType(MediaType.APPLICATION_JSON).content("{\"language\":\"cobol\"}"))
                .andExpect(status().isBadRequest());
    }

    // ------------------------------------------------------------------ guards

    @Test
    void unverifiedEmailCannotRunCode() throws Exception {
        mvc.perform(post("/api/v1/submissions/run").with(as(unverifiedUser, "eve")).with(csrf())
                        .contentType(MediaType.APPLICATION_JSON).content(body("shout", "python", "UPPER")))
                .andExpect(status().isForbidden()).andExpect(jsonPath("$.code").value("EMAIL_NOT_VERIFIED"));
        assertThat(CALLS).isEmpty();
    }

    @Test
    void anonymousCannotRunAndUnknownOrDraftProblemsAreNotFound() throws Exception {
        mvc.perform(post("/api/v1/submissions/run").with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content(body("shout", "python", "UPPER"))).andExpect(status().isUnauthorized());
        mvc.perform(post("/api/v1/submissions/run").with(as(verifiedUser, "ada")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content(body("draft", "python", "UPPER"))).andExpect(status().isNotFound());
        mvc.perform(post("/api/v1/submissions/run").with(as(verifiedUser, "ada")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content(body("nope", "python", "UPPER"))).andExpect(status().isNotFound());
    }

    @Test
    void unavailableLanguageAndOversizedSourceAreRejected() throws Exception {
        mvc.perform(post("/api/v1/submissions/run").with(as(verifiedUser, "ada")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content(body("shout", "cpp", "UPPER"))).andExpect(status().isBadRequest());
        mvc.perform(post("/api/v1/submissions/run").with(as(verifiedUser, "ada")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content(body("shout", "python", "x".repeat(64001)))).andExpect(status().isBadRequest());
    }

    @Test
    void requestsWithoutCsrfTokenAreRejected() throws Exception {
        mvc.perform(post("/api/v1/submissions/run").with(as(verifiedUser, "ada")).contentType(MediaType.APPLICATION_JSON)
                .content(body("shout", "python", "UPPER"))).andExpect(status().isForbidden());
    }

    @Test
    void anotherUsersJobLooksLikeAMissingJob() throws Exception {
        String jobId = start("/api/v1/submissions/run", verifiedUser, "ada", body("shout", "python", "UPPER"));
        mvc.perform(get("/api/v1/submissions/jobs/" + jobId).with(as(otherUser, "bob"))).andExpect(status().isNotFound());
        mvc.perform(get("/api/v1/submissions/jobs/00000000-0000-0000-0000-000000000000").with(as(verifiedUser, "ada")))
                .andExpect(status().isNotFound());
    }

    @Test
    void submissionHistoryIsPrivateToItsOwner() throws Exception {
        await(start("/api/v1/submissions/submit", verifiedUser, "ada", body("shout", "python", "UPPER")), verifiedUser, "ada");
        long id = jdbc.queryForObject("select id from submissions", Long.class);
        mvc.perform(get("/api/v1/submissions/mine").with(as(verifiedUser, "ada")))
                .andExpect(jsonPath("$.items[0].problemSlug").value("shout")).andExpect(jsonPath("$.totalItems").value(1));
        mvc.perform(get("/api/v1/submissions/mine").with(as(otherUser, "bob"))).andExpect(jsonPath("$.totalItems").value(0));
        mvc.perform(get("/api/v1/submissions/" + id).with(as(verifiedUser, "ada")))
                .andExpect(status().isOk()).andExpect(jsonPath("$.sourceCode").value("UPPER"));
        mvc.perform(get("/api/v1/submissions/" + id).with(as(otherUser, "bob"))).andExpect(status().isNotFound());
    }

    @Test
    void aSecondConcurrentJobBeyondTheLimitIsRefused() throws Exception {
        // Two jobs already active for the user: the third is refused with 429.
        for (int i = 0; i < 2; i++) {
            jdbc.update("insert into submission_jobs (id, user_id, mode, state) values (?,?,?,?)",
                    java.util.UUID.randomUUID().toString(), verifiedUser, "RUN", "RUNNING");
        }
        mvc.perform(post("/api/v1/submissions/run").with(as(verifiedUser, "ada")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content(body("shout", "python", "UPPER"))).andExpect(status().isTooManyRequests());
    }

    // ------------------------------------------------------------------ outage

    @Test
    void jdoodleOutageFailsTheJobHonestlyWithoutRetryAndNeverReturnsAVerdict() throws Exception {
        jdoodleDown = true;
        JsonNode job = await(start("/api/v1/submissions/submit", verifiedUser, "ada", body("shout", "python", "UPPER")), verifiedUser, "ada");
        assertThat(job.get("state").asText()).isEqualTo("FAILED");
        assertThat(job.get("errorCode").asText()).isEqualTo("EXECUTION_SERVICE_UNAVAILABLE");
        assertThat(job.has("status")).isFalse();
        assertThat(jdbc.queryForObject("select count(*) from submissions", Integer.class)).isZero();
        assertThat(JDOODLE.getRequestCount()).isGreaterThanOrEqualTo(1);
    }

    // ------------------------------------------------------------------ timers

    @Test
    void timerStartPauseResumeResetAreIdempotentAndServerSide() throws Exception {
        String base = "/api/v1/timers/shout";
        mvc.perform(get(base).with(as(verifiedUser, "ada"))).andExpect(jsonPath("$.state").value("IDLE"));
        mvc.perform(post(base + "/start").with(as(verifiedUser, "ada")).with(csrf())).andExpect(jsonPath("$.state").value("RUNNING"));
        mvc.perform(post(base + "/start").with(as(verifiedUser, "ada")).with(csrf())).andExpect(jsonPath("$.state").value("RUNNING"));
        assertThat(jdbc.queryForObject("select count(*) from problem_timers", Integer.class)).isEqualTo(1);
        Thread.sleep(50);
        mvc.perform(post(base + "/pause").with(as(verifiedUser, "ada")).with(csrf())).andExpect(jsonPath("$.state").value("PAUSED"));
        long first = jdbc.queryForObject("select accumulated_ms from problem_timers", Long.class);
        assertThat(first).isGreaterThan(0);
        mvc.perform(post(base + "/pause").with(as(verifiedUser, "ada")).with(csrf())).andExpect(jsonPath("$.state").value("PAUSED"));
        assertThat(jdbc.queryForObject("select accumulated_ms from problem_timers", Long.class)).isEqualTo(first);
        mvc.perform(post(base + "/start").with(as(verifiedUser, "ada")).with(csrf())).andExpect(jsonPath("$.state").value("RUNNING"));
        mvc.perform(get(base).with(as(otherUser, "bob"))).andExpect(jsonPath("$.state").value("IDLE")); // per-user
        mvc.perform(post(base + "/reset").with(as(verifiedUser, "ada")).with(csrf()))
                .andExpect(jsonPath("$.state").value("PAUSED")).andExpect(jsonPath("$.elapsedMs").value(0));
        mvc.perform(post("/api/v1/timers/nope/start").with(as(verifiedUser, "ada")).with(csrf())).andExpect(status().isNotFound());
    }

    // ------------------------------------------------------------------ attempts

    @Test
    void attemptStartIsIdempotentAndFinishIsFinal() throws Exception {
        String a = mvc.perform(post("/api/v1/attempts/start").with(as(verifiedUser, "ada")).with(csrf())
                        .contentType(MediaType.APPLICATION_JSON).content("{\"problemSlug\":\"shout\"}"))
                .andExpect(status().isOk()).andReturn().getResponse().getContentAsString();
        String b = mvc.perform(post("/api/v1/attempts/start").with(as(verifiedUser, "ada")).with(csrf())
                        .contentType(MediaType.APPLICATION_JSON).content("{\"problemSlug\":\"shout\"}"))
                .andExpect(status().isOk()).andReturn().getResponse().getContentAsString();
        long id = JSON.readTree(a).get("id").asLong();
        assertThat(JSON.readTree(b).get("id").asLong()).isEqualTo(id);
        assertThat(JSON.readTree(a).has("serverTime")).isTrue();
        assertThat(jdbc.queryForObject("select count(*) from attempts", Integer.class)).isEqualTo(1);

        mvc.perform(post("/api/v1/attempts/" + id + "/finish").with(as(otherUser, "bob")).with(csrf())).andExpect(status().isNotFound());
        String f1 = mvc.perform(post("/api/v1/attempts/" + id + "/finish").with(as(verifiedUser, "ada")).with(csrf()))
                .andExpect(status().isOk()).andReturn().getResponse().getContentAsString();
        String f2 = mvc.perform(post("/api/v1/attempts/" + id + "/finish").with(as(verifiedUser, "ada")).with(csrf()))
                .andExpect(status().isOk()).andReturn().getResponse().getContentAsString();
        assertThat(JSON.readTree(f2).get("elapsedMs").asLong()).isEqualTo(JSON.readTree(f1).get("elapsedMs").asLong());

        // After finishing, starting again opens a new attempt.
        String c = mvc.perform(post("/api/v1/attempts/start").with(as(verifiedUser, "ada")).with(csrf())
                        .contentType(MediaType.APPLICATION_JSON).content("{\"problemSlug\":\"shout\"}"))
                .andReturn().getResponse().getContentAsString();
        assertThat(JSON.readTree(c).get("id").asLong()).isNotEqualTo(id);
    }

    // ------------------------------------------------------------------ dashboard

    @Test
    void dashboardShowsZerosForANewUserWithAllDifficultiesAndThirtyDays() throws Exception {
        mvc.perform(get("/api/v1/dashboard/progress").with(as(otherUser, "bob")))
                .andExpect(jsonPath("$.length()").value(4))
                .andExpect(jsonPath("$[0].difficulty").value("EASY")).andExpect(jsonPath("$[0].total").value(1))
                .andExpect(jsonPath("$[0].solved").value(0));
        mvc.perform(get("/api/v1/dashboard/activity").with(as(otherUser, "bob"))).andExpect(jsonPath("$.length()").value(30));
    }

    @Test
    void calendarReturnsAnEmptyMonthForANewUserAndRejectsABadMonth() throws Exception {
        mvc.perform(get("/api/v1/dashboard/calendar").param("month", "2026-10").param("offsetMinutes", "330").with(as(otherUser, "bob")))
                .andExpect(jsonPath("$.length()").value(0));
        mvc.perform(get("/api/v1/dashboard/calendar").param("month", "nope").with(as(otherUser, "bob")))
                .andExpect(status().isBadRequest());
    }
}
