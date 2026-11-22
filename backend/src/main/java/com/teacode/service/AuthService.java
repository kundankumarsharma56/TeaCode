package com.teacode.service;

import com.teacode.audit.AuditService;
import com.teacode.config.AppProperties;
import com.teacode.dto.RegisterRequest;
import com.teacode.dto.UserResponse;
import com.teacode.entity.EmailVerificationToken;
import com.teacode.entity.EmailOtp;
import com.teacode.entity.PasswordResetToken;
import com.teacode.entity.PolicyAcceptance;
import com.teacode.entity.RefreshSession;
import com.teacode.entity.User;
import com.teacode.exception.BadRequestException;
import com.teacode.exception.ConflictException;
import com.teacode.exception.MailDeliveryException;
import com.teacode.exception.UnauthorizedException;
import com.teacode.repository.EmailVerificationTokenRepository;
import com.teacode.repository.PasswordResetTokenRepository;
import com.teacode.repository.PolicyAcceptanceRepository;
import com.teacode.repository.RefreshSessionRepository;
import com.teacode.repository.UserRepository;
import com.teacode.security.JwtService;
import com.teacode.security.TokenService;
import java.time.Clock;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Locale;
import java.util.Optional;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

/**
 * Registration, login, session refresh/rotation, logout, email verification and password reset.
 * Multi-step database work runs inside TransactionTemplate blocks; emails are sent only after commit.
 */
@Service
public class AuthService {

    /** A refresh token revoked less than this long ago is a benign race, not token theft. */
    static final long REUSE_GRACE_SECONDS = 10;

    public static final String BAD_LINK = "This link is invalid or has expired.";
    public static final String BAD_CODE = "This code is invalid or has expired.";

    /** Result of a successful login or refresh: the user view plus the raw cookie values to set. */
    public record AuthResult(UserResponse user, String accessToken, String refreshToken) {
    }

    private final UserRepository users;
    private final RefreshSessionRepository sessions;
    private final EmailVerificationTokenRepository verificationTokens;
    private final PasswordResetTokenRepository resetTokens;
    private final PolicyAcceptanceRepository policies;
    private final PasswordEncoder encoder;
    private final TokenService tokens;
    private final JwtService jwt;
    private final AuthMailer mailer;
    private final AuditService audit;
    private final RateLimiter limiter;
    private final TransactionTemplate tx;
    private final AppProperties props;
    private final Clock clock;
    private final UserViewService views;
    private final OtpService otp;
    /** When false, accounts are verified at registration and no verification email is sent. */
    @org.springframework.beans.factory.annotation.Value("${TEACODE_REQUIRE_EMAIL_VERIFICATION:true}")
    private boolean requireEmailVerification = true;
    /** Verified against when the account does not exist, so login timing does not reveal which emails are registered. */
    private final String dummyHash;

    public AuthService(UserRepository users, RefreshSessionRepository sessions,
                       EmailVerificationTokenRepository verificationTokens, PasswordResetTokenRepository resetTokens,
                       PolicyAcceptanceRepository policies, PasswordEncoder encoder, TokenService tokens,
                       JwtService jwt, AuthMailer mailer, AuditService audit, RateLimiter limiter,
                       TransactionTemplate tx, AppProperties props, Clock clock, UserViewService views,
                       OtpService otp) {
        this.views = views;
        this.otp = otp;
        this.users = users;
        this.sessions = sessions;
        this.verificationTokens = verificationTokens;
        this.resetTokens = resetTokens;
        this.policies = policies;
        this.encoder = encoder;
        this.tokens = tokens;
        this.jwt = jwt;
        this.mailer = mailer;
        this.audit = audit;
        this.limiter = limiter;
        this.tx = tx;
        this.props = props;
        this.clock = clock;
        this.dummyHash = encoder.encode(tokens.newOpaqueToken());
    }

    public static String normalizeEmail(String email) {
        return email.trim().toLowerCase(Locale.ROOT);
    }

    private LocalDateTime now() {
        return LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
    }

    private String link(String path, String rawToken) {
        String base = props.publicUrl().endsWith("/")
                ? props.publicUrl().substring(0, props.publicUrl().length() - 1)
                : props.publicUrl();
        return base + path + "?token=" + rawToken;
    }

    // ---------------------------------------------------------------- registration

    /**
     * Creates the account. With email verification on, the account stays unverified until the 6-digit code from
     * the email is accepted (verifyOtp). Registering again with an email whose account is still unverified replaces
     * its username and password and sends a new code, so nobody can lock an address they do not own.
     * Returns true when a code was emailed.
     */
    public boolean register(RegisterRequest req, String ip) {
        limiter.check("register-ip", ip, 10, Duration.ofHours(1));
        String email = normalizeEmail(req.email());
        String username = req.username().trim();
        if (requireEmailVerification) {
            limiter.check("register-email", email, 3, Duration.ofHours(1));
        }
        // Always hash, so response time is the same for every outcome.
        String hash = encoder.encode(req.password());

        String code;
        try {
            code = tx.execute(status -> {
                User existing = users.findByEmail(email).orElse(null);
                if (existing != null) {
                    if (!requireEmailVerification || existing.isEmailVerified() || !existing.isActive()) {
                        throw new ConflictException("This email is already registered. Sign in instead.");
                    }
                    if (!existing.getUsername().equalsIgnoreCase(username) && users.existsByUsernameIgnoreCase(username)) {
                        throw new ConflictException("Username is not available.");
                    }
                    existing.setUsername(username);
                    existing.setPasswordHash(hash);
                    sessions.revokeAllForUser(existing.getId(), now());
                    return otp.issue(existing.getId(), EmailOtp.VERIFY);
                }
                if (users.existsByUsernameIgnoreCase(username)) {
                    throw new ConflictException("Username is not available.");
                }
                User user = users.save(new User(username, email, hash));
                policies.save(new PolicyAcceptance(user.getId(), "TERMS", req.policyVersion()));
                policies.save(new PolicyAcceptance(user.getId(), "PRIVACY", req.policyVersion()));
                if (!requireEmailVerification) {
                    user.setEmailVerified(true);
                    return "";
                }
                return otp.issue(user.getId(), EmailOtp.VERIFY);
            });
        } catch (DataIntegrityViolationException e) {
            // Lost a race on a unique constraint (username or email).
            throw new ConflictException("Email or username is not available.");
        }

        if (code == null || code.isEmpty()) {
            audit.record(null, "REGISTER", "SUCCESS", ip, "email verification off");
            return false;
        }
        try {
            mailer.sendOtp(email, EmailOtp.VERIFY, code, OtpService.CODE_MINUTES);
        } catch (MailDeliveryException e) {
            audit.record(null, "REGISTER", "MAIL_FAILED", ip, null);
            throw e;
        }
        audit.record(null, "REGISTER", "SUCCESS", ip, "code sent");
        return true;
    }

    /** Checks the emailed code, marks the email verified and signs the user in. One message for every failure. */
    public AuthResult verifyOtp(String rawEmail, String code, String ip) {
        String email = normalizeEmail(rawEmail);
        limiter.check("otp-ip", ip, 30, Duration.ofHours(1));
        limiter.check("otp-email", email, 15, Duration.ofHours(1));
        User found = users.findByEmail(email).filter(u -> u.isActive() && !u.isEmailVerified()).orElse(null);
        if (found == null) {
            throw new BadRequestException(BAD_CODE);
        }
        long userId = found.getId();
        Boolean ok = tx.execute(status -> {
            if (!otp.verify(userId, EmailOtp.VERIFY, code)) {
                return false;
            }
            users.findById(userId).orElseThrow().setEmailVerified(true);
            return true;
        });
        if (!Boolean.TRUE.equals(ok)) {
            audit.record(userId, "EMAIL_VERIFIED", "FAILURE", ip, "wrong or expired code");
            throw new BadRequestException(BAD_CODE);
        }
        audit.record(userId, "EMAIL_VERIFIED", "SUCCESS", ip, "code");
        return startSession(userId);
    }

    /** Sends a fresh code to an unverified account. Does nothing for unknown or already verified emails. */
    public void resendOtp(String rawEmail, String ip) {
        String email = normalizeEmail(rawEmail);
        limiter.check("otp-resend-ip", ip, 10, Duration.ofHours(1));
        limiter.check("otp-resend-email", email, 5, Duration.ofHours(1));
        limiter.check("otp-resend-wait", email, 1, Duration.ofSeconds(60));
        User user = users.findByEmail(email).filter(u -> u.isActive() && !u.isEmailVerified()).orElse(null);
        if (user == null || !requireEmailVerification) {
            return;
        }
        long userId = user.getId();
        String code = tx.execute(status -> otp.issue(userId, EmailOtp.VERIFY));
        mailer.sendOtp(email, EmailOtp.VERIFY, code, OtpService.CODE_MINUTES);
        audit.record(userId, "OTP_RESENT", "SUCCESS", ip, null);
    }

    /** Must be called inside a transaction. */
    private String issueVerificationToken(Long userId) {
        verificationTokens.invalidateAllForUser(userId, now());
        String raw = tokens.newOpaqueToken();
        verificationTokens.save(new EmailVerificationToken(userId, tokens.hash(raw), now().plusHours(24)));
        return raw;
    }

    public void verifyEmail(String rawToken, String ip) {
        limiter.check("verify-ip", ip, 20, Duration.ofHours(1));
        Optional<EmailVerificationToken> found = verificationTokens.findByTokenHash(tokens.hash(rawToken));
        if (found.isEmpty()) {
            throw new BadRequestException(BAD_LINK);
        }
        EmailVerificationToken token = found.get();
        Boolean ok = tx.execute(status -> {
            if (verificationTokens.consume(token.getId(), now()) == 0) {
                return false;
            }
            User user = users.findById(token.getUserId()).orElseThrow();
            user.setEmailVerified(true);
            return true;
        });
        if (!Boolean.TRUE.equals(ok)) {
            throw new BadRequestException(BAD_LINK);
        }
        audit.record(token.getUserId(), "EMAIL_VERIFIED", "SUCCESS", ip, null);
    }

    // ---------------------------------------------------------------- login / sessions

    public AuthResult login(String rawEmail, String password, String ip) {
        String email = normalizeEmail(rawEmail);
        limiter.check("login-ip", ip, 30, Duration.ofMinutes(15));
        limiter.check("login-email", email, 10, Duration.ofMinutes(15));

        User user = users.findByEmail(email).orElse(null);
        boolean passwordOk = encoder.matches(password, user != null ? user.getPasswordHash() : dummyHash);
        if (user == null || !passwordOk || !user.isActive()) {
            audit.record(user != null ? user.getId() : null, "LOGIN", "FAILURE", ip, null);
            throw new UnauthorizedException("Invalid email or password.");
        }
        if (requireEmailVerification && !user.isEmailVerified()) {
            audit.record(user.getId(), "LOGIN", "DENIED", ip, "email not verified");
            throw new com.teacode.exception.ForbiddenException("EMAIL_UNVERIFIED", "Verify your email address before signing in.");
        }
        Long userId = user.getId();
        AuthResult result = tx.execute(status -> {
            User fresh = users.findById(userId).orElseThrow();
            fresh.setLastLoginAt(now());
            return createSession(fresh, null);
        });
        audit.record(userId, "LOGIN", "SUCCESS", ip, null);
        return result;
    }

    /** Starts a session for an already-authenticated user (used after a provider sign-in). */
    public AuthResult startSession(long userId) {
        return tx.execute(status -> {
            User user = users.findById(userId).filter(User::isActive).orElseThrow(() -> new UnauthorizedException("Not signed in."));
            user.setLastLoginAt(now());
            return createSession(user, null);
        });
    }

    /** Must be called inside a transaction. */
    private AuthResult createSession(User user, Long rotatedFromSessionId) {
        String raw = tokens.newOpaqueToken();
        RefreshSession session = sessions.save(new RefreshSession(
                user.getId(), tokens.hash(raw), now().plusDays(props.security().refreshTtlDays()), rotatedFromSessionId));
        return new AuthResult(views.view(user), jwt.issue(user.getId(), session.getId()), raw);
    }

    /**
     * Rotates the refresh token. Presenting an already-used (revoked) token is treated as theft and
     * ends every session of that user.
     */
    public AuthResult refresh(String rawRefreshToken, String ip) {
        if (rawRefreshToken == null || rawRefreshToken.isBlank()) {
            throw new UnauthorizedException("Not signed in.");
        }
        limiter.check("refresh-ip", ip, 60, Duration.ofMinutes(10));
        RefreshSession session = sessions.findByTokenHash(tokens.hash(rawRefreshToken))
                .orElseThrow(() -> new UnauthorizedException("Session expired."));

        if (session.getRevokedAt() != null) {
            // A second tab or a retried request can present a token that was rotated moments ago. Within a short
            // grace window that is refused without treating it as theft; later replays still end every session.
            if (session.getRevokedAt().isAfter(now().minusSeconds(REUSE_GRACE_SECONDS))) {
                throw new UnauthorizedException("Session expired.");
            }
            tx.executeWithoutResult(status -> sessions.revokeAllForUser(session.getUserId(), now()));
            audit.record(session.getUserId(), "REFRESH_TOKEN_REUSE", "DENIED", ip, "all sessions revoked");
            throw new UnauthorizedException("Session expired.");
        }
        if (!session.getExpiresAt().isAfter(now())) {
            throw new UnauthorizedException("Session expired.");
        }
        AuthResult result = tx.execute(status -> {
            User user = users.findById(session.getUserId()).filter(User::isActive).orElse(null);
            if (user == null || sessions.revokeIfActive(session.getId(), now()) == 0) {
                return null; // inactive user, or another request rotated this token first
            }
            return createSession(user, session.getId());
        });
        if (result == null) {
            throw new UnauthorizedException("Session expired.");
        }
        return result;
    }

    /** Idempotent: unknown or already-revoked tokens are ignored. */
    public void logout(String rawRefreshToken, String ip) {
        if (rawRefreshToken == null || rawRefreshToken.isBlank()) {
            return;
        }
        sessions.findByTokenHash(tokens.hash(rawRefreshToken)).ifPresent(session -> {
            tx.executeWithoutResult(status -> sessions.revokeIfActive(session.getId(), now()));
            audit.record(session.getUserId(), "LOGOUT", "SUCCESS", ip, null);
        });
    }

    // ---------------------------------------------------------------- password reset

    /** Emails a 6-digit reset code. Does nothing for unknown emails, so the answer does not reveal them. */
    public void forgotPassword(String rawEmail, String ip) {
        String email = normalizeEmail(rawEmail);
        limiter.check("forgot-ip", ip, 10, Duration.ofHours(1));
        limiter.check("forgot-email", email, 5, Duration.ofHours(1));
        limiter.check("forgot-wait", email, 1, Duration.ofSeconds(60));

        User user = users.findByEmail(email).filter(User::isActive).orElse(null);
        if (user == null) {
            return;
        }
        long userId = user.getId();
        String code = tx.execute(status -> otp.issue(userId, EmailOtp.RESET));
        try {
            mailer.sendOtp(email, EmailOtp.RESET, code, OtpService.CODE_MINUTES);
        } catch (MailDeliveryException e) {
            audit.record(userId, "PASSWORD_RESET_REQUESTED", "MAIL_FAILED", ip, null);
            throw e;
        }
        audit.record(userId, "PASSWORD_RESET_REQUESTED", "SUCCESS", ip, "code sent");
    }

    /** Checks the emailed code, sets the new password, marks the email verified and ends every session. */
    public void resetPassword(String rawEmail, String code, String newPassword, String ip) {
        String email = normalizeEmail(rawEmail);
        limiter.check("reset-ip", ip, 20, Duration.ofHours(1));
        limiter.check("reset-email", email, 15, Duration.ofHours(1));
        // Always hash first, so response time does not depend on the email.
        String hash = encoder.encode(newPassword);
        User found = users.findByEmail(email).filter(User::isActive).orElse(null);
        if (found == null) {
            throw new BadRequestException(BAD_CODE);
        }
        long userId = found.getId();
        Boolean ok = tx.execute(status -> {
            if (!otp.verify(userId, EmailOtp.RESET, code)) {
                return false;
            }
            User user = users.findById(userId).filter(User::isActive).orElse(null);
            if (user == null) {
                return false;
            }
            user.setPasswordHash(hash);
            user.setEmailVerified(true);
            sessions.revokeAllForUser(userId, now());
            return true;
        });
        if (!Boolean.TRUE.equals(ok)) {
            audit.record(userId, "PASSWORD_RESET", "FAILURE", ip, "wrong or expired code");
            throw new BadRequestException(BAD_CODE);
        }
        audit.record(userId, "PASSWORD_RESET", "SUCCESS", ip, "all sessions revoked");
    }
}
