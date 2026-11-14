package com.teacode.execution;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class OutputSignalsTest {

    @Test
    void recognisesTimeoutAndRuntimeFailures() {
        assertThat(OutputSignals.classify("JDoodle - Timeout")).isEqualTo(OutputSignals.Signal.TIME_LIMIT);
        assertThat(OutputSignals.classify("Traceback (most recent call last):\n  File")).isEqualTo(OutputSignals.Signal.RUNTIME_ERROR);
        assertThat(OutputSignals.classify("Segmentation fault")).isEqualTo(OutputSignals.Signal.RUNTIME_ERROR);
    }

    @Test
    void ordinaryOutputIsNotASignal() {
        assertThat(OutputSignals.classify("42\n")).isEqualTo(OutputSignals.Signal.NONE);
        assertThat(OutputSignals.classify("")).isEqualTo(OutputSignals.Signal.NONE);
        assertThat(OutputSignals.classify(null)).isEqualTo(OutputSignals.Signal.NONE);
    }
}
