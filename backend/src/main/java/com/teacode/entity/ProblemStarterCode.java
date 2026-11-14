package com.teacode.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "problem_starter_code")
public class ProblemStarterCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "problem_id", nullable = false)
    private Long problemId;

    @Column(name = "language", nullable = false, length = 20)
    private String language;

    @Column(name = "code", nullable = false, columnDefinition = "text")
    private String code;

    protected ProblemStarterCode() {
    }

    public Long getId() {
        return id;
    }

    public Long getProblemId() {
        return problemId;
    }

    public String getLanguage() {
        return language;
    }

    public String getCode() {
        return code;
    }
}
