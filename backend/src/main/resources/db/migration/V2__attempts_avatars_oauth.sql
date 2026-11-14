-- Terminal jobs have no problem and are not persisted as submissions.
ALTER TABLE submission_jobs DROP CHECK chk_jobs_mode;
ALTER TABLE submission_jobs
  ADD CONSTRAINT chk_jobs_mode CHECK (mode IN ('RUN','SUBMIT','TERMINAL'));

-- Server-backed solve timer. At most one unfinished attempt per user and problem:
-- active_flag is 1 while finished_at IS NULL and NULL afterwards (NULLs never collide in a UNIQUE index).
CREATE TABLE attempts (
  id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id      BIGINT UNSIGNED NOT NULL,
  problem_id   BIGINT UNSIGNED NOT NULL,
  started_at   DATETIME(6) NOT NULL,
  finished_at  DATETIME(6) NULL,
  elapsed_ms   BIGINT UNSIGNED NULL,
  active_flag  TINYINT GENERATED ALWAYS AS (IF(finished_at IS NULL, 1, NULL)) STORED,
  PRIMARY KEY (id),
  CONSTRAINT uq_attempt_active UNIQUE (user_id, problem_id, active_flag),
  INDEX idx_attempts_problem (problem_id),
  CONSTRAINT fk_attempts_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_attempts_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Uploaded avatars are validated and re-encoded by the backend and served via an unguessable key.
CREATE TABLE user_avatars (
  user_id       BIGINT UNSIGNED NOT NULL,
  avatar_key    CHAR(32) NOT NULL,
  content_type  VARCHAR(30) NOT NULL,
  data          MEDIUMBLOB NOT NULL,
  updated_at    DATETIME(6) NOT NULL,
  PRIMARY KEY (user_id),
  CONSTRAINT uq_avatar_key UNIQUE (avatar_key),
  CONSTRAINT fk_avatar_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Sign-in providers linked to an account (Google, GitHub). No provider tokens are stored.
CREATE TABLE oauth_identities (
  id                BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id           BIGINT UNSIGNED NOT NULL,
  provider          VARCHAR(20)  NOT NULL,
  provider_user_id  VARCHAR(100) NOT NULL,
  avatar_url        VARCHAR(500) NULL,
  created_at        DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  CONSTRAINT uq_oauth_provider_subject UNIQUE (provider, provider_user_id),
  CONSTRAINT uq_oauth_user_provider UNIQUE (user_id, provider),
  CONSTRAINT fk_oauth_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Chosen avatar when the user has both a provider image and an upload: 'CUSTOM' or 'PROVIDER'.
ALTER TABLE users ADD COLUMN avatar_preference VARCHAR(10) NOT NULL DEFAULT 'PROVIDER';
