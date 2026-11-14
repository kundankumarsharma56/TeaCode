package com.teacode.dto;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record RegisterRequest(
        @NotBlank @Pattern(regexp = "^[A-Za-z0-9_]{3,30}$", message = "must be 3-30 letters, numbers or underscores") String username,
        @NotBlank @Email @Size(max = 254) String email,
        @NotBlank @Size(min = 10, max = 128, message = "must be 10-128 characters") String password,
        @AssertTrue(message = "the Terms and Privacy Policy must be accepted") boolean acceptPolicies,
        @NotBlank @Size(max = 20) String policyVersion) {
}
