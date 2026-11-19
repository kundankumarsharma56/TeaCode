package com.teacode.repository;

import com.teacode.entity.EmailOtp;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface EmailOtpRepository extends JpaRepository<EmailOtp, Long> {

    /** The newest unused code of this user for this purpose. */
    Optional<EmailOtp> findFirstByUserIdAndPurposeAndUsedAtIsNullOrderByIdDesc(Long userId, String purpose);

    /** Counts one wrong try. */
    @Modifying
    @Query("update EmailOtp o set o.attempts = o.attempts + 1 where o.id = :id")
    int addAttempt(@Param("id") Long id);

    /** Atomic single-use consume: returns 1 only if the code was unused, unexpired and under the try limit. */
    @Modifying
    @Query("update EmailOtp o set o.usedAt = :now where o.id = :id and o.usedAt is null and o.expiresAt > :now and o.attempts < :maxAttempts")
    int consume(@Param("id") Long id, @Param("now") LocalDateTime now, @Param("maxAttempts") int maxAttempts);

    /** Invalidates older unused codes of this purpose when a new one is issued. */
    @Modifying
    @Query("update EmailOtp o set o.usedAt = :now where o.userId = :userId and o.purpose = :purpose and o.usedAt is null")
    int invalidateAllForUser(@Param("userId") Long userId, @Param("purpose") String purpose, @Param("now") LocalDateTime now);

    /** Retention: expired codes carry no further use. */
    @Modifying
    @Query("delete from EmailOtp o where o.expiresAt < :cutoff")
    int deleteExpiredBefore(@Param("cutoff") LocalDateTime cutoff);
}