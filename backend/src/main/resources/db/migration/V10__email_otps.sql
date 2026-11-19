-- One-time email codes (6 digits). purpose = 'VERIFY' (registration) or 'RESET' (forgot password).
-- Only an HMAC of the code is stored, never the code itself.
CREATE TABLE email_otps (
  id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id     BIGINT UNSIGNED NOT NULL,
  purpose     VARCHAR(10) NOT NULL,
  code_hash   CHAR(64) NOT NULL,
  attempts    INT NOT NULL DEFAULT 0,
  expires_at  DATETIME(6) NOT NULL,
  used_at     DATETIME(6) NULL,
  created_at  DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (id),
  INDEX idx_eo_user_purpose (user_id, purpose),
  CONSTRAINT fk_eo_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;