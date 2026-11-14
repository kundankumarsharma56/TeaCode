package com.teacode.service;

import com.teacode.audit.AuditService;
import com.teacode.entity.OAuthIdentity;
import com.teacode.entity.User;
import com.teacode.repository.OAuthIdentityRepository;
import com.teacode.repository.RefreshSessionRepository;
import com.teacode.repository.UserRepository;
import com.teacode.security.OAuthLoginException;
import com.teacode.security.OAuthProfile;
import com.teacode.security.TokenService;
import java.security.SecureRandom;
import java.time.Clock;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Optional;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

/**
 * Turns a provider-verified identity into a local session.
 * Rules: a known provider identity signs in directly; otherwise the provider must vouch for a verified
 * email. An existing account with that email is linked; if that account's email was never verified, its
 * password is replaced with an unusable one and its sessions are revoked, so whoever pre-registered the
 * address (without proving ownership) cannot keep access. Otherwise a new verified account is created.
 */
@Service
public class OAuthLoginService {

    private static final SecureRandom RANDOM = new SecureRandom();

    private final UserRepository users;
    private final OAuthIdentityRepository identities;
    private final RefreshSessionRepository sessions;
    private final PasswordEncoder encoder;
    private final TokenService tokens;
    private final AuthService auth;
    private final AuditService audit;
    private final RateLimiter limiter;
    private final TransactionTemplate tx;
    private final Clock clock;

    public OAuthLoginService(UserRepository users, OAuthIdentityRepository identities, RefreshSessionRepository sessions,
                             PasswordEncoder encoder, TokenService tokens, AuthService auth, AuditService audit,
                             RateLimiter limiter, TransactionTemplate tx, Clock clock) {
        this.users = users;
        this.identities = identities;
        this.sessions = sessions;
        this.encoder = encoder;
        this.tokens = tokens;
        this.auth = auth;
        this.audit = audit;
        this.limiter = limiter;
        this.tx = tx;
        this.clock = clock;
    }

    private LocalDateTime now() {
        return LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
    }

    public AuthService.AuthResult signIn(OAuthProfile p, String ip) {
        limiter.check("oauth-ip", ip, 30, Duration.ofMinutes(15));
        if (p.subject() == null || p.subject().isBlank()) {
            throw new OAuthLoginException("failed");
        }
        Long userId;
        try {
            userId = tx.execute(status -> resolveUser(p));
        } catch (OAuthLoginException e) {
            audit.record(null, "OAUTH_LOGIN", "DENIED", ip, p.provider() + ":" + e.getCode());
            throw e;
        } catch (DataIntegrityViolationException e) {
            // Concurrent first sign-in created the same identity or username; the caller can simply retry.
            audit.record(null, "OAUTH_LOGIN", "FAILURE", ip, p.provider() + ":conflict");
            throw new OAuthLoginException("failed");
        }
        AuthService.AuthResult result = auth.startSession(userId);
        audit.record(userId, "OAUTH_LOGIN", "SUCCESS", ip, p.provider());
        return result;
    }

    /** Runs inside a transaction. */
    private Long resolveUser(OAuthProfile p) {
        Optional<OAuthIdentity> known = identities.findByProviderAndProviderUserId(p.provider(), p.subject());
        if (known.isPresent()) {
            OAuthIdentity identity = known.get();
            User user = users.findById(identity.getUserId()).orElseThrow(() -> new OAuthLoginException("failed"));
            if (!user.isActive()) {
                throw new OAuthLoginException("account_disabled");
            }
            if (p.avatarUrl() != null && !p.avatarUrl().equals(identity.getAvatarUrl())) {
                identity.setAvatarUrl(truncate(p.avatarUrl(), 500));
            }
            return user.getId();
        }

        if (p.email() == null || p.email().isBlank() || !p.emailVerified()) {
            throw new OAuthLoginException("email_unverified");
        }
        String email = AuthService.normalizeEmail(p.email());

        Optional<User> existing = users.findByEmail(email);
        if (existing.isPresent()) {
            User user = existing.get();
            if (!user.isActive()) {
                throw new OAuthLoginException("account_disabled");
            }
            if (!user.isEmailVerified()) {
                user.setPasswordHash(encoder.encode(tokens.newOpaqueToken()));
                user.setEmailVerified(true);
                sessions.revokeAllForUser(user.getId(), now());
            }
            identities.save(new OAuthIdentity(user.getId(), p.provider(), p.subject(), truncate(p.avatarUrl(), 500)));
            return user.getId();
        }

        User created = new User(freeUsername(p.displayName(), email), email, encoder.encode(tokens.newOpaqueToken()));
        created.setEmailVerified(true);
        created = users.saveAndFlush(created);
        identities.save(new OAuthIdentity(created.getId(), p.provider(), p.subject(), truncate(p.avatarUrl(), 500)));
        return created.getId();
    }

    /** 3-30 characters of letters, digits and underscore (the same rule as registration), unique case-insensitively. */
    private String freeUsername(String displayName, String email) {
        String base = sanitize(displayName);
        if (base.length() < 3) {
            base = sanitize(email.substring(0, email.indexOf('@')));
        }
        if (base.length() < 3) {
            base = "user";
        }
        if (base.length() > 24) {
            base = base.substring(0, 24);
        }
        if (!users.existsByUsernameIgnoreCase(base)) {
            return base;
        }
        for (int i = 0; i < 20; i++) {
            String candidate = base + "_" + (1000 + RANDOM.nextInt(9000));
            if (!users.existsByUsernameIgnoreCase(candidate)) {
                return candidate;
            }
        }
        return "user_" + Long.toHexString(RANDOM.nextLong() & 0xFFFFFFFFFL);
    }

    private static String sanitize(String s) {
        return s == null ? "" : s.replaceAll("[^A-Za-z0-9_]", "_").replaceAll("_+", "_").replaceAll("^_|_$", "");
    }

    private static String truncate(String s, int max) {
        return s == null ? null : s.length() <= max ? s : null; // an over-long URL is dropped rather than cut
    }
}
