package com.teacode.controller;

import com.teacode.dto.DashboardDtos;
import com.teacode.security.AuthUser;
import com.teacode.service.DashboardService;
import com.teacode.exception.BadRequestException;
import java.time.YearMonth;
import java.time.format.DateTimeParseException;
import java.util.List;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/dashboard")
public class DashboardController {

    private final DashboardService dashboard;

    public DashboardController(DashboardService dashboard) {
        this.dashboard = dashboard;
    }

    @GetMapping("/summary")
    public DashboardDtos.Summary summary(@AuthenticationPrincipal AuthUser user) {
        return dashboard.summary(user.id());
    }

    @GetMapping("/progress")
    public List<DashboardDtos.Progress> progress(@AuthenticationPrincipal AuthUser user) {
        return dashboard.progress(user.id());
    }

    @GetMapping("/languages")
    public List<DashboardDtos.LanguageStat> languages(@AuthenticationPrincipal AuthUser user) {
        return dashboard.languages(user.id());
    }

    @GetMapping("/topics")
    public List<DashboardDtos.TopicStat> topics(@AuthenticationPrincipal AuthUser user) {
        return dashboard.topics(user.id());
    }

    @GetMapping("/time")
    public List<DashboardDtos.TimeStat> time(@AuthenticationPrincipal AuthUser user) {
        return dashboard.time(user.id());
    }

    @GetMapping("/activity")
    public List<DashboardDtos.Activity> activity(@AuthenticationPrincipal AuthUser user) {
        return dashboard.activity(user.id());
    }

    /** Submission counts per day for one month ({@code month=YYYY-MM}), bucketed by the client's UTC offset. */
    @GetMapping("/calendar")
    public List<DashboardDtos.CalendarDay> calendar(@AuthenticationPrincipal AuthUser user,
                                                    @RequestParam String month,
                                                    @RequestParam(defaultValue = "0") int offsetMinutes) {
        YearMonth ym;
        try {
            ym = YearMonth.parse(month);
        } catch (DateTimeParseException e) {
            throw new BadRequestException("month must be formatted as YYYY-MM");
        }
        return dashboard.calendar(user.id(), ym, offsetMinutes);
    }
}
