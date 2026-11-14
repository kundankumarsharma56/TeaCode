# Legal review checklist (before public launch)

The policy pages are **drafts written from how the product is built**. They have not been reviewed by counsel.

## Operator must provide (frontend build-time `VITE_*`, see `frontend/.env.example`)
- [ ] Legal entity name, registered address
- [ ] Support email and privacy contact email
- [ ] Hosting provider and email delivery provider
- [ ] Data retention periods (accounts, submissions, backups, audit/security logs)

## Counsel must confirm
- [ ] Liability, warranty disclaimer, governing law, dispute resolution (Terms section 9 is a placeholder)
- [ ] Legal basis for each processing purpose and data-subject rights, including Indian data-protection requirements and any other jurisdiction served
- [ ] Cross-border transfer rules for sending source code to the JDoodle provider (and fetching metadata from Codeforces) and for hosting/email processors
- [ ] Children/minimum-age position
- [ ] Whether the retention exceptions on the deletion page are accurate

## Product behaviour the policies assume (verify when the backend exists)
- [ ] Passwords stored only as hashes; audit logs hold no passwords, tokens or cookies; source code not logged by default
- [ ] Only essential cookies (access, refresh, CSRF) plus a theme preference in local storage; no analytics or ad trackers. If analytics are added, add consent first and update the Cookie Policy
- [ ] Account deletion removes profile, submissions, progress and policy records, with documented exceptions
- [ ] Policy acceptance is recorded with the version (`policy_acceptances`) and users are re-prompted when the version changes (**re-prompt not implemented yet**)
- [ ] Bump `POLICY_VERSION` in `frontend/src/config/legal.js` whenever policy text changes

## Retention as implemented (use these facts when filling `VITE_RETENTION_NOTE`)
Enforced by `DataRetentionJob` (daily 03:45 UTC) and `JobMaintenance` (daily 03:30 UTC); **written, not yet run against a database**:
- Refresh sessions: deleted `teacode.retention.token-grace-days` (default 7) after they expire. Revoked sessions are kept until expiry so token-reuse detection keeps working.
- E-mail verification and password-reset tokens: deleted 7 days after expiry.
- Audit events (hashed IP, event name, outcome; no secrets): deleted after `teacode.retention.audit-days` (default 365, minimum 30). Rows of a deleted account are kept (detached from the user) until that period ends.
- Execution jobs: finished jobs deleted after 7 days. Submissions and progress live until the user deletes the account.
- Account deletion cascades to submissions, progress, timers, attempts, sessions, tokens, OAuth links, avatar and policy acceptances.
- Database backups are an operator responsibility; their retention must be stated by the operator and matched to the policy text.
- Accounts created through Google/GitHub have no known password: deletion and password change need one, so the Settings page tells them to use "Forgot password" first.
