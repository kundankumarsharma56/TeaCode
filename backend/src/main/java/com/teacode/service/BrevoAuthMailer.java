package com.teacode.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.teacode.config.AppProperties;
import com.teacode.exception.MailDeliveryException;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.stereotype.Component;
import org.springframework.web.util.HtmlUtils;

/**
 * Sends account emails through the Brevo HTTPS API (Render free blocks SMTP ports). Active only when
 * TEACODE_MAIL_PROVIDER=brevo. Needs BREVO_API_KEY and MAIL_FROM (a plain address verified in Brevo).
 * Sending is synchronous: any failure throws MailDeliveryException. Recipients, codes, links and Brevo response
 * bodies are never logged.
 */
@Component
@ConditionalOnExpression("'${TEACODE_MAIL_PROVIDER:smtp}' == 'brevo'")
public class BrevoAuthMailer implements AuthMailer {

    private static final Logger log = LoggerFactory.getLogger(BrevoAuthMailer.class);
    private static final URI ENDPOINT = URI.create("https://api.brevo.com/v3/smtp/email");

    private final HttpClient http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(5)).build();
    private final ObjectMapper json = new ObjectMapper();
    private final String apiKey;
    private final String from;

    public BrevoAuthMailer(@Value("${BREVO_API_KEY:}") String apiKey, AppProperties props) {
        this.apiKey = apiKey == null ? "" : apiKey.trim();
        this.from = props.mailFrom() == null ? "" : props.mailFrom().trim();
    }

    @Override
    public void sendOtp(String to, String purpose, String code, int minutes) {
        deliver(to, OtpMail.subject(purpose), OtpMail.text(purpose, code, minutes), OtpMail.html(purpose, code, minutes));
    }

    @Override
    public void sendVerification(String to, String link) {
        deliver(to, "Verify your TeaCode email",
                "Verify your email address by opening this link (valid for 24 hours):\n" + link,
                "<p>Verify your email address by opening this link (valid for 24 hours):</p><p><a href=\""
                        + HtmlUtils.htmlEscape(link) + "\">Verify email address</a></p>");
    }

    @Override
    public void sendPasswordReset(String to, String link) {
        deliver(to, "Reset your TeaCode password",
                "Choose a new password using this link (valid for 1 hour):\n" + link,
                "<p>Choose a new password using this link (valid for 1 hour):</p><p><a href=\""
                        + HtmlUtils.htmlEscape(link) + "\">Choose a new password</a></p>");
    }

    private void deliver(String to, String subject, String text, String html) {
        if (apiKey.isEmpty() || from.isEmpty()) {
            log.error("Email is not configured (BREVO_API_KEY / MAIL_FROM); the message '{}' was NOT sent", subject);
            throw new MailDeliveryException();
        }
        try {
            Map<String, Object> body = Map.of(
                    "sender", Map.of("name", "TeaCode", "email", from),
                    "to", List.of(Map.of("email", to)),
                    "subject", subject,
                    "textContent", text,
                    "htmlContent", html);
            HttpRequest request = HttpRequest.newBuilder(ENDPOINT)
                    .timeout(Duration.ofSeconds(10))
                    .header("api-key", apiKey)
                    .header("Content-Type", "application/json")
                    .header("Accept", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(json.writeValueAsString(body)))
                    .build();
            HttpResponse<Void> response = http.send(request, HttpResponse.BodyHandlers.discarding());
            if (response.statusCode() / 100 != 2) {
                log.error("Brevo did not accept the email '{}': HTTP {}", subject, response.statusCode());
                throw new MailDeliveryException();
            }
        } catch (IOException e) {
            log.error("Sending email '{}' through Brevo failed: {}", subject, e.getClass().getSimpleName());
            throw new MailDeliveryException();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            log.error("Sending email '{}' through Brevo was interrupted", subject);
            throw new MailDeliveryException();
        }
    }
}