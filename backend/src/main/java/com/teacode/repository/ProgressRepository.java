package com.teacode.repository;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

/**
 * Read-only per-user progress views. Nothing is stored here: "solved" means the user has an ACCEPTED submission,
 * so progress can never drift from the submission records (and recomputing it is idempotent by construction).
 */
@Repository
public class ProgressRepository {

    private final NamedParameterJdbcTemplate jdbc;

    public ProgressRepository(NamedParameterJdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    /** Which of the given problems the user has solved. */
    public Set<Long> solvedAmong(long userId, Collection<Long> problemIds) {
        if (problemIds.isEmpty()) {
            return Set.of();
        }
        return new HashSet<>(jdbc.queryForList(
                "SELECT DISTINCT problem_id FROM submissions WHERE user_id = :userId AND status = 'ACCEPTED' AND problem_id IN (:ids)",
                new MapSqlParameterSource().addValue("userId", userId).addValue("ids", problemIds), Long.class));
    }

    /** Timer total per problem in milliseconds (closed segments plus the open one), for problems that have a timer. */
    public Map<Long, Long> timeSpentAmong(long userId, Collection<Long> problemIds) {
        Map<Long, Long> out = new HashMap<>();
        if (problemIds.isEmpty()) {
            return out;
        }
        jdbc.query("""
                SELECT problem_id, accumulated_ms + IF(running_since IS NULL, 0,
                       LEAST(TIMESTAMPDIFF(MICROSECOND, running_since, UTC_TIMESTAMP(6)) DIV 1000, :cap)) AS ms
                FROM problem_timers WHERE user_id = :userId AND problem_id IN (:ids)""",
                new MapSqlParameterSource().addValue("userId", userId).addValue("ids", problemIds)
                        .addValue("cap", com.teacode.service.TimerService.MAX_SEGMENT_MS),
                rs -> {
                    out.put(rs.getLong("problem_id"), rs.getLong("ms"));
                });
        return out;
    }
}
