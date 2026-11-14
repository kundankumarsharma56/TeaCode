package com.teacode.execution;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.teacode.config.AppProperties;
import com.teacode.exception.ServiceUnavailableException;
import okhttp3.mockwebserver.MockResponse;
import okhttp3.mockwebserver.MockWebServer;
import okhttp3.mockwebserver.RecordedRequest;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/** JDoodle is replaced by a local HTTP stand-in: no real credentials or credits are used. */
class JdoodleClientTest {

    static final String ID = "test-client-id";
    static final String SECRET = "test-client-secret";

    MockWebServer server;

    @BeforeEach
    void start() throws Exception {
        server = new MockWebServer();
        server.start();
    }

    @AfterEach
    void stop() throws Exception {
        server.shutdown();
    }

    static AppProperties props(String baseUrl, String id, String secret) {
        return new AppProperties("http://localhost", "",
                new AppProperties.Security("x".repeat(40), "test", 15, 14, false),
                new AppProperties.Jdoodle(id, secret, baseUrl, 2, 5, 2, 20, 60, ""),
                null, null);
    }

    JdoodleClient client() {
        return new JdoodleClient(props(server.url("/").toString(), ID, SECRET));
    }

    @Test
    void sendsLanguageVersionIndexAndCredentialsOnlyToJdoodle() throws Exception {
        server.enqueue(new MockResponse().setHeader("Content-Type", "application/json")
                .setBody("{\"output\":\"hi\\n\",\"statusCode\":200,\"memory\":\"1234\",\"cpuTime\":\"0.02\"}"));
        JdoodleClient.Result r = client().execute(new JdoodleClient.RunSpec("python3", "6", "print('hi')", "in", false));
        assertThat(r.output()).isEqualTo("hi\n");
        assertThat(r.memory()).isEqualTo(1234);
        assertThat(r.cpuSeconds()).isEqualTo(0.02);

        RecordedRequest req = server.takeRequest();
        assertThat(req.getPath()).isEqualTo("/v1/execute");
        String body = req.getBody().readUtf8();
        assertThat(body).contains("\"language\":\"python3\"").contains("\"versionIndex\":\"6\"")
                .contains("\"clientId\":\"" + ID + "\"").contains("\"stdin\":\"in\"");
        assertThat(body).doesNotContain("compileOnly");
    }

    @Test
    void compileErrorsInOutputAreReturnedAsOutputNotAsAnException() {
        server.enqueue(new MockResponse().setHeader("Content-Type", "application/json")
                .setBody("{\"output\":\"main.c:1: error: expected ;\",\"statusCode\":200,\"memory\":null,\"cpuTime\":null}"));
        JdoodleClient.Result r = client().execute(new JdoodleClient.RunSpec("c", "6", "x", null, false));
        assertThat(r.output()).contains("error");
        assertThat(r.memory()).isNull();
        assertThat(r.cpuSeconds()).isNull();
    }

    @Test
    void compileOnlyIsForwarded() throws Exception {
        server.enqueue(new MockResponse().setHeader("Content-Type", "application/json")
                .setBody("{\"output\":\"\",\"statusCode\":200,\"compilationStatus\":0}"));
        JdoodleClient.Result r = client().execute(new JdoodleClient.RunSpec("java", "5", "x", null, true));
        assertThat(r.compilationStatus()).isZero();
        assertThat(server.takeRequest().getBody().readUtf8()).contains("\"compileOnly\":true");
    }

    @Test
    void unauthorisedAndQuotaAreDistinctErrors() {
        server.enqueue(new MockResponse().setResponseCode(401).setBody("{\"error\":\"Unauthorized\"}"));
        server.enqueue(new MockResponse().setResponseCode(429).setBody("{\"error\":\"Daily limit reached\"}"));
        JdoodleClient c = client();
        var spec = new JdoodleClient.RunSpec("python3", "6", "x", null, false);
        assertThatThrownBy(() -> c.execute(spec)).isInstanceOf(ServiceUnavailableException.class)
                .hasMessageNotContaining(SECRET).hasMessageNotContaining(ID)
                .extracting("code").isEqualTo(JdoodleClient.CREDENTIALS_REJECTED);
        assertThatThrownBy(() -> c.execute(spec)).extracting("code").isEqualTo(JdoodleClient.QUOTA_EXCEEDED);
    }

    @Test
    void aServerErrorIsNeverRetriedBecauseARunMayHaveBeenBilled() {
        server.enqueue(new MockResponse().setResponseCode(500));
        server.enqueue(new MockResponse().setResponseCode(200).setBody("{\"output\":\"x\",\"statusCode\":200}"));
        assertThatThrownBy(() -> client().execute(new JdoodleClient.RunSpec("python3", "6", "x", null, false)))
                .extracting("code").isEqualTo(JdoodleClient.UNAVAILABLE);
        assertThat(server.getRequestCount()).isEqualTo(1);
    }

    @Test
    void unreadableBodyIsAnErrorNotAnEmptySuccess() {
        server.enqueue(new MockResponse().setHeader("Content-Type", "application/json").setBody("{}"));
        assertThatThrownBy(() -> client().execute(new JdoodleClient.RunSpec("python3", "6", "x", null, false)))
                .extracting("code").isEqualTo(JdoodleClient.UNAVAILABLE);
    }

    @Test
    void withoutCredentialsNothingIsSent() {
        JdoodleClient c = new JdoodleClient(props(server.url("/").toString(), "", ""));
        assertThat(c.isConfigured()).isFalse();
        assertThatThrownBy(() -> c.execute(new JdoodleClient.RunSpec("python3", "6", "x", null, false)))
                .extracting("code").isEqualTo(JdoodleClient.NOT_CONFIGURED);
        assertThat(server.getRequestCount()).isZero();
    }
}
