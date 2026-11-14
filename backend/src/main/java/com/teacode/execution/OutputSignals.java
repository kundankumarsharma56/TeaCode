package com.teacode.execution;

import java.util.List;
import java.util.Locale;

/**
 * JDoodle reports compile errors, runtime failures and time-outs as normal HTTP 200 responses with text in
 * {@code output}; it has no status code for them. This class looks for well-known failure phrases so the
 * user gets a more helpful label. It is a HEURISTIC: it is used only when the output did not match the
 * expected output (or for the free-form compiler), never to turn a failure into success, and a program that
 * prints one of these phrases deliberately can be mislabelled.
 */
final class OutputSignals {

    enum Signal { NONE, TIME_LIMIT, RUNTIME_ERROR }

    private static final List<String> TIME = List.of("jdoodle - timeout", "execution timed out", "time limit exceeded", "timed out after");
    private static final List<String> RUNTIME = List.of(
            "traceback (most recent call last)", "exception in thread", "segmentation fault", "core dumped",
            "unhandled exception", "panicked at", "terminate called after throwing", "uncaught referenceerror",
            "uncaught typeerror", "fatal error:", "killed");

    private OutputSignals() {
    }

    static Signal classify(String output) {
        if (output == null || output.isEmpty()) {
            return Signal.NONE;
        }
        String o = output.toLowerCase(Locale.ROOT);
        for (String t : TIME) {
            if (o.contains(t)) {
                return Signal.TIME_LIMIT;
            }
        }
        for (String r : RUNTIME) {
            if (o.contains(r)) {
                return Signal.RUNTIME_ERROR;
            }
        }
        return Signal.NONE;
    }
}
