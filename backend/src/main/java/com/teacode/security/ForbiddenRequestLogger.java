package com.teacode.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Records WHY a request ended in 403, so the cause (CORS origin mismatch, missing/mismatched CSRF token, or an
 * authorization rule) is visible in the server log instead of only as "Request failed with status code 403" in the
 * browser. Logs the method, path (no query string), the Origin the browser sent, the origin the server believes it
 * is serving, the configured public origin, and only whether the CSRF cookie/header were present. Never logs cookie
 * values, header values, tokens or request bodies.
 */
public class ForbiddenRequestLogger extends OncePerRequestFilter {

    private static final Logger log = LoggerFactory.getLogger(ForbiddenRequestLogger.class);

    private final String configuredOrigin;

    public ForbiddenRequestLogger(String publicUrl) {
        this.configuredOrigin = origin(publicUrl);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {
        chain.doFilter(request, response);
        if (response.getStatus() != HttpServletResponse.SC_FORBIDDEN) {
            return;
        }
        String browserOrigin = request.getHeader("Origin");
        String serverOrigin = request.getScheme() + "://" + request.getServerName()
                + ((request.getServerPort() == 80 || request.getServerPort() == 443) ? "" : ":" + request.getServerPort());
        boolean crossOrigin = browserOrigin != null && !browserOrigin.equalsIgnoreCase(serverOrigin);
        String likelyCause;
        if (crossOrigin && !browserOrigin.equalsIgnoreCase(configuredOrigin)) {
            likelyCause = "CORS: Origin is neither the server's own origin nor the configured APP_PUBLIC_URL origin";
        } else if (!"GET".equals(request.getMethod()) && !"HEAD".equals(request.getMethod()) && !"OPTIONS".equals(request.getMethod())
                && request.getHeader("X-XSRF-TOKEN") == null) {
            likelyCause = "CSRF: the X-XSRF-TOKEN header was missing";
        } else if (!"GET".equals(request.getMethod()) && !hasCookie(request, "XSRF-TOKEN")) {
            likelyCause = "CSRF: the XSRF-TOKEN cookie was not sent by the browser";
        } else {
            likelyCause = "CSRF token mismatch or an authorization rule";
        }
        log.warn("403 {} {} origin={} serverSeesOrigin={} configuredPublicOrigin={} xsrfCookie={} xsrfHeader={} likelyCause={}",
                request.getMethod(), request.getRequestURI(), browserOrigin, serverOrigin, configuredOrigin,
                hasCookie(request, "XSRF-TOKEN"), request.getHeader("X-XSRF-TOKEN") != null, likelyCause);
    }

    private static boolean hasCookie(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (name.equals(c.getName())) {
                    return true;
                }
            }
        }
        return false;
    }

    static String origin(String url) {
        if (url == null) {
            return "";
        }
        try {
            java.net.URI u = java.net.URI.create(url.trim());
            String scheme = u.getScheme();
            String host = u.getHost();
            if (scheme == null || host == null) {
                return "";
            }
            int port = u.getPort();
            boolean standard = port == -1 || (port == 80 && "http".equalsIgnoreCase(scheme)) || (port == 443 && "https".equalsIgnoreCase(scheme));
            return scheme.toLowerCase(java.util.Locale.ROOT) + "://" + host.toLowerCase(java.util.Locale.ROOT) + (standard ? "" : ":" + port);
        } catch (IllegalArgumentException e) {
            return "";
        }
    }
}
