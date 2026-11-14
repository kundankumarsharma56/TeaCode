# Deployment and operations

**Nothing in the backend, Docker or nginx parts of this file has been executed.** (The frontend lint, tests, build and browser checks have.) The sandbox used to build this project has no Docker daemon and blocked Maven Central, so images, compose files, nginx config and the CI workflow are written but untested. Treat the first real run as the test, and fix what it finds.

## Topology
Browser -> TLS-terminating proxy/load balancer -> `frontend` container (nginx, port 8080) -> `/api/` proxied to `backend` (Spring Boot, port 8080) -> MySQL 8.4. JDoodle and SMTP are external services reached only from the backend.

## Required configuration
See `.env.example`. The backend refuses to start in any profile if `DB_URL`, `DB_USERNAME`, `DB_PASSWORD`, `JWT_SECRET` or `APP_PUBLIC_URL` is missing. Use the `prod` profile (`SPRING_PROFILES_ACTIVE=prod`). Never reuse development secrets. Create a dedicated least-privilege MySQL user (`SELECT, INSERT, UPDATE, DELETE` plus DDL rights only for the Flyway run, ideally a separate migration user).

## Run
Production needs an `https://` `APP_PUBLIC_URL`; the `prod` profile refuses to start otherwise. For local HTTP testing:
```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml --profile full up --build   # dev profile, never for production
```
Production:
```bash
cp .env.example .env              # fill in real values
docker compose up -d mysql
docker compose --profile full up -d --build
```
Put a reverse proxy or load balancer with a valid certificate in front of port 8081 and redirect HTTP to HTTPS. `Secure` cookies and HSTS require HTTPS.

## Public URL, proxy and HTTP 403 on POST (login, signup, Terminal)
The browser and the API are one origin behind nginx. Spring refuses a POST as cross-origin (HTTP 403, `Invalid CORS request`) when the request's `Origin` header is neither the origin Spring reconstructs from the forwarded headers nor exactly `APP_PUBLIC_URL`. So:
- `APP_PUBLIC_URL` must be the exact `https://` origin users type in the browser (scheme, host, and port if non-standard). A placeholder such as `https://teacode.example.invalid` is logged as an ERROR at start-up and makes every POST from a real address fail.
- nginx forwards `Host`/`X-Forwarded-Host` with the port (`$http_host`), so a direct `http://localhost:8081` visit is recognised as same-origin.
- Every 403 is logged by `ForbiddenRequestLogger` with the method, path, `Origin`, the origin the server sees, the configured origin, whether the CSRF cookie/header were present, and the likely cause (never cookie, header or token values). Search the backend log for `403 POST`.
- Local HTTP testing must use the dev override (`docker-compose.dev.yml`); `prod` requires HTTPS and Secure cookies.

## Problem packages
Mount a folder at `PROBLEM_PACKAGES_DIR` (compose: `./problem-packages`). New ZIPs are imported automatically; see `docs/catalog-and-imports.md`. Check the `problem_imports` table for results. There is no external problem sync: only TeaCode-owned problems (`source` `LOCAL` or `PACKAGE`) are ever listed or opened.

## Proxy trust
nginx believes `X-Forwarded-For` only from private address ranges (`set_real_ip_from` in `TeaCode-fontend/nginx.conf`). Edit those ranges to match your load balancer. If nginx is exposed directly to the internet, remove them so the socket address is used. Rate limits and audit hashes key on this address.

## Health and monitoring
- `GET /actuator/health/liveness` and `/readiness` (container healthcheck uses readiness); not routed publicly by nginx.
- `/actuator/prometheus` is exposed by the backend but requires authentication; scrape it from inside the network once an operations credential/network rule is set up.
- Alert on: backend readiness failing, 5xx rate, JDoodle error rate and quota, MySQL connectivity and disk, backup job failures.

## Backups and restore
Daily logical backup (adjust retention to your policy):
```bash
docker compose exec -T mysql sh -c 'mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" --single-transaction --routines --triggers "$MYSQL_DATABASE"' | gzip > backups/teacode-$(date -u +%F).sql.gz
```
Restore into a **scratch** database first:
```bash
gunzip -c backups/teacode-YYYY-MM-DD.sql.gz | docker compose exec -T mysql sh -c 'mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"_restore_test'
```
Test a restore on a schedule and record the result. Encrypt backups at rest and keep copies off the host. Backups contain user data, so their retention must match the Privacy Policy.

## Runbook
- **Backend not ready:** check logs for a missing setting or a Flyway error; the app fails safe rather than starting with defaults.
- **Execution errors for all users:** check JDoodle credentials, quota and reachability (the job error code says which: `EXECUTION_CREDENTIALS_REJECTED`, `EXECUTION_QUOTA_EXCEEDED`, `EXECUTION_SERVICE_UNAVAILABLE`); nothing is judged while it fails.
- **Suspected account abuse:** suspend via `users.account_status`, revoke `refresh_sessions` rows, review `audit_events`.
- **Schema changes:** add a new `V<n>__*.sql` Flyway migration; never edit an applied one.
- **Policy change:** bump `POLICY_VERSION` in `frontend/src/config/legal.js` and update the Privacy/Cookie pages first.

## Incident response (outline)
Contain (disable affected feature or revoke sessions) -> assess scope using audit logs -> rotate affected secrets -> notify users/regulators as the law requires (confirm obligations with counsel) -> write a post-incident review.
