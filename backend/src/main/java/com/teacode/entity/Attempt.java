package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

/** One timed solving attempt. The generated active_flag column (not mapped) keeps one open attempt per user and problem. */
@Entity
@Table(name = "attempts")
public class Attempt {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "problem_id", nullable = false)
    private Long problemId;

    @Column(name = "started_at", nullable = false)
    private LocalDateTime startedAt;

    @Column(name = "finished_at")
    private LocalDateTime finishedAt;

    @Column(name = "elapsed_ms")
    private Long elapsedMs;

    protected Attempt() {
    }

    public Attempt(Long userId, Long problemId, LocalDateTime startedAt) {
        this.userId = userId;
        this.problemId = problemId;
        this.startedAt = startedAt;
    }

    public Long getId() { return id; }
    public Long getUserId() { return userId; }
    public Long getProblemId() { return problemId; }
    public LocalDateTime getStartedAt() { return startedAt; }
    public LocalDateTime getFinishedAt() { return finishedAt; }
    public Long getElapsedMs() { return elapsedMs; }
}
