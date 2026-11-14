package com.teacode.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record StartAttemptRequest(@NotBlank @Size(max = 220) String problemSlug) {
}
