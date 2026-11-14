package com.teacode.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** Body of POST /terminal/run. */
public record TerminalRequest(
        @NotBlank @Size(max = 20) String language,
        @NotBlank @Size(max = 64000, message = "sourceCode is too long") String sourceCode,
        @Size(max = 10000, message = "stdin is too long") String stdin) {
}
