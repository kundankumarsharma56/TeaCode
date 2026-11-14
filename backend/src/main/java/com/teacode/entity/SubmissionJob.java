package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.PostLoad;
import jakarta.persistence.PostPersist;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import java.time.LocalDateTime;
import org.springframework.data.domain.Persistable;

/**
 * Durable state of one run/submit/terminal execution. State changes after creation are done with
 * atomic UPDATE statements (see SubmissionJobRepository) so concurrent workers cannot overwrite each other.
 */
@Entity
@Table(name = "submission_jobs")
public class SubmissionJob implements Persistable<String> {

    public static final String QUEUED = "QUEUED";
    public static final String RUNNING = "RUNNING";
    public static final String COMPLETED = "COMPLETED";
    public static final String FAILED = "FAILED";

    @Id
    @Column(name = "id", length = 36, columnDefinition = "char(36)")
    private String id;

    @Column(name = "user_id", nullable = true)
    private Long userId;

    @Column(name = "submission_id")
    private Long submissionId;

    @Column(name = "mode", nullable = false, length = 10)
    private String mode;

    @Column(name = "state", nullable = false, length = 15)
    private String state;

    @Column(name = "result_json", columnDefinition = "mediumtext")
    private String resultJson;

    @Column(name = "error_code", length = 50)
    private String errorCode;

    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Transient
    private boolean isNew = true;

    protected SubmissionJob() {
    }

    public SubmissionJob(String id, Long userId, String mode) {
        this.id = id;
        this.userId = userId;
        this.mode = mode;
        this.state = QUEUED;
    }

    @Override
    public String getId() { return id; }

    @Override
    public boolean isNew() { return isNew; }

    @PostLoad
    @PostPersist
    void markNotNew() { this.isNew = false; }

    public Long getUserId() { return userId; }
    public Long getSubmissionId() { return submissionId; }
    public String getMode() { return mode; }
    public String getState() { return state; }
    public String getResultJson() { return resultJson; }
    public String getErrorCode() { return errorCode; }
    public LocalDateTime getCreatedAt() { return createdAt; }
}
