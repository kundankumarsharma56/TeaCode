package com.teacode.security;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.teacode.exception.ServiceUnavailableException;
import com.teacode.exception.UnauthorizedException;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.crypto.RSASSASigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.time.Instant;
import java.util.Date;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;

/**
 * The verifier must accept only tokens signed by the expected key for THIS Firebase project. A locally generated RSA
 * key stands in for Google's signing keys; the project rules are the production ones ({@code withFirebaseRules}).
 */
class FirebaseTokenVerifierTest {

    private static final String PROJECT = "teacode-test";
    private static RSAPrivateKey privateKey;
    private static RSAPublicKey publicKey;

    @BeforeAll
    static void keys() throws Exception {
        KeyPairGenerator gen = KeyPairGenerator.getInstance("RSA");
        gen.initialize(2048);
        KeyPair pair = gen.generateKeyPair();
        privateKey = (RSAPrivateKey) pair.getPrivate();
        publicKey = (RSAPublicKey) pair.getPublic();
    }

    private static FirebaseTokenVerifier verifier(String project) {
        NimbusJwtDecoder decoder = FirebaseTokenVerifier.withFirebaseRules(NimbusJwtDecoder.withPublicKey(publicKey).build(), project);
        return new FirebaseTokenVerifier(project, decoder);
    }

    private static String token(RSAPrivateKey key, String issuer, String audience, String subject, Instant expires, boolean emailVerified) throws Exception {
        JWTClaimsSet.Builder claims = new JWTClaimsSet.Builder()
                .issuer(issuer).audience(audience)
                .issueTime(Date.from(Instant.now().minusSeconds(30)))
                .expirationTime(Date.from(expires))
                .claim("email", "ada@example.com").claim("email_verified", emailVerified).claim("name", "Ada Lovelace");
        if (subject != null) {
            claims.subject(subject);
        }
        SignedJWT jwt = new SignedJWT(new JWSHeader(JWSAlgorithm.RS256), claims.build());
        jwt.sign(new RSASSASigner(key));
        return jwt.serialize();
    }

    private static String good() throws Exception {
        return token(privateKey, "https://securetoken.google.com/" + PROJECT, PROJECT, "firebase-uid-1", Instant.now().plusSeconds(600), true);
    }

    @Test
    void validTokenBecomesAProfile() throws Exception {
        OAuthProfile p = verifier(PROJECT).verify(good());
        assertThat(p.provider()).isEqualTo("firebase");
        assertThat(p.subject()).isEqualTo("firebase-uid-1");
        assertThat(p.email()).isEqualTo("ada@example.com");
        assertThat(p.emailVerified()).isTrue();
        assertThat(p.displayName()).isEqualTo("Ada Lovelace");
    }

    @Test
    void unverifiedEmailIsReportedAsUnverifiedSoTheSignInServiceCanRefuseIt() throws Exception {
        String t = token(privateKey, "https://securetoken.google.com/" + PROJECT, PROJECT, "u", Instant.now().plusSeconds(600), false);
        assertThat(verifier(PROJECT).verify(t).emailVerified()).isFalse();
    }

    @Test
    void tokensForAnotherProjectAreRejected() throws Exception {
        String t = token(privateKey, "https://securetoken.google.com/other", "other", "u", Instant.now().plusSeconds(600), true);
        assertThatThrownBy(() -> verifier(PROJECT).verify(t)).isInstanceOf(UnauthorizedException.class);
    }

    @Test
    void wrongAudienceWithRightIssuerIsRejected() throws Exception {
        String t = token(privateKey, "https://securetoken.google.com/" + PROJECT, "other", "u", Instant.now().plusSeconds(600), true);
        assertThatThrownBy(() -> verifier(PROJECT).verify(t)).isInstanceOf(UnauthorizedException.class);
    }

    @Test
    void expiredTokensAreRejected() throws Exception {
        String t = token(privateKey, "https://securetoken.google.com/" + PROJECT, PROJECT, "u", Instant.now().minusSeconds(3600), true);
        assertThatThrownBy(() -> verifier(PROJECT).verify(t)).isInstanceOf(UnauthorizedException.class);
    }

    @Test
    void tokenWithoutSubjectIsRejected() throws Exception {
        String t = token(privateKey, "https://securetoken.google.com/" + PROJECT, PROJECT, null, Instant.now().plusSeconds(600), true);
        assertThatThrownBy(() -> verifier(PROJECT).verify(t)).isInstanceOf(UnauthorizedException.class);
    }

    @Test
    void tokenSignedWithAnotherKeyIsRejected() throws Exception {
        KeyPairGenerator gen = KeyPairGenerator.getInstance("RSA");
        gen.initialize(2048);
        RSAPrivateKey attacker = (RSAPrivateKey) gen.generateKeyPair().getPrivate();
        String t = token(attacker, "https://securetoken.google.com/" + PROJECT, PROJECT, "u", Instant.now().plusSeconds(600), true);
        assertThatThrownBy(() -> verifier(PROJECT).verify(t)).isInstanceOf(UnauthorizedException.class);
    }

    @Test
    void garbageIsRejected() {
        assertThatThrownBy(() -> verifier(PROJECT).verify("not-a-jwt")).isInstanceOf(UnauthorizedException.class);
    }

    @Test
    void withoutAProjectIdSigningInIsUnavailableNotOpen() {
        FirebaseTokenVerifier v = new FirebaseTokenVerifier("");
        assertThat(v.configured()).isFalse();
        assertThatThrownBy(() -> v.verify("anything")).isInstanceOf(ServiceUnavailableException.class);
    }
}
