package com.teacode.security;

import com.teacode.config.AppProperties;
import java.time.Duration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

/**
 * Builds the session cookies. All are HttpOnly and SameSite=Lax; Secure is on except in the dev profile.
 * The access cookie is sent to the whole API, the refresh cookie only to the auth endpoints.
 * "Remember me" off: the refresh cookie has no expiry (it ends with the browser session). The small
 * cv_remember cookie records the choice so that /refresh keeps it.
 */
@Component
public class CookieService {

    public static final String ACCESS = "cv_access";
    public static final String REFRESH = "cv_refresh";
    public static final String REMEMBER = "cv_remember";
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

    /** A null maxAge makes a session cookie. */
    private ResponseCookie build(String name, String value, String path, Duration maxAge) {
        ResponseCookie.ResponseCookieBuilder cookie = ResponseCookie.from(name, value)
                .httpOnly(true)
                .secure(secure)
                .sameSite("Lax")
                .path(path);
        if (maxAge != null) {
            cookie.maxAge(maxAge);
        }
        return cookie.build();
    }

    /** Persistent session (remember me on). */
    public ResponseEntity.BodyBuilder withSession(ResponseEntity.BodyBuilder builder, String accessToken, String refreshToken) {
        return withSession(builder, accessToken, refreshToken, true);
    }

    public ResponseEntity.BodyBuilder withSession(ResponseEntity.BodyBuilder builder, String accessToken, String refreshToken, boolean remember) {
        ResponseEntity.BodyBuilder out = builder
                .header(HttpHeaders.SET_COOKIE, build(ACCESS, accessToken, ACCESS_PATH, accessTtl).toString());
        if (remember) {
            return out
                    .header(HttpHeaders.SET_COOKIE, build(REFRESH, refreshToken, REFRESH_PATH, refreshTtl).toString())
                    .header(HttpHeaders.SET_COOKIE, build(REMEMBER, "1", REFRESH_PATH, refreshTtl).toString());
        }
        return out
                .header(HttpHeaders.SET_COOKIE, build(REFRESH, refreshToken, REFRESH_PATH, null).toString())
                .header(HttpHeaders.SET_COOKIE, build(REMEMBER, "", REFRESH_PATH, Duration.ZERO).toString());
    }

    public ResponseEntity.BodyBuilder withClearedSession(ResponseEntity.BodyBuilder builder) {
        return builder
                .header(HttpHeaders.SET_COOKIE, build(ACCESS, "", ACCESS_PATH, Duration.ZERO).toString())
                .header(HttpHeaders.SET_COOKIE, build(REFRESH, "", REFRESH_PATH, Duration.ZERO).toString())
                .header(HttpHeaders.SET_COOKIE, build(REMEMBER, "", REFRESH_PATH, Duration.ZERO).toString());
    }

    /** For redirect responses (OAuth2 sign-in), which are not built through ResponseEntity. */
    public void addSessionCookies(jakarta.servlet.http.HttpServletResponse response, String accessToken, String refreshToken) {
        response.addHeader(HttpHeaders.SET_COOKIE, build(ACCESS, accessToken, ACCESS_PATH, accessTtl).toString());
        response.addHeader(HttpHeaders.SET_COOKIE, build(REFRESH, refreshToken, REFRESH_PATH, refreshTtl).toString());
        response.addHeader(HttpHeaders.SET_COOKIE, build(REMEMBER, "1", REFRESH_PATH, refreshTtl).toString());
    }
}
