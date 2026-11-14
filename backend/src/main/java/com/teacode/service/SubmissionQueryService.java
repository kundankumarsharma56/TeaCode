package com.teacode.service;

import com.teacode.dto.PageResponse;
import com.teacode.dto.PracticeHistoryRowDto;
import com.teacode.dto.SubmissionDetailDto;
import com.teacode.dto.SubmissionSummaryDto;
import com.teacode.entity.Problem;
import com.teacode.entity.Submission;
import com.teacode.exception.BadRequestException;
import com.teacode.exception.NotFoundException;
import com.teacode.repository.ProblemRepository;
import com.teacode.repository.SubmissionRepository;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;
import java.time.ZoneOffset;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/** A user's own submission history. Every query is scoped to the caller's id. */
@Service
@Transactional(readOnly = true)
public class SubmissionQueryService {

    public static final int MAX_PAGE_SIZE = 50;

    private final SubmissionRepository submissions;
    private final ProblemRepository problems;

    public SubmissionQueryService(SubmissionRepository submissions, ProblemRepository problems) {
        this.submissions = submissions;
        this.problems = problems;
    }

    private static final Pattern STATUS = Pattern.compile("[A-Z_]{1,30}");
    private static final Pattern LANGUAGE = Pattern.compile("[A-Za-z0-9_+#-]{1,20}");
    private static final Pattern SLUG = Pattern.compile("[a-z0-9-]{1,220}");
    private static final Set<String> DIFFICULTIES = Set.of("EASY", "MEDIUM", "HARD", "UNRATED");

    /** Optional filters shared by the history endpoints; blank values mean "no filter". */
    public record Filters(String status, String language, String slug, String difficulty, String q,
                          String from, String to, int offsetMinutes) {
        public static Filters none() {
            return new Filters(null, null, null, null, null, null, null, 0);
        }
    }

    public PageResponse<SubmissionSummaryDto> mine(long userId, int page, int size) {
        return mine(userId, page, size, Filters.none());
    }

    public PageResponse<SubmissionSummaryDto> mine(long userId, int page, int size, Filters f) {
        checkPaging(page, size);
        String status = pick(f.status(), STATUS, "status");
        String language = pick(f.language(), LANGUAGE, "language");
        String slug = pick(f.slug(), SLUG, "problem");
        LocalDateTime[] range = range(f);
        return PageResponse.of(submissions.findMineFiltered(userId, status, language, slug, range[0], range[1],
                PageRequest.of(page, size)).map(r -> new SubmissionSummaryDto(
                r.getId(), r.getProblemSlug(), r.getProblemTitle(), r.getLanguage(), r.getStatus(), r.getPassedTests(),
                r.getTotalTests(), toMs(r.getExecutionTime()), r.getMemoryUsed(), toInstant(r.getCreatedAt()))));
    }

    /** One row per problem, newest activity first. All queries are scoped to {@code userId}. */
    public PageResponse<PracticeHistoryRowDto> practiceHistory(long userId, int page, int size, Filters f) {
        checkPaging(page, size);
        String status = pick(f.status(), STATUS, "status");
        String language = pick(f.language(), LANGUAGE, "language");
        String difficulty = f.difficulty() == null || f.difficulty().isBlank() ? null : f.difficulty().trim().toUpperCase(Locale.ROOT);
        if (difficulty != null && !DIFFICULTIES.contains(difficulty)) {
            throw new BadRequestException("difficulty is not valid.");
        }
        String titleLike = null;
        if (f.q() != null && !f.q().isBlank()) {
            String q = f.q().trim();
            if (q.length() > 100) {
                throw new BadRequestException("q must be at most 100 characters.");
            }
            titleLike = "%" + q.toLowerCase(Locale.ROOT).replace("%", "").replace("_", "") + "%";
        }
        LocalDateTime[] range = range(f);
        var rows = submissions.practiceHistory(userId, status, language, difficulty, titleLike, range[0], range[1],
                PageRequest.of(page, size));
        Map<Long, String> latest = new HashMap<>();
        List<Long> ids = rows.getContent().stream().map(SubmissionRepository.HistoryRow::getLastSubmissionId).toList();
        if (!ids.isEmpty()) {
            submissions.findStatuses(userId, ids).forEach(s -> latest.put(s.getId(), s.getStatus()));
        }
        return PageResponse.of(rows.map(r -> new PracticeHistoryRowDto(r.getProblemSlug(), r.getProblemTitle(),
                r.getDifficulty(), r.getSubmissionCount(), r.getAcceptedCount() == null ? 0 : r.getAcceptedCount(),
                r.getAcceptedCount() != null && r.getAcceptedCount() > 0, r.getLastSubmissionId(),
                latest.get(r.getLastSubmissionId()), toInstant(r.getLastSubmittedAt()))));
    }

    private static void checkPaging(int page, int size) {
        if (page < 0) {
            throw new BadRequestException("page must be 0 or greater.");
        }
        if (size < 1 || size > MAX_PAGE_SIZE) {
            throw new BadRequestException("size must be between 1 and " + MAX_PAGE_SIZE + ".");
        }
    }

    private static String pick(String value, Pattern allowed, String name) {
        if (value == null || value.isBlank()) {
            return null;
        }
        String v = value.trim();
        if (!allowed.matcher(v).matches()) {
            throw new BadRequestException(name + " is not valid.");
        }
        return v;
    }

    /** Inclusive local dates {@code from}..{@code to} (yyyy-MM-dd) in the caller's UTC offset, as a UTC [start, end) range. */
    private static LocalDateTime[] range(Filters f) {
        int off = Math.max(-14 * 60, Math.min(14 * 60, f.offsetMinutes()));
        LocalDateTime start = null;
        LocalDateTime end = null;
        try {
            if (f.from() != null && !f.from().isBlank()) {
                start = LocalDate.parse(f.from().trim()).atStartOfDay().minusMinutes(off);
            }
            if (f.to() != null && !f.to().isBlank()) {
                end = LocalDate.parse(f.to().trim()).plusDays(1).atStartOfDay().minusMinutes(off);
            }
        } catch (DateTimeParseException e) {
            throw new BadRequestException("Dates must be formatted as YYYY-MM-DD.");
        }
        if (start != null && end != null && !start.isBefore(end)) {
            throw new BadRequestException("from must not be after to.");
        }
        return new LocalDateTime[] {start, end};
    }

    public SubmissionDetailDto detail(long userId, long id) {
        Submission s = submissions.findByIdAndUserId(id, userId).orElseThrow(() -> new NotFoundException("Submission not found."));
        Problem p = problems.findById(s.getProblemId()).orElseThrow(() -> new NotFoundException("Submission not found."));
        return new SubmissionDetailDto(s.getId(), p.getSlug(), p.getTitle(), s.getLanguage(), s.getStatus(), s.getPassedTests(),
                s.getTotalTests(), toMs(s.getExecutionTime()), s.getMemoryUsed(), toInstant(s.getCreatedAt()), s.getSourceCode());
    }

    private static Integer toMs(BigDecimal seconds) {
        return seconds == null ? null : seconds.movePointRight(3).intValue();
    }

    private static Instant toInstant(LocalDateTime t) {
        return t == null ? null : t.toInstant(ZoneOffset.UTC);
    }
}
