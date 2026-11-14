# Problem packages (automatic import)

Place authorized problem-package ZIPs in this folder. The backend scans it on startup and every 5 minutes, validates each
archive, imports new ones and records the result in the `problem_imports` table. Nothing else is needed: there is no admin
screen and no upload endpoint.

Placing a file here is your statement that you are authorized to use it (check its license). Format and rules:
see `docs/catalog-and-imports.md`.
