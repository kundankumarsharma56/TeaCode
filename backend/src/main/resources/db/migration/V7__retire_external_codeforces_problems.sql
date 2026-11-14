-- V7: Codevibs lists only problems it owns. Previously synchronised Codeforces catalog rows are ARCHIVED (not deleted),
-- so submissions, timers and progress that reference them stay intact. The affected ids are recorded so the change is
-- reversible and so only rows that were PUBLISHED at this moment are touched.
--
-- To reverse (manual, only if ever required):
--   UPDATE problems p JOIN problem_source_archive a ON a.problem_id = p.id
--      SET p.visibility = 'PUBLISHED' WHERE p.source = 'CODEFORCES';
--   DROP TABLE problem_source_archive;

CREATE TABLE problem_source_archive (
  problem_id  BIGINT UNSIGNED NOT NULL,
  source      VARCHAR(20)     NOT NULL,
  archived_at DATETIME(6)     NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (problem_id),
  CONSTRAINT fk_psa_problem FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO problem_source_archive (problem_id, source)
SELECT id, source FROM problems WHERE source = 'CODEFORCES' AND visibility = 'PUBLISHED';

UPDATE problems SET visibility = 'ARCHIVED' WHERE source = 'CODEFORCES' AND visibility = 'PUBLISHED';
