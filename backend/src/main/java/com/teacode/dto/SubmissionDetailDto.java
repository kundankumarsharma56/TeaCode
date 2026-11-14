package com.teacode.dto;

import java.time.Instant;

/** The owner's own submission including their source code. Never includes test data. */
public record SubmissionDetailDto(long id, String problemSlug, String problemTitle, String language, String status,
                                  int passedTests, int totalTests, Integer executionTimeMs, Integer memoryKb,
                                  Instant createdAt, String sourceCode) {
}
