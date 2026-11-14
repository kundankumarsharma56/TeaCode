package com.teacode.repository;

import com.teacode.entity.ReferenceSolution;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ReferenceSolutionRepository extends JpaRepository<ReferenceSolution, Long> {

    Optional<ReferenceSolution> findByProblemIdAndLanguage(Long problemId, String language);

    /** Rows of (language, status, count) for coverage reporting. */
    @Query("select r.language, r.verificationStatus, count(r) from ReferenceSolution r group by r.language, r.verificationStatus")
    List<Object[]> countByLanguageAndStatus();

    @Query("select r.language, r.verificationStatus from ReferenceSolution r where r.problemId = :problemId")
    List<Object[]> statusesForProblem(Long problemId);
}
