package com.teacode.execution;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

class VerificationCoverageTest {

    private static final List<String> REQUIRED = List.of("python", "java", "dart");

    @Test
    void notVerifiedWhenAnyLanguageIsMissingUnverifiedOrFailed() {
        assertThat(VerificationCoverage.fullyVerified(REQUIRED, Map.of())).isFalse();
        assertThat(VerificationCoverage.fullyVerified(REQUIRED,
                Map.of("python", "VERIFIED", "java", "VERIFIED", "dart", "UNVERIFIED"))).isFalse();
        assertThat(VerificationCoverage.fullyVerified(REQUIRED,
                Map.of("python", "VERIFIED", "java", "FAILED", "dart", "VERIFIED"))).isFalse();
        assertThat(VerificationCoverage.missing(REQUIRED, Map.of("python", "VERIFIED", "java", "FAILED")))
                .containsExactly("java", "dart");
    }

    @Test
    void verifiedOnlyWhenEveryRequiredLanguageIsVerified() {
        assertThat(VerificationCoverage.fullyVerified(REQUIRED,
                Map.of("python", "VERIFIED", "java", "VERIFIED", "dart", "VERIFIED", "sql", "FAILED"))).isTrue();
    }

    @Test
    void emptyRequirementIsNeverVerified() {
        assertThat(VerificationCoverage.fullyVerified(List.of(), Map.of())).isFalse();
    }
}
