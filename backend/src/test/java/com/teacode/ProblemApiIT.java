package com.teacode;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/** Public problem API against a real MySQL 8.4 container (schema comes from Flyway; Hibernate only validates). */
@Testcontainers
@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource(properties = {
        "teacode.public-url=http://localhost",
        "teacode.security.jwt-secret=test-only-secret-that-is-long-enough-0123456789"
})
class ProblemApiIT {

    private static final String HIDDEN_MARKER = "SECRET_HIDDEN_CASE_42";

    @Container
    static final MySQLContainer<?> MYSQL = new MySQLContainer<>("mysql:8.4")
            .withCommand("--character-set-server=utf8mb4", "--collation-server=utf8mb4_0900_ai_ci");

    @DynamicPropertySource
    static void datasource(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", MYSQL::getJdbcUrl);
        registry.add("spring.datasource.username", MYSQL::getUsername);
        registry.add("spring.datasource.password", MYSQL::getPassword);
    }

    @Autowired
    MockMvc mvc;

    @Autowired
    JdbcTemplate jdbc;

    @BeforeEach
    void cleanAndSeed() {
        for (String table : new String[] {"problem_tag_map", "test_cases", "problem_starter_code", "problems", "problem_tags"}) {
            jdbc.update("delete from " + table);
        }
        long arrays = tag("Arrays", "arrays");
        long graphs = tag("Graphs", "graphs");

        long twoSum = problem("Two Sum", "two-sum", "EASY", "PUBLISHED");
        long lis = problem("Longest Increasing Subsequence", "lis", "MEDIUM", "PUBLISHED");
        long hardOne = problem("Shortest Path 100%", "shortest-path", "HARD", "PUBLISHED");
        problem("Secret Draft", "secret-draft", "EASY", "DRAFT");
        problem("Old Problem", "old-problem", "EASY", "ARCHIVED");

        link(twoSum, arrays);
        link(lis, arrays);
        link(hardOne, graphs);
        link(hardOne, arrays);

        testCase(twoSum, "2 7 11 15\n9", "0 1", true, 1);
        testCase(twoSum, HIDDEN_MARKER + "_INPUT", HIDDEN_MARKER + "_OUTPUT", false, 2);
        jdbc.update("insert into problem_starter_code (problem_id, language, code) values (?,?,?)",
                twoSum, "python", "def solve():\n    pass");
    }

    @Test
    void listReturnsOnlyPublishedProblems() throws Exception {
        mvc.perform(get("/api/v1/problems"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalItems").value(3))
                .andExpect(jsonPath("$.items[?(@.slug=='secret-draft')]").isEmpty())
                .andExpect(jsonPath("$.items[?(@.slug=='old-problem')]").isEmpty());
    }

    @Test
    void paginationIsServerSide() throws Exception {
        mvc.perform(get("/api/v1/problems").param("size", "2").param("page", "0").param("sort", "oldest"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.items.length()").value(2))
                .andExpect(jsonPath("$.totalItems").value(3))
                .andExpect(jsonPath("$.totalPages").value(2))
                .andExpect(jsonPath("$.items[0].slug").value("two-sum"));
        mvc.perform(get("/api/v1/problems").param("size", "2").param("page", "1").param("sort", "oldest"))
                .andExpect(jsonPath("$.items.length()").value(1))
                .andExpect(jsonPath("$.items[0].slug").value("shortest-path"));
    }

    @Test
    void searchMatchesTitleCaseInsensitively() throws Exception {
        mvc.perform(get("/api/v1/problems").param("search", "increasing"))
                .andExpect(jsonPath("$.totalItems").value(1))
                .andExpect(jsonPath("$.items[0].slug").value("lis"));
    }

    @Test
    void searchTreatsLikeWildcardsAsLiteralText() throws Exception {
        mvc.perform(get("/api/v1/problems").param("search", "%"))
                .andExpect(jsonPath("$.totalItems").value(1))
                .andExpect(jsonPath("$.items[0].slug").value("shortest-path"));
        mvc.perform(get("/api/v1/problems").param("search", "_"))
                .andExpect(jsonPath("$.totalItems").value(0));
    }

    @Test
    void difficultyFilter() throws Exception {
        mvc.perform(get("/api/v1/problems").param("difficulty", "hard"))
                .andExpect(jsonPath("$.totalItems").value(1))
                .andExpect(jsonPath("$.items[0].difficulty").value("HARD"));
    }

    @Test
    void tagFilterReturnsEachProblemOnce() throws Exception {
        mvc.perform(get("/api/v1/problems").param("topics", "arrays"))
                .andExpect(jsonPath("$.totalItems").value(3));
        mvc.perform(get("/api/v1/problems").param("topics", "graphs"))
                .andExpect(jsonPath("$.totalItems").value(1));
    }

    @Test
    void sortByTitleAndDifficulty() throws Exception {
        mvc.perform(get("/api/v1/problems").param("sort", "title"))
                .andExpect(jsonPath("$.items[0].slug").value("lis"))
                .andExpect(jsonPath("$.items[2].slug").value("two-sum"));
        mvc.perform(get("/api/v1/problems").param("sort", "difficulty"))
                .andExpect(jsonPath("$.items[0].difficulty").value("EASY"))
                .andExpect(jsonPath("$.items[1].difficulty").value("MEDIUM"))
                .andExpect(jsonPath("$.items[2].difficulty").value("HARD"));
    }

    @Test
    void listIncludesTagsAndOmitsSolvedForAnonymousUsers() throws Exception {
        mvc.perform(get("/api/v1/problems").param("topics", "graphs"))
                .andExpect(jsonPath("$.items[0].tags.length()").value(2))
                .andExpect(jsonPath("$.items[0].solved").doesNotExist());
    }

    @Test
    void invalidParametersAreRejectedWithConsistentErrors() throws Exception {
        mvc.perform(get("/api/v1/problems").param("size", "0")).andExpect(status().isBadRequest());
        mvc.perform(get("/api/v1/problems").param("size", "1000")).andExpect(status().isBadRequest());
        mvc.perform(get("/api/v1/problems").param("page", "-1")).andExpect(status().isBadRequest());
        mvc.perform(get("/api/v1/problems").param("page", "abc")).andExpect(status().isBadRequest());
        mvc.perform(get("/api/v1/problems").param("difficulty", "IMPOSSIBLE")).andExpect(status().isBadRequest());
        mvc.perform(get("/api/v1/problems").param("sort", "random")).andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("BAD_REQUEST"))
                .andExpect(jsonPath("$.correlationId").isNotEmpty());
    }

    @Test
    void detailExposesSampleCasesOnly() throws Exception {
        MvcResult result = mvc.perform(get("/api/v1/problems/two-sum"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.title").value("Two Sum"))
                .andExpect(jsonPath("$.sampleCases.length()").value(1))
                .andExpect(jsonPath("$.sampleCases[0].expectedOutput").value("0 1"))
                .andReturn();
        assertThat(result.getResponse().getContentAsString()).doesNotContain(HIDDEN_MARKER);
    }

    @Test
    void hiddenCasesNeverAppearInAnyPublicResponse() throws Exception {
        for (String path : new String[] {
                "/api/v1/problems", "/api/v1/problems/two-sum", "/api/v1/problems/two-sum/starter-code", "/api/v1/problems/topics"}) {
            String body = mvc.perform(get(path)).andReturn().getResponse().getContentAsString();
            assertThat(body).as(path).doesNotContain(HIDDEN_MARKER);
        }
    }

    @Test
    void unpublishedAndUnknownProblemsAre404() throws Exception {
        mvc.perform(get("/api/v1/problems/secret-draft")).andExpect(status().isNotFound());
        mvc.perform(get("/api/v1/problems/old-problem")).andExpect(status().isNotFound());
        mvc.perform(get("/api/v1/problems/does-not-exist")).andExpect(status().isNotFound());
        mvc.perform(get("/api/v1/problems/secret-draft/starter-code")).andExpect(status().isNotFound());
    }

    @Test
    void starterCodeIsReturnedPerLanguage() throws Exception {
        mvc.perform(get("/api/v1/problems/two-sum/starter-code"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].language").value("python"));
    }

    @Test
    void severalTopicsMatchProblemsWithAnyOfThem() throws Exception {
        mvc.perform(get("/api/v1/problems").param("topics", "graphs,arrays"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalItems").value(3)); // two-sum, lis, shortest-path (once, though it has both tags)
    }

    @Test
    void solvedFilterRequiresSignInAndRejectsOtherValues() throws Exception {
        mvc.perform(get("/api/v1/problems").param("solved", "true")).andExpect(status().isBadRequest());
        mvc.perform(get("/api/v1/problems")).andExpect(jsonPath("$.items[0].solved").doesNotExist());
    }

    @Test
    void problemsNotOwnedByTeaCodeAreNeverListedSearchedOpenedOrFiltered() throws Exception {
        long before = totalListed();
        jdbc.update("insert into problems (title, slug, description, difficulty, visibility, source, source_id, source_url, rating, statement_status) "
                + "values ('CF A','cf-1-a',NULL,'EASY','PUBLISHED','CODEFORCES','1-A','https://example.invalid/1/A',800,'LINK_ONLY')");
        // listing and search
        org.junit.jupiter.api.Assertions.assertEquals(before, totalListed());
        mvc.perform(get("/api/v1/problems").param("search", "CF A")).andExpect(jsonPath("$.totalItems").value(0));
        // the explicit source filter cannot reach it either
        mvc.perform(get("/api/v1/problems").param("source", "codeforces")).andExpect(status().isBadRequest());
        // detail, starter code
        mvc.perform(get("/api/v1/problems/cf-1-a")).andExpect(status().isNotFound());
        mvc.perform(get("/api/v1/problems/cf-1-a/starter-code")).andExpect(status().isNotFound());
        // validation of the remaining filters is unchanged
        mvc.perform(get("/api/v1/problems").param("source", "bogus")).andExpect(status().isBadRequest());
        mvc.perform(get("/api/v1/problems").param("minRating", "2000").param("maxRating", "800")).andExpect(status().isBadRequest());
    }

    private long totalListed() throws Exception {
        String body = mvc.perform(get("/api/v1/problems")).andReturn().getResponse().getContentAsString();
        return new com.fasterxml.jackson.databind.ObjectMapper().readTree(body).get("totalItems").asLong();
    }

    @Test
    void tagsListContainsOnlyTagsOfPublishedProblems() throws Exception {
        long orphan = tag("Orphan", "orphan");
        long draft = jdbc.queryForObject("select id from problems where slug='secret-draft'", Long.class);
        link(draft, orphan);
        mvc.perform(get("/api/v1/problems/topics"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2))
                .andExpect(jsonPath("$[0].slug").value("arrays"))
                .andExpect(jsonPath("$[1].slug").value("graphs"));
    }

    @Test
    void correlationIdIsGeneratedAndEchoed() throws Exception {
        mvc.perform(get("/api/v1/problems")).andExpect(header().exists("X-Correlation-Id"));
        mvc.perform(get("/api/v1/problems").header("X-Correlation-Id", "abc-123"))
                .andExpect(header().string("X-Correlation-Id", "abc-123"));
        MvcResult unsafe = mvc.perform(get("/api/v1/problems").header("X-Correlation-Id", "bad id\twith chars"))
                .andReturn();
        assertThat(unsafe.getResponse().getHeader("X-Correlation-Id")).isNotEqualTo("bad id\twith chars");
    }

    @Test
    void protectedRoutesRequireAuthentication() throws Exception {
        mvc.perform(get("/api/v1/auth/me")).andExpect(status().isUnauthorized());
        mvc.perform(post("/api/v1/submissions/run").with(csrf())).andExpect(status().isUnauthorized());
    }

    private long tag(String name, String slug) {
        jdbc.update("insert into problem_tags (name, slug) values (?,?)", name, slug);
        return jdbc.queryForObject("select id from problem_tags where slug=?", Long.class, slug);
    }

    private long problem(String title, String slug, String difficulty, String visibility) {
        jdbc.update("insert into problems (title, slug, description, difficulty, visibility) values (?,?,?,?,?)",
                title, slug, "Description of " + title, difficulty, visibility);
        return jdbc.queryForObject("select id from problems where slug=?", Long.class, slug);
    }

    private void link(long problemId, long tagId) {
        jdbc.update("insert into problem_tag_map (problem_id, tag_id) values (?,?)", problemId, tagId);
    }

    private void testCase(long problemId, String input, String output, boolean sample, int order) {
        jdbc.update("insert into test_cases (problem_id, input_data, expected_output, sample_case, sort_order) values (?,?,?,?,?)",
                problemId, input, output, sample, order);
    }
}
