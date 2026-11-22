package com.teacode.service;

import com.teacode.config.AppProperties;
import com.teacode.entity.EmailOtp;
import com.teacode.repository.EmailOtpRepository;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.time.Clock;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.HexFormat;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.stereotype.Service;

/**
 * Six-digit email codes. Only an HMAC of the code is stored (key derived from the JWT secret), so a leaked
 * database does not reveal valid codes. A code is valid for CODE_MINUTES and allows MAX_ATTEMPTS wrong tries.
 * Both methods must run inside a transaction (the caller's TransactionTemplate).
 */
@Service
public class OtpService {

    public static final int CODE_MINUTES = 10;
    public static final int MAX_ATTEMPTS = 5;

    private static final SecureRandom RANDOM = new SecureRandom();

    private final EmailOtpRepository otps;
    private final byte[] key;
    private final Clock clock;

    public OtpService(EmailOtpRepository otps, AppProperties props, Clock clock) {
        this.otps = otps;
        this.key = ("teacode-otp:" + props.security().jwtSecret()).getBytes(StandardCharsets.UTF_8);
        this.clock = clock;
    }

    private LocalDateTime now() {
        return LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
    }

    /** Invalidates older unused codes of this purpose and returns the new plain code (to email, never stored). */
    public String issue(long userId, String purpose) {
        otps.invalidateAllForUser(userId, purpose, now());
        String code = String.format("%06d", RANDOM.nextInt(1_000_000));
        otps.save(new EmailOtp(userId, purpose, hash(userId, purpose, code), now().plusMinutes(CODE_MINUTES)));
        return code;
    }

    /** True only for a correct, unused, unexpired code under the try limit. A wrong code counts one try. */
    public boolean verify(long userId, String purpose, String code) {
        if (code == null || !code.matches("\\d{6}")) {
            return false;
        }
        EmailOtp otp = otps.findFirstByUserIdAndPurposeAndUsedAtIsNullOrderByIdDesc(userId, purpose).orElse(null);
        if (otp == null || otp.getAttempts() >= MAX_ATTEMPTS || !otp.getExpiresAt().isAfter(now())) {
            return false;
        }
        byte[] expected = otp.getCodeHash().getBytes(StandardCharsets.UTF_8);
        byte[] actual = hash(userId, purpose, code).getBytes(StandardCharsets.UTF_8);
        if (!MessageDigest.isEqual(expected, actual)) {
            otps.addAttempt(otp.getId());
            return false;
        }
        return otps.consume(otp.getId(), now(), MAX_ATTEMPTS) == 1;
    }

    private String hash(long userId, String purpose, String code) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(key, "HmacSHA256"));
            return HexFormat.of().formatHex(mac.doFinal((userId + ":" + purpose + ":" + code).getBytes(StandardCharsets.UTF_8)));
        } catch (GeneralSecurityException e) {
            throw new IllegalStateException("HmacSHA256 is not available", e);
        }
    }
}