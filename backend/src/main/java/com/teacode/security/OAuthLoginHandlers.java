package com.teacode.security;

import com.teacode.config.AppProperties;
import com.teacode.service.AuthService;
import com.teacode.service.OAuthLoginService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

/**
 * Ends the OAuth2 handshake. On success it issues the same HttpOnly session cookies as a password login and
 * sends the browser to the dashboard; on any problem it sends the browser to /login with a short error code
 * (never an exception message). The temporary handshake session is always discarded.
 */
@Component
public class OAuthLoginHandlers implements AuthenticationSuccessHandler, AuthenticationFailureHandler {

    private static final Logger log = LoggerFactory.getLogger(OAuthLoginHandlers.class);

    private final OAuthLoginService login;
    private final CookieService cookies;
    private final String base;

    public OAuthLoginHandlers(OAuthLoginService login, CookieService cookies, AppProperties props) {
        this.login = login;
        this.cookies = cookies;
        this.base = props.publicUrl().replaceAll("/+$", "");
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException {
        discardHandshakeSession(request);
        if (!(authentication instanceof OAuth2AuthenticationToken token)) {
            response.sendRedirect(errorUrl("failed"));
            return;
        }
        try {
            OAuthProfile profile = OAuthProfile.from(token.getAuthorizedClientRegistrationId(), token.getPrincipal().getAttributes());
            AuthService.AuthResult result = login.signIn(profile, request.getRemoteAddr());
            cookies.addSessionCookies(response, result.accessToken(), result.refreshToken());
            response.sendRedirect(base + "/dashboard");
        } catch (OAuthLoginException e) {
            response.sendRedirect(errorUrl(e.getCode()));
        } catch (RuntimeException e) {
            log.error("OAuth sign-in failed", e);
            response.sendRedirect(errorUrl("failed"));
        }
    }

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception)
            throws IOException {
        discardHandshakeSession(request);
        log.info("OAuth2 handshake rejected: {}", exception.getClass().getSimpleName());
        response.sendRedirect(errorUrl("denied"));
    }

    private String errorUrl(String code) {
        return base + "/login?oauth_error=" + code;
    }

    private static void discardHandshakeSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
