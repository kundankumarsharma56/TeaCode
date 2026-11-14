package com.teacode.dto;

import java.time.Instant;

/** Short-lived, single-use terminal session credentials. */
public record TerminalSessionResponse(String sessionId, String token, Instant expiresAt) {
}
