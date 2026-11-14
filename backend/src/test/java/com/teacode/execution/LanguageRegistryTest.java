package com.teacode.execution;

import static org.assertj.core.api.Assertions.assertThat;

import com.teacode.config.AppProperties;
import java.util.List;
import org.junit.jupiter.api.Test;

class LanguageRegistryTest {

    private static LanguageRegistry registry(String id, String secret, String disabled) {
        return new LanguageRegistry(new AppProperties("http://localhost", "",
                new AppProperties.Security("x".repeat(40), "t", 15, 14, false),
                new AppProperties.Jdoodle(id, secret, "http://x", 1, 1, 1, 20, 60, disabled), null, null));
    }

    @Test
    void nothingIsOfferedWithoutCredentials() {
        assertThat(registry("", "", "").available()).isEmpty();
        assertThat(registry("id", "", "").available()).isEmpty();
    }

    @Test
    void fifteenJudgeableLanguagesPlusSqlPlaygroundWhenConfigured() {
        List<LanguageRegistry.Lang> all = registry("id", "secret", "").available();
        assertThat(all).hasSize(16);
        assertThat(registry("id", "secret", "").judgeable()).hasSize(15).extracting(LanguageRegistry.Lang::key)
                .doesNotContain("sql");
        assertThat(all).extracting(LanguageRegistry.Lang::key).doesNotHaveDuplicates()
                .contains("java", "python", "c", "cpp", "javascript", "typescript", "csharp", "php", "ruby", "go", "r",
                        "kotlin", "rust", "swift", "dart", "sql");
        assertThat(all).allSatisfy(l -> {
            assertThat(l.jdoodleLanguage()).isNotBlank();
            assertThat(l.versionIndex()).matches("\\d+");
            assertThat(l.extension()).startsWith(".");
            assertThat(l.toolchain()).isNotBlank();
        });
    }

    @Test
    void operatorCanDisableLanguages() {
        assertThat(registry("id", "secret", "swift, Rust").available()).extracting(LanguageRegistry.Lang::key)
                .doesNotContain("swift", "rust").hasSize(14);
        assertThat(registry("id", "secret", "swift").find("swift")).isEmpty();
    }

    @Test
    void sqlIsNotJudgeable() {
        assertThat(registry("id", "secret", "").find("sql").orElseThrow().judgeable()).isFalse();
        assertThat(registry("id", "secret", "").find("java").orElseThrow().judgeable()).isTrue();
    }

    @Test
    void interactiveTerminalLanguagesDoNotNeedJdoodleCredentials() {
        LanguageRegistry unconfigured = registry("", "", "");
        assertThat(unconfigured.available()).isEmpty();
        assertThat(unconfigured.interactive()).hasSize(15).extracting(LanguageRegistry.Lang::key)
                .contains("python", "java", "c", "cpp", "go", "rust").doesNotContain("sql");
        assertThat(unconfigured.findInteractive("python")).isPresent();
        assertThat(unconfigured.findInteractive("sql")).isEmpty();
        assertThat(unconfigured.findInteractive("cobol")).isEmpty();
    }
}
