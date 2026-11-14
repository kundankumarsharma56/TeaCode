package com.teacode.repository;

import com.teacode.entity.ProblemStarterCode;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProblemStarterCodeRepository extends JpaRepository<ProblemStarterCode, Long> {

    List<ProblemStarterCode> findByProblemIdOrderByLanguage(Long problemId);
}
