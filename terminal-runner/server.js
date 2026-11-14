import Docker from 'dockerode';
import { createRunner } from './runner.js';

const PORT = Number(process.env.PORT || 3000);
const INTERNAL_TOKEN = process.env.TERMINAL_RUNNER_INTERNAL_TOKEN || '';
const DOCKER_HOST = process.env.DOCKER_HOST || 'tcp://terminal-docker:2375';
const [dockerHost, dockerPort] = DOCKER_HOST.replace(/^tcp:\/\//, '').split(':');
const docker = new Docker({ host: dockerHost, port: Number(dockerPort || 2375), protocol: 'http' });

// Without a strong shared secret nobody can create sessions, so refuse to start rather than run half-configured.
if (INTERNAL_TOKEN.length < 32) {
  console.error('TERMINAL_RUNNER_INTERNAL_TOKEN must be set to at least 32 characters.');
  process.exit(1);
}

const runner = createRunner({ docker, internalToken: INTERNAL_TOKEN });

// The runner can be restarted independently of its daemon. Remove labelled execution containers left behind
// by a crash before advertising the service as healthy.
try {
  await runner.removeLeftovers();
} catch (err) {
  console.error('could not perform startup cleanup:', err?.message || 'Docker daemon unavailable');
}

runner.server.listen(PORT, '0.0.0.0', () => console.log(`terminal runner listening on ${PORT}`));

// Download runtime images in the background so the first Run in a language is quick. TERMINAL_PREPULL is a comma
// separated list of languages, "all", or "none". Anything not pre-pulled is still downloaded on first use.
const PREPULL = (process.env.TERMINAL_PREPULL ?? 'python,javascript,java,c,cpp').trim();
if (PREPULL && PREPULL !== 'none') {
  const keys = PREPULL === 'all' ? undefined : PREPULL.split(',').map((k) => k.trim()).filter(Boolean);
  runner.prepullImages(keys)
    .then(({ pulled, failed }) => console.log(`runtime images ready: ${pulled.length}, unavailable: ${failed.length}${failed.length ? ` (${failed.join(', ')})` : ''}`))
    .catch((err) => console.error('image preparation failed:', err?.message || 'unknown'));
}

let stopping = false;
for (const signal of ['SIGTERM', 'SIGINT']) {
  process.on(signal, async () => {
    if (stopping) return;
    stopping = true;
    console.log(`${signal} received: stopping runner and removing execution containers`);
    try { await runner.close(); } catch (err) { console.error('shutdown error:', err?.message || 'unknown'); }
    process.exit(0);
  });
}
