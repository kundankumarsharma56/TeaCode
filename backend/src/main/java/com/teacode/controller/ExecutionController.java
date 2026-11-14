package com.teacode.controller;

import com.teacode.dto.JobStartedResponse;
import com.teacode.dto.LanguageDto;
import com.teacode.dto.RunRequest;
import com.teacode.dto.TerminalRequest;
import com.teacode.execution.ExecutionService;
import com.teacode.execution.ExecutionService.Mode;
import com.teacode.execution.JobResponse;
import com.teacode.execution.LanguageRegistry;
import com.teacode.security.AuthUser;
import jakarta.validation.Valid;
import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ExecutionController {

    private final ExecutionService execution;
    private final LanguageRegistry languages;

    public ExecutionController(ExecutionService execution, LanguageRegistry languages) {
        this.execution = execution;
        this.languages = languages;
    }

    /** Public. Lists only languages that can run now; empty when JDoodle credentials are not configured. */
    @GetMapping("/api/v1/execution/languages")
    public List<LanguageDto> languages() {
        return languages.available().stream().map(l -> new LanguageDto(l.key(), l.name(), l.version(), l.kind().name(), l.extension(), l.toolchain())).toList();
    }

    @PostMapping("/api/v1/submissions/run")
    public ResponseEntity<JobStartedResponse> run(@AuthenticationPrincipal AuthUser user, @Valid @RequestBody RunRequest r) {
        return accepted(execution.start(user.id(), Mode.RUN, r.problemSlug(), r.language(), r.sourceCode(), null));
    }

    @PostMapping("/api/v1/submissions/submit")
    public ResponseEntity<JobStartedResponse> submit(@AuthenticationPrincipal AuthUser user, @Valid @RequestBody RunRequest r) {
        return accepted(execution.start(user.id(), Mode.SUBMIT, r.problemSlug(), r.language(), r.sourceCode(), null));
    }

    @PostMapping("/api/v1/terminal/run")
    public ResponseEntity<JobStartedResponse> terminal(@AuthenticationPrincipal AuthUser user, @Valid @RequestBody TerminalRequest r) {
        return accepted(execution.start(user == null ? null : user.id(), Mode.TERMINAL, null, r.language(), r.sourceCode(), r.stdin()));
    }

    @GetMapping("/api/v1/submissions/jobs/{jobId}")
    public JobResponse job(@AuthenticationPrincipal AuthUser user, @PathVariable String jobId) {
        return execution.job(user == null ? null : user.id(), jobId);
    }

    private static ResponseEntity<JobStartedResponse> accepted(String jobId) {
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(new JobStartedResponse(jobId));
    }
}
