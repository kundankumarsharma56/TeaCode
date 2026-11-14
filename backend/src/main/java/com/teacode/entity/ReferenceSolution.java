package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

/**
 * A reference solution for one problem in one language. Internal only: no public API or DTO exposes the source.
 * Status starts UNVERIFIED; {@link #markVerified} is the only way to reach VERIFIED and requires a report.
 */
@Entity
@Table(name = "reference_solutions")
public class ReferenceSolution {

    public static final String UNVERIFIED = "UNVERIFIED";
    public static final String VERIFIED = "VERIFIED";
    public static final String FAILED = "FAILED";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "problem_id", nullable = false)
    private Long problemId;

    @Column(name = "language", nullable = false, length = 20)
    private String language;

    @Column(name = "source_code", nullable = false, columnDefinition = "mediumtext")
    private String sourceCode;

    @Column(name = "runtime_version", length = 80)
    private String runtimeVersion;

    @Column(name = "solution_version", nullable = false)
    private int solutionVersion = 1;

    @Column(name = "verification_status", nullable = false, length = 12)
    private String verificationStatus = UNVERIFIED;

    @Column(name = "last_verified_at")
    private LocalDateTime lastVerifiedAt;

    @Column(name = "validation_report", columnDefinition = "mediumtext")
    private String validationReport;

    protected ReferenceSolution() {
    }

    public ReferenceSolution(Long problemId, String language, String sourceCode) {
        this.problemId = problemId;
        this.language = language;
        this.sourceCode = sourceCode;
    }

    public Long getId() { return id; }
    public Long getProblemId() { return problemId; }
    public String getLanguage() { return language; }
    public String getSourceCode() { return sourceCode; }
    public String getRuntimeVersion() { return runtimeVersion; }
    public int getSolutionVersion() { return solutionVersion; }
    public String getVerificationStatus() { return verificationStatus; }
    public LocalDateTime getLastVerifiedAt() { return lastVerifiedAt; }
    public String getValidationReport() { return validationReport; }

    /** Changing the source invalidates earlier verification. */
    public void replaceSource(String newSource) {
        this.sourceCode = newSource;
        this.solutionVersion++;
        this.verificationStatus = UNVERIFIED;
        this.lastVerifiedAt = null;
        this.validationReport = null;
    }

    public void markVerified(String runtimeVersion, String report, LocalDateTime at) {
        if (report == null || report.isBlank()) {
            throw new IllegalArgumentException("A verification report is required.");
        }
        this.verificationStatus = VERIFIED;
        this.runtimeVersion = runtimeVersion;
        this.validationReport = report;
        this.lastVerifiedAt = at;
    }

    public void markFailed(String runtimeVersion, String report, LocalDateTime at) {
        this.verificationStatus = FAILED;
        this.runtimeVersion = runtimeVersion;
        this.validationReport = report;
        this.lastVerifiedAt = at;
    }
}
