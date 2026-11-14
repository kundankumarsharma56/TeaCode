package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * Hidden cases (sample_case = false) must never be returned by public APIs.
 * Public code paths only use {@code TestCaseRepository#findSamplesByProblemId}.
 */
@Entity
@Table(name = "test_cases")
public class TestCase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "problem_id", nullable = false)
    private Long problemId;

    @Column(name = "input_data", nullable = false, columnDefinition = "mediumtext")
    private String inputData;

    @Column(name = "expected_output", nullable = false, columnDefinition = "mediumtext")
    private String expectedOutput;

    @Column(name = "sample_case", nullable = false)
    private boolean sampleCase;

    @Column(name = "sort_order", nullable = false)
    private int sortOrder;

    protected TestCase() {
    }

    public Long getId() {
        return id;
    }

    public Long getProblemId() {
        return problemId;
    }

    public String getInputData() {
        return inputData;
    }

    public String getExpectedOutput() {
        return expectedOutput;
    }

    public boolean isSampleCase() {
        return sampleCase;
    }

    public int getSortOrder() {
        return sortOrder;
    }
}
