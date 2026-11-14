package com.teacode.repository;

import com.teacode.entity.RefreshSession;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface RefreshSessionRepository extends JpaRepository<RefreshSession, Long> {

    Optional<RefreshSession> findByTokenHash(String tokenHash);

    /** Atomic: returns 1 only for the caller that actually revoked the session (guards rotation races). */
    @Modifying
    @Query("update RefreshSession s set s.revokedAt = :now where s.id = :id and s.revokedAt is null")
    int revokeIfActive(@Param("id") Long id, @Param("now") LocalDateTime now);

    @Modifying
    @Query("update RefreshSession s set s.revokedAt = :now where s.userId = :userId and s.revokedAt is null")
    int revokeAllForUser(@Param("userId") Long userId, @Param("now") LocalDateTime now);

    /** Retention: a session is useless once it has expired; revoked rows are kept until then so reuse detection works. */
    @Modifying
    @Query("delete from RefreshSession s where s.expiresAt < :cutoff")
    int deleteExpiredBefore(@Param("cutoff") LocalDateTime cutoff);
}
