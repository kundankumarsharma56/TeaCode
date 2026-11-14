package com.teacode.service;

import com.teacode.audit.AuditService;
import com.teacode.dto.UserResponse;
import com.teacode.entity.User;
import com.teacode.exception.BadRequestException;
import com.teacode.exception.ConflictException;
import com.teacode.exception.UnauthorizedException;
import com.teacode.repository.AuditEventRepository;
import com.teacode.repository.OAuthIdentityRepository;
import com.teacode.repository.RefreshSessionRepository;
import com.teacode.repository.UserRepository;
import java.time.Clock;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

/** Profile, password change and account deletion for the signed-in user. */
@Service
public class AccountService {

    private final UserRepository users;
    private final RefreshSessionRepository sessions;
    private final AuditEventRepository auditEvents;
    private final PasswordEncoder encoder;
    private final AuditService audit;
    private final RateLimiter limiter;
    private final TransactionTemplate tx;
    private final Clock clock;
    private final UserViewService views;
    private final OAuthIdentityRepository identities;

    public AccountService(UserRepository users, RefreshSessionRepository sessions, AuditEventRepository auditEvents,
                          PasswordEncoder encoder, AuditService audit, RateLimiter limiter,
                          TransactionTemplate tx, Clock clock, UserViewService views,
                          OAuthIdentityRepository identities) {
        this.views = views;
        this.identities = identities;
        this.users = users;
        this.sessions = sessions;
        this.auditEvents = auditEvents;
        this.encoder = encoder;
        this.audit = audit;
        this.limiter = limiter;
        this.tx = tx;
        this.clock = clock;
    }

    private LocalDateTime now() {
        return LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
    }

    private User load(long userId) {
        return users.findById(userId).orElseThrow(() -> new UnauthorizedException("Not signed in."));
    }

    public UserResponse me(long userId) {
        return views.view(load(userId));
    }

    public UserResponse updateUsername(long userId, String rawUsername) {
        String username = rawUsername.trim();
        try {
            return tx.execute(status -> {
                User user = users.findById(userId).orElseThrow(() -> new UnauthorizedException("Not signed in."));
                if (users.existsByUsernameIgnoreCaseAndIdNot(username, userId)) {
                    throw new ConflictException("Username is not available.");
                }
                user.setUsername(username);
                return views.view(users.saveAndFlush(user));
            });
        } catch (DataIntegrityViolationException e) {
            throw new ConflictException("Username is not available.");
        }
    }

    /** Verifies the current password, sets the new one and ends every session (the user signs in again). */
    public void changePassword(long userId, String currentPassword, String newPassword, String ip) {
        limiter.check("change-password-user", Long.toString(userId), 5, Duration.ofMinutes(15));
        User user = load(userId);
        if (!encoder.matches(currentPassword, user.getPasswordHash())) {
            audit.record(userId, "PASSWORD_CHANGE", "FAILURE", ip, null);
            throw new BadRequestException("The current password is incorrect.");
        }
        String hash = encoder.encode(newPassword);
        tx.executeWithoutResult(status -> {
            User fresh = users.findById(userId).orElseThrow();
            fresh.setPasswordHash(hash);
            sessions.revokeAllForUser(userId, now());
        });
        audit.record(userId, "PASSWORD_CHANGE", "SUCCESS", ip, "all sessions revoked");
    }

    /**
     * Permanently deletes the account. Foreign keys cascade to sessions, tokens, submissions, progress and
     * policy acceptances. Audit rows are kept (for security investigations) but detached from the user.
     */
    public void deleteAccount(long userId, String confirmation, String ip) {
        limiter.check("delete-account-user", Long.toString(userId), 5, Duration.ofMinutes(15));
        User user = load(userId);
        boolean passwordless = identities.findByUserId(userId).stream().anyMatch(i -> "firebase".equals(i.getProvider()));
        boolean confirmed = encoder.matches(confirmation, user.getPasswordHash())
                // Email-link accounts have no password the person knows: typing their own email address confirms the request.
                || (passwordless && user.getEmail().equalsIgnoreCase(confirmation.trim()));
        if (!confirmed) {
            audit.record(userId, "ACCOUNT_DELETE", "FAILURE", ip, null);
            throw new BadRequestException(passwordless ? "That is not the email address of this account." : "The password is incorrect.");
        }
        tx.executeWithoutResult(status -> {
            auditEvents.detachUser(userId);
            users.deleteById(userId);
        });
        audit.record(null, "ACCOUNT_DELETE", "SUCCESS", ip, "account removed");
    }
}
