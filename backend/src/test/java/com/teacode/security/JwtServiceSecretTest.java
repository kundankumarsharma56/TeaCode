package com.teacode.security;

import static org.assertj.core.api.Assertions.assertThatCode;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import org.junit.jupiter.api.Test;

class JwtServiceSecretTest {

    @Test
    void rejectsRepeatedCharacterAndPlaceholderSecrets() {
        assertThatThrownBy(() -> JwtService.rejectPlaceholderSecret("x".repeat(48))).isInstanceOf(IllegalStateException.class);
        assertThatThrownBy(() -> JwtService.rejectPlaceholderSecret("change-me-change-me-change-me-12345678")).isInstanceOf(IllegalStateException.class);
        assertThatThrownBy(() -> JwtService.rejectPlaceholderSecret("ChangeMe-0123456789-abcdefghijklmnop")).isInstanceOf(IllegalStateException.class);
    }

    @Test
    void acceptsARandomLookingSecret() {
        assertThatCode(() -> JwtService.rejectPlaceholderSecret("q8Zr1vKp0Lw3Xn7Tb5Ys2Hc9Df4Gj6Mu+Ea/Ni8Ro1Vt=")).doesNotThrowAnyException();
    }
}
