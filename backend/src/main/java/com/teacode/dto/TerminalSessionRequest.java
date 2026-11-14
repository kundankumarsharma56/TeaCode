package com.teacode.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** Language selection for a short-lived interactive Terminal session. Source is sent only over the session WebSocket. */
public record TerminalSessionRequest(@NotBlank @Size(max = 20) String language) {
}
