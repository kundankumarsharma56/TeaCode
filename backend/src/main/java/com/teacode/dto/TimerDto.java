package com.teacode.dto;

import java.time.Instant;

/** {@code state} is IDLE (never started), RUNNING or PAUSED. {@code elapsedMs} is the server's current total. */
public record TimerDto(String state, long elapsedMs, Instant serverTime) {
}
