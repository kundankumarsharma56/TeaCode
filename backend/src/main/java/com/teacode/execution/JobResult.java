package com.teacode.execution;

import java.util.List;

/** Stored form of a finished execution. Hidden test cases carry no input, expected output, actual output or stderr. */
public record JobResult(String status, Integer passedTests, Integer totalTests, Integer executionTimeMs, Integer memoryKb,
                        String compileOutput, String stdout, String stderr, List<CaseResult> cases) {

    public record CaseResult(int index, boolean sample, String status, Integer timeMs, Integer memoryKb,
                             String input, String expected, String actual, String stderr) {
    }
}
