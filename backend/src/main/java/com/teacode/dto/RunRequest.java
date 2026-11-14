package com.teacode.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** Body of POST /submissions/run and /submissions/submit. Limits match the frontend and are enforced here. */
public record RunRequest(
        @NotBlank @Size(max = 220) String problemSlug,
        @NotBlank @Size(max = 20) String language,
        @NotBlank @Size(max = 64000, message = "sourceCode is too long") String sourceCode) {
}
