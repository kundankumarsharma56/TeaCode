-- Codevibs initial schema (MySQL 8.4, InnoDB, utf8mb4, UTC timestamps)

CREATE TABLE users (
  id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  username         VARCHAR(40)  NOT NULL,
  email            VARCHAR(254) NOT NULL,
  password_hash    VARCHAR(255) NOT NULL,
  role             VARCHAR(20)  NOT NULL DEFAULT 'USER',
  account_status   VARCHAR(20)  NOT NULL DEFAULT 'ACTIVE',
  email_verified   TINYINT(1)   NOT NULL DEFAULT 0,
  created_at       DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at       DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  last_login_at    DATETIME(6)  NULL,
  PRIMARY KEY (id),
  CONSTRAINT uq_users_username UNIQUE (username),
  CONSTRAINT uq_users_email UNIQUE (email),
  CONSTRAINT chk_users_email_lower CHECK (email = LOWER(email))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE problems (
  id                    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title                 VARCHAR(200) NOT NULL,
  slug                  VARCHAR(220) NOT NULL,
  description           MEDIUMTEXT   NOT NULL,
  difficulty            VARCHAR(10)  NOT NULL,
  constraints_text      TEXT         NULL,
  input_format          TEXT         NULL,
  output_format         TEXT         NULL,
  comparison_mode       VARCHAR(20)  NOT NULL DEFAULT 'TRIM_LINES',
  float_tolerance       DOUBLE       NULL,
  time_limit_seconds    DECIMAL(5,2) NOT NULL DEFAULT 2.00,
  memory_limit_kb       INT UNSIGNED NOT NULL DEFAULT 262144,
  visibility            VARCHAR(12)  NOT NULL DEFAULT 'DRAFT',
  created_at            DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at            DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  CONSTRAINT uq_problems_slug UNIQUE (slug),
  CONSTRAINT chk_problems_difficulty CHECK (difficulty IN ('EASY','MEDIUM','HARD')),
  CONSTRAINT chk_problems_visibility CHECK (visibility IN ('DRAFT','PUBLISHED','ARCHIVED')),
  CONSTRAINT chk_problems_comparison CHECK (comparison_mode IN ('EXACT','TRIM_LINES','TOKEN','FLOAT_TOLERANCE')),
  INDEX idx_problems_visibility_difficulty (visibility, difficulty),
  INDEX idx_problems_title (title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE problem_tags (
  id    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name  VARCHAR(50) NOT NULL,
  slug  VARCHAR(60) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT uq_problem_tags_slug UNIQUE (slug),
  CONSTRAINT uq_problem_tags_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE problem_tag_map (
  problem_id BIGINT UNSIGNED NOT NULL,
  tag_id     BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (problem_id, tag_id),
  INDEX idx_ptm_tag (tag_id),
  CONSTRAINT fk_ptm_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE,
  CONSTRAINT fk_ptm_tag FOREIGN KEY (tag_id) REFERENCES problem_tags(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE test_cases (
  id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  problem_id       BIGINT UNSIGNED NOT NULL,
  input_data       MEDIUMTEXT NOT NULL,
  expected_output  MEDIUMTEXT NOT NULL,
  sample_case      TINYINT(1) NOT NULL DEFAULT 0,
  sort_order       INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  INDEX idx_test_cases_problem (problem_id, sample_case, sort_order),
  CONSTRAINT fk_test_cases_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE problem_starter_code (
  id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  problem_id  BIGINT UNSIGNED NOT NULL,
  language    VARCHAR(20) NOT NULL,
  code        TEXT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT uq_starter_problem_language UNIQUE (problem_id, language),
  CONSTRAINT fk_starter_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE submissions (
  id              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id         BIGINT UNSIGNED NOT NULL,
  problem_id      BIGINT UNSIGNED NOT NULL,
  language        VARCHAR(20) NOT NULL,
  source_code     MEDIUMTEXT NOT NULL,
  status          VARCHAR(30) NOT NULL,
  execution_time  DECIMAL(8,3) NULL,
  memory_used     INT UNSIGNED NULL,
  passed_tests    INT NOT NULL DEFAULT 0,
  total_tests     INT NOT NULL DEFAULT 0,
  created_at      DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  INDEX idx_submissions_user_created (user_id, created_at DESC),
  INDEX idx_submissions_user_problem (user_id, problem_id, created_at DESC),
  CONSTRAINT fk_submissions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_submissions_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE submission_jobs (
  id             CHAR(36) NOT NULL,
  user_id        BIGINT UNSIGNED NOT NULL,
  submission_id  BIGINT UNSIGNED NULL,
  mode           VARCHAR(10) NOT NULL,
  state          VARCHAR(15) NOT NULL DEFAULT 'QUEUED',
  result_json    MEDIUMTEXT NULL,
  error_code     VARCHAR(50) NULL,
  created_at     DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at     DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  INDEX idx_jobs_user_state (user_id, state),
  CONSTRAINT chk_jobs_mode CHECK (mode IN ('RUN','SUBMIT')),
  CONSTRAINT fk_jobs_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_jobs_submission FOREIGN KEY (submission_id) REFERENCES submissions(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE user_problem_progress (
  id                 BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id            BIGINT UNSIGNED NOT NULL,
  problem_id         BIGINT UNSIGNED NOT NULL,
  solved             TINYINT(1) NOT NULL DEFAULT 0,
  first_solved_at    DATETIME(6) NULL,
  last_attempted_at  DATETIME(6) NULL,
  PRIMARY KEY (id),
  CONSTRAINT uq_progress_user_problem UNIQUE (user_id, problem_id),
  INDEX idx_progress_problem (problem_id),
  CONSTRAINT fk_progress_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_progress_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE refresh_sessions (
  id                        BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id                   BIGINT UNSIGNED NOT NULL,
  token_hash                CHAR(64) NOT NULL,
  expires_at                DATETIME(6) NOT NULL,
  revoked_at                DATETIME(6) NULL,
  created_at                DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  rotated_from_session_id   BIGINT UNSIGNED NULL,
  PRIMARY KEY (id),
  CONSTRAINT uq_refresh_token_hash UNIQUE (token_hash),
  INDEX idx_refresh_user (user_id),
  INDEX idx_refresh_expires (expires_at),
  CONSTRAINT fk_refresh_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_refresh_rotated FOREIGN KEY (rotated_from_session_id) REFERENCES refresh_sessions(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE email_verification_tokens (
  id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id     BIGINT UNSIGNED NOT NULL,
  token_hash  CHAR(64) NOT NULL,
  expires_at  DATETIME(6) NOT NULL,
  used_at     DATETIME(6) NULL,
  created_at  DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  CONSTRAINT uq_evt_hash UNIQUE (token_hash),
  INDEX idx_evt_user (user_id),
  CONSTRAINT fk_evt_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE password_reset_tokens (
  id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id     BIGINT UNSIGNED NOT NULL,
  token_hash  CHAR(64) NOT NULL,
  expires_at  DATETIME(6) NOT NULL,
  used_at     DATETIME(6) NULL,
  created_at  DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  CONSTRAINT uq_prt_hash UNIQUE (token_hash),
  INDEX idx_prt_user (user_id),
  CONSTRAINT fk_prt_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE policy_acceptances (
  id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id          BIGINT UNSIGNED NOT NULL,
  policy_type      VARCHAR(30) NOT NULL,
  policy_version   VARCHAR(20) NOT NULL,
  accepted_at      DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  metadata         JSON NULL,
  PRIMARY KEY (id),
  CONSTRAINT uq_policy_user_type_version UNIQUE (user_id, policy_type, policy_version),
  CONSTRAINT fk_policy_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Audit records deliberately hold no secrets (no passwords, tokens, cookies, auth headers).
CREATE TABLE audit_events (
  id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id       BIGINT UNSIGNED NULL,
  event_type    VARCHAR(50) NOT NULL,
  outcome       VARCHAR(15) NOT NULL,
  correlation_id VARCHAR(64) NULL,
  ip_hash       CHAR(64) NULL,
  detail        VARCHAR(500) NULL,
  created_at    DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  INDEX idx_audit_user_time (user_id, created_at),
  INDEX idx_audit_type_time (event_type, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
