package com.teacode.repository;

import com.teacode.entity.EmailVerificationToken;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface EmailVerificationTokenRepository extends JpaRepository<EmailVerificationToken, Long> {

    Optional<EmailVerificationToken> findByTokenHash(String tokenHash);

    /** Atomic single-use consume: returns 1 only if the token was unused and unexpired. */
    @Modifying
    @Query("update EmailVerificationToken t set t.usedAt = :now where t.id = :id and t.usedAt is null and t.expiresAt > :now")
    int consume(@Param("id") Long id, @Param("now") LocalDateTime now);

    /** Invalidates older unused tokens when a new one is issued. */
    @Modifying
    @Query("update EmailVerificationToken t set t.usedAt = :now where t.userId = :userId and t.usedAt is null")
    int invalidateAllForUser(@Param("userId") Long userId, @Param("now") LocalDateTime now);

    /** Retention: used or expired tokens carry no further use. */
    @Modifying
    @Query("delete from EmailVerificationToken t where t.expiresAt < :cutoff")
    int deleteExpiredBefore(@Param("cutoff") LocalDateTime cutoff);
}
