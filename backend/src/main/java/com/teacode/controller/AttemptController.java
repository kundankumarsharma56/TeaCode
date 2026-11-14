package com.teacode.controller;

import com.teacode.dto.AttemptDto;
import com.teacode.dto.AttemptFinishedDto;
import com.teacode.dto.StartAttemptRequest;
import com.teacode.security.AuthUser;
import com.teacode.service.AttemptService;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/attempts")
public class AttemptController {

    private final AttemptService attempts;

    public AttemptController(AttemptService attempts) {
        this.attempts = attempts;
    }

    @PostMapping("/start")
    public AttemptDto start(@AuthenticationPrincipal AuthUser user, @Valid @RequestBody StartAttemptRequest r) {
        return attempts.start(user.id(), r.problemSlug());
    }

    @PostMapping("/{id}/finish")
    public AttemptFinishedDto finish(@AuthenticationPrincipal AuthUser user, @PathVariable long id) {
        return attempts.finish(user.id(), id);
    }
}
