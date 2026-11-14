package com.teacode.security;

import com.teacode.config.AppProperties;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import java.nio.charset.StandardCharsets;
import java.time.Clock;
import java.time.Duration;
import java.time.Instant;
import java.util.Date;
import javax.crypto.SecretKey;
import org.springframework.stereotype.Component;

/**
 * Short-lived access tokens. The signature, issuer and expiry are validated here; revocation is
 * enforced separately by checking the referenced server-side session on every request.
 */
@Component
public class JwtService {

    private final SecretKey key;
    private final String issuer;
    private final Duration ttl;
    private final Clock clock;

    public JwtService(AppProperties props, Clock clock) {
        rejectPlaceholderSecret(props.security().jwtSecret());
        this.key = Keys.hmacShaKeyFor(props.security().jwtSecret().getBytes(StandardCharsets.UTF_8));
        this.issuer = props.security().jwtIssuer();
        this.ttl = Duration.ofMinutes(props.security().accessTtlMinutes());
        this.clock = clock;
    }

    /** Fails startup for secrets that are obviously not random (repeated characters, copied placeholders). */
    static void rejectPlaceholderSecret(String secret) {
        String lower = secret.toLowerCase(java.util.Locale.ROOT);
        long distinct = secret.chars().distinct().count();
        if (distinct < 10 || lower.contains("change-me") || lower.contains("changeme") || lower.contains("your-secret")) {
            throw new IllegalStateException("JWT_SECRET looks like a placeholder; generate one with: openssl rand -base64 48");
        }
    }

    public String issue(long userId, long sessionId) {
        Instant now = clock.instant();
        return Jwts.builder()
                .issuer(issuer)
                .subject(Long.toString(userId))
                .claim("sid", Long.toString(sessionId))
                .issuedAt(Date.from(now))
                .expiration(Date.from(now.plus(ttl)))
                .signWith(key)
                .compact();
    }

    /** Throws JwtException for a bad signature, wrong issuer, expiry or malformed token. */
    public Claims parse(String token) {
        return Jwts.parser()
                .verifyWith(key)
                .requireIssuer(issuer)
                .clock(() -> Date.from(clock.instant()))
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    public Duration ttl() {
        return ttl;
    }

    /** Convenience for callers that only need a boolean. */
    public boolean isValid(String token) {
        try {
            parse(token);
            return true;
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }
}
