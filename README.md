# TeaCode

TeaCode is a coding-practice platform. You pick a problem, write a solution in an in-browser editor, run it against sample input, and submit it for judging. Your submissions, progress and per-problem timers are saved to your account.

It is a full-stack project built end to end by one developer: a React frontend, a Spring Boot API, a MySQL database managed with Flyway migrations, and a separate Node service that runs the interactive terminal.

> **Status:** TeaCode runs locally with Docker. There is **no public live site yet**.

## What it does

- **Problem library.** 71 original, TeaCode-owned practice problems with full statements, topic tags and difficulty levels. They are written for this project and are not copied from other sites. Extra problems can be imported from authorized problem packages (ZIP files in a folder, with archive safety checks and an import history).
- **Workspace.** A Monaco editor (the editor core of VS Code) with a searchable language selector, per-language starter code, saved drafts, custom stdin, a console and run metrics.
- **Run and submit.** Running a problem checks your code against the samples. Submitting judges it against private tests. The verdicts are deliberately conservative: a run that only passed samples is never shown as Accepted, "Insufficient verification" is shown when no private tests exist, and a service failure is never reported as Wrong Answer.
- **Languages.** 15 judgeable languages: Java, Python 3, C, C++, JavaScript, TypeScript, C#, PHP, Ruby, Go, R, Kotlin, Rust, Swift and Dart. There is also an SQL/MySQL playground that is never used for judging.
- **Terminal.** A standalone `/terminal` page with live stdin/stdout, backed by an isolated runner. It needs no account and stores nothing on the server.
- **Accounts.** Password sign-in, registration with required Terms and Privacy acceptance, email verification, and password reset. Google and GitHub sign-in are optional and are enabled by configuration.
- **Progress.** A dashboard and submission history computed from real submissions: attempts, solved problems, acceptance rate, and breakdowns by difficulty, topic and language, plus time spent per problem.
- **Per-problem timer.** A server-side timer (start, pause, resume, reset) that stays correct across browser tabs.
- **Profile and settings.** Avatar upload, account settings and account deletion.
- **Design.** Dark and light themes, responsive layouts, and legal and contact pages (Terms, Privacy, Cookies, Acceptable use, Privacy requests).

## Tech stack

| Part | Technology |
|---|---|
| Frontend | React 18, Vite, MUI 6, Framer Motion, Monaco Editor, Vitest |
| Backend | Spring Boot 3.4, Java 21, Flyway, JWT authentication |
| Database | MySQL 8.4 |
| Code execution | JDoodle Compiler API (called only from the backend) |
| Interactive terminal | Node.js runner (`terminal-runner/`) with a Docker-in-Docker sandbox |
| Catalog tooling | Python scripts in `catalog/` |
| Packaging | Docker Compose, nginx (frontend), Caddy (production TLS) |

## Project layout

    TeaCode-fontend/   React app (the folder name keeps its original spelling)
    backend/           Spring Boot API, package com.teacode, Flyway migrations
    terminal-runner/   Node service for the interactive terminal
    catalog/           problem catalog validation
    docs/              architecture, API, security, deployment and more
    scripts/           helper scripts (language checks, sandbox images, tests)

## Run it locally

You need Docker with Compose. The backend compiles inside Docker, so Maven and Java are not required on your machine.

1. Copy the example settings and fill in the placeholders. **Never commit `.env`.**

        cp .env.example .env

   At minimum set `JWT_SECRET` (32 or more characters), the `MYSQL_*` passwords and `TERMINAL_RUNNER_INTERNAL_TOKEN`. To run code you also need a JDoodle account: set `JDOODLE_CLIENT_ID` and `JDOODLE_CLIENT_SECRET`. Without them the language list is empty and nothing runs. For local use set `SPRING_PROFILES_ACTIVE=dev` and `APP_PUBLIC_URL=http://localhost:8081`.

2. Start the full stack:

        docker compose -p teacode -f docker-compose.yml -f docker-compose.dev.yml --profile full up -d --build

3. Open http://localhost:8081.

On Windows, `start-local.ps1` and `smoke-test.ps1` wrap these steps. How the terminal token is generated is described in [the terminal runner guide](docs/terminal-interactive-runner.md).

## Configuration

All settings are in `.env.example`. The main groups:

| Variable | Purpose |
|---|---|
| `MYSQL_*`, `JWT_SECRET`, `APP_PUBLIC_URL` | required |
| `JDOODLE_CLIENT_ID`, `JDOODLE_CLIENT_SECRET` | code execution |
| `JDOODLE_DISABLED_LANGUAGES` | optional comma list of language keys to hide |
| `TERMINAL_RUNNER_INTERNAL_TOKEN` | secret shared only between the backend and the terminal runner |
| `PROBLEM_PACKAGES_DIR`, `PROBLEM_PACKAGES_AUTO_PUBLISH` | folder scanned for problem package ZIPs |
| `GOOGLE_*`, `GITHUB_*` | optional sign-in providers |
| `SMTP_*`, `MAIL_FROM` | verification and password-reset email (not sent while `SMTP_HOST` is empty) |
| `VITE_*` | public legal and contact details shown on the policy pages |

## Tests

    cd TeaCode-fontend
    npm run lint
    npm test
    npm run build

The frontend has 18 test files with 160 tests. On a slow machine a full parallel run can fail one or two timing-sensitive tests that pass when run alone. The terminal runner has its own tests (`cd terminal-runner && npm test`). The backend has unit and integration tests (`mvn -B verify` in `backend/`, integration tests need Docker); they have not been re-run since the project was last renamed.

## Limits

- **Judging is paid.** Running and judging code uses the JDoodle API, which is billed per use. Set a spending limit on your own JDoodle account.
- **The terminal needs a privileged sandbox.** The interactive terminal runs user code inside a privileged Docker-in-Docker service. It is meant for local development. Never run it on a host that also holds the database or secrets, and review [the security notes](docs/security.md) before exposing it to the internet. The prepared production setup leaves the terminal disabled.
- **No public deployment.** The repository includes a production Compose file, a Caddyfile and an nginx config, but the site has not been deployed.
- **Legal pages are drafts.** Terms, Privacy and the other policy pages need review by a qualified professional before a public launch (see [the legal checklist](docs/legal-review-checklist.md)).

## Documentation

[Architecture](docs/architecture.md) · [API](docs/api.md) · [Security](docs/security.md) · [Deployment](docs/deployment.md) · [Multi-language support](docs/multi-language.md) · [Catalog, imports, JDoodle, timers, progress](docs/catalog-and-imports.md) · [Interactive terminal runner](docs/terminal-interactive-runner.md) · [Firebase setup](docs/firebase-setup.md) · [Legal checklist](docs/legal-review-checklist.md) · [Third-party notices](docs/third-party-notices.md)

## Author

Built by **Kundan Kumar Sharma**.

[LinkedIn](https://linkedin.com/in/kundankrsharma65/) · [GitHub](https://github.com/kundankumarsharma56)