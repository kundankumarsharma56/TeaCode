package com.teacode.execution;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.teacode.exception.ServiceUnavailableException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Map;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestClientResponseException;

/**
 * Client for a Judge0 CE server (default: the free public instance, no key). Used only when the environment
 * variable TEACODE_RUNNER is "judge0"; otherwise JdoodleClient uses JDoodle as before.
 * Source, stdin and output are never logged. A call is never retried automatically.
 */
public class Judge0Client {

    private static final Logger log = LoggerFactory.getLogger(Judge0Client.class);

    /** Judge0 CE language ids (public instance, checked November 2026), keyed by our JDoodle language names. */
    private static final Map<String, Integer> IDS = Map.ofEntries(
            Map.entry("java", 91), Map.entry("python3", 100), Map.entry("c", 103), Map.entry("cpp17", 105),
            Map.entry("nodejs", 102), Map.entry("typescript", 101), Map.entry("csharp", 51), Map.entry("php", 98),
            Map.entry("ruby", 72), Map.entry("go", 107), Map.entry("r", 99), Map.entry("kotlin", 111),
            Map.entry("rust", 108), Map.entry("swift", 83), Map.entry("dart", 90));

    private record Request(@JsonProperty("source_code") String sourceCode,
                           @JsonProperty("language_id") int languageId, String stdin) {
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    record Status(Integer id, String description) {
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    record Response(String stdout, String stderr, @JsonProperty("compile_output") String compileOutput,
                    String time, Double memory, Status status) {
    }

    private final RestClient client;
    private final Semaphore gate = new Semaphore(2, true);

    public Judge0Client() {
        String url = System.getenv("JUDGE0_URL");
        if (url == null || url.isBlank()) {
            url = "https://ce.judge0.com";
        }
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(5000);
        factory.setReadTimeout(60000);
        this.client = RestClient.builder().requestFactory(factory).baseUrl(url.replaceAll("/+$", "")).build();
    }

    public static boolean enabled() {
        return "judge0".equalsIgnoreCase(System.getenv("TEACODE_RUNNER"));
    }

    public JdoodleClient.Result execute(JdoodleClient.RunSpec spec) {
        Integer id = IDS.get(spec.language());
        if (id == null) {
            throw new ServiceUnavailableException(JdoodleClient.UNAVAILABLE, "This language is not available on the code execution service.");
        }
        if (spec.compileOnly()) {
            // Judge0 has no compile-only mode: a compile error is reported by the real run instead.
            return new JdoodleClient.Result("", null, null, 0);
        }
        boolean acquired = false;
        try {
            acquired = gate.tryAcquire(30, TimeUnit.SECONDS);
            if (!acquired) {
                throw new ServiceUnavailableException(JdoodleClient.BUSY, "The execution service is busy. Please try again shortly.");
            }
            String stdin = spec.stdin() == null || spec.stdin().isEmpty() ? null : b64(spec.stdin());
            Response r = client.post().uri("/submissions?base64_encoded=true&wait=true")
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(new Request(b64(spec.script()), id, stdin))
                    .retrieve()
                    .body(Response.class);
            return interpret(r);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new ServiceUnavailableException(JdoodleClient.UNAVAILABLE, "The code execution service is unavailable.");
        } catch (RestClientResponseException e) {
            int code = e.getStatusCode().value();
            log.warn("Judge0 rejected the request with status {}", code);
            if (code == 429) {
                throw new ServiceUnavailableException(JdoodleClient.QUOTA_EXCEEDED, "The code-execution limit is reached. Try again later.");
            }
            throw new ServiceUnavailableException(JdoodleClient.UNAVAILABLE, "The code execution service is unavailable.");
        } catch (RestClientException e) {
            log.warn("Judge0 call failed ({})", e.getClass().getSimpleName());
            throw new ServiceUnavailableException(JdoodleClient.UNAVAILABLE, "The code execution service is unavailable.");
        } finally {
            if (acquired) {
                gate.release();
            }
        }
    }

    JdoodleClient.Result interpret(Response r) {
        if (r == null || r.status() == null || r.status().id() == null) {
            log.warn("Judge0 returned an unreadable response");
            throw new ServiceUnavailableException(JdoodleClient.UNAVAILABLE, "The code execution service returned an unreadable response.");
        }
        int s = r.status().id();
        if (s == 6) {
            return new JdoodleClient.Result(dec(r.compileOutput()), null, null, 1);
        }
        if (s == 1 || s == 2 || s == 13 || s == 14) {
            log.warn("Judge0 returned status {}", s);
            throw new ServiceUnavailableException(JdoodleClient.UNAVAILABLE, "The code execution service is unavailable.");
        }
        Integer mem = r.memory() == null ? null : (int) Math.round(r.memory());
        Double cpu = null;
        try {
            cpu = r.time() == null ? null : Double.valueOf(r.time().trim());
        } catch (NumberFormatException e) {
            cpu = null;
        }
        StringBuilder out = new StringBuilder(dec(r.stdout()));
        if (s != 3) {
            out.append(dec(r.stderr()));
        }
        if (s == 5) {
            out.append("\nTime limit exceeded");
        } else if (s >= 7 && s <= 12) {
            out.append("\nRuntime error (").append(r.status().description()).append(")");
        }
        return new JdoodleClient.Result(out.toString(), mem, cpu, null);
    }

    private static String b64(String s) {
        return Base64.getEncoder().encodeToString(s.getBytes(StandardCharsets.UTF_8));
    }

    private static String dec(String s) {
        return s == null ? "" : new String(Base64.getMimeDecoder().decode(s), StandardCharsets.UTF_8);
    }
}