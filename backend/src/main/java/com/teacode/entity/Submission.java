package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/** A judged submission. Only SUBMIT jobs create one; RUN and terminal executions are not stored. */
@Entity
@Table(name = "submissions")
public class Submission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "problem_id", nullable = false)
    private Long problemId;

    @Column(name = "language", nullable = false, length = 20)
    private String language;

    @Column(name = "source_code", nullable = false, columnDefinition = "mediumtext")
    private String sourceCode;

    @Column(name = "status", nullable = false, length = 30)
    private String status;

    /** Seconds, as the schema stores it. */
    @Column(name = "execution_time", precision = 8, scale = 3)
    private BigDecimal executionTime;

    @Column(name = "memory_used")
    private Integer memoryUsed;

    @Column(name = "passed_tests", nullable = false)
    private int passedTests;

    @Column(name = "total_tests", nullable = false)
    private int totalTests;

    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    protected Submission() {
    }

    public Submission(Long userId, Long problemId, String language, String sourceCode, String status,
                      BigDecimal executionTime, Integer memoryUsed, int passedTests, int totalTests) {
        this.userId = userId;
        this.problemId = problemId;
        this.language = language;
        this.sourceCode = sourceCode;
        this.status = status;
        this.executionTime = executionTime;
        this.memoryUsed = memoryUsed;
        this.passedTests = passedTests;
        this.totalTests = totalTests;
    }

    public Long getId() { return id; }
    public Long getUserId() { return userId; }
    public Long getProblemId() { return problemId; }
    public String getLanguage() { return language; }
    public String getSourceCode() { return sourceCode; }
    public String getStatus() { return status; }
    public BigDecimal getExecutionTime() { return executionTime; }
    public Integer getMemoryUsed() { return memoryUsed; }
    public int getPassedTests() { return passedTests; }
    public int getTotalTests() { return totalTests; }
    public LocalDateTime getCreatedAt() { return createdAt; }
}
