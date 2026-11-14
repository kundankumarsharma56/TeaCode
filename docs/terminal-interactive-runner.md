# Interactive Terminal execution

The standalone Terminal has two execution paths:

- **Interactive languages** use `POST /api/v1/terminal/sessions` to allocate a short-lived, one-use session. The browser authenticates the WebSocket with the opaque token in its first frame, then sends source and stdin through the same connection. Output is streamed back as stdout/stderr frames. Closing the connection, pressing Stop, hitting the 120-second timeout, or exceeding the output limit tears down the disposable execution container.
- **SQL** keeps the existing JDoodle one-shot path because it is a database playground rather than a persistent stdin/stdout process.

The existing `/api/v1/submissions/run`, `/api/v1/submissions/submit`, and judging workflow are unchanged.

## Local setup

Add a random internal service token to `.env`. On Windows PowerShell, generate one with:

```powershell
$b = New-Object byte[] 48
$r = [Security.Cryptography.RandomNumberGenerator]::Create()
$r.GetBytes($b)
[Convert]::ToBase64String($b)
$r.Dispose()
```

Set the printed value as `TERMINAL_RUNNER_INTERNAL_TOKEN` in `.env`. Keep it private. Start the full stack with `docker compose --profile full up -d --build`.

The runner control plane connects to a separate rootless Docker-in-Docker daemon. Runtime containers are created with no network, a read-only root filesystem, a 256 MiB memory limit, a one-CPU quota, a 128-process limit, no Linux capabilities, `no-new-privileges`, and a 120-second wall-clock timeout. Images are pulled on first use, so the first run for a language can take longer. The runner supports Python, Java, C, C++, JavaScript, TypeScript (Node's type stripping), C#, PHP, Ruby, Go, R, Kotlin, Rust, Swift, and Dart. SQL remains one-shot.

## Deployment security note

The `terminal-docker` service is marked `privileged` because the rootless Docker daemon needs a controlled bootstrap environment on common Docker Desktop setups. Although submitted code runs in unnetworked, resource-limited containers managed by the rootless daemon, all containers still share the host kernel and the privileged daemon container is a high-value boundary. **Do not expose this Compose configuration as an internet-facing production execution service without moving the runner daemon to a dedicated hardened host and adding a stronger isolation runtime (for example, gVisor or Kata Containers), per-user quotas, monitoring, and cleanup/recovery controls.** Never publish port 2375. The browser never receives the internal runner token.

## Runtime notes

- Program prompts are ordinary stdout bytes; input is written to the live process stdin, and the UI echoes the entered line into its terminal transcript.
- Stdout and stderr are streamed in Docker's multiplexed event order and stderr is styled separately.
- The runner reports `Waiting for input` when its in-container monitor observes the runtime process blocked in a `read(0, ...)` syscall. This covers common read-based stdin calls on x86_64, aarch64, and 32-bit ARM. A runtime that waits through `poll`/`epoll` may remain labeled `Running`; the input line remains available either way.
- A dropped WebSocket closes the session and kills its container. A fresh Run always gets a new one-use session.
- The first language run pulls the language image; if an upstream image tag is unavailable, the runner reports a startup failure instead of fabricating output.

## Terminal behaviour after the production-readiness pass

- **Separate from problems.** The Terminal has no problem ID, no verdicts and never touches submissions. It is a plain online compiler: pick a language, write a complete program, run it, type into stdin while it runs, and see stdout, stderr, compiler errors, runtime errors and the exit status.
- **Language list.** `GET /api/v1/terminal/languages` (anonymous) returns exactly the languages the runner can execute, plus SQL only when JDoodle credentials are configured. The page no longer advertises languages that cannot run, and the silent one-shot fallback to JDoodle has been removed: when the runner is not configured, `POST /api/v1/terminal/sessions` answers `503 TERMINAL_RUNNER_NOT_CONFIGURED` and the page shows that message. `sql` is refused by the interactive endpoint (400).
- **Protocol** (`WebSocket /ws/`): `auth`, `start`, `input`, `eof`, `stop`. Ctrl+D in the page sends `eof`, which closes stdin.
- **End states:** `finished` (exit code shown), `error` with `phase` = `compile` or `run`, `timed_out`, `stopped`, `output_limit`, `memory_limit`, `busy`. Output is flushed before the exit message, so no trailing output is lost.
- **Runner implementation** lives in `terminal-runner/runner.js` (protocol and Docker orchestration, injectable Docker client) and `server.js` (entry point). `npm test` in `terminal-runner/` runs 11 protocol tests against a scripted fake Docker daemon. These prove the protocol logic only. They do not prove real container isolation, which must be checked on a host with Docker (see `deployment.md`).
- **Unverified here:** the runner image tags for each language, and real sandbox limits (no network, memory, pids, read-only root). They need a Docker host.

### First Run in a language (image download)

Each language runs in its own image inside the isolated Docker daemon. An image that is not there yet is downloaded on first use, which can take minutes for large images. The runner therefore:

- counts the download separately (`pullTimeoutMs`, 5 minutes) from the program's run time (`executionTimeoutMs`, 2 minutes), so a first Run no longer times out while downloading;
- sends a `preparing` status every 10 seconds during the download so the browser connection and nginx's 130 s idle timeout stay alive;
- reports a clear message when a download fails or stalls ("The runtime for this language could not be downloaded...");
- downloads the images listed in `TERMINAL_PREPULL` (default `python,javascript,java,c,cpp`) in the background at start-up. Use `all` to prepare every language, or `none`.
