// Protocol and state-machine tests for the terminal runner using a scripted fake Docker client.
// They prove the runner's own logic (auth, limits, ordering, cleanup, error classification). They do NOT prove
// container isolation or that the real images run; that needs a Docker daemon (see docs/terminal-interactive-runner.md).
import test from 'node:test';
import assert from 'node:assert/strict';
import { Duplex, PassThrough } from 'node:stream';
import { WebSocket } from 'ws';
import { createRunner, buildScript, RUNTIMES } from '../runner.js';

const TOKEN = 'x'.repeat(40);

function frame(type, text) {
  const body = Buffer.from(text, 'utf8');
  const header = Buffer.alloc(8);
  header[0] = type;
  header.writeUInt32BE(body.length, 4);
  return Buffer.concat([header, body]);
}

/** Scriptable fake of the dockerode surface the runner uses. */
class FakeDocker {
  constructor(program) {
    this.program = program; // ({stdin, out, err, exit, written}) => void
    this.containers = [];
    this.removed = 0;
    this.killed = 0;
    this.modem = { followProgress: (s, cb) => cb(null) };
    this.compiled = true;
    this.oom = false;
  }
  getImage() { return { inspect: async () => ({}) }; }
  async pull() { return new PassThrough(); }
  getContainer() { return { remove: async () => { this.removed += 1; } }; }
  async listContainers() { return []; }
  async createContainer(options) {
    const docker = this;
    const record = { options, archives: [], execs: [], files: {} };
    docker.containers.push(record);
    return {
      start: async () => {},
      kill: async () => { docker.killed += 1; },
      remove: async () => { docker.removed += 1; },
      inspect: async () => ({ State: { OOMKilled: docker.oom } }),
      // Like the real daemon: archives cannot be copied into a container whose root filesystem is read-only.
      putArchive: async (buf) => {
        if (options.HostConfig?.ReadonlyRootfs) throw new Error('(HTTP code 400) client error, bad parameters - container rootfs is marked read-only');
        record.archives.push(buf);
      },
      exec: async (cfg) => {
        record.execs.push(cfg);
        const cmd = cfg.Cmd.join(' ');
        if (cmd.startsWith('sh -c cat > /tmp/')) {
          const name = cmd.slice('sh -c cat > /tmp/'.length);
          const chunks = [];
          const writer = new Duplex({
            read() {},
            write(chunk, _enc, cb) { chunks.push(chunk); cb(); },
            final(cb) { record.files[name] = Buffer.concat(chunks).toString('utf8'); this.push(null); cb(); }
          });
          return { start: async () => writer, inspect: async () => ({ Running: false, ExitCode: 0 }) };
        }
        if (cmd.startsWith('test -f')) {
          return { start: async () => {}, inspect: async () => ({ Running: false, ExitCode: docker.compiled ? 0 : 1 }) };
        }
        if (cmd.includes('syscall')) {
          const idle = new PassThrough();
          return { start: async () => idle, inspect: async () => ({ Running: true }) };
        }
        const state = { running: true, exitCode: 0, writes: [], ended: false };
        let readable;
        const stream = new Duplex({
          read() {},
          write(chunk, _enc, cb) { state.writes.push(chunk.toString()); docker.program.onInput?.(chunk.toString(), api); cb(); },
          final(cb) { state.ended = true; docker.program.onEof?.(api); cb(); }
        });
        readable = stream;
        const api = {
          out: (t) => readable.push(frame(1, t)),
          err: (t) => readable.push(frame(2, t)),
          // exit(code, streamDelayMs): the exec reports "not running" immediately; the stream closes later (race).
          exit: (code, streamDelayMs = 0) => {
            state.running = false; state.exitCode = code;
            setTimeout(() => readable.push(null), streamDelayMs);
          },
          state
        };
        setImmediate(() => docker.program.onStart?.(api));
        return { start: async () => stream, inspect: async () => ({ Running: state.running, ExitCode: state.exitCode }) };
      }
    };
  }
}

async function boot(program, limits = {}) {
  const docker = new FakeDocker(program);
  const runner = createRunner({ docker, internalToken: TOKEN, limits: { pollMs: 10, streamDrainMs: 500, ...limits }, logger: { error() {} } });
  await new Promise((resolve) => runner.server.listen(0, '127.0.0.1', resolve));
  const port = runner.server.address().port;
  const base = `http://127.0.0.1:${port}`;
  const createSession = async (language = 'python', token = TOKEN) => {
    const res = await fetch(`${base}/sessions`, { method: 'POST', headers: { 'x-internal-token': token, 'content-type': 'application/json' }, body: JSON.stringify({ language }) });
    return { status: res.status, body: await res.json().catch(() => ({})) };
  };
  const connect = (sessionId) => {
    const ws = new WebSocket(`ws://127.0.0.1:${port}/ws/${sessionId}`);
    const events = [];
    const waiters = [];
    ws.on('message', (raw) => { const m = JSON.parse(raw.toString()); events.push(m); waiters.splice(0).forEach((w) => w()); });
    const closed = new Promise((resolve) => ws.on('close', (code) => resolve(code)));
    const until = async (pred, ms = 3000) => {
      const deadline = Date.now() + ms;
      for (;;) {
        const hit = events.find(pred);
        if (hit) return hit;
        if (Date.now() > deadline) throw new Error(`timed out waiting; events=${JSON.stringify(events)}`);
        await new Promise((resolve) => { waiters.push(resolve); setTimeout(resolve, 20); });
      }
    };
    const opened = new Promise((resolve, reject) => { ws.on('open', resolve); ws.on('error', reject); });
    return { ws, events, closed, until, opened, send: (m) => ws.send(JSON.stringify(m)) };
  };
  const run = async (language = 'python', source = 'print(1)') => {
    const { body } = await createSession(language);
    const c = connect(body.sessionId);
    await c.opened;
    c.send({ type: 'auth', token: body.token });
    await c.until((e) => e.type === 'authenticated');
    c.send({ type: 'start', language, sourceCode: source });
    return c;
  };
  const stop = () => runner.close();
  return { docker, runner, createSession, connect, run, stop };
}

test('session creation: token, language allow-list and prototype keys', async (t) => {
  const h = await boot({});
  t.after(h.stop);
  assert.equal((await h.createSession('python', 'wrong')).status, 403);
  assert.equal((await h.createSession('cobol')).status, 422);
  for (const key of ['constructor', '__proto__', 'toString', 'hasOwnProperty']) {
    assert.equal((await h.createSession(key)).status, 422, key);
  }
  const ok = await h.createSession('python');
  assert.equal(ok.status, 201);
  assert.ok(ok.body.sessionId.length >= 20 && ok.body.token.length >= 32);
});

test('websocket: wrong token is rejected and a session token is single use', async (t) => {
  const h = await boot({});
  t.after(h.stop);
  const { body } = await h.createSession();
  const bad = h.connect(body.sessionId);
  await bad.opened;
  bad.send({ type: 'auth', token: 'nope' });
  assert.equal(await bad.closed, 4401);

  const good = h.connect(body.sessionId);
  await good.opened;
  good.send({ type: 'auth', token: body.token });
  await good.until((e) => e.type === 'authenticated');
  // A second connection with the same session is refused: the credential is spent.
  const again = h.connect(body.sessionId);
  assert.equal(await again.closed, 4401);
  good.ws.close();
});

test('interactive program: prompt, input, output order, exit status and cleanup', async (t) => {
  const program = {
    onStart: (p) => p.out('Name: '),
    onInput: (data, p) => { p.out(`Hello ${data.trim()}\n`); p.exit(0); }
  };
  const h = await boot(program);
  t.after(h.stop);
  const c = await h.run();
  await c.until((e) => e.type === 'output' && e.data === 'Name: ');
  c.send({ type: 'input', data: 'Ada\n' });
  const exit = await c.until((e) => e.type === 'exit');
  assert.deepEqual({ state: exit.state, exitCode: exit.exitCode }, { state: 'finished', exitCode: 0 });
  const outputs = c.events.filter((e) => e.type === 'output').map((e) => e.data).join('');
  assert.equal(outputs, 'Name: Hello Ada\n');
  assert.ok(c.events.findIndex((e) => e.type === 'exit') > c.events.findLastIndex((e) => e.type === 'output'), 'exit must come after all output');
  await c.closed;
  assert.equal(h.docker.killed, 1);
  assert.ok(h.docker.removed >= 1);
  assert.equal(h.runner.active.size, 0);
});

test('output that arrives after the exec reports "not running" is not lost', async (t) => {
  const h = await boot({ onStart: (p) => { p.out('first\n'); p.exit(0, 150); setTimeout(() => p.out('late line\n'), 60); } });
  t.after(h.stop);
  const c = await h.run();
  const exit = await c.until((e) => e.type === 'exit');
  assert.equal(exit.state, 'finished');
  assert.match(c.events.filter((e) => e.type === 'output').map((e) => e.data).join(''), /late line/);
});

test('non-zero exit: compile phase vs run phase, memory limit, plain exit code', async (t) => {
  const h = await boot({ onStart: (p) => { p.err('error: something\n'); p.exit(1); } });
  t.after(h.stop);

  h.docker.compiled = false;
  let c = await h.run('java', 'public class Main {}');
  let exit = await c.until((e) => e.type === 'exit');
  assert.deepEqual({ state: exit.state, phase: exit.phase, exitCode: exit.exitCode }, { state: 'error', phase: 'compile', exitCode: 1 });

  h.docker.compiled = true;
  c = await h.run('java', 'public class Main {}');
  exit = await c.until((e) => e.type === 'exit');
  assert.deepEqual({ state: exit.state, phase: exit.phase }, { state: 'error', phase: 'run' });

  // An interpreted language has no compile step: a failure is always a run failure and never probes the marker.
  c = await h.run('python', 'raise SystemExit(1)');
  exit = await c.until((e) => e.type === 'exit');
  assert.equal(exit.phase, 'run');

  h.docker.oom = true;
  c = await h.run('python', 'x=[0]*10**9');
  exit = await c.until((e) => e.type === 'exit');
  assert.equal(exit.state, 'memory_limit');
});

test('Ctrl+D (eof) closes stdin so a program that reads to EOF can finish', async (t) => {
  let sawEof = false;
  const program = { onEof: (p) => { sawEof = true; p.out('done\n'); p.exit(0); } };
  const h = await boot(program);
  t.after(h.stop);
  const c = await h.run();
  await c.until((e) => e.type === 'status' && e.state === 'running');
  c.send({ type: 'eof' });
  const exit = await c.until((e) => e.type === 'exit');
  assert.equal(exit.state, 'finished');
  assert.ok(sawEof);
});

test('wall-clock timeout, output limit and input limit end the run and remove the container', async (t) => {
  let h = await boot({}, { executionTimeoutMs: 150 });
  let c = await h.run();
  assert.equal((await c.until((e) => e.type === 'exit')).state, 'timed_out');
  await c.closed;
  assert.equal(h.docker.killed, 1);
  await h.stop();

  h = await boot({ onStart: (p) => p.out('x'.repeat(5000)) }, { maxOutputBytes: 1000 });
  c = await h.run();
  assert.equal((await c.until((e) => e.type === 'exit')).state, 'output_limit');
  assert.equal(h.docker.killed, 1);
  await h.stop();

  h = await boot({}, { maxInputBytes: 20 });
  c = await h.run();
  await c.until((e) => e.type === 'status' && e.state === 'running');
  c.send({ type: 'input', data: 'y'.repeat(50) + '\n' });
  const exit = await c.until((e) => e.type === 'exit');
  assert.equal(exit.state, 'error');
  await h.stop();
});

test('concurrency limit is enforced when a program starts', async (t) => {
  const h = await boot({}, { maxActive: 1 });
  t.after(h.stop);
  // Both sessions are created while nothing is active; the limit then applies when programs start.
  const open = async () => {
    const { body } = await h.createSession();
    const c = h.connect(body.sessionId);
    await c.opened;
    c.send({ type: 'auth', token: body.token });
    await c.until((e) => e.type === 'authenticated');
    return c;
  };
  const first = await open();
  const second = await open();
  first.send({ type: 'start', language: 'python', sourceCode: 'print(1)' });
  await first.until((e) => e.type === 'status' && e.state === 'running');
  second.send({ type: 'start', language: 'python', sourceCode: 'print(2)' });
  assert.equal((await second.until((e) => e.type === 'exit')).state, 'busy');
  // While the runner is full, new sessions are refused up front.
  assert.equal((await h.createSession()).status, 429);
  first.send({ type: 'stop' });
  assert.equal((await first.until((e) => e.type === 'exit')).state, 'stopped');
});

test('start validation: wrong language, empty or oversized source, double start', async (t) => {
  const h = await boot({});
  t.after(h.stop);
  const { body } = await h.createSession('python');
  const c = h.connect(body.sessionId);
  await c.opened;
  c.send({ type: 'auth', token: body.token });
  await c.until((e) => e.type === 'authenticated');
  c.send({ type: 'start', language: 'java', sourceCode: 'x' });
  c.send({ type: 'start', language: 'python', sourceCode: '   ' });
  c.send({ type: 'start', language: 'python', sourceCode: 'x'.repeat(70_000) });
  await c.until(() => c.events.filter((e) => e.type === 'error').length >= 3);
  assert.equal(h.docker.containers.length, 0);
  c.ws.close();
});

test('the container is created with the isolation settings and no login shell', async (t) => {
  const h = await boot({ onStart: (p) => p.exit(0) });
  t.after(h.stop);
  const c = await h.run('c', 'int main(){return 0;}');
  await c.until((e) => e.type === 'exit');
  const { options, execs } = h.docker.containers[0];
  const host = options.HostConfig;
  assert.equal(host.NetworkMode, 'none');
  assert.equal(host.ReadonlyRootfs, true);
  assert.deepEqual(host.CapDrop, ['ALL']);
  assert.ok(host.SecurityOpt.includes('no-new-privileges:true'));
  assert.ok(host.Memory > 0 && host.PidsLimit > 0 && host.NanoCpus > 0);
  // /tmp must allow exec (compiled languages run the binary they build there) but stay nosuid and nodev.
  assert.match(host.Tmpfs['/tmp'], /(^|,)exec(,|$)/);
  assert.match(host.Tmpfs['/tmp'], /(^|,)nosuid(,|$)/);
  assert.match(host.Tmpfs['/tmp'], /(^|,)nodev(,|$)/);
  assert.equal(options.Entrypoint[1], '-c');
  const main = execs.find((e) => e.AttachStdin && !e.Cmd[2].startsWith('cat > '));
  assert.equal(main.Cmd[0], 'sh');
  assert.equal(main.Cmd[1], '-c');
});

test('script builder: compile step, marker, java class name, shell safety', () => {
  assert.match(buildScript(RUNTIMES.python, 'print(1)'), /^echo \$\$ > \/tmp\/\.teacode-pid; exec python -u main\.py$/);
  const cpp = buildScript(RUNTIMES.cpp, 'int main(){}');
  assert.match(cpp, /g\+\+ -O0 main\.cpp -o \/tmp\/code \|\| exit \$\?; : > \/tmp\/\.teacode-compiled; exec stdbuf -o0 -e0 \/tmp\/code/);
  assert.match(buildScript(RUNTIMES.java, 'public class Solution { }'), /javac -d \/tmp Solution\.java .*java -cp \/tmp Solution/);
  assert.match(buildScript(RUNTIMES.java, 'class A {}'), /Main\.java/);
  // A class name containing shell metacharacters must never reach the command line.
  const evil = buildScript(RUNTIMES.java, 'public class A$(touch${IFS}x) {}');
  assert.ok(!evil.includes('touch'));
});

test('image download time does not count as program run time, and the browser is kept informed', async () => {
  const h = await boot({ onStart: (p) => p.exit(0) }, { executionTimeoutMs: 300, pullKeepAliveMs: 10 });
  // The image is missing and the download takes longer than the whole execution limit.
  h.docker.getImage = () => ({ inspect: async () => { throw new Error('no such image'); } });
  h.docker.pull = async () => new PassThrough();
  h.docker.modem.followProgress = (_s, done, onProgress) => {
    let n = 0;
    const tick = setInterval(() => { onProgress?.({}); if (++n === 6) { clearInterval(tick); done(null); } }, 100);
  };
  const c = await h.run();
  const exit = await c.until((e) => e.type === 'exit', 5000);
  assert.equal(exit.state, 'finished', `expected a finished run, got ${JSON.stringify(c.events)}`);
  assert.ok(c.events.filter((e) => e.type === 'status' && e.state === 'preparing').length >= 2, 'progress keep-alives were sent while downloading');
  await h.stop();
});

test('a failed or stalled image download gives a clear message instead of a vague start failure', async () => {
  let h = await boot({}, { pullTimeoutMs: 200 });
  h.docker.getImage = () => ({ inspect: async () => { throw new Error('no such image'); } });
  h.docker.pull = async () => { throw new Error('registry unreachable'); };
  let c = await h.run();
  let exit = await c.until((e) => e.type === 'exit');
  assert.equal(exit.state, 'error');
  assert.match(exit.message, /could not be downloaded/);
  assert.equal(h.docker.containers.length, 0);
  await h.stop();

  h = await boot({}, { pullTimeoutMs: 150 });
  h.docker.getImage = () => ({ inspect: async () => { throw new Error('no such image'); } });
  h.docker.pull = async () => new PassThrough();
  h.docker.modem.followProgress = () => { /* never completes */ };
  c = await h.run();
  exit = await c.until((e) => e.type === 'exit', 3000);
  assert.match(exit.message, /could not be downloaded/);
  await h.stop();
});

test('source files are written through exec stdin, never putArchive (the daemon refuses archives into a read-only root)', async (t) => {
  const h = await boot({ onStart: (p) => p.exit(0) });
  t.after(h.stop);
  const c = await h.run('python', 'print("hello")');
  const exit = await c.until((e) => e.type === 'exit');
  assert.equal(exit.state, 'finished');
  const record = h.docker.containers[0];
  assert.equal(record.options.HostConfig.ReadonlyRootfs, true);
  assert.equal(record.archives.length, 0);
  assert.equal(record.files['main.py'], 'print("hello")');
});
test('memory limit is 256 MB by default; only the Kotlin compiler gets more, from its own pinned image', async (t) => {
  const h = await boot({ onStart: (p) => p.exit(0) });
  t.after(h.stop);
  const first = await h.run('python', 'print(1)');
  await first.until((e) => e.type === 'exit');
  const second = await h.run('kotlin', 'fun main() {}');
  await second.until((e) => e.type === 'exit');
  const [py, kt] = h.docker.containers;
  assert.equal(py.options.HostConfig.Memory, 256 * 1024 * 1024);
  assert.equal(py.options.HostConfig.MemorySwap, 256 * 1024 * 1024);
  assert.equal(kt.options.HostConfig.Memory, 768 * 1024 * 1024);
  assert.equal(kt.options.HostConfig.MemorySwap, 768 * 1024 * 1024);
  assert.equal(kt.options.Image, 'teacode/kotlin:2.4.21');
});