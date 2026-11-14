package com.teacode.security;

import com.teacode.config.AppProperties;
import java.time.Duration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

/**
 * Builds the session cookies. Both are HttpOnly and SameSite=Lax; Secure is on except in the dev profile.
 * The access cookie is sent to the whole API, the refresh cookie only to the auth endpoints.
 */
@Component
public class CookieService {

    public static final String ACCESS = "cv_access";
    public static final String REFRESH = "cv_refresh";
    private static final String ACCESS_PATH = "/api";
    private static final String REFRESH_PATH = "/api/v1/auth";

    private final boolean secure;
    private final Duration refreshTtl;
    private final Duration accessTtl;

    public CookieService(AppProperties props) {
        this.secure = props.security().cookieSecure();
        this.refreshTtl = Duration.ofDays(props.security().refreshTtlDays());
        this.accessTtl = Duration.ofMinutes(props.security().accessTtlMinutes());
    }

    private ResponseCookie build(String name, String value, String path, Duration maxAge) {
        return ResponseCookie.from(name, value)
                .httpOnly(true)
                .secure(secure)
                .sameSite("Lax")
                .path(path)
                .maxAge(maxAge)
                .build();
    }

    public ResponseEntity.BodyBuilder withSession(ResponseEntity.BodyBuilder builder, String accessToken, String refreshToken) {
        return builder
                .header(HttpHeaders.SET_COOKIE, build(ACCESS, accessToken, ACCESS_PATH, accessTtl).toString())
                .header(HttpHeaders.SET_COOKIE, build(REFRESH, refreshToken, REFRESH_PATH, refreshTtl).toString());
    }

    public ResponseEntity.BodyBuilder withClearedSession(ResponseEntity.BodyBuilder builder) {
        return builder
                .header(HttpHeaders.SET_COOKIE, build(ACCESS, "", ACCESS_PATH, Duration.ZERO).toString())
                .header(HttpHeaders.SET_COOKIE, build(REFRESH, "", REFRESH_PATH, Duration.ZERO).toString());
    }

    /** For redirect responses (OAuth2 sign-in), which are not built through ResponseEntity. */
    public void addSessionCookies(jakarta.servlet.http.HttpServletResponse response, String accessToken, String refreshToken) {
        response.addHeader(HttpHeaders.SET_COOKIE, build(ACCESS, accessToken, ACCESS_PATH, accessTtl).toString());
        response.addHeader(HttpHeaders.SET_COOKIE, build(REFRESH, refreshToken, REFRESH_PATH, refreshTtl).toString());
    }
}
