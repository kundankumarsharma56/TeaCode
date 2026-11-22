package com.teacode.execution;

import com.teacode.config.AppProperties;
import com.teacode.exception.ServiceUnavailableException;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestClientResponseException;

/**
 * Server-side client for the JDoodle Compiler API ({@code POST /v1/execute}).
 *
 * <ul>
 *   <li>The client id and secret are read from configuration only and are sent only to JDoodle.</li>
 *   <li>Every call spends one JDoodle credit, so concurrency is bounded and a call is NEVER retried
 *       automatically (a timeout does not tell us whether the run was billed or executed).</li>
 *   <li>Source code, stdin, credentials and upstream bodies are never logged.</li>
 *   <li>Failures become {@link ServiceUnavailableException} with a stable code; nothing is faked.</li>
 * </ul>
 *
 * JDoodle documents only: {@code output}, {@code statusCode}, {@code memory} (string), {@code cpuTime}
 * (string), {@code compilationStatus} (only with compileOnly) and {@code error}. Anything else is "not available".
 */
@Component
public class JdoodleClient {

    public static final String NOT_CONFIGURED = "EXECUTION_NOT_CONFIGURED";
    public static final String UNAVAILABLE = "EXECUTION_SERVICE_UNAVAILABLE";
    public static final String CREDENTIALS_REJECTED = "EXECUTION_CREDENTIALS_REJECTED";
    public static final String QUOTA_EXCEEDED = "EXECUTION_QUOTA_EXCEEDED";
    public static final String BUSY = "EXECUTION_BUSY";

    private static final Logger log = LoggerFactory.getLogger(JdoodleClient.class);

    /** One program execution. {@code compileOnly} compiles without running (used to detect compile errors). */
    public record RunSpec(String language, String versionIndex, String script, String stdin, boolean compileOnly) {
    }

    /**
     * What JDoodle returned. {@code memory} is passed through as reported (JDoodle does not document its unit)
     * and {@code cpuSeconds} comes from {@code cpuTime}; either is null when absent or unparsable.
     */
    public record Result(String output, Integer memory, Double cpuSeconds, Integer compilationStatus) {
    }

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private record Request(String clientId, String clientSecret, String script, String stdin, String language,
                           String versionIndex, Boolean compileOnly) {
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    record Response(String output, Integer statusCode, String memory, String cpuTime, Integer compilationStatus,
                            String error) {
    }

    private final RestClient client;
    private final String clientId;
    private final String clientSecret;
    private final boolean configured;
    private final Judge0Client judge0 = new Judge0Client();
    private final Semaphore gate;
    private final long gateWaitSeconds;

    public JdoodleClient(AppProperties props) {
        AppProperties.Jdoodle cfg = props.jdoodle();
        this.clientId = cfg.clientId();
        this.clientSecret = cfg.clientSecret();
        this.configured = cfg.configured();
        this.gate = new Semaphore(cfg.maxConcurrentCalls(), true);
        this.gateWaitSeconds = Math.max(5, cfg.readTimeoutSeconds());
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(cfg.connectTimeoutSeconds() * 1000);
        factory.setReadTimeout(cfg.readTimeoutSeconds() * 1000);
        this.client = RestClient.builder()
                .requestFactory(factory)
                .baseUrl(cfg.baseUrl().replaceAll("/+$", ""))
                .build();
    }

    public boolean isConfigured() {
        return configured;
    }

    public Result execute(RunSpec spec) {
        if (Judge0Client.enabled()) {
            return judge0.execute(spec);
        }
        if (!configured) {
            throw new ServiceUnavailableException(NOT_CONFIGURED,
                    "Code execution is not configured on this server (JDoodle credentials are missing).");
        }
        boolean acquired = false;
        try {
            acquired = gate.tryAcquire(gateWaitSeconds, TimeUnit.SECONDS);
            if (!acquired) {
                throw new ServiceUnavailableException(BUSY, "The execution service is busy. Please try again shortly.");
            }
            String script = normalizeJava(spec.language(), spec.script());
            Request body = new Request(clientId, clientSecret, script,
                    spec.stdin() == null || spec.stdin().isEmpty() ? null : spec.stdin(),
                    spec.language(), spec.versionIndex(), spec.compileOnly() ? Boolean.TRUE : null);
            Response r = client.post().uri("/v1/execute")
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(body)
                    .retrieve()
                    .body(Response.class);
            return interpret(r);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new ServiceUnavailableException(UNAVAILABLE, "The code execution service is unavailable.");
        } catch (RestClientResponseException e) {
            String detail = e.getResponseBodyAsString();
            log.warn("JDoodle error text (HTTP {}): {}", e.getStatusCode().value(), detail == null ? "" : (detail.length() > 200 ? detail.substring(0, 200) : detail));
            throw fromStatus(e.getStatusCode().value());
        } catch (RestClientException e) {
            // Message class only: never the exception text, which could echo the request.
            log.warn("JDoodle call failed ({})", e.getClass().getSimpleName());
            throw new ServiceUnavailableException(UNAVAILABLE, "The code execution service is unavailable.");
        } finally {
            if (acquired) {
                gate.release();
            }
        }
    }

    /** Package-visible so tests can drive it with fixed JSON. */
    Result interpret(Response r) {
        if (r == null) {
            log.warn("JDoodle returned an empty response");
            throw new ServiceUnavailableException(UNAVAILABLE, "The code execution service returned an unreadable response.");
        }
        Integer code = r.statusCode();
        if (r.error() != null || (code != null && code != 200)) {
            log.warn("JDoodle error text (body status {}): {}", code, r.error() == null ? "" : (r.error().length() > 200 ? r.error().substring(0, 200) : r.error()));
            throw fromStatus(code == null ? 0 : code);
        }
        if (r.output() == null && r.compilationStatus() == null) {
            log.warn("JDoodle response had no output");
            throw new ServiceUnavailableException(UNAVAILABLE, "The code execution service returned an unreadable response.");
        }
        return new Result(r.output() == null ? "" : r.output(), parseInt(r.memory()), parseDouble(r.cpuTime()),
                r.compilationStatus());
    }

    /** JDoodle compiles Java from the public class, so a plain "class Main" is rejected there. Make it public when no class is. */
    static String normalizeJava(String language, String script) {
        if (script == null || !"java".equals(language) || script.contains("public class")) {
            return script;
        }
        return script.replaceFirst("(?m)^(\\s*)class\\s+Main\\b", "$1public class Main");
    }
    private ServiceUnavailableException fromStatus(int status) {
        log.warn("JDoodle rejected the request with status {}", status);
        return switch (status) {
            case 401 -> new ServiceUnavailableException(CREDENTIALS_REJECTED,
                    "The code execution service rejected this server's credentials. The operator must check them.");
            case 429 -> new ServiceUnavailableException(QUOTA_EXCEEDED,
                    "The daily code-execution quota is used up. Try again after it resets.");
            default -> new ServiceUnavailableException(UNAVAILABLE, "The code execution service is unavailable.");
        };
    }

    private static Integer parseInt(String s) {
        if (s == null) {
            return null;
        }
        try {
            return Integer.valueOf(s.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private static Double parseDouble(String s) {
        if (s == null) {
            return null;
        }
        try {
            return Double.valueOf(s.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
