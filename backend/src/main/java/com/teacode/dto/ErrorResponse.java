package com.teacode.dto;

import java.time.Instant;

/** Consistent error body. Never contains stack traces or internal details. */
public record ErrorResponse(String code, String message, String correlationId, Instant timestamp) {
}
