package com.teacode.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** The Firebase ID token the browser received after the user opened their email sign-in link. */
public record FirebaseLoginRequest(@NotBlank @Size(max = 4096) String idToken) {
}
