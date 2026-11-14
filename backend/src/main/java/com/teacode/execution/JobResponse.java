package com.teacode.execution;

import java.util.List;

/** What GET /submissions/jobs/{id} returns. Null fields are omitted from the JSON. */
public record JobResponse(String state, String errorCode, String status, Integer passedTests, Integer totalTests,
                          Integer executionTimeMs, Integer memoryKb, String compileOutput, String stdout, String stderr,
                          List<JobResult.CaseResult> cases) {

    public static JobResponse of(String state, String errorCode, JobResult r) {
        if (r == null) {
            return new JobResponse(state, errorCode, null, null, null, null, null, null, null, null, null);
        }
        return new JobResponse(state, errorCode, r.status(), r.passedTests(), r.totalTests(), r.executionTimeMs(),
                r.memoryKb(), r.compileOutput(), r.stdout(), r.stderr(), r.cases());
    }
}
