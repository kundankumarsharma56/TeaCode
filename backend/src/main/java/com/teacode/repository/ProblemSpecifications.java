package com.teacode.repository;

import com.teacode.entity.Problem;
import com.teacode.entity.ProblemTag;
import com.teacode.enums.Difficulty;
import com.teacode.enums.ProblemSort;
import com.teacode.enums.Visibility;
import jakarta.persistence.criteria.Expression;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Root;
import jakarta.persistence.criteria.Subquery;
import java.util.Locale;
import org.springframework.data.jpa.domain.Specification;

/** Composable filters for the public problem listing. All filtering happens in SQL. */
public final class ProblemSpecifications {

    private static final char LIKE_ESCAPE = '!';

    private ProblemSpecifications() {
    }

    /** Sources that TeaCode owns. Anything else is never listed, searched or filtered, whatever its visibility. */
    public static final java.util.List<String> OWNED_SOURCES = java.util.List.of("LOCAL", "PACKAGE");

    /** Published AND owned by TeaCode: the ownership filter is part of the base predicate of every listing query. */
    public static Specification<Problem> published() {
        return (root, query, cb) -> cb.and(
                cb.equal(root.get("visibility"), Visibility.PUBLISHED.name()),
                root.get("source").in(OWNED_SOURCES));
    }

    public static Specification<Problem> titleContains(String text) {
        String pattern = "%" + escapeLike(text.toLowerCase(Locale.ROOT)) + "%";
        return (root, query, cb) -> cb.like(cb.lower(root.get("title")), pattern, LIKE_ESCAPE);
    }

    public static Specification<Problem> hasDifficulty(Difficulty difficulty) {
        return (root, query, cb) -> cb.equal(root.get("difficulty"), difficulty.name());
    }

    /** Problems having at least one of the given topic slugs (any-match). */
    public static Specification<Problem> hasAnyTagSlug(java.util.Collection<String> tagSlugs) {
        return (root, query, cb) -> {
            Subquery<Long> sub = query.subquery(Long.class);
            Root<Problem> p2 = sub.from(Problem.class);
            Join<Problem, ProblemTag> tag = p2.join("tags");
            sub.select(p2.get("id")).where(
                    cb.equal(p2.get("id"), root.get("id")),
                    tag.get("slug").in(tagSlugs));
            return cb.exists(sub);
        };
    }

    /** Filters by the signed-in user's own progress. {@code solved=false} includes problems never attempted. */
    public static Specification<Problem> solvedBy(long userId, boolean solved) {
        return (root, query, cb) -> {
            Subquery<Long> sub = query.subquery(Long.class);
            // Solved means "has at least one ACCEPTED submission": submissions are the single source of truth.
            Root<com.teacode.entity.Submission> up = sub.from(com.teacode.entity.Submission.class);
            sub.select(up.get("id")).where(
                    cb.equal(up.get("problemId"), root.get("id")),
                    cb.equal(up.get("userId"), userId),
                    cb.equal(up.get("status"), "ACCEPTED"));
            return solved ? cb.exists(sub) : cb.not(cb.exists(sub));
        };
    }

    public static Specification<Problem> fromSource(String source) {
        return (root, query, cb) -> cb.equal(root.get("source"), source);
    }

    public static Specification<Problem> ratingBetween(Integer min, Integer max) {
        return (root, query, cb) -> {
            var p = cb.conjunction();
            if (min != null) {
                p = cb.and(p, cb.greaterThanOrEqualTo(root.<Integer>get("rating"), min));
            }
            if (max != null) {
                p = cb.and(p, cb.lessThanOrEqualTo(root.<Integer>get("rating"), max));
            }
            return p;
        };
    }

    /** Applies ordering to the data query only (the count query has a Long result type). */
    public static Specification<Problem> orderedBy(ProblemSort sort) {
        return (root, query, cb) -> {
            Class<?> type = query.getResultType();
            if (type != Long.class && type != long.class) {
                switch (sort) {
                    case NEWEST -> query.orderBy(cb.desc(root.get("id")));
                    case OLDEST -> query.orderBy(cb.asc(root.get("id")));
                    case TITLE -> query.orderBy(cb.asc(cb.lower(root.get("title"))), cb.asc(root.get("id")));
                    case DIFFICULTY -> {
                        Expression<Integer> rank = cb.<Integer>selectCase()
                                .when(cb.equal(root.get("difficulty"), Difficulty.EASY.name()), 1)
                                .when(cb.equal(root.get("difficulty"), Difficulty.MEDIUM.name()), 2)
                                .when(cb.equal(root.get("difficulty"), Difficulty.HARD.name()), 3)
                                .otherwise(4); // UNRATED last
                        query.orderBy(cb.asc(rank), cb.asc(root.get("id")));
                    }
                    // Unrated problems (NULL rating) always sort after rated ones.
                    case RATING_ASC -> query.orderBy(cb.asc(cb.coalesce(root.<Integer>get("rating"), 100000)), cb.asc(root.get("id")));
                    case RATING_DESC -> query.orderBy(cb.asc(cb.selectCase().when(cb.isNull(root.get("rating")), 1).otherwise(0)),
                            cb.desc(root.<Integer>get("rating")), cb.asc(root.get("id")));
                }
            }
            return cb.conjunction();
        };
    }

    static String escapeLike(String raw) {
        return raw.replace("!", "!!").replace("%", "!%").replace("_", "!_");
    }
}
