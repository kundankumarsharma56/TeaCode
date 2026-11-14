package com.teacode.config;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import org.junit.jupiter.api.Test;

class ProductionGuardTest {

    @Test
    void refusesPlainHttpAndInsecureCookies() {
        assertThatThrownBy(() -> ProductionGuard.check("http://example.com", true)).isInstanceOf(IllegalStateException.class);
        assertThatThrownBy(() -> ProductionGuard.check("http://localhost:8081", true)).isInstanceOf(IllegalStateException.class);
        assertThatThrownBy(() -> ProductionGuard.check(null, true)).isInstanceOf(IllegalStateException.class);
        assertThatThrownBy(() -> ProductionGuard.check("https://example.com", false)).isInstanceOf(IllegalStateException.class);
    }

    @Test
    void acceptsHttpsWithSecureCookies() {
        assertThatCode(() -> ProductionGuard.check("https://teacode.example", true)).doesNotThrowAnyException();
    }

    @Test
    void flagsReservedPlaceholderHostsButNotRealOnes() {
        assertThat(ProductionGuard.looksLikePlaceholder("https://teacode.example.invalid")).isTrue();
        assertThat(ProductionGuard.looksLikePlaceholder("https://example.com")).isTrue();
        assertThat(ProductionGuard.looksLikePlaceholder("https://app.example.org")).isTrue();
        assertThat(ProductionGuard.looksLikePlaceholder("not a url")).isTrue();
        assertThat(ProductionGuard.looksLikePlaceholder("https://teacode.io")).isFalse();
        assertThat(ProductionGuard.looksLikePlaceholder("https://practice.mycompany.com:8443")).isFalse();
    }
}
