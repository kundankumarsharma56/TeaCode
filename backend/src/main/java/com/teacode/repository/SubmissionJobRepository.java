package com.teacode.repository;

import com.teacode.entity.SubmissionJob;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface SubmissionJobRepository extends JpaRepository<SubmissionJob, String> {

    Optional<SubmissionJob> findByIdAndUserId(String id, Long userId);

    @Query("select count(j) from SubmissionJob j where j.userId = :userId and j.state in ('QUEUED','RUNNING')")
    long countActive(Long userId);

    long countByUserIdIsNullAndStateIn(java.util.Collection<String> states);

    /** Only a queued job may start; returns 0 if it was already failed (for example by the stale-job sweep). */
    @Transactional
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("update SubmissionJob j set j.state = 'RUNNING' where j.id = :id and j.state = 'QUEUED'")
    int markRunning(String id);

    /** Terminal states are final: a job that already finished is never overwritten. */
    @Transactional
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("""
            update SubmissionJob j set j.state = :state, j.resultJson = :resultJson, j.errorCode = :errorCode,
                   j.submissionId = :submissionId
            where j.id = :id and j.state in ('QUEUED','RUNNING')""")
    int finish(String id, String state, String resultJson, String errorCode, Long submissionId);

    /** Fails jobs whose worker is gone (restart, crash). Instance-safe: only jobs not touched for a while. */
    @Transactional
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query(value = """
            update submission_jobs set state = 'FAILED', error_code = 'INTERRUPTED'
            where state in ('QUEUED','RUNNING') and updated_at < :cutoff""", nativeQuery = true)
    int failStale(LocalDateTime cutoff);

    @Transactional
    @Modifying
    @Query(value = "delete from submission_jobs where state in ('COMPLETED','FAILED') and updated_at < :cutoff", nativeQuery = true)
    int deleteFinishedBefore(LocalDateTime cutoff);
}
