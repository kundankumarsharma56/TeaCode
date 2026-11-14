package com.teacode.dto;

import java.time.Instant;

/**
 * One problem in the caller's practice history. {@code lastStatus} is the verdict of the most recent submission
 * that matched the filters; {@code solved} is true when any matching submission was ACCEPTED.
 */
public record PracticeHistoryRowDto(String problemSlug, String problemTitle, String difficulty, long submissionCount,
                                    long acceptedCount, boolean solved, long lastSubmissionId, String lastStatus,
                                    Instant lastSubmittedAt) {
}
