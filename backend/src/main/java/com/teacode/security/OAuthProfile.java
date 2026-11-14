package com.teacode.security;

import java.util.Map;

/** Provider-independent view of the identity a provider vouched for. */
public record OAuthProfile(String provider, String subject, String email, boolean emailVerified,
                           String displayName, String avatarUrl) {

    /** Reads Google (OIDC claims) or GitHub (user attributes plus the verified email added by GithubEmailUserService). */
    public static OAuthProfile from(String registrationId, Map<String, Object> a) {
        return switch (registrationId) {
            case "google" -> new OAuthProfile("google", str(a.get("sub")), str(a.get("email")),
                    Boolean.TRUE.equals(a.get("email_verified")), str(a.get("name")), str(a.get("picture")));
            case "github" -> new OAuthProfile("github", str(a.get("id")), str(a.get("email")),
                    Boolean.TRUE.equals(a.get("email_verified")), str(a.get("login")), str(a.get("avatar_url")));
            default -> throw new IllegalArgumentException("Unsupported provider");
        };
    }

    private static String str(Object o) {
        return o == null ? null : o.toString();
    }
}
