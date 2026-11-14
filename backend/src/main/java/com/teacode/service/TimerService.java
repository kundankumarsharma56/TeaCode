package com.teacode.service;

import com.teacode.dto.TimerDto;
import com.teacode.entity.Problem;
import com.teacode.enums.Visibility;
import com.teacode.exception.NotFoundException;
import com.teacode.repository.ProblemRepository;
import java.time.Duration;
import java.time.Instant;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

/**
 * Per-problem study timer, stored on the server.
 *
 * <p><b>What is counted:</b> wall-clock time between an explicit start/resume and the next pause, per user and
 * problem. It is not "time with the tab focused" and not coding time. A single running stretch counts at most
 * {@link #MAX_SEGMENT_MS} (4 h), so a timer forgotten overnight cannot inflate statistics.
 *
 * <p>Every transition is one atomic SQL statement against the database clock, so it is idempotent (starting a
 * running timer or pausing a paused one changes nothing) and two tabs can never double count: both read and
 * write the same row. The UI shows what the server returns.
 */
@Service
public class TimerService {

    public static final long MAX_SEGMENT_MS = Duration.ofHours(4).toMillis();

    private final NamedParameterJdbcTemplate jdbc;
    private final ProblemRepository problems;
    private final RateLimiter limiter;

    public TimerService(NamedParameterJdbcTemplate jdbc, ProblemRepository problems, RateLimiter limiter) {
        this.jdbc = jdbc;
        this.problems = problems;
        this.limiter = limiter;
    }

    public TimerDto get(long userId, String slug) {
        return read(userId, problemId(slug));
    }

    /** Start and resume are the same operation. */
    public TimerDto start(long userId, String slug) {
        long pid = problemId(slug);
        limit(userId);
        jdbc.update("""
                INSERT INTO problem_timers (user_id, problem_id, accumulated_ms, running_since)
                VALUES (:u, :p, 0, UTC_TIMESTAMP(6))
                ON DUPLICATE KEY UPDATE running_since = COALESCE(running_since, UTC_TIMESTAMP(6))""", ids(userId, pid));
        return read(userId, pid);
    }

    public TimerDto pause(long userId, String slug) {
        long pid = problemId(slug);
        limit(userId);
        jdbc.update("""
                UPDATE problem_timers
                SET accumulated_ms = accumulated_ms + LEAST(TIMESTAMPDIFF(MICROSECOND, running_since, UTC_TIMESTAMP(6)) DIV 1000, :cap),
                    running_since = NULL
                WHERE user_id = :u AND problem_id = :p AND running_since IS NOT NULL""",
                ids(userId, pid).addValue("cap", MAX_SEGMENT_MS));
        return read(userId, pid);
    }

    public TimerDto reset(long userId, String slug) {
        long pid = problemId(slug);
        limit(userId);
        jdbc.update("UPDATE problem_timers SET accumulated_ms = 0, running_since = NULL WHERE user_id = :u AND problem_id = :p", ids(userId, pid));
        return read(userId, pid);
    }

    private TimerDto read(long userId, long pid) {
        return jdbc.query("""
                SELECT accumulated_ms, running_since IS NOT NULL AS running,
                       accumulated_ms + IF(running_since IS NULL, 0,
                         LEAST(TIMESTAMPDIFF(MICROSECOND, running_since, UTC_TIMESTAMP(6)) DIV 1000, :cap)) AS total_ms
                FROM problem_timers WHERE user_id = :u AND problem_id = :p""",
                ids(userId, pid).addValue("cap", MAX_SEGMENT_MS),
                rs -> {
                    if (!rs.next()) {
                        return new TimerDto("IDLE", 0, Instant.now());
                    }
                    return new TimerDto(rs.getBoolean("running") ? "RUNNING" : "PAUSED", rs.getLong("total_ms"), Instant.now());
                });
    }

    private long problemId(String slug) {
        Problem p = problems.findBySlugAndVisibility(slug, Visibility.PUBLISHED.name())
                .orElseThrow(() -> new NotFoundException("Problem not found."));
        return p.getId();
    }

    private void limit(long userId) {
        limiter.check("timer", Long.toString(userId), 120, Duration.ofMinutes(1));
    }

    private static MapSqlParameterSource ids(long userId, long pid) {
        return new MapSqlParameterSource().addValue("u", userId).addValue("p", pid);
    }
}
