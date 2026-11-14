package com.teacode.config;

import jakarta.annotation.PostConstruct;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

/**
 * Refuses to start the {@code prod} profile with settings that would silently weaken security:
 * a non-HTTPS public URL (Secure cookies and HSTS cannot work) or Secure cookies switched off.
 * Local HTTP testing uses the {@code dev} profile (see docker-compose.dev.yml), never a relaxed prod.
 */
@Component
@Profile("prod")
public class ProductionGuard {

    private final AppProperties props;

    public ProductionGuard(AppProperties props) {
        this.props = props;
    }

    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ProductionGuard.class);

    @PostConstruct
    void verify() {
        check(props.publicUrl(), props.security().cookieSecure());
        if (looksLikePlaceholder(props.publicUrl())) {
            // Not fatal (the operator may be mid-setup), but every browser POST from a different origin is refused with 403.
            log.error("APP_PUBLIC_URL points at a reserved/placeholder host. Browsers that open the site at any other address "
                    + "will get HTTP 403 on login, signup and the Terminal. Set APP_PUBLIC_URL to the real https:// origin.");
        }
    }

    /** True for reserved test hosts (.invalid, .example, .test, example.com/net/org), which can never be a real deployment. */
    static boolean looksLikePlaceholder(String publicUrl) {
        try {
            String host = java.net.URI.create(publicUrl.trim()).getHost();
            if (host == null) {
                return true;
            }
            String h = host.toLowerCase(java.util.Locale.ROOT);
            return h.endsWith(".invalid") || h.endsWith(".example") || h.endsWith(".test")
                    || h.equals("example.com") || h.equals("example.net") || h.equals("example.org")
                    || h.endsWith(".example.com") || h.endsWith(".example.net") || h.endsWith(".example.org");
        } catch (RuntimeException e) {
            return true;
        }
    }

    static void check(String publicUrl, boolean cookieSecure) {
        if (publicUrl == null || !publicUrl.toLowerCase(java.util.Locale.ROOT).startsWith("https://")) {
            throw new IllegalStateException("APP_PUBLIC_URL must be an https:// URL in the prod profile "
                    + "(for local HTTP testing use SPRING_PROFILES_ACTIVE=dev, see docker-compose.dev.yml).");
        }
        if (!cookieSecure) {
            throw new IllegalStateException("teacode.security.cookie-secure must stay true in the prod profile.");
        }
    }
}
