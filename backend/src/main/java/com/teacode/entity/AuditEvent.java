package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

/** Security audit record. Never holds passwords, tokens, cookies or authorization headers. */
@Entity
@Table(name = "audit_events")
public class AuditEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id")
    private Long userId;

    @Column(name = "event_type", nullable = false, length = 50)
    private String eventType;

    @Column(name = "outcome", nullable = false, length = 15)
    private String outcome;

    @Column(name = "correlation_id", length = 64)
    private String correlationId;

    @Column(name = "ip_hash", columnDefinition = "char(64)")
    private String ipHash;

    @Column(name = "detail", length = 500)
    private String detail;

    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    protected AuditEvent() {
    }

    public AuditEvent(Long userId, String eventType, String outcome, String correlationId, String ipHash, String detail) {
        this.userId = userId;
        this.eventType = eventType;
        this.outcome = outcome;
        this.correlationId = correlationId;
        this.ipHash = ipHash;
        this.detail = detail;
    }

    public Long getId() {
        return id;
    }

    public Long getUserId() {
        return userId;
    }

    public String getEventType() {
        return eventType;
    }

    public String getOutcome() {
        return outcome;
    }
}
