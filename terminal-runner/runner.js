import http from 'node:http';
import crypto from 'node:crypto';
import { WebSocketServer, WebSocket } from 'ws';

/**
 * Interactive terminal runner (control plane).
 *
 * Untrusted code never runs in this process. Each run gets a disposable container created through the Docker
 * API (a separate rootless daemon in the Compose file) with no network, a read-only root filesystem, memory,
 * CPU and PID limits, no capabilities and no-new-privileges.
 *
 * WebSocket protocol (JSON text frames)
 *   client -> {type:'auth', token} | {type:'start', language, sourceCode} | {type:'input', data} | {type:'eof'} | {type:'stop'}
 *   server -> {type:'authenticated'} | {type:'status', state:'preparing'|'compiling'|'running'|'waiting'}
 *          | {type:'output', stream:'stdout'|'stderr', data} | {type:'error', message}
 *          | {type:'exit', state, exitCode?, phase?, message?}
 *   exit states: finished (exit 0), error (non-zero; phase 'compile' or 'run'), timed_out, stopped,
 *                output_limit, memory_limit, busy.
 */

// Marker files written inside the container. They live on the tmpfs and die with the container.
const PID_FILE = '/tmp/.teacode-pid';
const COMPILED_FILE = '/tmp/.teacode-compiled';

/** Public class name for Java so `public class Foo` compiles as Foo.java, like a normal online compiler. */
function javaClassName(source) {
  // `$` is deliberately not allowed: the name ends up in a shell command line.
  const m = /public\s+(?:final\s+|abstract\s+)*class\s+([A-Za-z_][A-Za-z0-9_]*)/.exec(source);
  return m ? m[1] : 'Main';
}

/**
 * Each runtime: image, files to write into /tmp, optional compile command and run command.
 * Commands are run by `sh -c` (never a login shell: login shells on Alpine reset PATH and hide the toolchain).
 */
export const RUNTIMES = {
  python: { image: 'python:3.13-alpine', files: () => ({ 'main.py': null }), run: () => 'python -u main.py' },
  java: {
    image: 'eclipse-temurin:21-jdk-alpine',
    files: (src) => ({ [`${javaClassName(src)}.java`]: null }),
    compile: (src) => `javac -d /tmp ${javaClassName(src)}.java`,
    run: (src) => `java -cp /tmp ${javaClassName(src)}`
  },
  // stdbuf makes C/C++ stdio unbuffered so a prompt such as printf("Name: ") appears before the program waits for input.
  c: { image: 'gcc:14', files: () => ({ 'main.c': null }), compile: () => 'gcc -O0 main.c -o /tmp/code', run: () => 'stdbuf -o0 -e0 /tmp/code' },
  cpp: { image: 'gcc:14', files: () => ({ 'main.cpp': null }), compile: () => 'g++ -O0 main.cpp -o /tmp/code', run: () => 'stdbuf -o0 -e0 /tmp/code' },
  javascript: { image: 'node:22-alpine', files: () => ({ 'main.js': null }), run: () => 'node main.js' },
  typescript: { image: 'node:22-alpine', files: () => ({ 'main.ts': null }), run: () => 'node --experimental-strip-types main.ts' },
  csharp: {
    image: 'mcr.microsoft.com/dotnet/sdk:10.0',
    files: () => ({
      'Program.cs': null,
      'terminal.csproj': '<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net10.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable></PropertyGroup></Project>'
    }),
    compile: () => 'dotnet build terminal.csproj -nologo -v q -o /tmp/out -p:NuGetAudit=false',
    run: () => 'dotnet /tmp/out/terminal.dll'
  },
  php: { image: 'php:8.4-cli-alpine', files: () => ({ 'main.php': null }), run: () => 'php main.php' },
  ruby: {
    image: 'ruby:3.4-alpine',
    files: () => ({ 'main.rb': null, 'cv_sync.rb': '$stdout.sync = true\n$stderr.sync = true\n' }),
    run: () => 'ruby -r/tmp/cv_sync.rb main.rb'
  },
  go: { image: 'golang:1.25-alpine', files: () => ({ 'main.go': null }), compile: () => 'GO111MODULE=off go build -o /tmp/code main.go', run: () => '/tmp/code' },
  r: { image: 'r-base:4.5.2', files: () => ({ 'main.R': null }), run: () => 'Rscript main.R' },
  // Built from images/kotlin/Dockerfile (pinned JetBrains compiler); it is not on Docker Hub. The JVM compiler needs more than the default memory.
  kotlin: { image: 'teacode/kotlin:2.4.21', memoryMb: 768, files: () => ({ 'Main.kt': null }), compile: () => 'JAVA_OPTS=-Xmx448m kotlinc Main.kt -include-runtime -d /tmp/main.jar', run: () => 'java -jar /tmp/main.jar' },
  rust: { image: 'rust:1.90-alpine', files: () => ({ 'main.rs': null }), compile: () => 'rustc main.rs -o /tmp/code', run: () => '/tmp/code' },
  swift: { image: 'swift:6.2-jammy', files: () => ({ 'main.swift': null }), run: () => 'swift main.swift' },
  dart: { image: 'dart:stable', files: () => ({ 'main.dart': null }), run: () => 'dart main.dart' }
};

const DEFAULT_MEMORY_MB = 256;

export const DEFAULT_LIMITS = {
  maxSourceChars: 64_000,
  maxOutputBytes: 200_000,
  maxInputBytes: 64_000,
  executionTimeoutMs: 120_000,
  sessionTtlMs: 3 * 60_000,
  maxActive: 4,
  pollMs: 300,
  streamDrainMs: 1_500,
  authTimeoutMs: 5_000,
  startTimeoutMs: 15_000,
  // First use of a language downloads its image into the isolated daemon. That wait is not program run time, so it has its own limit.
  pullTimeoutMs: 300_000,
  pullKeepAliveMs: 10_000
};

/** Builds the shell script that runs one program: optional compile step, a marker, then exec of the program. */
export function buildScript(runtime, source) {
  const run = runtime.run(source);
  if (!runtime.compile) return `echo $$ > ${PID_FILE}; exec ${run}`;
  // `echo $$` is the PID that later becomes the program (exec keeps the PID), so the monitor watches the right process.
  return `echo $$ > ${PID_FILE}; ${runtime.compile(source)} || exit $?; : > ${COMPILED_FILE}; exec ${run}`;
}

function json(res, status, value) {
  const body = JSON.stringify(value);
  res.writeHead(status, { 'content-type': 'application/json; charset=utf-8', 'content-length': Buffer.byteLength(body), 'cache-control': 'no-store' });
  res.end(body);
}

function safeEqual(a, b) {
  const aa = Buffer.from(String(a || ''));
  const bb = Buffer.from(String(b || ''));
  return aa.length === bb.length && crypto.timingSafeEqual(aa, bb);
}

function send(ws, value) { if (ws.readyState === WebSocket.OPEN) ws.send(JSON.stringify(value)); }

/** Splits Docker's multiplexed stream (8-byte header per frame) into frames. */
export function attachDockerFrames(source, onFrame) {
  let buffer = Buffer.alloc(0);
  source.on('data', (chunk) => {
    buffer = Buffer.concat([buffer, chunk]);
    while (buffer.length >= 8) {
      const streamType = buffer[0];
      const size = buffer.readUInt32BE(4);
      if (buffer.length < 8 + size) break;
      const payload = buffer.subarray(8, 8 + size);
      buffer = buffer.subarray(8 + size);
      onFrame(streamType, payload.toString('utf8'));
    }
  });
}

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

/**
 * Writes one file into the container's /tmp through the stdin of an exec. The archive API (putArchive) is refused by
 * the daemon for a container whose root filesystem is read-only (HTTP 400 "container rootfs is marked read-only"),
 * even for a tmpfs path, and the read-only root is a deliberate isolation setting. File names are fixed constants or a
 * validated Java class name, never raw user text; the check below enforces that.
 */
async function writeFile(container, name, content) {
  if (!/^[A-Za-z0-9_.-]+$/.test(name)) throw new Error('unsafe file name');
  const writer = await container.exec({ Cmd: ['sh', '-c', `cat > /tmp/${name}`], AttachStdin: true, AttachStdout: true, AttachStderr: true, Tty: false, WorkingDir: '/tmp' });
  const stream = await writer.start({ hijack: true, stdin: true, Tty: false });
  stream.on('error', () => { /* the exit code below is authoritative */ });
  stream.on('data', () => { /* drain, so the stream can end */ });
  const closed = new Promise((resolve) => { stream.on('end', resolve); stream.on('close', resolve); });
  stream.end(Buffer.from(content, 'utf8'));
  await Promise.race([closed, sleep(5000)]);
  for (let i = 0; i < 200; i += 1) {
    const info = await writer.inspect();
    if (!info.Running) {
      if (info.ExitCode !== 0) throw new Error(`could not write ${name} (exit ${info.ExitCode})`);
      return;
    }
    await sleep(25);
  }
  throw new Error(`timed out writing ${name}`);
}

/**
 * @param {object} options
 * @param {object} options.docker dockerode-compatible client (injectable so the protocol can be tested without a daemon)
 * @param {string} options.internalToken shared secret the backend sends to create sessions
 */
export function createRunner({ docker, internalToken, limits = {}, logger = console }) {
  const L = { ...DEFAULT_LIMITS, ...limits };
  const sessions = new Map();
  const active = new Map();

  async function ensureImage(name, onProgress, timeoutMs) {
    const image = docker.getImage(name);
    try { await image.inspect(); return false; } catch { /* Pull missing image. */ }
    const pulling = (async () => {
      const stream = await docker.pull(name);
      await new Promise((resolve, reject) => docker.modem.followProgress(stream, (err) => (err ? reject(err) : resolve()), () => onProgress?.()));
    })();
    let timer;
    const limit = new Promise((_, reject) => { timer = setTimeout(() => reject(new Error(`image pull timed out after ${Math.round(timeoutMs / 1000)}s`)), timeoutMs); });
    try { await Promise.race([pulling, limit]); } finally { clearTimeout(timer); pulling.catch(() => {}); }
    return true;
  }

  /** Downloads the runtime images in the background so the first Run in a language does not wait for a pull. */
  async function prepullImages(keys = Object.keys(RUNTIMES)) {
    const images = [...new Set(keys.map((k) => RUNTIMES[k]?.image).filter(Boolean))];
    const results = { pulled: [], failed: [] };
    for (const name of images) {
      try { await ensureImage(name, undefined, L.pullTimeoutMs); results.pulled.push(name); } catch (err) {
        logger.error(`could not prepare image ${name}:`, err?.message || 'unknown error');
        results.failed.push(name);
      }
    }
    return results;
  }

  const server = http.createServer((req, res) => {
    if (req.method === 'GET' && req.url === '/healthz') return json(res, 200, { status: 'ok' });
    if (req.method !== 'POST' || req.url !== '/sessions') return json(res, 404, { error: 'Not found' });
    if (!internalToken || !safeEqual(req.headers['x-internal-token'], internalToken)) return json(res, 403, { error: 'Forbidden' });
    let body = '';
    let tooLarge = false;
    req.on('data', (chunk) => {
      body += chunk;
      if (body.length > 4096) { tooLarge = true; req.destroy(); }
    });
    req.on('end', () => {
      if (tooLarge) return;
      try {
        const data = JSON.parse(body || '{}');
        const language = String(data.language || '');
        if (!Object.hasOwn(RUNTIMES, language)) return json(res, 422, { error: 'This language is not supported by the interactive runner.' });
        // `sessions` holds pending and running sessions, so a burst of unused sessions cannot pile up without bound.
        // The hard concurrency limit is enforced again when a program actually starts.
        if (sessions.size >= L.maxActive * 4 || active.size >= L.maxActive) return json(res, 429, { error: 'Interactive runner is busy. Try again shortly.' });
        const sessionId = crypto.randomBytes(24).toString('base64url');
        const token = crypto.randomBytes(32).toString('base64url');
        const expiresAt = Date.now() + L.sessionTtlMs;
        sessions.set(sessionId, { token, language, expiresAt, used: false });
        json(res, 201, { sessionId, token, expiresAt: new Date(expiresAt).toISOString() });
      } catch { json(res, 400, { error: 'Invalid request.' }); }
    });
  });

  const wss = new WebSocketServer({ noServer: true, maxPayload: 300 * 1024, perMessageDeflate: false });
  server.on('upgrade', (req, socket, head) => {
    const url = new URL(req.url, 'http://runner.internal');
    const match = url.pathname.match(/^\/ws\/([A-Za-z0-9_-]{20,80})$/);
    if (!match) { socket.write('HTTP/1.1 404 Not Found\r\nConnection: close\r\n\r\n'); socket.destroy(); return; }
    wss.handleUpgrade(req, socket, head, (ws) => { ws.sessionId = match[1]; wss.emit('connection', ws, req); });
  });

  wss.on('connection', (ws) => {
    const sessionId = ws.sessionId;
    const session = sessions.get(sessionId);
    if (!session || session.expiresAt < Date.now() || session.used) { ws.close(4401, 'Session expired'); return; }
    let authenticated = false;
    let started = false;
    let container = null;
    let exec = null;
    let stream = null;
    let timeout = null;
    let poll = null;
    let outputBytes = 0;
    let inputBytes = 0;
    let finished = false;
    let streamDone = Promise.resolve();
    let hasCompileStep = false;
    let memoryMb = DEFAULT_MEMORY_MB;

    const cleanup = async ({ keepSession = false } = {}) => {
      if (timeout) clearTimeout(timeout);
      if (poll) clearInterval(poll);
      if (!keepSession) sessions.delete(sessionId);
      active.delete(sessionId);
      const c = container;
      container = null;
      if (c) {
        try { await c.kill({ signal: 'KILL' }); } catch { /* Already exited. */ }
        try { await c.remove({ force: true, v: true }); } catch { /* Already removed. */ }
      }
    };
    const finish = async (state, extra = {}) => {
      if (finished) return;
      finished = true;
      send(ws, { type: 'exit', state, ...extra });
      await cleanup();
      if (ws.readyState === WebSocket.OPEN) ws.close(1000, state);
    };
    const appendOutput = (type, text) => {
      if (!text || finished) return;
      outputBytes += Buffer.byteLength(text);
      if (outputBytes > L.maxOutputBytes) {
        void finish('output_limit', { message: `Output limit exceeded (${Math.round(L.maxOutputBytes / 1000)} KB).` });
        return;
      }
      send(ws, { type: 'output', stream: type, data: text });
    };

    /** True when the compile step finished (marker file exists). Only meaningful for runtimes with a compile step. */
    const compiled = async () => {
      try {
        const probe = await container.exec({ Cmd: ['test', '-f', COMPILED_FILE], AttachStdout: false, AttachStderr: false });
        await probe.start({ Detach: true });
        for (let i = 0; i < 20; i += 1) {
          const info = await probe.inspect();
          if (!info.Running) return info.ExitCode === 0;
          await sleep(50);
        }
      } catch { /* Treat as unknown: reported as a run failure. */ }
      return true;
    };

    const reportExit = async (exitCode) => {
      // Let buffered program output reach the browser before the verdict (the poll can see the exit first).
      await Promise.race([streamDone, sleep(L.streamDrainMs)]);
      if (finished) return;
      if (exitCode === 0) return finish('finished', { exitCode });
      let oom = false;
      try { oom = Boolean((await container.inspect())?.State?.OOMKilled); } catch { /* Container already gone. */ }
      if (oom || exitCode === 137) {
        return finish('memory_limit', { exitCode, message: `The program was killed, most likely because it used more than ${memoryMb} MB of memory.` });
      }
      const phase = hasCompileStep && !(await compiled()) ? 'compile' : 'run';
      return finish('error', { exitCode, phase });
    };

    ws.on('message', async (raw) => {
      let msg;
      try { msg = JSON.parse(raw.toString()); } catch { send(ws, { type: 'error', message: 'Invalid terminal message.' }); return; }
      if (!msg || typeof msg !== 'object') return;
      if (!authenticated) {
        if (msg.type !== 'auth' || !safeEqual(msg.token, session.token) || session.expiresAt < Date.now()) { ws.close(4401, 'Unauthorized'); return; }
        authenticated = true;
        session.used = true;
        session.token = '';
        send(ws, { type: 'authenticated', language: session.language });
        return;
      }
      if (msg.type === 'start') {
        if (started) { send(ws, { type: 'error', message: 'This session has already started.' }); return; }
        if (msg.language !== session.language || typeof msg.sourceCode !== 'string' || !msg.sourceCode.trim() || msg.sourceCode.length > L.maxSourceChars) {
          send(ws, { type: 'error', message: 'Invalid source or language.' }); return;
        }
        // Check and reserve in the same synchronous step: the slot is taken before any await.
        if (active.size >= L.maxActive) { await finish('busy', { message: 'Interactive runner is busy. Try again shortly.' }); return; }
        started = true;
        active.set(sessionId, ws);
        try {
          const runtime = RUNTIMES[session.language];
          hasCompileStep = typeof runtime.compile === 'function';
          memoryMb = runtime.memoryMb ?? DEFAULT_MEMORY_MB;
          send(ws, { type: 'status', state: 'preparing' });
          // Pull time is not program time: keep the browser connection alive while the image downloads, then start the clock.
          let lastPing = 0;
          try {
            await ensureImage(runtime.image, () => {
              const now = Date.now();
              if (now - lastPing >= L.pullKeepAliveMs) { lastPing = now; send(ws, { type: 'status', state: 'preparing' }); }
            }, L.pullTimeoutMs);
          } catch (err) {
            logger.error(`could not prepare image ${runtime.image}:`, err?.message || 'unknown error');
            await finish('error', { phase: 'start', message: 'The runtime for this language could not be downloaded. Try again in a minute or choose another language.' });
            return;
          }
          if (finished || ws.readyState !== WebSocket.OPEN) return cleanup();
          timeout = setTimeout(() => { void finish('timed_out', { message: `Execution timed out after ${Math.round(L.executionTimeoutMs / 1000)} seconds.` }); }, L.executionTimeoutMs);
          container = await docker.createContainer({
            Image: runtime.image,
            Entrypoint: ['/bin/sh', '-c'],
            Cmd: ['while :; do sleep 3600; done'],
            WorkingDir: '/tmp',
            Tty: false,
            OpenStdin: false,
            NetworkDisabled: true,
            HostConfig: {
              NetworkMode: 'none',
              Memory: memoryMb * 1024 * 1024,
              MemorySwap: memoryMb * 1024 * 1024,
              NanoCpus: 1_000_000_000,
              PidsLimit: 128,
              ReadonlyRootfs: true,
              Tmpfs: { '/tmp': 'rw,exec,nosuid,nodev,size=64m' }, // exec: Docker mounts a tmpfs noexec by default, but compiled languages run the binary they just built in /tmp
              CapDrop: ['ALL'],
              SecurityOpt: ['no-new-privileges:true'],
              AutoRemove: false,
              Init: true
            },
            Labels: { 'com.teacode.terminal-session': sessionId }
          });
          if (finished || ws.readyState !== WebSocket.OPEN) return cleanup();
          await container.start();
          if (finished || ws.readyState !== WebSocket.OPEN) return cleanup();
          const sourceName = Object.keys(runtime.files(msg.sourceCode))[0];
          const files = Object.fromEntries(Object.entries(runtime.files(msg.sourceCode)).map(([name, content]) => [name, name === sourceName ? msg.sourceCode : content]));
          for (const [name, content] of Object.entries(files)) await writeFile(container, name, content);
          exec = await container.exec({
            Cmd: ['sh', '-c', buildScript(runtime, msg.sourceCode)],
            AttachStdin: true, AttachStdout: true, AttachStderr: true, Tty: false,
            WorkingDir: '/tmp',
            Env: ['HOME=/tmp', 'TMPDIR=/tmp', 'TERM=xterm-256color', 'PYTHONUNBUFFERED=1', 'PYTHONIOENCODING=utf-8', 'DOTNET_CLI_TELEMETRY_OPTOUT=1', 'DOTNET_NOLOGO=1']
          });
          stream = await exec.start({ hijack: true, stdin: true, Tty: false });
          streamDone = new Promise((resolve) => { stream.on('end', resolve); stream.on('close', resolve); });
          send(ws, { type: 'status', state: hasCompileStep ? 'compiling' : 'running' });
          attachDockerFrames(stream, (streamType, text) => {
            if (streamType === 1) appendOutput('stdout', text);
            else if (streamType === 2) appendOutput('stderr', text);
          });
          stream.on('error', () => { if (!finished) void finish('error', { phase: 'run', message: 'Execution stream failed.' }); });

          // Reports "waiting for input" only when the program is really blocked in read(0, ...): the process' current
          // syscall is read from /proc inside the container's own PID namespace.
          const monitorScript = `while [ ! -s ${PID_FILE} ]; do sleep 0.1; done; pid="$(cat ${PID_FILE})"; arch="$(uname -m)"; last=; ann=0; while kill -0 "$pid" 2>/dev/null; do if [ "$ann" -eq 0 ] && [ -f ${COMPILED_FILE} ]; then echo RUNNING; ann=1; fi; waiting=0; for t in /proc/$pid/task/*/syscall; do line="$(cat $t 2>/dev/null || true)"; set -- $line; nr="\${1:-}"; fd="\${2:-}"; case "$arch:$nr:$fd" in x86_64:0:0x0|aarch64:63:0x0|arm*:3:0x0|i?86:3:0x0) waiting=1;; esac; done; if [ "$waiting" -eq 1 ] && [ "$last" != waiting ]; then echo WAITING; last=waiting; fi; if [ "$waiting" -eq 0 ] && [ "$last" = waiting ]; then echo RUNNING; last=running; fi; sleep 0.2; done`;
          const monitorExec = await container.exec({ Cmd: ['sh', '-c', monitorScript], AttachStdin: false, AttachStdout: true, AttachStderr: true, Tty: false, WorkingDir: '/tmp' });
          const monitorStream = await monitorExec.start({ hijack: true, stdin: false, Tty: false });
          let monitorBuffer = '';
          attachDockerFrames(monitorStream, (streamType, text) => {
            if (streamType !== 1 || finished) return;
            monitorBuffer += text;
            const lines = monitorBuffer.split('\n');
            monitorBuffer = lines.pop() || '';
            for (const line of lines) {
              if (line.trim() === 'WAITING') send(ws, { type: 'status', state: 'waiting' });
              else if (line.trim() === 'RUNNING') send(ws, { type: 'status', state: 'running' });
            }
          });
          monitorStream.on('error', () => { /* The main execution stream remains authoritative. */ });
          let exiting = false;
          poll = setInterval(async () => {
            if (finished || !exec || exiting) return;
            try {
              const detail = await exec.inspect();
              if (!detail.Running) { exiting = true; await reportExit(detail.ExitCode); }
            } catch { /* Docker may briefly report the exec as unavailable during startup. */ }
          }, L.pollMs);
        } catch (err) {
          logger.error('terminal execution failed:', err?.message || 'unknown error');
          await finish('error', { phase: 'start', message: 'The interactive execution service could not start this program.' });
        }
        return;
      }
      if (msg.type === 'input') {
        if (!started || finished || !stream || typeof msg.data !== 'string' || msg.data.length > 10_000) return;
        inputBytes += Buffer.byteLength(msg.data, 'utf8');
        if (inputBytes > L.maxInputBytes) { await finish('error', { phase: 'run', message: `Input limit exceeded (${Math.round(L.maxInputBytes / 1000)} KB).` }); return; }
        // Newlines are sent exactly as entered. An empty line is "\n".
        stream.write(msg.data);
        return;
      }
      if (msg.type === 'eof') {
        // End of input (Ctrl+D): lets programs that read until EOF finish instead of waiting for the time limit.
        if (!started || finished || !stream) return;
        try { stream.end(); } catch { /* Stream already closed. */ }
        return;
      }
      if (msg.type === 'stop') await finish('stopped');
    });

    const authTimer = setTimeout(() => { if (!authenticated && ws.readyState === WebSocket.OPEN) ws.close(4401, 'Authentication timeout'); }, L.authTimeoutMs);
    const startTimer = setTimeout(() => { if (authenticated && !started && ws.readyState === WebSocket.OPEN) ws.close(4408, 'Start timeout'); }, L.startTimeoutMs);
    authTimer.unref?.();
    startTimer.unref?.();
    // A socket that never authenticated must not destroy the session: someone who only knows the session id (not the
    // one-use token) could otherwise cancel another user's pending session by connecting and closing.
    ws.on('close', () => {
      clearTimeout(authTimer);
      clearTimeout(startTimer);
      if (!finished) { finished = true; void cleanup({ keepSession: !authenticated }); }
    });
    ws.on('error', () => { if (!finished) { finished = true; void cleanup({ keepSession: !authenticated }); } });
  });

  const sweep = setInterval(() => {
    const now = Date.now();
    for (const [id, s] of sessions) if (s.expiresAt < now && !active.has(id)) sessions.delete(id);
  }, 30_000);
  sweep.unref();

  /** Removes labelled containers left behind by a crash. Call before reporting healthy. */
  async function removeLeftovers() {
    const leftovers = await docker.listContainers({ all: true, filters: { label: ['com.teacode.terminal-session'] } });
    await Promise.all(leftovers.map(async (item) => {
      try { await docker.getContainer(item.Id).remove({ force: true, v: true }); } catch { /* Already gone. */ }
    }));
  }

  /** Stops accepting work, closes sockets (which kills their containers) and clears timers. */
  async function close() {
    clearInterval(sweep);
    for (const ws of wss.clients) { try { ws.close(1001, 'Runner shutting down'); } catch { /* ignore */ } }
    await new Promise((resolve) => server.close(() => resolve()));
    await sleep(50);
    try { await removeLeftovers(); } catch { /* Daemon unavailable during shutdown. */ }
  }

  return { server, wss, sessions, active, removeLeftovers, prepullImages, close, limits: L };
}
