-- Standalone compiler jobs may be created without an account. Authenticated problem jobs remain user-owned.
ALTER TABLE submission_jobs DROP CHECK chk_jobs_mode;
ALTER TABLE submission_jobs MODIFY COLUMN user_id BIGINT UNSIGNED NULL;
ALTER TABLE submission_jobs ADD CONSTRAINT chk_jobs_mode CHECK (mode IN ('RUN','SUBMIT','TERMINAL'));
