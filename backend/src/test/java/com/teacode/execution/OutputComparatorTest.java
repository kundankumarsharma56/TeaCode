package com.teacode.execution;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class OutputComparatorTest {

    @Test
    void trimLinesIgnoresTrailingWhitespaceAndBlankLinesButNotContent() {
        assertThat(OutputComparator.matches("TRIM_LINES", "1 2\n3\n", "1 2  \r\n3\n\n\n", null)).isTrue();
        assertThat(OutputComparator.matches("TRIM_LINES", "1 2\n3", "1 2\n4", null)).isFalse();
        assertThat(OutputComparator.matches("TRIM_LINES", "a b", "a  b", null)).isFalse(); // inner spacing matters
        assertThat(OutputComparator.matches("TRIM_LINES", "x\n\ny", "x\ny", null)).isFalse(); // inner blank line matters
    }

    @Test
    void defaultsToTrimLinesForUnknownOrMissingMode() {
        assertThat(OutputComparator.matches(null, "ok\n", "ok", null)).isTrue();
        assertThat(OutputComparator.matches("SOMETHING_ELSE", "ok\n", "ok", null)).isTrue();
    }

    @Test
    void exactOnlyNormalisesLineEndings() {
        assertThat(OutputComparator.matches("EXACT", "a\nb\n", "a\r\nb\r\n", null)).isTrue();
        assertThat(OutputComparator.matches("EXACT", "a\nb\n", "a\nb", null)).isFalse();
        assertThat(OutputComparator.matches("EXACT", "a ", "a", null)).isFalse();
    }

    @Test
    void tokenModeIgnoresAllWhitespaceDifferences() {
        assertThat(OutputComparator.matches("TOKEN", "1 2 3", "1\n2\t3\n", null)).isTrue();
        assertThat(OutputComparator.matches("TOKEN", "1 2 3", "1 2", null)).isFalse();
        assertThat(OutputComparator.matches("TOKEN", "", "  \n", null)).isTrue();
    }

    @Test
    void floatToleranceAcceptsSmallNumericDifferencesOnly() {
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "3.14159265", "3.1415927", 1e-6)).isTrue();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "3.14159265", "3.15", 1e-6)).isFalse();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "1 2.0000001", "1 2", 1e-6)).isTrue();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "1000000", "1000000.5", 1e-6)).isTrue(); // relative error
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "yes", "no", 1e-6)).isFalse();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "NaN", "NaN", 1e-6)).isTrue(); // identical tokens
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "1", "NaN", 1e-6)).isFalse();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "1.0", "1.0000001", null)).isTrue(); // default tolerance
    }

    @Test
    void floatToleranceRejectsJavaSpecificNumberSyntaxThatIsNotPlainDecimal() {
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "1.5", "1.5f", 1e-6)).isFalse();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "2", "2d", 1e-6)).isFalse();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "8", "0x1p3", 1e-6)).isFalse();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "1", "Infinity", 1e-6)).isFalse();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "1e3", "1000", 1e-6)).isTrue();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", ".5", "0.5", 1e-6)).isTrue();
        assertThat(OutputComparator.matches("FLOAT_TOLERANCE", "-2.50", "-2.5", 1e-6)).isTrue();
    }

    @Test
    void nullActualOutputIsTreatedAsEmpty() {
        assertThat(OutputComparator.matches("TRIM_LINES", "", null, null)).isTrue();
        assertThat(OutputComparator.matches("TRIM_LINES", "x", null, null)).isFalse();
    }
}
