package com.teacode.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record UpdateProfileRequest(
        @NotBlank @Pattern(regexp = "^[A-Za-z0-9_]{3,30}$", message = "must be 3-30 letters, numbers or underscores") String username) {
}
