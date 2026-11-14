-- V3: external problem catalog (Codeforces metadata, authorized packages), per-problem timers, progress indexes.
-- Forward-compatible: existing rows keep working (source LOCAL, statement AVAILABLE, execution STDIN).

-- A catalog entry may have no stored statement (link-only), and Codeforces problems may be unrated.
ALTER TABLE problems DROP CHECK chk_problems_difficulty;
ALTER TABLE problems ADD CONSTRAINT chk_problems_difficulty CHECK (difficulty IN ('EASY','MEDIUM','HARD','UNRATED'));
ALTER TABLE problems MODIFY description MEDIUMTEXT NULL;

ALTER TABLE problems
  ADD COLUMN source            VARCHAR(20)  NOT NULL DEFAULT 'LOCAL',
  ADD COLUMN source_id         VARCHAR(60)  NULL,
  ADD COLUMN source_url        VARCHAR(300) NULL,
  ADD COLUMN contest_id        INT          NULL,
  ADD COLUMN problem_index     VARCHAR(10)  NULL,
  ADD COLUMN rating            INT          NULL,
  ADD COLUMN statement_status  VARCHAR(12)  NOT NULL DEFAULT 'AVAILABLE',
  ADD COLUMN execution_model   VARCHAR(10)  NOT NULL DEFAULT 'STDIN',
  ADD COLUMN source_synced_at  DATETIME(6)  NULL,
  ADD CONSTRAINT chk_problems_source    CHECK (source IN ('LOCAL','CODEFORCES','PACKAGE')),
  ADD CONSTRAINT chk_problems_statement CHECK (statement_status IN ('AVAILABLE','LINK_ONLY')),
  ADD CONSTRAINT chk_problems_exec_model CHECK (execution_model IN ('STDIN','FUNCTION')),
  -- Idempotent sync and duplicate-import prevention. Rows without a source_id (LOCAL) never collide.
  ADD CONSTRAINT uq_problems_source UNIQUE (source, source_id),
  ADD INDEX idx_problems_visibility_rating (visibility, rating),
  ADD INDEX idx_problems_source (source, visibility);

-- Last synchronisation of an external catalog, so a failed run is visible and the next run is safe.
CREATE TABLE catalog_sync_state (
  source           VARCHAR(20)  NOT NULL,
  last_attempt_at  DATETIME(6)  NULL,
  last_success_at  DATETIME(6)  NULL,
  last_status      VARCHAR(12)  NOT NULL DEFAULT 'NEVER',
  last_message     VARCHAR(300) NULL,
  problems_seen    INT          NOT NULL DEFAULT 0,
  PRIMARY KEY (source),
  CONSTRAINT chk_sync_status CHECK (last_status IN ('NEVER','RUNNING','SUCCESS','FAILED','PARTIAL'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Audit trail of authorized problem-package imports.
CREATE TABLE problem_imports (
  id             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  archive_sha256 CHAR(64)     NOT NULL,
  filename       VARCHAR(200) NOT NULL,
  status         VARCHAR(12)  NOT NULL,
  problem_id     BIGINT UNSIGNED NULL,
  imported_by    BIGINT UNSIGNED NULL,
  license_note   VARCHAR(300) NULL,
  error_message  VARCHAR(500) NULL,
  created_at     DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  INDEX idx_imports_hash (archive_sha256),
  CONSTRAINT chk_imports_status CHECK (status IN ('IMPORTED','FAILED')),
  CONSTRAINT fk_imports_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE SET NULL,
  CONSTRAINT fk_imports_user FOREIGN KEY (imported_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Per-user, per-problem solving timer. Time is WALL-CLOCK time while the timer is running (it is not a
-- measure of active study). accumulated_ms holds closed segments; running_since is set while running.
CREATE TABLE problem_timers (
  id              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id         BIGINT UNSIGNED NOT NULL,
  problem_id      BIGINT UNSIGNED NOT NULL,
  accumulated_ms  BIGINT UNSIGNED NOT NULL DEFAULT 0,
  running_since   DATETIME(6) NULL,
  updated_at      DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  CONSTRAINT uq_timer_user_problem UNIQUE (user_id, problem_id),
  INDEX idx_timer_problem (problem_id),
  CONSTRAINT fk_timer_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_timer_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Progress is computed from submissions (the source of truth); these indexes keep that cheap.
ALTER TABLE submissions
  ADD INDEX idx_submissions_user_status_problem (user_id, status, problem_id),
  ADD INDEX idx_submissions_user_language (user_id, language);
