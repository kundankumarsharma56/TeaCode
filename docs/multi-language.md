# Multi-language support: status against the spec

Source: `MULTI-LANGUAGE SUPPORT - TEACODE`. Written 2026-10-27. **Nothing in the backend has been compiled or run** (Maven Central is unreachable
from the build environment); frontend lint, 130 Vitest tests and `vite build` pass.

## Design decision: JDoodle instead of a self-hosted sandbox
Spec section 6 describes isolated execution with CPU/memory/process limits. This project already runs every submission on the JDoodle Compiler
API (called only from the backend, never in the web process), with bounded concurrency, a per-user rate limit and active-job cap, job deadlines
and output caps. Replacing it with our own container sandbox is a separate infrastructure project and was not attempted. Consequences: per-language
CPU/memory limits are whatever JDoodle enforces for its plan; the registry does not carry per-language limit fields.

## Spec section by section
| Spec | State |
|---|---|
| 1. 15 languages | The 14 existing ones plus **Dart** are judgeable. SQL (MySQL) remains as a playground-only extra, so the API lists 16 and `LanguageRegistry.judgeable()` lists 15. |
| 2. 15 reference solutions x 500 problems, 20+ tests each | **Not done.** There are no authored problems or solutions in this repository. Problems come from Codeforces metadata and authorized packages. |
| 3. Language selector, editor mode, templates, drafts | Already present (searchable selector, per-language drafts kept in memory while switching, starter code, error display). **Fixed:** Monaco only had 4 grammars bundled, so 11 languages were unhighlighted; all supported grammars are now imported. Drafts are not persisted across page reloads. |
| 4. Starter templates per problem | Stored per problem and language in `problem_starter_code` (existing). Nothing generates them; terminal templates exist for all 16 keys. |
| 5. Registry | `LanguageRegistry` now also has file extension and toolchain (returned by `GET /execution/languages`). Enable/disable without touching problems: `JDOODLE_DISABLED_LANGUAGES`. Per-language limits, compile timeout and availability status fields were **not** added (see decision above). |
| 6. Secure execution | See decision above. |
| 7. Evaluation pipeline and statuses | Existing. Hidden tests/expected output are never put in job results. |
| 8, 9. Verification, reference-solution storage | **Added the storage and rules only:** Flyway `V4` table `reference_solutions` (separate from problems, unique per problem+language, status UNVERIFIED/VERIFIED/FAILED, a database CHECK that VERIFIED needs a timestamp and report), entity `ReferenceSolution` (changing source resets verification), repository, and `VerificationCoverage` (a problem is fully verified only if every required language is VERIFIED; empty/missing/failed never count). **There is no runner** that executes reference solutions against tests and records results, and no importer for them. |
| 10. Acceptance | Items 1, 3, 4 (infrastructure), 5, 7 (existing), 12 are met in code; 2 and 6 depend on JDoodle; 9 and 10 are not met. |

## Open item: Dart on JDoodle
The identifier `dart` and **version index `0` are unchecked**: the JDoodle language reference was not reachable. Index 0 is the first entry in
JDoodle's list, which may be an old Dart. Open https://www.jdoodle.com/docs/api/languages, set the right index and version text in
`LanguageRegistry`, and run one Dart program before relying on it; otherwise set `JDOODLE_DISABLED_LANGUAGES=dart`. Dart is registered as not
"compiled", so no compile-only call is made and compile errors appear as program output.

## Verified vs not
- Run: frontend lint, `vitest` (130 pass, 2 new), `vite build`; `VerificationCoverage` rules executed standalone with `java -ea`.
- Written, not run: `LanguageRegistryTest` (updated), `ExecutionApiIT` (expects 16 languages and Dart extension), `MigrationIT` (expects the new table), `VerificationCoverageTest`, Flyway `V4`, all other Java.
