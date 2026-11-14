# Security

Status key: **Built** = code exists and was tested here; **Written** = code exists but was not compiled or run; **Planned** = not started.

| Control | Status |
|---|---|
| No tokens in localStorage/sessionStorage (frontend); a test checks it | Built |
| CSP, nosniff, referrer, permissions, HSTS headers; `/actuator/` blocked at the proxy | Written (`frontend/nginx.conf`, not run) |
| Problem text rendered as plain text, never HTML | Built |
| Hidden test cases never in public API responses (query design, DTOs, integration test) | Written (`ProblemApiIT` not run); UI redaction Built |
| Centralized error responses, safe messages, correlation IDs | Written |
| Schema owned by Flyway; Hibernate only validates | Written |
| LIKE-wildcard escaping in search | Written |
| Cookie auth (HttpOnly, Secure, SameSite), refresh rotation with reuse detection, CSRF handshake | Written (not compiled or run) |
| Argon2id password hashing, login/reset rate limiting, account enumeration protection | Written (not compiled or run); frontend side Built |
| JDoodle integration, per-user concurrency/rate limits, output comparison, package-import safety | Written (not compiled or run); `OutputComparatorTest`, `JdoodleClientTest`, `ProblemPackageImporterTest`, `ExecutionApiIT` written, **not run** |
| Audit events (hashed IP, no secrets), structured logs (prod profile enables ECS JSON logging) | Written (not run) |
| Dependency scanning in CI (`npm audit`; Maven scanning not yet configured) | Written |

## Production-readiness audit (2026-10-27) - changes and status
| Change | Verified how |
|---|---|
| Frontend renews expired access cookies once (single-flight, Web Locks across tabs) instead of logging users out every 15 minutes | 5 Vitest tests, run and passing |
| Refresh-token replay inside a 10 s grace window is refused without ending all sessions; later replays still revoke everything | Code + `AuthApiIT` written, **not run** |
| `RateLimiter`: hard cap on tracked keys with a shared overflow bucket per scope, throttled cleanup | Code + `RateLimiterTest` written, **not run** (Bucket4j unavailable offline) |
| nginx: client `X-Forwarded-*`/`Forwarded` headers no longer reach the backend; real client IP only from private-range proxies; security headers repeated in every location that sets `add_header`; auth-endpoint request throttle; gzip | Written, **nginx not run** (no nginx or Docker daemon in the audit environment) |
| `prod` profile refuses to start with an `http://` public URL or non-Secure cookies (`ProductionGuard`); local HTTP uses `docker-compose.dev.yml` | Code + test written, **not run** |
| `/actuator/**` (except health/info) restricted to ADMIN | Written, **not run** |
| JWT secret placeholder/low-entropy rejection | Code + test written, **not run** |
| Retention job for expired sessions/tokens and old audit rows | Written, **not run** |
| FLOAT_TOLERANCE comparison no longer accepts Java-only number syntax (`1.5f`, `0x1p3`) | Logic executed directly with `java`; JUnit test written |
| `npm audit`: zod 4.6.7, @hookform/resolvers 5, vitest 5 | `npm audit` -> 0 vulnerabilities; full test suite passing |
| CI workflow (lint, tests, build, `npm audit`, Maven verify with Testcontainers, Trivy scan, image build) | YAML parses; **never executed** |

**Not distributed:** the rate limiter is per instance. With N backend instances the effective limits are N times higher. Do not run more than one backend instance until a shared limiter (Redis/DB) is implemented.

**Not enforced:** problem memory limits (JDoodle does not document the unit of the `memory` field, so a Memory Limit Exceeded verdict would be a guess). Time limits are enforced from JDoodle's reported CPU time.

## Known findings
- The frontend now uses react-router 7. Login redirects are still restricted to same-site paths. Re-run `npm audit` on a networked machine and record the result here.
- Colour contrast and screen-reader behaviour have not been audited; the automated axe checks exclude contrast because jsdom cannot compute it.
- CSP uses `style-src 'unsafe-inline'` because MUI/Emotion injects styles at runtime.

## Reporting
Use the support contact configured for the deployment (see Contact page).

## Code execution, avatars and OAuth (backend, unverified)
- **Hidden tests:** loaded only by `ExecutionService` for judging. Stored and returned job results contain input, expected output, actual output and stderr for *sample* cases only, because a submitted program can print its stdin to stderr or stdout.
- **Execution abuse:** email verification is required to run code (403); per-user rate limits and at most two unfinished jobs per user; bounded worker queue (503 when full); source <= 64,000 and stdin <= 10,000 characters; JDoodle enforces its own CPU and time limits (its sandbox policy is JDoodle's; review its terms). JDoodle calls are bounded (max 2 concurrent), never retried automatically because each costs a credit, and at most 20 tests run per submission. The JDoodle client id/secret are only sent from the backend to JDoodle, never to the browser, API responses or logs; source, stdin and upstream bodies are not logged.
- **No fake results:** if JDoodle is down, rejects credentials or is out of quota, the job fails with an `EXECUTION_*` error code; no verdict is produced and no submission is saved. Only a submission checked against private tests can be Accepted.
- **Problem packages:** no upload endpoint and no admin role. Archives are read from a server folder with traversal checks, size/entry caps while streaming, safe YAML, UTF-8 text only, SHA-256 duplicate detection and an import history. Private tests are stored server-side only and never returned.
- **Ownership:** jobs, submissions and attempts are looked up by id *and* the caller's user id; other users get 404.
- **Avatars:** declared type and file name are ignored; magic bytes are checked, dimensions are read from the header before decoding (decompression-bomb guard), the image is decoded, cropped, scaled and re-encoded as PNG, and served by a random key with `Content-Security-Policy: default-src 'none'`.
- **OAuth2:** only provider-verified emails are accepted; linking to an existing account whose email was never verified replaces its password and revokes its sessions; provider tokens are not stored; failures return a short code in the redirect, never an exception message; the temporary handshake session is invalidated at once.

