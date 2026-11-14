package com.teacode;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.reset;
import static org.mockito.Mockito.verify;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.teacode.service.AuthMailer;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.Cookie;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Date;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.RequestPostProcessor;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/**
 * Authentication lifecycle against real MySQL (Flyway schema): registration without account enumeration, login,
 * HttpOnly cookie attributes, refresh rotation, reuse detection, logout revocation, missing/malformed/expired access
 * tokens, CSRF, password reset and change, e-mail verification and account deletion.
 * Each test uses its own client address so the in-memory rate limits of one test cannot affect another.
 */
@Testcontainers
@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource(properties = {
        "teacode.public-url=http://localhost",
        "teacode.security.jwt-secret=test-only-secret-that-is-long-enough-0123456789",
        "teacode.security.cookie-secure=false"
})
class AuthApiIT {

    private static final String SECRET = "test-only-secret-that-is-long-enough-0123456789";
    private static final String PASSWORD = "correct horse battery";

    @Container
    static final MySQLContainer<?> MYSQL = new MySQLContainer<>("mysql:8.4")
            .withCommand("--character-set-server=utf8mb4", "--collation-server=utf8mb4_0900_ai_ci");

    @DynamicPropertySource
    static void props(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", MYSQL::getJdbcUrl);
        registry.add("spring.datasource.username", MYSQL::getUsername);
        registry.add("spring.datasource.password", MYSQL::getPassword);
    }

    @MockitoBean
    AuthMailer mailer;

    @Autowired
    MockMvc mvc;

    @Autowired
    JdbcTemplate jdbc;

    @Autowired
    PasswordEncoder encoder;

    @BeforeEach
    void clean() {
        reset(mailer);
        for (String t : new String[] {"refresh_sessions", "email_verification_tokens", "password_reset_tokens", "policy_acceptances",
                "oauth_identities", "user_avatars", "submission_jobs", "submissions", "problem_timers", "attempts", "audit_events", "users"}) {
            jdbc.update("delete from " + t);
        }
    }

    // ------------------------------------------------------------------ helpers

    private static RequestPostProcessor from(String ip) {
        return request -> {
            request.setRemoteAddr(ip);
            return request;
        };
    }

    private long createUser(String name, String email, boolean verified) {
        jdbc.update("insert into users (username, email, password_hash, email_verified) values (?,?,?,?)",
                name, email, encoder.encode(PASSWORD), verified);
        return jdbc.queryForObject("select id from users where username=?", Long.class, name);
    }

    private MvcResult login(String email, String password, String ip) throws Exception {
        return mvc.perform(post("/api/v1/auth/login").with(from(ip)).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content("{\"email\":\"" + email + "\",\"password\":\"" + password + "\"}")).andReturn();
    }

    private static String cookie(MvcResult result, String name) {
        for (String header : result.getResponse().getHeaders(HttpHeaders.SET_COOKIE)) {
            if (header.startsWith(name + "=")) {
                return header.substring(name.length() + 1, header.indexOf(';'));
            }
        }
        return null;
    }

    private static String setCookieHeader(MvcResult result, String name) {
        return result.getResponse().getHeaders(HttpHeaders.SET_COOKIE).stream().filter(h -> h.startsWith(name + "=")).findFirst().orElse("");
    }

    private MvcResult refresh(String refreshToken, String ip) throws Exception {
        return mvc.perform(post("/api/v1/auth/refresh").with(from(ip)).with(csrf()).cookie(new Cookie("cv_refresh", refreshToken))).andReturn();
    }

    private static String tokenFrom(ArgumentCaptor<String> link) {
        String l = link.getValue();
        return l.substring(l.indexOf("token=") + "token=".length());
    }

    private int activeSessions(long userId) {
        return jdbc.queryForObject("select count(*) from refresh_sessions where user_id=? and revoked_at is null", Integer.class, userId);
    }

    // ------------------------------------------------------------------ registration

    @Test
    void registrationCreatesAnUnverifiedAccountAndNeverStoresThePlainPassword() throws Exception {
        mvc.perform(post("/api/v1/auth/register").with(from("10.1.0.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content("{\"username\":\"newbie\",\"email\":\"New@Example.com\",\"password\":\"" + PASSWORD + "\",\"acceptPolicies\":true,\"policyVersion\":\"1\"}"))
                .andExpect(status().isAccepted());
        assertThat(jdbc.queryForObject("select email_verified from users where username='newbie'", Boolean.class)).isFalse();
        assertThat(jdbc.queryForObject("select email from users where username='newbie'", String.class)).isEqualTo("new@example.com");
        String hash = jdbc.queryForObject("select password_hash from users where username='newbie'", String.class);
        assertThat(hash).startsWith("$argon2id$").doesNotContain(PASSWORD);
        assertThat(jdbc.queryForObject("select count(*) from policy_acceptances", Integer.class)).isEqualTo(2);
        verify(mailer).sendVerification(eq("new@example.com"), anyString());
    }

    @Test
    void registeringAnExistingEmailLooksIdenticalAndSendsNothing() throws Exception {
        createUser("taken", "taken@example.com", true);
        mvc.perform(post("/api/v1/auth/register").with(from("10.1.0.2")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content("{\"username\":\"someoneelse\",\"email\":\"taken@example.com\",\"password\":\"" + PASSWORD + "\",\"acceptPolicies\":true,\"policyVersion\":\"1\"}"))
                .andExpect(status().isAccepted());
        assertThat(jdbc.queryForObject("select count(*) from users", Integer.class)).isEqualTo(1);
        verify(mailer, never()).sendVerification(anyString(), anyString());
    }

    @Test
    void registrationRejectsInvalidInputAndMissingPolicyAcceptance() throws Exception {
        mvc.perform(post("/api/v1/auth/register").with(from("10.1.0.3")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content("{\"username\":\"a\",\"email\":\"not-an-email\",\"password\":\"short\",\"acceptPolicies\":false,\"policyVersion\":\"1\"}"))
                .andExpect(status().isBadRequest());
        assertThat(jdbc.queryForObject("select count(*) from users", Integer.class)).isZero();
    }

    // ------------------------------------------------------------------ login and cookies

    @Test
    void loginSetsHttpOnlyCookiesWithTheDocumentedPathsAndReturnsNoSecrets() throws Exception {
        createUser("ada", "ada@example.com", true);
        MvcResult res = login("ada@example.com", PASSWORD, "10.2.0.1");
        assertThat(res.getResponse().getStatus()).isEqualTo(200);
        String access = setCookieHeader(res, "cv_access");
        String refresh = setCookieHeader(res, "cv_refresh");
        assertThat(access).contains("HttpOnly").contains("Path=/api").contains("SameSite=Lax");
        assertThat(refresh).contains("HttpOnly").contains("Path=/api/v1/auth").contains("SameSite=Lax");
        String body = res.getResponse().getContentAsString();
        assertThat(body).doesNotContain("password").doesNotContain("hash").doesNotContain(cookie(res, "cv_refresh"));
    }

    @Test
    void unverifiedAccountsCannotStartPasswordSessions() throws Exception {
        createUser("pending", "pending@example.com", false);
        MvcResult res = login("pending@example.com", PASSWORD, "10.2.0.3");
        assertThat(res.getResponse().getStatus()).isEqualTo(403);
        assertThat(res.getResponse().getContentAsString()).contains("EMAIL_UNVERIFIED");
        assertThat(res.getResponse().getHeaders(HttpHeaders.SET_COOKIE)).isEmpty();
        assertThat(activeSessions(jdbc.queryForObject("select id from users where email='pending@example.com'", Long.class))).isZero();
    }

    @Test
    void wrongPasswordAndUnknownEmailGetTheSameGenericAnswer() throws Exception {
        createUser("ada", "ada@example.com", true);
        MvcResult wrong = login("ada@example.com", "definitely wrong", "10.2.0.2");
        MvcResult unknown = login("nobody@example.com", "definitely wrong", "10.2.0.2");
        assertThat(wrong.getResponse().getStatus()).isEqualTo(401);
        assertThat(unknown.getResponse().getStatus()).isEqualTo(401);
        var a = new com.fasterxml.jackson.databind.ObjectMapper().readTree(wrong.getResponse().getContentAsString());
        var b = new com.fasterxml.jackson.databind.ObjectMapper().readTree(unknown.getResponse().getContentAsString());
        // correlationId and timestamp legitimately differ; what the caller can learn from the answer must not.
        assertThat(a.get("code")).isEqualTo(b.get("code"));
        assertThat(a.get("message")).isEqualTo(b.get("message"));
        assertThat(wrong.getResponse().getHeaders(HttpHeaders.SET_COOKIE)).isEmpty();
    }

    @Test
    void loginIsRateLimitedPerEmail() throws Exception {
        createUser("ada", "ada@example.com", true);
        int last = 0;
        for (int i = 0; i < 12; i++) {
            last = login("ada@example.com", "wrong " + i, "10.2.0." + (10 + i)).getResponse().getStatus();
        }
        assertThat(last).isEqualTo(429);
        // The correct password is refused too while the limit is in force.
        assertThat(login("ada@example.com", PASSWORD, "10.2.0.99").getResponse().getStatus()).isEqualTo(429);
    }

    @Test
    void stateChangingRequestsWithoutACsrfTokenAreRefused() throws Exception {
        mvc.perform(post("/api/v1/auth/login").with(from("10.2.1.1")).contentType(MediaType.APPLICATION_JSON)
                .content("{\"email\":\"a@b.c\",\"password\":\"x\"}")).andExpect(status().isForbidden());
        mvc.perform(post("/api/v1/auth/logout").with(from("10.2.1.1"))).andExpect(status().isForbidden());
    }

    // ------------------------------------------------------------------ access tokens

    @Test
    void protectedRoutesRejectMissingMalformedAndExpiredAccessTokens() throws Exception {
        long id = createUser("ada", "ada@example.com", true);
        mvc.perform(get("/api/v1/auth/me").with(from("10.3.0.1"))).andExpect(status().isUnauthorized());
        mvc.perform(get("/api/v1/auth/me").with(from("10.3.0.1")).cookie(new Cookie("cv_access", "not-a-jwt"))).andExpect(status().isUnauthorized());

        var key = Keys.hmacShaKeyFor(SECRET.getBytes(StandardCharsets.UTF_8));
        String expired = Jwts.builder().issuer("codevibs").subject(Long.toString(id)).claim("sid", "1")
                .issuedAt(Date.from(Instant.now().minusSeconds(7200))).expiration(Date.from(Instant.now().minusSeconds(3600))).signWith(key).compact();
        mvc.perform(get("/api/v1/auth/me").with(from("10.3.0.1")).cookie(new Cookie("cv_access", expired))).andExpect(status().isUnauthorized());

        String wrongKey = Jwts.builder().issuer("codevibs").subject(Long.toString(id)).claim("sid", "1")
                .expiration(Date.from(Instant.now().plusSeconds(600)))
                .signWith(Keys.hmacShaKeyFor("another-secret-another-secret-another-secret".getBytes(StandardCharsets.UTF_8))).compact();
        mvc.perform(get("/api/v1/auth/me").with(from("10.3.0.1")).cookie(new Cookie("cv_access", wrongKey))).andExpect(status().isUnauthorized());

        // Valid signature but pointing at a session that does not exist.
        String orphan = Jwts.builder().issuer("codevibs").subject(Long.toString(id)).claim("sid", "999999")
                .expiration(Date.from(Instant.now().plusSeconds(600))).signWith(key).compact();
        mvc.perform(get("/api/v1/auth/me").with(from("10.3.0.1")).cookie(new Cookie("cv_access", orphan))).andExpect(status().isUnauthorized());
    }

    @Test
    void aValidSessionReachesMeAndLogoutRevokesItImmediately() throws Exception {
        createUser("ada", "ada@example.com", true);
        MvcResult res = login("ada@example.com", PASSWORD, "10.3.1.1");
        Cookie access = new Cookie("cv_access", cookie(res, "cv_access"));
        mvc.perform(get("/api/v1/auth/me").with(from("10.3.1.1")).cookie(access)).andExpect(status().isOk()).andExpect(jsonPath("$.username").value("ada"));

        mvc.perform(post("/api/v1/auth/logout").with(from("10.3.1.1")).with(csrf()).cookie(new Cookie("cv_refresh", cookie(res, "cv_refresh"))))
                .andExpect(status().isNoContent());
        mvc.perform(get("/api/v1/auth/me").with(from("10.3.1.1")).cookie(access)).andExpect(status().isUnauthorized());
    }

    @Test
    void aSuspendedAccountLosesAccessImmediately() throws Exception {
        long id = createUser("ada", "ada@example.com", true);
        MvcResult res = login("ada@example.com", PASSWORD, "10.3.2.1");
        jdbc.update("update users set account_status='SUSPENDED' where id=?", id);
        mvc.perform(get("/api/v1/auth/me").with(from("10.3.2.1")).cookie(new Cookie("cv_access", cookie(res, "cv_access")))).andExpect(status().isUnauthorized());
        assertThat(login("ada@example.com", PASSWORD, "10.3.2.1").getResponse().getStatus()).isEqualTo(401);
    }

    // ------------------------------------------------------------------ refresh rotation

    @Test
    void refreshRotatesTheTokenAndTheOldOneStopsWorking() throws Exception {
        long id = createUser("ada", "ada@example.com", true);
        MvcResult res = login("ada@example.com", PASSWORD, "10.4.0.1");
        String first = cookie(res, "cv_refresh");

        MvcResult rotated = refresh(first, "10.4.0.1");
        assertThat(rotated.getResponse().getStatus()).isEqualTo(204);
        String second = cookie(rotated, "cv_refresh");
        assertThat(second).isNotBlank().isNotEqualTo(first);
        assertThat(activeSessions(id)).isEqualTo(1);
        assertThat(refresh(second, "10.4.0.1").getResponse().getStatus()).isEqualTo(204);
    }

    @Test
    void replayingARotatedTokenLongAfterwardsEndsEverySession() throws Exception {
        long id = createUser("ada", "ada@example.com", true);
        MvcResult res = login("ada@example.com", PASSWORD, "10.4.1.1");
        String first = cookie(res, "cv_refresh");
        String second = cookie(refresh(first, "10.4.1.1"), "cv_refresh");
        // Age the revocation beyond the benign-race grace window.
        jdbc.update("update refresh_sessions set revoked_at = revoked_at - interval 5 minute where revoked_at is not null");

        assertThat(refresh(first, "10.4.1.1").getResponse().getStatus()).isEqualTo(401);
        assertThat(activeSessions(id)).isZero();
        assertThat(refresh(second, "10.4.1.1").getResponse().getStatus()).isEqualTo(401);
        assertThat(jdbc.queryForObject("select count(*) from audit_events where event_type='REFRESH_TOKEN_REUSE'", Integer.class)).isEqualTo(1);
    }

    @Test
    void aReplayWithinTheGraceWindowIsRefusedWithoutEndingTheNewSession() throws Exception {
        long id = createUser("ada", "ada@example.com", true);
        String first = cookie(login("ada@example.com", PASSWORD, "10.4.2.1"), "cv_refresh");
        String second = cookie(refresh(first, "10.4.2.1"), "cv_refresh");

        assertThat(refresh(first, "10.4.2.1").getResponse().getStatus()).isEqualTo(401);
        assertThat(activeSessions(id)).isEqualTo(1);
        assertThat(refresh(second, "10.4.2.1").getResponse().getStatus()).isEqualTo(204);
    }

    @Test
    void missingUnknownAndExpiredRefreshTokensAreRefused() throws Exception {
        long id = createUser("ada", "ada@example.com", true);
        mvc.perform(post("/api/v1/auth/refresh").with(from("10.4.3.1")).with(csrf())).andExpect(status().isUnauthorized());
        assertThat(refresh("unknown-token", "10.4.3.1").getResponse().getStatus()).isEqualTo(401);

        String token = cookie(login("ada@example.com", PASSWORD, "10.4.3.1"), "cv_refresh");
        jdbc.update("update refresh_sessions set expires_at = now(6) - interval 1 minute where user_id=?", id);
        assertThat(refresh(token, "10.4.3.1").getResponse().getStatus()).isEqualTo(401);
    }

    // ------------------------------------------------------------------ e-mail verification

    @Test
    void verificationLinksAreSingleUseAndMalformedOnesAreRejected() throws Exception {
        mvc.perform(post("/api/v1/auth/register").with(from("10.5.0.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON)
                .content("{\"username\":\"newbie\",\"email\":\"newbie@example.com\",\"password\":\"" + PASSWORD + "\",\"acceptPolicies\":true,\"policyVersion\":\"1\"}"))
                .andExpect(status().isAccepted());
        ArgumentCaptor<String> link = ArgumentCaptor.forClass(String.class);
        verify(mailer).sendVerification(eq("newbie@example.com"), link.capture());
        String token = tokenFrom(link);
        assertThat(jdbc.queryForObject("select token_hash from email_verification_tokens", String.class)).doesNotContain(token);

        String body = "{\"token\":\"" + token + "\"}";
        mvc.perform(post("/api/v1/auth/verify-email").with(from("10.5.0.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON).content(body)).andExpect(status().isNoContent());
        assertThat(jdbc.queryForObject("select email_verified from users where username='newbie'", Boolean.class)).isTrue();
        mvc.perform(post("/api/v1/auth/verify-email").with(from("10.5.0.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON).content(body)).andExpect(status().isBadRequest());
        mvc.perform(post("/api/v1/auth/verify-email").with(from("10.5.0.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON).content("{\"token\":\"garbage\"}")).andExpect(status().isBadRequest());
        mvc.perform(post("/api/v1/auth/verify-email").with(from("10.5.0.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON).content("{}")).andExpect(status().isBadRequest());
    }

    // ------------------------------------------------------------------ password reset and change

    @Test
    void forgotPasswordGivesTheSameAnswerForKnownAndUnknownEmails() throws Exception {
        createUser("ada", "ada@example.com", true);
        mvc.perform(post("/api/v1/auth/forgot-password").with(from("10.6.0.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON).content("{\"email\":\"ada@example.com\"}")).andExpect(status().isAccepted());
        mvc.perform(post("/api/v1/auth/forgot-password").with(from("10.6.0.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON).content("{\"email\":\"ghost@example.com\"}")).andExpect(status().isAccepted());
        verify(mailer).sendPasswordReset(eq("ada@example.com"), anyString());
        verify(mailer, never()).sendPasswordReset(eq("ghost@example.com"), anyString());
    }

    @Test
    void resetTokensWorkOnceAndRevokeEverySession() throws Exception {
        long id = createUser("ada", "ada@example.com", true);
        String refreshToken = cookie(login("ada@example.com", PASSWORD, "10.6.1.1"), "cv_refresh");
        mvc.perform(post("/api/v1/auth/forgot-password").with(from("10.6.1.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON).content("{\"email\":\"ada@example.com\"}")).andExpect(status().isAccepted());
        ArgumentCaptor<String> link = ArgumentCaptor.forClass(String.class);
        verify(mailer).sendPasswordReset(eq("ada@example.com"), link.capture());
        String token = tokenFrom(link);

        String body = "{\"token\":\"" + token + "\",\"password\":\"a brand new passphrase\"}";
        mvc.perform(post("/api/v1/auth/reset-password").with(from("10.6.1.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON).content(body)).andExpect(status().isNoContent());
        mvc.perform(post("/api/v1/auth/reset-password").with(from("10.6.1.1")).with(csrf()).contentType(MediaType.APPLICATION_JSON).content(body)).andExpect(status().isBadRequest());
        assertThat(activeSessions(id)).isZero();
        assertThat(refresh(refreshToken, "10.6.1.1").getResponse().getStatus()).isEqualTo(401);
        assertThat(login("ada@example.com", PASSWORD, "10.6.1.1").getResponse().getStatus()).isEqualTo(401);
        assertThat(login("ada@example.com", "a brand new passphrase", "10.6.1.1").getResponse().getStatus()).isEqualTo(200);
    }

    @Test
    void changingThePasswordRequiresTheCurrentOneAndEndsEverySession() throws Exception {
        long id = createUser("ada", "ada@example.com", true);
        MvcResult res = login("ada@example.com", PASSWORD, "10.6.2.1");
        Cookie access = new Cookie("cv_access", cookie(res, "cv_access"));

        mvc.perform(post("/api/v1/users/me/change-password").with(from("10.6.2.1")).with(csrf()).cookie(access).contentType(MediaType.APPLICATION_JSON)
                .content("{\"currentPassword\":\"wrong wrong wrong\",\"newPassword\":\"another long passphrase\"}")).andExpect(status().isBadRequest());
        assertThat(activeSessions(id)).isEqualTo(1);

        mvc.perform(post("/api/v1/users/me/change-password").with(from("10.6.2.1")).with(csrf()).cookie(access).contentType(MediaType.APPLICATION_JSON)
                .content("{\"currentPassword\":\"" + PASSWORD + "\",\"newPassword\":\"another long passphrase\"}")).andExpect(status().isNoContent());
        assertThat(activeSessions(id)).isZero();
        mvc.perform(get("/api/v1/auth/me").with(from("10.6.2.1")).cookie(access)).andExpect(status().isUnauthorized());
    }

    // ------------------------------------------------------------------ account deletion

    @Test
    void deletingAnAccountNeedsThePasswordAndRemovesEveryPersonalRecord() throws Exception {
        long id = createUser("ada", "ada@example.com", true);
        long other = createUser("bob", "bob@example.com", true);
        jdbc.update("insert into problems (title, slug, description, difficulty, visibility) values ('P','p','d','EASY','PUBLISHED')");
        long problem = jdbc.queryForObject("select id from problems where slug='p'", Long.class);
        for (long u : new long[] {id, other}) {
            jdbc.update("insert into submissions (user_id, problem_id, language, source_code, status) values (?,?,'python','print(1)','ACCEPTED')", u, problem);
            jdbc.update("insert into problem_timers (user_id, problem_id, accumulated_ms) values (?,?,1000)", u, problem);
            jdbc.update("insert into policy_acceptances (user_id, policy_type, policy_version) values (?,'TERMS','1')", u);
        }
        Cookie access = new Cookie("cv_access", cookie(login("ada@example.com", PASSWORD, "10.7.0.1"), "cv_access"));

        mvc.perform(delete("/api/v1/users/me").with(from("10.7.0.1")).with(csrf()).cookie(access).contentType(MediaType.APPLICATION_JSON)
                .content("{\"password\":\"not my password\"}")).andExpect(status().isBadRequest());
        assertThat(jdbc.queryForObject("select count(*) from users where id=?", Integer.class, id)).isEqualTo(1);

        mvc.perform(delete("/api/v1/users/me").with(from("10.7.0.1")).with(csrf()).cookie(access).contentType(MediaType.APPLICATION_JSON)
                .content("{\"password\":\"" + PASSWORD + "\"}")).andExpect(status().isNoContent());

        for (String table : List.of("users", "submissions", "problem_timers", "policy_acceptances", "refresh_sessions")) {
            String col = table.equals("users") ? "id" : "user_id";
            assertThat(jdbc.queryForObject("select count(*) from " + table + " where " + col + "=?", Integer.class, id)).as(table).isZero();
        }
        // Another user's data is untouched, and the deleted user's audit trail no longer points at them.
        assertThat(jdbc.queryForObject("select count(*) from submissions where user_id=?", Integer.class, other)).isEqualTo(1);
        assertThat(jdbc.queryForObject("select count(*) from audit_events where user_id=?", Integer.class, id)).isZero();
        mvc.perform(get("/api/v1/auth/me").with(from("10.7.0.1")).cookie(access)).andExpect(status().isUnauthorized());
    }
}
