# API contract (`/api/v1`)

Status: the frontend is written against these shapes and the backend implements them. **The backend has never been compiled or run** (Maven Central is unreachable in the build sandbox); only a parse-only syntax check has passed. Treat everything below as "implemented, unverified" until `mvn verify` (including the Testcontainers ITs) passes on a machine with network access.

Errors use `{ "code", "message", "correlationId", "timestamp" }`. Mutating requests are cookie-authenticated and require the `X-XSRF-TOKEN` header (value of the `XSRF-TOKEN` cookie).

## Auth
| Endpoint | Request | Success | Notes |
|---|---|---|---|
| `POST /auth/register` | `{ username, email, password, acceptPolicies: true, policyVersion }` | 202 | Same response for new and existing emails (no enumeration). Sends a verification email. Username `^[A-Za-z0-9_]{3,30}$`; password 10-128 chars |
| `POST /auth/login` | `{ email, password }` | 200 user + HttpOnly cookies | Generic 401 for bad credentials; 429 when rate-limited |
| `POST /auth/logout` | none | 204 | Revokes the refresh session, clears cookies |
| `POST /auth/refresh` | none (refresh cookie) | 204 + new cookies | Rotates the refresh token; reuse of an old token revokes every session of that user. The frontend calls this once, automatically, on a 401 and retries the request |
| `GET /auth/me` | none | 200 user / 401 | |
| `POST /auth/verify-email` | `{ token }` | 204 / 400 | Single-use token |
| `POST /auth/forgot-password` | `{ email }` | 202 always | |
| `POST /auth/reset-password` | `{ token, password }` | 204 / 400 | Single-use, revokes existing sessions |

### OAuth2 sign-in (Google, GitHub)
Browser navigations, not XHR: `GET /oauth2/authorization/{google|github}` -> provider -> `GET /login/oauth2/code/{id}` -> redirect to `/dashboard` with the same HttpOnly session cookies as a password login. Only enabled for a provider when both its client id and secret are configured; otherwise those URLs return 404.

- A known provider identity signs in directly.
- Otherwise the provider must vouch for a **verified** email (Google `email_verified`; GitHub: the primary email GitHub marks verified). If not: `/login?oauth_error=email_unverified`.
- An existing account with that email is linked. If that account's email was never verified, its password is replaced with an unusable one and its sessions are revoked (pre-registration hijack defence).
- Otherwise a verified account is created (username derived from the provider name, made unique). No policy acceptance is recorded for these accounts yet (see "Known gaps").
- Failures redirect to `/login?oauth_error=<email_unverified|account_disabled|denied|failed>`; no provider tokens are stored.
- OAuth-only accounts have no known password: to change or delete the account they first use "Forgot password" to set one.
- The handshake uses a short-lived server session (cookie `CV_OAUTH`) that is invalidated immediately afterwards; with several backend instances the load balancer must keep a client on one instance during those few seconds.

## Problems
- `GET /problems?search&difficulty&topics&solved&source&minRating&maxRating&sort&page&size` -> `{ items: [{ slug, title, difficulty, rating, source, tags, solved?, timeSpentMs? }], page, size, totalItems, totalPages }`. `sort`: newest, oldest, title, difficulty, rating_asc, rating_desc; `source`: LOCAL, CODEFORCES, PACKAGE.
  - `search`: case-insensitive title substring (LIKE wildcards are literal). `topics`: comma-separated topic slugs, **any-match** (max 20). `sort`: `newest|oldest|title|difficulty`. `size` 1-50.
  - `solved=true|false` requires sign-in (400 otherwise); `solved` is present on items only for signed-in callers.
- `GET /problems/topics` -> `[{ name, slug }]` (topics of published problems)
- `GET /problems/{slug}` -> `{ slug, title, difficulty, rating, source, sourceUrl, statementAvailable, testDataStatus (FULL|SAMPLES_ONLY|NONE), judgeable, description (null when unavailable), constraints, inputFormat, outputFormat, tags, sampleCases }` (samples only; private tests are never returned)
- `GET /problems/{slug}/starter-code` -> `[{ language, code }]`
- Only `PUBLISHED` problems are ever returned. Hidden cases never appear in any public response.

## Execution (JDoodle)
- `GET /execution/languages` -> `[{ key, name, version, kind }]` (`kind` PROGRAM or DATABASE). Empty when JDoodle credentials are not configured.
- `POST /submissions/run` / `POST /submissions/submit` `{ problemSlug, language, sourceCode (<= 64000 chars) }` -> 202 `{ jobId }`. Run uses sample cases; submit uses all cases and stores a submission; progress is computed from stored submissions.
- `POST /terminal/run` `{ language, sourceCode, stdin (<= 10000 chars) }` -> 202 `{ jobId }`. Standalone: no problem, nothing stored (5 s CPU, 256 MB).
- `GET /submissions/jobs/{jobId}` (owner only; others get 404) -> `{ state: QUEUED|RUNNING|COMPLETED|FAILED, status, errorCode, passedTests, totalTests, executionTimeMs, memoryKb, compileOutput, stdout, stderr, cases }`
  - `status`: `ACCEPTED | WRONG_ANSWER | COMPILATION_ERROR | RUNTIME_ERROR | TIME_LIMIT_EXCEEDED | INSUFFICIENT_VERIFICATION` for submit, `SAMPLES_PASSED` for run, `FINISHED` for the terminal (JDoodle gives no exit status). `FAILED` jobs carry `errorCode` (`EXECUTION_SERVICE_UNAVAILABLE | EXECUTION_NOT_CONFIGURED | EXECUTION_CREDENTIALS_REJECTED | EXECUTION_QUOTA_EXCEEDED | EXECUTION_BUSY | TEST_DATA_UNAVAILABLE`). Start errors: 422 `LANGUAGE_NOT_SUPPORTED_FOR_PROBLEMS | EXECUTION_MODEL_UNSUPPORTED | TEST_DATA_UNAVAILABLE | TEST_SUITE_TOO_LARGE`. Runtime Error and Time Limit detection partly rely on output text (heuristic).
  - `cases[]`: `{ index, sample, status, timeMs, memoryKb }`. `input`, `expected`, `actual`, `stderr` are present **only for sample cases**. Hidden cases carry verdict and resource use only (a program could otherwise echo hidden input through stderr).
  - `FAILED` + `errorCode`: `EXECUTION_SERVICE_UNAVAILABLE`, `EXECUTION_TIMEOUT`, `EXECUTION_BUSY`, `INTERRUPTED`, `PROBLEM_HAS_NO_TESTS`, `INTERNAL_ERROR`. Nothing was judged.
- Guards: signed in (401); **verified email required (403 `EMAIL_NOT_VERIFIED`)**; per-user rate limits (run/terminal 20/min, submit 10/min) and at most 2 unfinished jobs per user (429); full worker queue -> 503 `EXECUTION_BUSY`. Jobs whose worker disappeared are failed with `INTERRUPTED` after a few minutes.
- Comparison per problem: `EXACT | TRIM_LINES | TOKEN | FLOAT_TOLERANCE`.
- Java must declare `public class Main`.

## Timers (per problem, signed in)
- `GET /timers/{slug}`, `POST /timers/{slug}/start|pause|reset` -> `{ state: IDLE|RUNNING|PAUSED, elapsedMs, serverTime }`. Idempotent; start = resume. Counts wall-clock time between start and pause (max 4 h per running stretch).

## Attempts (legacy solve timer, unused by the UI)
- `POST /attempts/start` `{ problemSlug }` -> `{ id, startedAt, serverTime }`. Idempotent: returns the open attempt or opens one (a unique index allows one open attempt per user and problem).
- `POST /attempts/{id}/finish` -> `{ elapsedMs }`. Idempotent; 404 for anyone but the owner.

## Dashboard and submissions
- `GET /dashboard/summary` -> `{ solvedCount, totalProblems, totalSubmissions, acceptedSubmissions }`
- `GET /dashboard/progress` -> `[{ difficulty, solved, total }]` (EASY, MEDIUM, HARD, UNRATED always present)
- `GET /dashboard/summary` -> `{ solvedCount, totalProblems, totalSubmissions, acceptedSubmissions, attemptedProblems, acceptanceRate (null if none judged), totalTimeMs }`
- `GET /dashboard/languages`, `/dashboard/topics`, `/dashboard/time` -> per-user breakdowns
- `GET /dashboard/activity` -> `[{ date: "YYYY-MM-DD", submissions }]` (last 30 UTC days, oldest first, zero days included)
- `GET /submissions/mine?page&size` -> page of `{ id, problemSlug, problemTitle, language, status, passedTests, totalTests, executionTimeMs, memoryKb, createdAt }` (own only)
- `GET /submissions/{id}` -> same plus `sourceCode`; 404 for anyone but the owner

## Account
- `GET /users/me` -> `{ username, email, emailVerified, createdAt, authProviders: ["Google"], avatarUrl, avatarSource: "CUSTOM"|"PROVIDER"|null, providerAvatarAvailable }`
- `PATCH /users/me` `{ username }` -> updated user (409 if taken)
- `POST /users/me/avatar` multipart field `file` (PNG/JPEG/WebP, <= 2 MB, 32-4096 px) -> updated user. The server ignores the browser-declared type, checks the real format, decodes it, crops to a square, scales to 256 px and re-encodes as PNG (metadata and trailing data are dropped). 10 uploads/hour.
- `DELETE /users/me/avatar` -> updated user (provider image becomes active again, if any)
- `GET /avatars/{key}` (public, immutable cache) serves a re-encoded avatar by random key
- `POST /users/me/change-password` `{ currentPassword, newPassword }` -> 204; revokes all sessions
- `DELETE /users/me` `{ password }` -> 204; deletes the account and its data, clears cookies

## Known gaps
No endpoint to resend the verification email; no admin/problem-management API (by design: problems come from the built-in collection and the package folder); no policy re-acceptance flow and no policy acceptance recorded for OAuth sign-ups; avatar URLs from providers are loaded by the browser directly from the provider's CDN (allowed in the nginx CSP), which reveals the visitor's IP to that CDN.
