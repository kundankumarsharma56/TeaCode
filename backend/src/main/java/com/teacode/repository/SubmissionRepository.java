package com.teacode.repository;

import com.teacode.entity.Submission;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface SubmissionRepository extends JpaRepository<Submission, Long> {

    /** Row for the list page: no source code. */
    interface ListRow {
        Long getId();
        String getProblemSlug();
        String getProblemTitle();
        String getLanguage();
        String getStatus();
        int getPassedTests();
        int getTotalTests();
        java.math.BigDecimal getExecutionTime();
        Integer getMemoryUsed();
        java.time.LocalDateTime getCreatedAt();
    }

    @Query(value = """
            select s.id as id, p.slug as problemSlug, p.title as problemTitle, s.language as language,
                   s.status as status, s.passedTests as passedTests, s.totalTests as totalTests,
                   s.executionTime as executionTime, s.memoryUsed as memoryUsed, s.createdAt as createdAt
            from Submission s join Problem p on p.id = s.problemId
            where s.userId = :userId
            order by s.createdAt desc, s.id desc""",
            countQuery = "select count(s) from Submission s where s.userId = :userId")
    Page<ListRow> findMine(Long userId, Pageable pageable);

    /** Scoped by owner in the query itself, so another user's id yields nothing. */
    Optional<Submission> findByIdAndUserId(Long id, Long userId);

    /** Filtered variant of {@link #findMine}. Every filter is optional (null = no filter); the owner scope is always applied. */
    @Query(value = """
            select s.id as id, p.slug as problemSlug, p.title as problemTitle, s.language as language,
                   s.status as status, s.passedTests as passedTests, s.totalTests as totalTests,
                   s.executionTime as executionTime, s.memoryUsed as memoryUsed, s.createdAt as createdAt
            from Submission s join Problem p on p.id = s.problemId
            where s.userId = :userId
              and (:status is null or s.status = :status)
              and (:language is null or s.language = :language)
              and (:slug is null or p.slug = :slug)
              and (:fromTs is null or s.createdAt >= :fromTs)
              and (:toTs is null or s.createdAt < :toTs)
            order by s.createdAt desc, s.id desc""",
            countQuery = """
            select count(s) from Submission s join Problem p on p.id = s.problemId
            where s.userId = :userId
              and (:status is null or s.status = :status)
              and (:language is null or s.language = :language)
              and (:slug is null or p.slug = :slug)
              and (:fromTs is null or s.createdAt >= :fromTs)
              and (:toTs is null or s.createdAt < :toTs)""")
    Page<ListRow> findMineFiltered(Long userId, String status, String language, String slug,
                                   LocalDateTime fromTs, LocalDateTime toTs, Pageable pageable);

    /** One row per problem the user submitted to (within the filters). */
    interface HistoryRow {
        String getProblemSlug();
        String getProblemTitle();
        String getDifficulty();
        Long getSubmissionCount();
        Long getAcceptedCount();
        Long getLastSubmissionId();
        LocalDateTime getLastSubmittedAt();
    }

    @Query(value = """
            select p.slug as problemSlug, p.title as problemTitle, p.difficulty as difficulty,
                   count(s) as submissionCount,
                   sum(case when s.status = 'ACCEPTED' then 1 else 0 end) as acceptedCount,
                   max(s.id) as lastSubmissionId, max(s.createdAt) as lastSubmittedAt
            from Submission s join Problem p on p.id = s.problemId
            where s.userId = :userId
              and (:status is null or s.status = :status)
              and (:language is null or s.language = :language)
              and (:difficulty is null or p.difficulty = :difficulty)
              and (:titleLike is null or lower(p.title) like :titleLike)
              and (:fromTs is null or s.createdAt >= :fromTs)
              and (:toTs is null or s.createdAt < :toTs)
            group by p.id, p.slug, p.title, p.difficulty
            order by max(s.id) desc""",
            countQuery = """
            select count(distinct s.problemId) from Submission s join Problem p on p.id = s.problemId
            where s.userId = :userId
              and (:status is null or s.status = :status)
              and (:language is null or s.language = :language)
              and (:difficulty is null or p.difficulty = :difficulty)
              and (:titleLike is null or lower(p.title) like :titleLike)
              and (:fromTs is null or s.createdAt >= :fromTs)
              and (:toTs is null or s.createdAt < :toTs)""")
    Page<HistoryRow> practiceHistory(Long userId, String status, String language, String difficulty, String titleLike,
                                     LocalDateTime fromTs, LocalDateTime toTs, Pageable pageable);

    interface StatusRow {
        Long getId();
        String getStatus();
    }

    /** Verdicts of specific submissions of one owner (used to show the latest result per problem). */
    @Query("select s.id as id, s.status as status from Submission s where s.userId = :userId and s.id in :ids")
    List<StatusRow> findStatuses(Long userId, Collection<Long> ids);
}
