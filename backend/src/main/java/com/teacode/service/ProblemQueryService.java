package com.teacode.service;

import com.teacode.dto.PageResponse;
import com.teacode.dto.ProblemDetailDto;
import com.teacode.dto.ProblemSummaryDto;
import com.teacode.dto.StarterCodeDto;
import com.teacode.dto.TagDto;
import com.teacode.entity.Problem;
import com.teacode.enums.Difficulty;
import com.teacode.enums.ProblemSort;
import com.teacode.enums.Visibility;
import com.teacode.exception.BadRequestException;
import com.teacode.exception.NotFoundException;
import com.teacode.mapper.ProblemMapper;
import com.teacode.repository.ProblemRepository;
import com.teacode.repository.ProgressRepository;
import com.teacode.repository.ProblemSpecifications;
import com.teacode.repository.ProblemStarterCodeRepository;
import com.teacode.repository.ProblemTagRepository;
import com.teacode.repository.TestCaseRepository;
import java.util.List;
import java.util.Set;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/** Read-only public problem queries. Only PUBLISHED problems and sample cases are ever returned. */
@Service
@Transactional(readOnly = true)
public class ProblemQueryService {

    public static final int MAX_PAGE_SIZE = 50;
    public static final int MAX_QUERY_LENGTH = 100;
    private static final int MAX_TAG_SLUG_LENGTH = 60;
    private static final int MAX_TOPICS = 20;

    private final ProblemRepository problems;
    private final ProblemTagRepository tags;
    private final TestCaseRepository testCases;
    private final ProblemStarterCodeRepository starterCode;
    private final ProgressRepository progress;

    public ProblemQueryService(ProblemRepository problems, ProblemTagRepository tags,
                               TestCaseRepository testCases, ProblemStarterCodeRepository starterCode,
                               ProgressRepository progress) {
        this.progress = progress;
        this.problems = problems;
        this.tags = tags;
        this.testCases = testCases;
        this.starterCode = starterCode;
    }

    /** {@code userId} is null for anonymous callers; signed-in callers also get a per-problem solved flag. */
    public PageResponse<ProblemSummaryDto> list(String query, String difficulty, String topicsCsv, String solved,
                                                String source, Integer minRating, Integer maxRating,
                                                String sort, int page, int size, Long userId) {
        if (page < 0) {
            throw new BadRequestException("page must be 0 or greater.");
        }
        if (size < 1 || size > MAX_PAGE_SIZE) {
            throw new BadRequestException("size must be between 1 and " + MAX_PAGE_SIZE + ".");
        }
        ProblemSort order = sort == null || sort.isBlank()
                ? ProblemSort.NEWEST
                : ProblemSort.parse(sort).orElseThrow(() -> new BadRequestException("Unknown sort option."));

        Specification<Problem> spec = ProblemSpecifications.published();

        if (query != null && !query.isBlank()) {
            if (query.length() > MAX_QUERY_LENGTH) {
                throw new BadRequestException("q is too long.");
            }
            spec = spec.and(ProblemSpecifications.titleContains(query.trim()));
        }
        if (difficulty != null && !difficulty.isBlank()) {
            Difficulty d = Difficulty.parse(difficulty)
                    .orElseThrow(() -> new BadRequestException("Unknown difficulty."));
            spec = spec.and(ProblemSpecifications.hasDifficulty(d));
        }
        if (topicsCsv != null && !topicsCsv.isBlank()) {
            List<String> slugs = java.util.Arrays.stream(topicsCsv.split(","))
                    .map(String::trim).filter(t -> !t.isEmpty()).distinct().toList();
            if (slugs.size() > MAX_TOPICS || slugs.stream().anyMatch(t -> t.length() > MAX_TAG_SLUG_LENGTH)) {
                throw new BadRequestException("Too many topics or a topic is too long.");
            }
            if (!slugs.isEmpty()) {
                spec = spec.and(ProblemSpecifications.hasAnyTagSlug(slugs));
            }
        }
        if (solved != null && !solved.isBlank()) {
            if (userId == null) {
                throw new BadRequestException("The solved filter requires signing in.");
            }
            if (!solved.equals("true") && !solved.equals("false")) {
                throw new BadRequestException("solved must be true or false.");
            }
            spec = spec.and(ProblemSpecifications.solvedBy(userId, solved.equals("true")));
        }
        if (source != null && !source.isBlank()) {
            String src = source.trim().toUpperCase(java.util.Locale.ROOT);
            if (!Set.of("LOCAL", "PACKAGE").contains(src)) {
                throw new BadRequestException("Unknown source.");
            }
            spec = spec.and(ProblemSpecifications.fromSource(src));
        }
        if ((minRating != null && minRating < 0) || (maxRating != null && maxRating > 5000)
                || (minRating != null && maxRating != null && minRating > maxRating)) {
            throw new BadRequestException("Invalid rating range.");
        }
        if (minRating != null || maxRating != null) {
            spec = spec.and(ProblemSpecifications.ratingBetween(minRating, maxRating));
        }
        spec = spec.and(ProblemSpecifications.orderedBy(order));

        Page<Problem> found = problems.findAll(spec, PageRequest.of(page, size));
        Set<Long> solvedIds = userId == null
                ? Set.of()
                : progress.solvedAmong(userId, found.getContent().stream().map(Problem::getId).toList());
        java.util.Map<Long, Long> spent = userId == null
                ? java.util.Map.of()
                : progress.timeSpentAmong(userId, found.getContent().stream().map(Problem::getId).toList());
        return PageResponse.of(found.map(p -> ProblemMapper.toSummary(p, userId == null ? null : solvedIds.contains(p.getId()),
                userId == null ? null : spent.getOrDefault(p.getId(), 0L))));
    }

    public ProblemDetailDto detail(String slug) {
        Problem problem = findPublished(slug);
        return ProblemMapper.toDetail(problem, testCases.findSamplesByProblemId(problem.getId()),
                testCases.countByProblemIdAndSampleCase(problem.getId(), false));
    }

    public List<StarterCodeDto> starterCode(String slug) {
        Problem problem = findPublished(slug);
        return starterCode.findByProblemIdOrderByLanguage(problem.getId()).stream()
                .map(ProblemMapper::toDto)
                .toList();
    }

    public List<TagDto> publishedTags() {
        return tags.findTagsOfPublishedProblems().stream().map(ProblemMapper::toDto).toList();
    }

    private Problem findPublished(String slug) {
        return problems.findBySlugAndVisibility(slug, Visibility.PUBLISHED.name())
                .orElseThrow(() -> new NotFoundException("Problem not found."));
    }
}
