package com.teacode.dto;

import java.time.Instant;
import java.util.List;

/**
 * Public view of the signed-in user. Never includes the password hash or internal status fields.
 * {@code avatarSource} is CUSTOM (uploaded), PROVIDER (sign-in provider image) or null (initials only).
 */
public record UserResponse(String username, String email, boolean emailVerified, Instant createdAt,
                           List<String> authProviders, String avatarUrl, String avatarSource,
                           boolean providerAvatarAvailable) {
}
