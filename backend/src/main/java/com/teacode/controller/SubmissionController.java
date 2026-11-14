package com.teacode.controller;

import com.teacode.dto.PageResponse;
import com.teacode.dto.PracticeHistoryRowDto;
import com.teacode.dto.SubmissionDetailDto;
import com.teacode.dto.SubmissionSummaryDto;
import com.teacode.security.AuthUser;
import com.teacode.service.SubmissionQueryService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/submissions")
public class SubmissionController {

    private final SubmissionQueryService service;

    public SubmissionController(SubmissionQueryService service) {
        this.service = service;
    }

    @GetMapping("/mine")
    public PageResponse<SubmissionSummaryDto> mine(@AuthenticationPrincipal AuthUser user,
                                                   @RequestParam(defaultValue = "0") int page,
                                                   @RequestParam(defaultValue = "20") int size,
                                                   @RequestParam(required = false) String status,
                                                   @RequestParam(required = false) String language,
                                                   @RequestParam(required = false) String problem,
                                                   @RequestParam(required = false) String from,
                                                   @RequestParam(required = false) String to,
                                                   @RequestParam(defaultValue = "0") int offsetMinutes) {
        return service.mine(user.id(), page, size,
                new SubmissionQueryService.Filters(status, language, problem, null, null, from, to, offsetMinutes));
    }

    /** Practice history: one row per problem the caller has submitted to. */
    @GetMapping("/history")
    public PageResponse<PracticeHistoryRowDto> history(@AuthenticationPrincipal AuthUser user,
                                                       @RequestParam(defaultValue = "0") int page,
                                                       @RequestParam(defaultValue = "20") int size,
                                                       @RequestParam(required = false) String status,
                                                       @RequestParam(required = false) String language,
                                                       @RequestParam(required = false) String difficulty,
                                                       @RequestParam(required = false) String q,
                                                       @RequestParam(required = false) String from,
                                                       @RequestParam(required = false) String to,
                                                       @RequestParam(defaultValue = "0") int offsetMinutes) {
        return service.practiceHistory(user.id(), page, size,
                new SubmissionQueryService.Filters(status, language, null, difficulty, q, from, to, offsetMinutes));
    }

    @GetMapping("/{id:\\d+}")
    public SubmissionDetailDto detail(@AuthenticationPrincipal AuthUser user, @PathVariable long id) {
        return service.detail(user.id(), id);
    }
}
