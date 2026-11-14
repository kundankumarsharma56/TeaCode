-- V4: reference solutions, kept apart from problem statements. One row per (problem, language); each row has its own
-- verification state. A row is VERIFIED only after the solution ran against the problem's tests (public and hidden),
-- and the evidence is stored in validation_report. Nothing here is ever returned by a public API.
CREATE TABLE reference_solutions (
  id                    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  problem_id            BIGINT UNSIGNED NOT NULL,
  language              VARCHAR(20)  NOT NULL,
  source_code           MEDIUMTEXT   NOT NULL,
  runtime_version       VARCHAR(80)  NULL,
  solution_version      INT          NOT NULL DEFAULT 1,
  verification_status   VARCHAR(12)  NOT NULL DEFAULT 'UNVERIFIED',
  last_verified_at      DATETIME(6)  NULL,
  validation_report     MEDIUMTEXT   NULL,
  created_at            DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at            DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  CONSTRAINT uq_refsol_problem_language UNIQUE (problem_id, language),
  INDEX idx_refsol_language_status (language, verification_status),
  CONSTRAINT chk_refsol_status CHECK (verification_status IN ('UNVERIFIED','VERIFIED','FAILED')),
  -- A VERIFIED row must carry its proof.
  CONSTRAINT chk_refsol_verified_evidence CHECK (verification_status <> 'VERIFIED'
      OR (last_verified_at IS NOT NULL AND validation_report IS NOT NULL)),
  CONSTRAINT fk_refsol_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
