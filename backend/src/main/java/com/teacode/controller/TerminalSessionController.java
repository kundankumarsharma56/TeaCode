package com.teacode.controller;

import com.teacode.dto.LanguageDto;
import com.teacode.dto.TerminalSessionRequest;
import com.teacode.dto.TerminalSessionResponse;
import com.teacode.exception.BadRequestException;
import com.teacode.exception.ServiceUnavailableException;
import com.teacode.execution.LanguageRegistry;
import com.teacode.security.AuthUser;
import com.teacode.service.RateLimiter;
import java.net.http.HttpClient;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.client.JdkClientHttpRequestFactory;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientException;
import org.springframework.web.server.ResponseStatusException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Issues one-use credentials for the isolated interactive runner. The browser never receives the internal
 * runner credential, and arbitrary code is never executed in the application JVM.
 */
@RestController
public class TerminalSessionController {
    private final LanguageRegistry languages;
    private final RateLimiter limiter;
    private final RestClient runner;
    private final String internalToken;
    private static final Logger log = LoggerFactory.getLogger(TerminalSessionController.class);

    public TerminalSessionController(LanguageRegistry languages, RateLimiter limiter,
                                     @Value("${TERMINAL_RUNNER_URL:http://terminal-runner:3000}") String runnerUrl,
                                     @Value("${TERMINAL_RUNNER_INTERNAL_TOKEN:}") String internalToken) {
        this.languages = languages;
        this.limiter = limiter;
        this.internalToken = internalToken;
        var client = HttpClient.newBuilder().version(HttpClient.Version.HTTP_1_1).connectTimeout(Duration.ofSeconds(3)).build();
        var factory = new JdkClientHttpRequestFactory(client);
        factory.setReadTimeout(Duration.ofSeconds(5));
        this.runner = RestClient.builder().baseUrl(runnerUrl).requestFactory(factory).build();
    }

    private boolean runnerConfigured() {
        return internalToken != null && internalToken.length() >= 32;
    }

    /**
     * Languages the Terminal can run right now. Program languages need only the isolated runner (no JDoodle account);
     * SQL needs the one-shot compiler. Nothing is listed that this server cannot execute, and the runner's own
     * toolchain versions are not claimed here (the JDoodle version strings would be wrong for the runner images).
     */
    @GetMapping("/api/v1/terminal/languages")
    public List<LanguageDto> terminalLanguages() {
        List<LanguageDto> out = new ArrayList<>();
        if (runnerConfigured()) {
            for (var l : languages.interactive()) {
                out.add(new LanguageDto(l.key(), l.name(), null, l.kind().name(), l.extension(), l.toolchain()));
            }
        }
        languages.find("sql").ifPresent(l ->
                out.add(new LanguageDto(l.key(), l.name(), l.version(), l.kind().name(), l.extension(), l.toolchain())));
        return out;
    }

    @PostMapping("/api/v1/terminal/sessions")
    public TerminalSessionResponse create(@AuthenticationPrincipal AuthUser user, HttpServletRequest http,
                                          @Valid @RequestBody TerminalSessionRequest request) {
        if ("sql".equals(request.language())) {
            throw new BadRequestException("SQL uses the existing one-shot compiler and does not support interactive sessions.");
        }
        var language = languages.findInteractive(request.language())
                .orElseThrow(() -> new BadRequestException("That language is not available."));
        // Public Terminal: anonymous visitors are limited per client address, not through one shared bucket.
        String key = user == null ? "ip:" + http.getRemoteAddr() : Long.toString(user.id());
        limiter.check("terminal-session", key, 10, Duration.ofMinutes(1));
        if (!runnerConfigured()) {
            throw new ServiceUnavailableException("TERMINAL_RUNNER_NOT_CONFIGURED",
                    "Interactive execution is not configured on this server.");
        }
        try {
            TerminalSessionResponse response = runner.post().uri("/sessions")
                    .header("X-Internal-Token", internalToken)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Map.of("language", language.key()))
                    .retrieve()
                    .onStatus(status -> status.value() == 429, (req, res) -> {
                        throw new ResponseStatusException(HttpStatus.TOO_MANY_REQUESTS, "Interactive runner is busy.");
                    })
                    .body(TerminalSessionResponse.class);
            if (response == null || response.sessionId() == null || response.token() == null) {
                throw new RestClientException("Runner returned an invalid session response");
            }
            return response;
        } catch (ResponseStatusException e) {
            if (e.getStatusCode().value() == HttpStatus.TOO_MANY_REQUESTS.value()) {
                throw new com.teacode.exception.TooManyRequestsException();
            }
            throw e;
        } catch (RestClientException e) {
               log.error("Terminal runner call failed ({}): {}", e.getClass().getSimpleName(), e.getMessage());
               throw new ServiceUnavailableException("TERMINAL_RUNNER_UNAVAILABLE",
                    "The interactive execution service is unavailable. Try again shortly.");
        }
    }
}