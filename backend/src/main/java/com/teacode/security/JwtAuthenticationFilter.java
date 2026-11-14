package com.teacode.security;

import com.teacode.entity.RefreshSession;
import com.teacode.entity.User;
import com.teacode.repository.RefreshSessionRepository;
import com.teacode.repository.UserRepository;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.Clock;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Optional;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Authenticates a request from the access cookie. A valid signature is not enough: the session the
 * token points at must still exist, be unrevoked and unexpired, and the user must be active. That is
 * what makes logout, password change and account suspension take effect immediately.
 * Any failure simply leaves the request anonymous; protected routes then answer 401.
 */
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwt;
    private final RefreshSessionRepository sessions;
    private final UserRepository users;
    private final Clock clock;

    public JwtAuthenticationFilter(JwtService jwt, RefreshSessionRepository sessions, UserRepository users, Clock clock) {
        this.jwt = jwt;
        this.sessions = sessions;
        this.users = users;
        this.clock = clock;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {
        String token = readCookie(request, CookieService.ACCESS);
        if (token != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            authenticate(token).ifPresent(user -> {
                var auth = new UsernamePasswordAuthenticationToken(
                        user, null, List.of(new SimpleGrantedAuthority("ROLE_" + user.role())));
                SecurityContextHolder.getContext().setAuthentication(auth);
            });
        }
        chain.doFilter(request, response);
    }

    private Optional<AuthUser> authenticate(String token) {
        try {
            Claims claims = jwt.parse(token);
            long userId = Long.parseLong(claims.getSubject());
            long sessionId = Long.parseLong(claims.get("sid", String.class));

            Optional<RefreshSession> session = sessions.findById(sessionId);
            LocalDateTime now = LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
            if (session.isEmpty()
                    || session.get().getUserId() != userId
                    || session.get().getRevokedAt() != null
                    || !session.get().getExpiresAt().isAfter(now)) {
                return Optional.empty();
            }
            Optional<User> user = users.findById(userId);
            if (user.isEmpty() || !user.get().isActive()) {
                return Optional.empty();
            }
            return Optional.of(new AuthUser(userId, user.get().getUsername(), user.get().getRole(), sessionId));
        } catch (JwtException | IllegalArgumentException e) {
            // Includes NumberFormatException (an IllegalArgumentException) for malformed claims.
            return Optional.empty();
        }
    }

    static String readCookie(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return null;
        }
        for (Cookie c : cookies) {
            if (name.equals(c.getName()) && c.getValue() != null && !c.getValue().isBlank()) {
                return c.getValue();
            }
        }
        return null;
    }
}
