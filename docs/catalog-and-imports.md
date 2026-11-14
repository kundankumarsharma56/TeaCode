# Code execution (JDoodle), catalog sync, package import, timers, progress

Everything here is **written but was never compiled or run against MySQL, JDoodle or Codeforces** in the environment where this upgrade was made (Maven Central and Docker were unavailable). The frontend was built and tested. Run the backend tests yourself before relying on any of it.

## 1. JDoodle Compiler API
Code is executed by `POST https://api.jdoodle.com/v1/execute`, called **only from the backend** (`execution/JdoodleClient`). `JDOODLE_CLIENT_ID` and `JDOODLE_CLIENT_SECRET` come from the environment and are never sent to the browser, put in API responses, logged, or included in the ZIP. Source code, stdin and upstream bodies are not logged.

- Not configured: `GET /execution/languages` returns `[]`, and run/submit fail with `EXECUTION_NOT_CONFIGURED`. Nothing is simulated.
- **Every run costs one JDoodle credit.** Calls are never retried automatically (a timeout does not tell us whether the run was billed). A submission stops at the first failing test to save credits. Concurrency is capped (`teacode.jdoodle.max-concurrent-calls`, default 2), and a submission may contain at most `max-tests-per-submission` tests (default 20).
- Failure mapping: 401 -> `EXECUTION_CREDENTIALS_REJECTED`; 429 -> `EXECUTION_QUOTA_EXCEEDED`; network/5xx/unreadable -> `EXECUTION_SERVICE_UNAVAILABLE`; busy -> `EXECUTION_BUSY`. These never become Wrong Answer or Accepted.
- Free plans have a daily credit quota set by JDoodle; check your plan. When it is used up, users see an explicit quota message.

### Languages and version indexes
`versionIndex` is a position in JDoodle's list for that language, so it changes when JDoodle updates its list. Values below were taken from JDoodle's published language table during this upgrade; **re-check them against https://docs.jdoodle.com/compiler-api/compiler-api when you deploy**, and edit `execution/LanguageRegistry.java` if they drifted. A language that fails on your plan can be switched off with `JDOODLE_DISABLED_LANGUAGES`.

| Key | JDoodle `language` | `versionIndex` | Version | Judged problems |
|---|---|---|---|---|
| java | java | 5 | JDK 21.0.0 | yes |
| python | python3 | 6 | 3.14.3 | yes |
| c | c | 6 | GCC 13.2.1 | yes |
| cpp | cpp17 | 2 | GCC 13.2.1 | yes |
| javascript | nodejs | 7 | 25.8.1 | yes |
| typescript | typescript | 1 | 5.9.3 | yes |
| csharp | csharp | 6 | .NET 10.0 | yes |
| php | php | 6 | 8.5.4 | yes |
| ruby | ruby | 6 | 3.4.8 | yes |
| go | go | 6 | 1.26.1 | yes |
| r | r | 6 | 4.5.3 | yes |
| kotlin | kotlin | 5 | 2.3.10 | yes |
| rust | rust | 6 | 1.94.0 | yes |
| swift | swift | 6 | 6.2.4 | yes |
| sql | mysql | 0 | MySQL | no (free-form compiler only) |

### What JDoodle does and does not tell us (affects verdicts)
JDoodle returns HTTP 200 with the program's combined output in `output` for compile errors, runtime failures and timeouts alike. It documents no exit code, no separate stderr and no memory unit. Consequences, implemented honestly:
- Compile errors are detected for compiled languages with one extra `compileOnly` call (`compilationStatus`); that call also costs a credit.
- Time Limit Exceeded is reported when JDoodle's `cpuTime` exceeds the problem limit, or when the output contains JDoodle's timeout message. Runtime Error is a **heuristic** (known crash phrases in the output, only checked when the output did not match). A program that prints such a phrase on purpose can be mislabelled.
- In the free-form compiler the status is `FINISHED` ("returned output"), not "Accepted".
- Memory numbers are shown as reported, unit undocumented.

## 2. Verdicts
`ACCEPTED`, `WRONG_ANSWER`, `COMPILATION_ERROR`, `RUNTIME_ERROR`, `TIME_LIMIT_EXCEEDED`, `INSUFFICIENT_VERIFICATION`, and (job level) `SAMPLES_PASSED` for Run. Service problems fail the job with an error code and produce **no verdict and no saved submission**.
- **Run** judges sample tests only, saves nothing, and ends in `SAMPLES_PASSED` at best.
- **Submit** judges samples + private tests. Accepted requires at least one private test. If only samples exist the result is `INSUFFICIENT_VERIFICATION` ("hidden tests unavailable"), which counts neither as solved nor against acceptance rate.
- Function-based problems (`execution_model = FUNCTION`) are refused (`EXECUTION_MODEL_UNSUPPORTED`): no trusted harness exists. Only stdin/stdout problems are judged.
- Private test data never leaves the server; hidden cases return verdict and resources only.

## 3. External catalogs (removed)
TeaCode does not import problems from Codeforces or any other external API. The sync service, its client and the `teacode.codeforces.*` / `CODEFORCES_SYNC_ENABLED` settings are deleted. Migration `V8__remove_codeforces_completely.sql` deletes every problem with `source = 'CODEFORCES'` together with its tags, tests, starter code, attempts, timers, submissions and progress (all cascade), and drops the sync bookkeeping tables. As a second line of defence the listing, detail, starter-code, attempt, timer and run paths only ever see rows whose `source` is `LOCAL` or `PACKAGE`.

## 4. Authorized problem packages (automatic, admin-free)
There is no admin role, admin screen or upload endpoint. Put package ZIPs in `PROBLEM_PACKAGES_DIR` (Compose mounts `./problem-packages` read-only). `catalog/PackageFolderImporter` scans on startup and every 5 minutes. **Placing a file there is the operator's statement that they are authorized to use it.**

Supported layout (ICPC/Kattis problem-package style): `problem.yaml` (name, optional `uuid`, `limits.time_limit` seconds, `limits.memory` MiB, `source`/`author`/`license`/`rights_owner` for attribution), `problem_statement/problem.en.md` (or `.tex`, stored as plain text), `data/sample/*.in|*.ans`, `data/secret/**/*.in|*.ans`. Custom validators, interactive and multi-pass problems are rejected. Comparison is whitespace-token based (or float tolerance if `validator_flags` has `float_tolerance`).

Safety: entry names with `..`, absolute paths, backslashes or NULs are rejected; archive size, per-file size, expanded size and entry count are capped (`teacode.imports.*`, read with hard limits so a zip bomb cannot expand); YAML uses a safe loader; files must be valid UTF-8 text; every `.in` needs a `.ans`; duplicates are rejected by SHA-256 and by `uuid`. Each outcome is a row in `problem_imports` (IMPORTED/FAILED, no test data in messages); a bad file is recorded once and not retried. Imported problems are `UNRATED`, source `PACKAGE`, published unless `PROBLEM_PACKAGES_AUTO_PUBLISH=false` (then they stay DRAFT and need an SQL update to publish). A package with only sample files imports but can never reach Accepted.
Limitation: a package must have `problem.yaml` at the ZIP root (no wrapping folder).

## 5. Per-problem timer
Server-owned (`problem_timers`, one row per user and problem). `GET/POST /timers/{slug}[/start|/pause|/reset]`. Start and Resume are the same idempotent call; Pause and Reset are idempotent. Each transition is a single SQL statement using the database clock, so two tabs cannot double count; the UI re-reads the server on focus and every 30 s.
**What is counted:** wall-clock time between Start/Resume and Pause. Not focus time, not typing time. One running stretch counts at most 4 hours. Reset clears it.

## 6. Progress
Computed from the `submissions` table, never from a stored counter (the old `user_problem_progress` table is no longer written or read; it remains in the schema).
- Attempts = saved submissions (Submit only; Run is not saved). Solved = distinct problems with an `ACCEPTED` submission. Acceptance rate = accepted / judged submissions, where `SERVICE_UNAVAILABLE` and `INSUFFICIENT_VERIFICATION` are not judged. Rate is `null`, not 0, when nothing was judged.
- Endpoints: `/dashboard/summary`, `/progress` (per difficulty), `/languages`, `/topics`, `/time` (top 10 by timer), `/activity` (30 days). All per user.
- The old `attempts` start/finish endpoints still exist in the backend for compatibility but the UI no longer uses them.

## 7. Known limitations
- Backend never compiled or run here; MySQL migration `V3` never executed; Docker never built.
- JDoodle `versionIndex` values can drift.
- Runtime Error / TLE detection from output text is heuristic.
- No retry of billable runs: a transient JDoodle failure fails the job and the user presses Run again.
- Packages must be zipped with `problem.yaml` at the root; custom validators/interactive problems unsupported.
- Free JDoodle plan quotas are small; heavy use will exhaust them.

## Curated catalog (migration V9) and validation pipeline

`catalog/` contains the source of the published problem set and the tool that validates it:

- `p_*.py` define each problem: statement, input/output format, constraints, at least two explained examples, hidden-test generators, a per-problem input validator, and **two independent reference solutions** (Python and C++, written differently on purpose).
- `python3 catalog/build.py --check` executes both references on every public and hidden input, requires identical output, checks that each example's stated output matches, validates every input against the problem's constraints, and detects duplicates (title, statement similarity, identical hidden suites or solutions). It exits non-zero on any failure. CI runs it. `python3 catalog/build.py` additionally writes `V9__curated_problem_catalog.sql` and `catalog/REPORT.md`.
- V9 is an idempotent upsert keyed by the unique problem `slug`: it can be applied again without creating duplicates. Examples are stored as `sample_case = 1` tests, so what is shown publicly is exactly what **Run** executes. Hidden tests are never returned by the public API. **Submit** runs all tests server-side.
- The 510 generated copies from V6 are **archived** (visibility `ARCHIVED`), not deleted, so existing submissions and progress keep their foreign keys. They contain 29 distinct tasks, which were rewritten in place; 42 new problems were added.
- Hidden tests larger than 350,000 characters (input plus output) are executed during validation but are not stored in the migration, to keep it a reasonable size.
- Reference solutions are stored for Python and C++ only. Starter code is provided for 15 languages. Only 10 of those were compiled or syntax-checked in the validation environment; see `catalog/REPORT.md`.
