package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "policy_acceptances")
public class PolicyAcceptance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "policy_type", nullable = false, length = 30)
    private String policyType;

    @Column(name = "policy_version", nullable = false, length = 20)
    private String policyVersion;

    @Column(name = "accepted_at", insertable = false, updatable = false)
    private LocalDateTime acceptedAt;

    protected PolicyAcceptance() {
    }

    public PolicyAcceptance(Long userId, String policyType, String policyVersion) {
        this.userId = userId;
        this.policyType = policyType;
        this.policyVersion = policyVersion;
    }

    public Long getId() {
        return id;
    }

    public Long getUserId() {
        return userId;
    }

    public String getPolicyType() {
        return policyType;
    }

    public String getPolicyVersion() {
        return policyVersion;
    }
}
