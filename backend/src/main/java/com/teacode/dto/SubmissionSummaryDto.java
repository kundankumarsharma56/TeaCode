package com.teacode.dto;

import java.time.Instant;

public record SubmissionSummaryDto(long id, String problemSlug, String problemTitle, String language, String status,
                                   int passedTests, int totalTests, Integer executionTimeMs, Integer memoryKb, Instant createdAt) {
}
