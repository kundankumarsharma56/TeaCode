-- V8: Codevibs owns its problem set. Every problem that was imported from Codeforces is deleted, together with
-- everything that belongs to it (tags, test cases, starter code, attempts, timers, submissions and progress),
-- because all of those tables reference problems(id) ON DELETE CASCADE.
DELETE FROM problems WHERE source = 'CODEFORCES';

-- Bookkeeping that only existed for the removed synchronisation.
DROP TABLE IF EXISTS problem_source_archive;
DROP TABLE IF EXISTS catalog_sync_state;
