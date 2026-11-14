import { describe, it, expect, beforeEach, vi } from 'vitest';
import { api } from '../services/api.js';
import { SESSION_EXPIRED_EVENT } from '../services/sessionEvents.js';

const original = api.defaults.adapter;
const reply = (config, status, data = {}) => {
  const response = { data, status, statusText: String(status), headers: {}, config };
  return status >= 200 && status < 300 ? Promise.resolve(response)
    : Promise.reject(Object.assign(new Error(`HTTP ${status}`), { config, response, isAxiosError: true }));
};

let calls;
let expired;
function install(handler) {
  api.defaults.adapter = (config) => { calls.push(`${config.method} ${config.url}`); return handler(config); };
}

beforeEach(() => { calls = []; expired = vi.fn(); window.addEventListener(SESSION_EXPIRED_EVENT, expired, { once: true }); api.defaults.adapter = original; });

describe('session refresh', () => {
  it('refreshes once on 401 and retries the original request', async () => {
    let fresh = false;
    install((c) => {
      if (c.url === '/auth/refresh') { fresh = true; return reply(c, 204); }
      return fresh ? reply(c, 200, { ok: true }) : reply(c, 401);
    });
    const res = await api.get('/auth/me');
    expect(res.data).toEqual({ ok: true });
    expect(calls).toEqual(['get /auth/me', 'post /auth/refresh', 'get /auth/me']);
    expect(expired).not.toHaveBeenCalled();
  });

  it('shares one refresh between concurrent 401s', async () => {
    let fresh = false;
    install(async (c) => {
      if (c.url === '/auth/refresh') { await Promise.resolve(); fresh = true; return reply(c, 204); }
      return fresh ? reply(c, 200) : reply(c, 401);
    });
    await Promise.all([api.get('/dashboard/summary'), api.get('/dashboard/progress'), api.get('/dashboard/time')]);
    expect(calls.filter((c) => c === 'post /auth/refresh')).toHaveLength(1);
  });

  it('gives up and signals expiry when the refresh fails', async () => {
    install((c) => reply(c, 401));
    await expect(api.get('/dashboard/summary')).rejects.toMatchObject({ response: { status: 401 } });
    expect(calls).toEqual(['get /dashboard/summary', 'post /auth/refresh']);
    expect(expired).toHaveBeenCalledTimes(1);
  });

  it('does not loop when the retried request is still unauthorized', async () => {
    install((c) => (c.url === '/auth/refresh' ? reply(c, 204) : reply(c, 401)));
    await expect(api.get('/dashboard/summary')).rejects.toMatchObject({ response: { status: 401 } });
    expect(calls).toEqual(['get /dashboard/summary', 'post /auth/refresh', 'get /dashboard/summary']);
  });

  it('never refreshes for login failures or non-401 errors', async () => {
    install((c) => reply(c, c.url === '/auth/login' ? 401 : 500));
    await expect(api.post('/auth/login', {})).rejects.toMatchObject({ response: { status: 401 } });
    await expect(api.get('/problems')).rejects.toMatchObject({ response: { status: 500 } });
    expect(calls).toEqual(['post /auth/login', 'get /problems']);
  });
});
