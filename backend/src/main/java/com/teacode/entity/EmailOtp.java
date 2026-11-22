package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

/** Single-use email code. Only an HMAC of the 6-digit code is stored, never the code itself. */
@Entity
@Table(name = "email_otps")
public class EmailOtp {

    public static final String VERIFY = "VERIFY";
    public static final String RESET = "RESET";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "purpose", nullable = false, length = 10)
    private String purpose;

    @Column(name = "code_hash", nullable = false, columnDefinition = "char(64)")
    private String codeHash;

    @Column(name = "attempts", nullable = false)
    private int attempts;

    @Column(name = "expires_at", nullable = false)
    private LocalDateTime expiresAt;

    @Column(name = "used_at")
    private LocalDateTime usedAt;

    protected EmailOtp() {
    }

    public EmailOtp(Long userId, String purpose, String codeHash, LocalDateTime expiresAt) {
        this.userId = userId;
        this.purpose = purpose;
        this.codeHash = codeHash;
        this.expiresAt = expiresAt;
    }

    public Long getId() {
        return id;
    }

    public Long getUserId() {
        return userId;
    }

    public String getPurpose() {
        return purpose;
    }

    public String getCodeHash() {
        return codeHash;
    }

    public int getAttempts() {
        return attempts;
    }

    public LocalDateTime getExpiresAt() {
        return expiresAt;
    }

    public LocalDateTime getUsedAt() {
        return usedAt;
    }
}