package com.teacode.controller;

import com.teacode.dto.PageResponse;
import com.teacode.dto.ProblemDetailDto;
import com.teacode.dto.ProblemSummaryDto;
import com.teacode.dto.StarterCodeDto;
import com.teacode.dto.TagDto;
import com.teacode.service.ProblemQueryService;
import java.util.List;
import com.teacode.security.AuthUser;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/problems")
public class ProblemController {

    private final ProblemQueryService service;

    public ProblemController(ProblemQueryService service) {
        this.service = service;
    }

    @GetMapping
    public PageResponse<ProblemSummaryDto> list(
            @RequestParam(name = "search", required = false) String search,
            @RequestParam(name = "difficulty", required = false) String difficulty,
            @RequestParam(name = "topics", required = false) String topics,
            @RequestParam(name = "solved", required = false) String solved,
            @RequestParam(name = "source", required = false) String source,
            @RequestParam(name = "minRating", required = false) Integer minRating,
            @RequestParam(name = "maxRating", required = false) Integer maxRating,
            @RequestParam(name = "sort", required = false) String sort,
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "20") int size,
            @AuthenticationPrincipal AuthUser user) {
        return service.list(search, difficulty, topics, solved, source, minRating, maxRating, sort, page, size, user == null ? null : user.id());
    }

    @GetMapping("/topics")
    public List<TagDto> tags() {
        return service.publishedTags();
    }

    @GetMapping("/{slug}")
    public ProblemDetailDto detail(@PathVariable String slug) {
        return service.detail(slug);
    }

    @GetMapping("/{slug}/starter-code")
    public List<StarterCodeDto> starterCode(@PathVariable String slug) {
        return service.starterCode(slug);
    }
}
