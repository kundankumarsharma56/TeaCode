package com.teacode.service;

import com.teacode.repository.AuditEventRepository;
import com.teacode.repository.EmailVerificationTokenRepository;
import com.teacode.repository.PasswordResetTokenRepository;
import com.teacode.repository.RefreshSessionRepository;
import java.time.Clock;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * Enforces the retention behaviour the privacy pages describe: expired sessions and spent tokens are removed,
 * and audit events are kept for a bounded, configurable period. Idempotent, so running on several instances is safe.
 */
@Component
public class DataRetentionJob {

    private static final Logger log = LoggerFactory.getLogger(DataRetentionJob.class);

    private final RefreshSessionRepository sessions;
    private final EmailVerificationTokenRepository verificationTokens;
    private final PasswordResetTokenRepository resetTokens;
    private final AuditEventRepository audit;
    private final Clock clock;
    private final int auditDays;
    private final int tokenGraceDays;

    public DataRetentionJob(RefreshSessionRepository sessions, EmailVerificationTokenRepository verificationTokens,
                            PasswordResetTokenRepository resetTokens, AuditEventRepository audit, Clock clock,
                            @Value("${teacode.retention.audit-days:365}") int auditDays,
                            @Value("${teacode.retention.token-grace-days:7}") int tokenGraceDays) {
        this.sessions = sessions;
        this.verificationTokens = verificationTokens;
        this.resetTokens = resetTokens;
        this.audit = audit;
        this.clock = clock;
        this.auditDays = Math.max(30, auditDays);
        this.tokenGraceDays = Math.max(1, tokenGraceDays);
    }

    @Scheduled(cron = "0 45 3 * * *", zone = "UTC")
    @Transactional
    public void purge() {
        LocalDateTime now = LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
        LocalDateTime tokenCutoff = now.minusDays(tokenGraceDays);
        int s = sessions.deleteExpiredBefore(tokenCutoff);
        int v = verificationTokens.deleteExpiredBefore(tokenCutoff);
        int r = resetTokens.deleteExpiredBefore(tokenCutoff);
        int a = audit.deleteCreatedBefore(now.minusDays(auditDays));
        log.info("Retention purge removed {} session(s), {} verification token(s), {} reset token(s), {} audit event(s)", s, v, r, a);
    }
}
