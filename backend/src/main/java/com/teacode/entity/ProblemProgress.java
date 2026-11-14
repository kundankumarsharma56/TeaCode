package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.hibernate.annotations.Immutable;

/** Read-only view of user_problem_progress for query filters. Writes go through ProgressRepository (atomic upsert). */
@Entity
@Immutable
@Table(name = "user_problem_progress")
public class ProblemProgress {

    @Id
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "problem_id", nullable = false)
    private Long problemId;

    @Column(name = "solved", nullable = false)
    private boolean solved;

    protected ProblemProgress() {
    }

    public Long getId() { return id; }
    public Long getUserId() { return userId; }
    public Long getProblemId() { return problemId; }
    public boolean isSolved() { return solved; }
}
