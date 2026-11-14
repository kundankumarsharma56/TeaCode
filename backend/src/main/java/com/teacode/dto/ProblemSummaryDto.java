package com.teacode.dto;

import java.util.List;

/**
 * {@code solved} and {@code timeSpentMs} are null (omitted from JSON) for anonymous users.
 * {@code rating} is null for problems without a difficulty rating; {@code source} is LOCAL or PACKAGE.
 */
public record ProblemSummaryDto(String slug, String title, String difficulty, Integer rating, String source,
                                List<TagDto> tags, Boolean solved, Long timeSpentMs) {
}
