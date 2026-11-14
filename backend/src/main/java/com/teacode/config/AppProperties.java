
package com.teacode.config;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.validation.annotation.Validated;

/**
 * Typed application configuration.
 * Missing or invalid security settings prevent startup.
 */
@Validated
@ConfigurationProperties(prefix = "teacode")
public record AppProperties(
        @NotBlank String publicUrl,
        @DefaultValue("") String mailFrom,
        @NotNull @Valid Security security,
        @NotNull @Valid Jdoodle jdoodle,
        @DefaultValue @Valid Imports imports,
        @DefaultValue @Valid OAuth oauth) {

    /** Sign-in providers are enabled only when both credentials are set. */
    public record OAuth(
            @DefaultValue Provider google,
            @DefaultValue Provider github) {
    }

    public record Provider(
            @DefaultValue("") String clientId,
            @DefaultValue("") String clientSecret) {

        public boolean enabled() {
            return !clientId.isBlank() && !clientSecret.isBlank();
        }
    }

    public record Security(
            @NotBlank
            @Size(min = 32, message = "JWT_SECRET must be at least 32 characters")
            String jwtSecret,

            @NotBlank String jwtIssuer,

            @DefaultValue("15")
            @Min(1)
            int accessTtlMinutes,

            @DefaultValue("14")
            @Min(1)
            int refreshTtlDays,

            @DefaultValue("true")
            boolean cookieSecure) {
    }

    /**
     * JDoodle Compiler API settings. Credentials come only from the environment and never leave the server.
     * Every execution is one billable call, so concurrency, test count and job time are bounded.
     */
    public record Jdoodle(
            @DefaultValue("") String clientId,
            @DefaultValue("") String clientSecret,
            @DefaultValue("https://api.jdoodle.com") String baseUrl,
            @DefaultValue("3") @Min(1) int connectTimeoutSeconds,
            @DefaultValue("30") @Min(1) int readTimeoutSeconds,
            @DefaultValue("2") @Min(1) int maxConcurrentCalls,
            @DefaultValue("20") @Min(1) int maxTestsPerSubmission,
            @DefaultValue("180") @Min(10) int jobDeadlineSeconds,
            @DefaultValue("") String disabledLanguages) {

        public boolean configured() {
            return !clientId.isBlank() && !clientSecret.isBlank();
        }

        /** Language keys an operator switched off (comma separated), for example a language the plan cannot run. */
        public java.util.Set<String> disabledLanguageKeys() {
            java.util.Set<String> out = new java.util.HashSet<>();
            for (String k : disabledLanguages.split(",")) {
                if (!k.isBlank()) {
                    out.add(k.trim().toLowerCase(java.util.Locale.ROOT));
                }
            }
            return out;
        }
    }

    /**
 * Authorized problem-package import. There is no upload endpoint and no admin role: the operator places package
 * ZIPs in {@code folder} on the server (that act is the authorization) and they are imported automatically.
 * An empty folder setting disables the importer.
 */
    public record Imports(
            @DefaultValue("20971520") @Min(1024) long maxArchiveBytes,
            @DefaultValue("52428800") @Min(1024) long maxExpandedBytes,
            @DefaultValue("2097152") @Min(1024) long maxFileBytes,
            @DefaultValue("500") @Min(1) int maxEntries,
            @DefaultValue("") String folder,
            @DefaultValue("true") boolean autoPublish) {
    }
}
