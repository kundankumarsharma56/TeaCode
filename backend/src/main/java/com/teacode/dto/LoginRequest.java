package com.teacode.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** rememberMe is optional: missing means true (the old behaviour). */
public record LoginRequest(
        @NotBlank @Size(max = 254) String email,
        @NotBlank @Size(max = 128) String password,
        Boolean rememberMe) {

    public LoginRequest(String email, String password) {
        this(email, password, null);
    }
}
