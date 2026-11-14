package com.teacode.service;

import com.teacode.dto.DashboardDtos;
import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

/** Aggregates over the signed-in user's own data. Only PUBLISHED problems count toward totals. */
@Service
public class DashboardService {

    static final int ACTIVITY_DAYS = 30;
    private static final List<String> DIFFICULTIES = List.of("EASY", "MEDIUM", "HARD", "UNRATED");

    private final NamedParameterJdbcTemplate jdbc;
    private final Clock clock;

    public DashboardService(NamedParameterJdbcTemplate jdbc, Clock clock) {
        this.jdbc = jdbc;
        this.clock = clock;
    }

    /** Submissions the judge could not rule on; they are attempts but never count against (or for) acceptance. */
    static final String UNJUDGED = "('SERVICE_UNAVAILABLE','INSUFFICIENT_VERIFICATION')";

    public DashboardDtos.Summary summary(long userId) {
        MapSqlParameterSource p = new MapSqlParameterSource("userId", userId);
        long solved = count("""
                SELECT COUNT(DISTINCT s.problem_id) FROM submissions s JOIN problems pr ON pr.id = s.problem_id
                WHERE s.user_id = :userId AND s.status = 'ACCEPTED' AND pr.visibility = 'PUBLISHED'""", p);
        long total = count("SELECT COUNT(*) FROM problems WHERE visibility = 'PUBLISHED'", p);
        long subs = count("SELECT COUNT(*) FROM submissions WHERE user_id = :userId", p);
        long accepted = count("SELECT COUNT(*) FROM submissions WHERE user_id = :userId AND status = 'ACCEPTED'", p);
        long judged = count("SELECT COUNT(*) FROM submissions WHERE user_id = :userId AND status NOT IN " + UNJUDGED, p);
        long attempted = count("SELECT COUNT(DISTINCT problem_id) FROM submissions WHERE user_id = :userId", p);
        long timeMs = count("""
                SELECT COALESCE(SUM(accumulated_ms + IF(running_since IS NULL, 0,
                       LEAST(TIMESTAMPDIFF(MICROSECOND, running_since, UTC_TIMESTAMP(6)) DIV 1000, :cap))), 0)
                FROM problem_timers WHERE user_id = :userId""", p.addValue("cap", TimerService.MAX_SEGMENT_MS));
        Double rate = judged == 0 ? null : Math.round(accepted * 1000.0 / judged) / 10.0;
        return new DashboardDtos.Summary(solved, total, subs, accepted, attempted, rate, timeMs);
    }

    public List<DashboardDtos.LanguageStat> languages(long userId) {
        return jdbc.query("""
                SELECT language, COUNT(*) n, SUM(status = 'ACCEPTED') ok FROM submissions
                WHERE user_id = :userId GROUP BY language ORDER BY n DESC, language""",
                new MapSqlParameterSource("userId", userId),
                (rs, i) -> new DashboardDtos.LanguageStat(rs.getString("language"), rs.getLong("n"), rs.getLong("ok")));
    }

    public List<DashboardDtos.TopicStat> topics(long userId) {
        return jdbc.query("""
                SELECT t.name, t.slug, COUNT(DISTINCT s.problem_id) attempted,
                       COUNT(DISTINCT CASE WHEN s.status = 'ACCEPTED' THEN s.problem_id END) solved
                FROM submissions s
                JOIN problems pr ON pr.id = s.problem_id AND pr.visibility = 'PUBLISHED'
                JOIN problem_tag_map m ON m.problem_id = pr.id
                JOIN problem_tags t ON t.id = m.tag_id
                WHERE s.user_id = :userId GROUP BY t.id, t.name, t.slug ORDER BY solved DESC, attempted DESC, t.name LIMIT 30""",
                new MapSqlParameterSource("userId", userId),
                (rs, i) -> new DashboardDtos.TopicStat(rs.getString("name"), rs.getString("slug"), rs.getLong("attempted"), rs.getLong("solved")));
    }

    /** The 10 problems the user has spent the most timer time on. */
    public List<DashboardDtos.TimeStat> time(long userId) {
        return jdbc.query("""
                SELECT pr.slug, pr.title,
                       tm.accumulated_ms + IF(tm.running_since IS NULL, 0,
                         LEAST(TIMESTAMPDIFF(MICROSECOND, tm.running_since, UTC_TIMESTAMP(6)) DIV 1000, :cap)) AS ms,
                       EXISTS (SELECT 1 FROM submissions s WHERE s.user_id = tm.user_id AND s.problem_id = tm.problem_id AND s.status = 'ACCEPTED') AS solved
                FROM problem_timers tm JOIN problems pr ON pr.id = tm.problem_id
                WHERE tm.user_id = :userId AND pr.visibility = 'PUBLISHED' ORDER BY ms DESC LIMIT 10""",
                new MapSqlParameterSource("userId", userId).addValue("cap", TimerService.MAX_SEGMENT_MS),
                (rs, i) -> new DashboardDtos.TimeStat(rs.getString("slug"), rs.getString("title"), rs.getLong("ms"), rs.getBoolean("solved")));
    }

    /** One row per difficulty (zeros included), in a fixed order. */
    public List<DashboardDtos.Progress> progress(long userId) {
        Map<String, Long> totals = new HashMap<>();
        jdbc.query("SELECT difficulty, COUNT(*) c FROM problems WHERE visibility = 'PUBLISHED' GROUP BY difficulty",
                rs -> {
                    totals.put(rs.getString("difficulty"), rs.getLong("c"));
                });
        Map<String, Long> solved = new HashMap<>();
        jdbc.query("""
                SELECT pr.difficulty, COUNT(DISTINCT s.problem_id) c FROM submissions s JOIN problems pr ON pr.id = s.problem_id
                WHERE s.user_id = :userId AND s.status = 'ACCEPTED' AND pr.visibility = 'PUBLISHED' GROUP BY pr.difficulty""",
                new MapSqlParameterSource("userId", userId),
                rs -> {
                    solved.put(rs.getString("difficulty"), rs.getLong("c"));
                });
        List<DashboardDtos.Progress> out = new ArrayList<>();
        for (String d : DIFFICULTIES) {
            out.add(new DashboardDtos.Progress(d, solved.getOrDefault(d, 0L), totals.getOrDefault(d, 0L)));
        }
        return out;
    }

    /** Submissions per UTC day for the last 30 days, oldest first; days without submissions are included with 0. */
    public List<DashboardDtos.Activity> activity(long userId) {
        LocalDate today = LocalDate.now(clock.withZone(ZoneOffset.UTC));
        LocalDate from = today.minusDays(ACTIVITY_DAYS - 1L);
        Map<LocalDate, Long> perDay = new HashMap<>();
        jdbc.query("""
                SELECT DATE(created_at) d, COUNT(*) c FROM submissions
                WHERE user_id = :userId AND created_at >= :from GROUP BY DATE(created_at)""",
                new MapSqlParameterSource().addValue("userId", userId).addValue("from", from.atStartOfDay()),
                rs -> {
                    perDay.put(rs.getDate("d").toLocalDate(), rs.getLong("c"));
                });
        List<DashboardDtos.Activity> out = new ArrayList<>();
        for (int i = 0; i < ACTIVITY_DAYS; i++) {
            LocalDate day = from.plusDays(i);
            out.add(new DashboardDtos.Activity(day.toString(), perDay.getOrDefault(day, 0L)));
        }
        return out;
    }

    /**
     * Days of one month on which the user submitted, bucketed by the caller's UTC offset so the calendar matches what the
     * person sees locally. Days without submissions are omitted. {@code offsetMinutes} is clamped to the valid range.
     */
    public List<DashboardDtos.CalendarDay> calendar(long userId, YearMonth month, int offsetMinutes) {
        int off = Math.max(-14 * 60, Math.min(14 * 60, offsetMinutes));
        LocalDateTime from = month.atDay(1).atStartOfDay().minusMinutes(off);
        LocalDateTime to = month.plusMonths(1).atDay(1).atStartOfDay().minusMinutes(off);
        return jdbc.query("""
                SELECT DATE(DATE_ADD(created_at, INTERVAL :off MINUTE)) d, COUNT(*) c, SUM(status = 'ACCEPTED') ok
                FROM submissions WHERE user_id = :userId AND created_at >= :from AND created_at < :to
                GROUP BY d ORDER BY d""",
                new MapSqlParameterSource().addValue("userId", userId).addValue("off", off)
                        .addValue("from", from).addValue("to", to),
                (rs, i) -> new DashboardDtos.CalendarDay(rs.getDate("d").toLocalDate().toString(), rs.getLong("c"), rs.getLong("ok")));
    }

    private long count(String sql, MapSqlParameterSource p) {
        Long n = jdbc.queryForObject(sql, p, Long.class);
        return n == null ? 0 : n;
    }
}
