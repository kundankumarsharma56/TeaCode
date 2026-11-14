package com.teacode.dto;

import java.time.Instant;

/** {@code serverTime} lets the client correct for its own clock skew. */
public record AttemptDto(long id, Instant startedAt, Instant serverTime) {
}
