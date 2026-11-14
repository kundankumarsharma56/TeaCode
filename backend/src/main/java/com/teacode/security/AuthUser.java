package com.teacode.security;

/** Authenticated principal built from a validated access token and a live session check. */
public record AuthUser(long id, String username, String role, long sessionId) {
}
