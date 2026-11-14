package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.util.LinkedHashSet;
import java.util.Set;
import org.hibernate.annotations.BatchSize;

@Entity
@Table(name = "problems")
public class Problem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @Column(name = "slug", nullable = false, length = 220)
    private String slug;

    /** Null for catalog entries whose statement may not be stored (see statementStatus). */
    @Column(name = "description", columnDefinition = "mediumtext")
    private String description;

    /** EASY | MEDIUM | HARD | UNRATED (see Difficulty). */
    @Column(name = "difficulty", nullable = false, length = 10)
    private String difficulty;

    @Column(name = "constraints_text", columnDefinition = "text")
    private String constraintsText;

    @Column(name = "input_format", columnDefinition = "text")
    private String inputFormat;

    @Column(name = "output_format", columnDefinition = "text")
    private String outputFormat;

    /** EXACT | TRIM_LINES | TOKEN | FLOAT_TOLERANCE (see OutputComparator). */
    @Column(name = "comparison_mode", nullable = false, length = 20)
    private String comparisonMode;

    @Column(name = "float_tolerance")
    private Double floatTolerance;

    @Column(name = "time_limit_seconds", nullable = false, precision = 5, scale = 2)
    private BigDecimal timeLimitSeconds;

    @Column(name = "memory_limit_kb", nullable = false)
    private Integer memoryLimitKb;

    /** DRAFT | PUBLISHED | ARCHIVED (see Visibility). */
    @Column(name = "visibility", nullable = false, length = 12)
    private String visibility;

    /** LOCAL | PACKAGE: where the problem came from (external catalogs are not supported). */
    @Column(name = "source", nullable = false, length = 20)
    private String source;

    /** Stable id within the source, e.g. a package id; unique together with source. */
    @Column(name = "source_id", length = 60)
    private String sourceId;

    @Column(name = "source_url", length = 300)
    private String sourceUrl;

    @Column(name = "contest_id")
    private Integer contestId;

    @Column(name = "problem_index", length = 10)
    private String problemIndex;

    @Column(name = "rating")
    private Integer rating;

    /** AVAILABLE | LINK_ONLY: whether a full statement is stored or only a link to the original. */
    @Column(name = "statement_status", nullable = false, length = 12)
    private String statementStatus;

    /** STDIN | FUNCTION. Only STDIN problems can be judged; FUNCTION needs a trusted harness. */
    @Column(name = "execution_model", nullable = false, length = 10)
    private String executionModel;

    // BatchSize loads tags for a whole result page in one query instead of one per problem.
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "problem_tag_map",
            joinColumns = @JoinColumn(name = "problem_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id"))
    @BatchSize(size = 50)
    private Set<ProblemTag> tags = new LinkedHashSet<>();

    protected Problem() {
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getSlug() {
        return slug;
    }

    public String getDescription() {
        return description;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public String getConstraintsText() {
        return constraintsText;
    }

    public String getInputFormat() {
        return inputFormat;
    }

    public String getOutputFormat() {
        return outputFormat;
    }

    public String getComparisonMode() {
        return comparisonMode;
    }

    public Double getFloatTolerance() {
        return floatTolerance;
    }

    public BigDecimal getTimeLimitSeconds() {
        return timeLimitSeconds;
    }

    public Integer getMemoryLimitKb() {
        return memoryLimitKb;
    }

    public String getVisibility() {
        return visibility;
    }

    public Set<ProblemTag> getTags() {
        return tags;
    }

    public String getSource() {
        return source;
    }

    public String getSourceId() {
        return sourceId;
    }

    public String getSourceUrl() {
        return sourceUrl;
    }

    public Integer getContestId() {
        return contestId;
    }

    public String getProblemIndex() {
        return problemIndex;
    }

    public Integer getRating() {
        return rating;
    }

    public String getStatementStatus() {
        return statementStatus;
    }

    public String getExecutionModel() {
        return executionModel;
    }
}
