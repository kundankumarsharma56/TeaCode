package com.teacode.controller;

import com.teacode.dto.TimerDto;
import com.teacode.security.AuthUser;
import com.teacode.service.TimerService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/** Signed-in users only (the GET /problems/** public rule is for the catalog, not timers). */
@RestController
@RequestMapping("/api/v1/timers/{slug}")
public class TimerController {

    private final TimerService timers;

    public TimerController(TimerService timers) {
        this.timers = timers;
    }

    @GetMapping
    public TimerDto get(@AuthenticationPrincipal AuthUser u, @PathVariable String slug) {
        return timers.get(u.id(), slug);
    }

    @PostMapping("/start")
    public TimerDto start(@AuthenticationPrincipal AuthUser u, @PathVariable String slug) {
        return timers.start(u.id(), slug);
    }

    @PostMapping("/pause")
    public TimerDto pause(@AuthenticationPrincipal AuthUser u, @PathVariable String slug) {
        return timers.pause(u.id(), slug);
    }

    @PostMapping("/reset")
    public TimerDto reset(@AuthenticationPrincipal AuthUser u, @PathVariable String slug) {
        return timers.reset(u.id(), slug);
    }
}
