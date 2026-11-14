# TeaCode Architecture

## 1. Overview

TeaCode is a coding practice platform: React SPA + Spring Boot REST API + MySQL 8.4 + JDoodle Compiler API for real code execution.

```
Browser (React, MUI, Monaco)
   │  same-origin HTTPS, HttpOnly cookies + CSRF header
   ▼
Reverse proxy (nginx)  ──  /        → frontend static files
                       └─  /api/v1  → Spring Boot backend
                                         │
                          ┌──────────────┼───────────────────┐
                          ▼              ▼                   ▼
                       MySQL 8.4     JDoodle API        SMTP server
                     (Flyway-managed) (server-side creds)  (verification/reset)
```

## 2. Key decisions

| Area | Decision | Reason |
|---|---|---|
| Deployment topology | Single origin behind nginx | Avoids CORS + SameSite complications; cookies stay first-party |
| Auth | Opaque, server-tracked sessions: short-lived access JWT (15 min) in HttpOnly cookie + rotating refresh token (hashed in `refresh_sessions`) | Revocable refresh; no tokens in web storage |
| CSRF | Spring `CookieCsrfTokenRepository` (double-submit); Axios reads `XSRF-TOKEN`, sends `X-XSRF-TOKEN` | Required for cookie-authenticated mutations |
| Password hashing | Argon2id via Spring Security `Argon2PasswordEncoder` | Modern, memory-hard |
| Execution | JDoodle via backend adapter (`execution/JdoodleClient`); async jobs with bounded executor; client polls `/submissions/jobs/{id}` | Never blocks request threads; never runs user code in JVM |
| Schema | Flyway only; `spring.jpa.hibernate.ddl-auto=validate` | Authoritative, versioned schema |
| Rate limiting | Bucket4j (in-memory first; swap to shared store when scaling out) | Login, register, reset, run/submit limits |
| Output comparison | Per-problem `comparison_mode` (EXACT, TRIM_LINES, TOKEN, FLOAT_TOLERANCE) + `float_tolerance` | Trimmed-string compare is not universally correct |

## 3. Backend package layout (`com.teacode`)

`config`, `controller`, `dto`, `entity`, `enums`, `exception`, `mapper`, `repository`, `security`, `service`, `execution`, `catalog`, `validation`, `audit`.

Rules: thin controllers; business logic in services; DTOs for every API contract (entities never serialized); constructor injection; explicit lazy fetching and fetch joins/entity graphs to avoid N+1.

## 4. Phase plan

1. **Foundation** (this phase): repo, config, Docker Compose, MySQL, Flyway schema, skeletons.
2. Frontend shell: theme, brand, navbar, landing, routing, animations.
3. Public problem APIs + problem list UI.
4. Authentication, cookies, CSRF, email flows.
5. Monaco + JDoodle execution.
6. Submissions history, dashboard, progress, profile.
7. Legal pages, policy acceptance, account deletion.
8. Integration/E2E tests, accessibility, CI/CD, deployment docs.

## 5. Dependency checklist

Backend (Maven): spring-boot-starter-web, -security, -data-jpa, -validation, -actuator, -mail, flyway-core + flyway-mysql, mysql-connector-j, jjwt (api/impl/jackson), bucket4j-core, springdoc-openapi-starter-webmvc-ui, micrometer-registry-prometheus, bcprov (required by Argon2PasswordEncoder), logstash-logback-encoder; test: spring-boot-starter-test, spring-security-test, testcontainers (mysql, junit-jupiter), mockwebserver (okhttp) for JDoodle and Codeforces adapter tests.

Frontend (npm): react, react-dom, react-router-dom, @mui/material, @mui/icons-material, @emotion/react, @emotion/styled, @monaco-editor/react, axios, framer-motion, react-hook-form, zod, @hookform/resolvers; dev: vite, @vitejs/plugin-react, eslint (+react plugins), vitest, @testing-library/react, jest-dom, user-event, jest-axe, playwright.

## 6. Configuration checklist (owner must supply)

| Variable | Purpose | Notes |
|---|---|---|
| `MYSQL_ROOT_PASSWORD`, `MYSQL_PASSWORD` | Database credentials | Dedicated least-privilege app user |
| `JWT_SECRET` | Access token signing (≥ 256-bit) | App fails to start in `prod` if missing |
| `JDOODLE_CLIENT_ID`, `JDOODLE_CLIENT_SECRET` | JDoodle credentials (backend only) | Language identifiers and version indexes are a static table; see `docs/catalog-and-imports.md` |
| `SMTP_HOST/PORT/USERNAME/PASSWORD`, `MAIL_FROM` | Email delivery | Required for verification/reset |
| `APP_PUBLIC_URL` | Links in emails, cookie/CORS origin | Exact origin, no wildcard |
| Legal values (`LEGAL_ENTITY_NAME`, `LEGAL_ADDRESS`, `PRIVACY_CONTACT_EMAIL`) | Policy pages | **Not fabricated**; owner must provide; legal counsel review required |

## 7. Not yet verified (honest status)

Nothing involving JDoodle, SMTP, or end-to-end flows has been verified against a live service. See README for the status table.
