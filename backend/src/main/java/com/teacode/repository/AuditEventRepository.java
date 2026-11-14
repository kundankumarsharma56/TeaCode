package com.teacode.repository;

import com.teacode.entity.AuditEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface AuditEventRepository extends JpaRepository<AuditEvent, Long> {

    /** On account deletion audit rows are kept but detached from the user. */
    @Modifying
    @Query("update AuditEvent a set a.userId = null where a.userId = :userId")
    int detachUser(@Param("userId") Long userId);

    /** Retention: audit rows are kept for a bounded period (teacode.retention.audit-days). */
    @Modifying
    @Query("delete from AuditEvent a where a.createdAt < :cutoff")
    int deleteCreatedBefore(@Param("cutoff") java.time.LocalDateTime cutoff);
}
