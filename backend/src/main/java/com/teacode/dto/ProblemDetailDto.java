package com.teacode.dto;

import java.util.List;

/**
 * Public problem view. Contains sample cases only; hidden cases never appear here, only whether they exist.
 * {@code description} is null when {@code statementAvailable} is false (catalog-only problems): link to {@code sourceUrl}.
 * {@code testDataStatus}: FULL (private tests present), SAMPLES_ONLY, or NONE. Only FULL can produce Accepted.
 * {@code judgeable}: this platform can run and judge the problem.
 */
public record ProblemDetailDto(
        String slug,
        String title,
        String difficulty,
        Integer rating,
        String source,
        String sourceUrl,
        boolean statementAvailable,
        String testDataStatus,
        boolean judgeable,
        String description,
        String constraints,
        String inputFormat,
        String outputFormat,
        List<TagDto> tags,
        List<SampleCaseDto> sampleCases) {
}
