package com.teacode.security;

import com.teacode.exception.ServiceUnavailableException;
import com.teacode.exception.UnauthorizedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.oauth2.core.DelegatingOAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.OAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2TokenValidatorResult;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.security.oauth2.jwt.JwtValidators;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.stereotype.Component;

/**
 * Verifies a Firebase Authentication ID token and turns it into the provider-independent {@link OAuthProfile}.
 *
 * The signature is checked against Google's published signing keys (RS256), and the token must have been issued for
 * THIS Firebase project (issuer {@code https://securetoken.google.com/<project>} and audience {@code <project>}),
 * be unexpired and carry a subject. Nothing from the token is trusted until all of that holds. The email claim is
 * passed on together with {@code email_verified}; the sign-in service refuses an unverified email.
 */
@Component
public class FirebaseTokenVerifier {

    private static final Logger log = LoggerFactory.getLogger(FirebaseTokenVerifier.class);
    static final String JWK_SET_URI = "https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com";
    static final String PROVIDER = "firebase";

    private final String projectId;
    private volatile JwtDecoder decoder;

    @Autowired
    public FirebaseTokenVerifier(@Value("${FIREBASE_PROJECT_ID:}") String projectId) {
        this(projectId, null);
    }

    /** For tests: supply a decoder that trusts a locally generated key instead of Google's. */
    FirebaseTokenVerifier(String projectId, JwtDecoder decoder) {
        this.projectId = projectId == null ? "" : projectId.trim();
        this.decoder = decoder;
    }

    public boolean configured() {
        return !projectId.isEmpty();
    }

    public OAuthProfile verify(String idToken) {
        if (!configured()) {
            throw new ServiceUnavailableException("FIREBASE_NOT_CONFIGURED", "Sign-in is not configured on this server.");
        }
        Jwt jwt;
        try {
            jwt = decoder().decode(idToken);
        } catch (JwtException e) {
            // Includes bad signatures, wrong project, expiry and a failure to download Google's keys.
            log.info("Firebase ID token rejected: {}", e.getClass().getSimpleName());
            throw new UnauthorizedException("This sign-in link is invalid or has expired. Request a new one.");
        }
        String email = jwt.getClaimAsString("email");
        boolean verified = Boolean.TRUE.equals(jwt.getClaimAsBoolean("email_verified"));
        return new OAuthProfile(PROVIDER, jwt.getSubject(), email, verified,
                jwt.getClaimAsString("name"), jwt.getClaimAsString("picture"));
    }

    private JwtDecoder decoder() {
        JwtDecoder d = decoder;
        if (d == null) {
            synchronized (this) {
                if (decoder == null) {
                    decoder = withFirebaseRules(NimbusJwtDecoder.withJwkSetUri(JWK_SET_URI).build(), projectId);
                }
                d = decoder;
            }
        }
        return d;
    }

    /** Applies the Firebase rules (issuer, audience, subject, expiry) to a Nimbus decoder. */
    static NimbusJwtDecoder withFirebaseRules(NimbusJwtDecoder base, String projectId) {
        OAuth2TokenValidator<Jwt> audience = jwt -> jwt.getAudience() != null && jwt.getAudience().contains(projectId)
                ? OAuth2TokenValidatorResult.success()
                : OAuth2TokenValidatorResult.failure(new OAuth2Error("invalid_token", "Wrong audience", null));
        OAuth2TokenValidator<Jwt> subject = jwt -> jwt.getSubject() != null && !jwt.getSubject().isBlank()
                && jwt.getSubject().length() <= 100
                ? OAuth2TokenValidatorResult.success()
                : OAuth2TokenValidatorResult.failure(new OAuth2Error("invalid_token", "Missing subject", null));
        base.setJwtValidator(new DelegatingOAuth2TokenValidator<>(
                JwtValidators.createDefaultWithIssuer("https://securetoken.google.com/" + projectId), audience, subject));
        return base;
    }
}
