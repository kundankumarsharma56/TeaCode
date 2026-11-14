package com.teacode;

import static org.assertj.core.api.Assertions.assertThat;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashSet;
import java.util.Set;
import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.Test;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/** Applies all Flyway migrations to a real MySQL 8.4 container and checks the resulting schema. */
@Testcontainers
class MigrationIT {

    @Container
    static final MySQLContainer<?> MYSQL = new MySQLContainer<>("mysql:8.4")
            .withCommand("--character-set-server=utf8mb4", "--collation-server=utf8mb4_0900_ai_ci");

    @Test
    void migrationsApplyAndCreateExpectedTables() throws Exception {
        Flyway flyway = Flyway.configure()
                .dataSource(MYSQL.getJdbcUrl(), MYSQL.getUsername(), MYSQL.getPassword())
                .locations("classpath:db/migration")
                .load();
        var result = flyway.migrate();
        assertThat(result.success).isTrue();

        Set<String> tables = new HashSet<>();
        try (Connection c = MYSQL.createConnection("");
             ResultSet rs = c.getMetaData().getTables(MYSQL.getDatabaseName(), null, "%", new String[] {"TABLE"})) {
            while (rs.next()) {
                tables.add(rs.getString("TABLE_NAME"));
            }
        }
        assertThat(tables).contains(
                "users", "problems", "problem_tags", "problem_tag_map", "test_cases", "submissions",
                "user_problem_progress", "refresh_sessions", "email_verification_tokens",
                "password_reset_tokens", "policy_acceptances", "submission_jobs", "audit_events",
                "problem_imports", "problem_timers", "reference_solutions");
    }
}
