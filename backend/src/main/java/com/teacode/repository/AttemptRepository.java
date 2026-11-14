package com.teacode.repository;

import com.teacode.entity.Attempt;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface AttemptRepository extends JpaRepository<Attempt, Long> {

    @Query("select a from Attempt a where a.userId = :userId and a.problemId = :problemId and a.finishedAt is null")
    Optional<Attempt> findActive(Long userId, Long problemId);

    Optional<Attempt> findByIdAndUserId(Long id, Long userId);

    /** Closes the attempt once; a second call matches 0 rows. */
    @Transactional
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("update Attempt a set a.finishedAt = :now, a.elapsedMs = :elapsedMs where a.id = :id and a.userId = :userId and a.finishedAt is null")
    int finish(Long id, Long userId, LocalDateTime now, Long elapsedMs);
}
