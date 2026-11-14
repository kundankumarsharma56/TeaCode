package com.teacode.repository;

import com.teacode.entity.TestCase;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface TestCaseRepository extends JpaRepository<TestCase, Long> {

    long countByProblemIdAndSampleCase(Long problemId, boolean sampleCase);

    @Query("select t from TestCase t where t.problemId = :problemId and t.sampleCase = true order by t.sortOrder, t.id")
    List<TestCase> findSamplesByProblemId(Long problemId);

    /**
     * INTERNAL (judging only): every case including hidden ones, samples first. The result must never be
     * mapped to a public DTO; ExecutionService only copies input/expected output for sample cases.
     */
    @Query("select t from TestCase t where t.problemId = :problemId order by t.sampleCase desc, t.sortOrder, t.id")
    List<TestCase> findAllForJudging(Long problemId);
}
