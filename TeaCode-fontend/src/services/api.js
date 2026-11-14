import axios from 'axios';
import { SESSION_EXPIRED_EVENT } from './sessionEvents.js';

// Same-origin API. Auth lives in HttpOnly cookies set by the backend; nothing is
// stored in localStorage/sessionStorage. Axios reads the XSRF-TOKEN cookie and sends
// it as X-XSRF-TOKEN on state-changing requests (Spring CookieCsrfTokenRepository).
export const api = axios.create({
  baseURL: '/api/v1',
  withCredentials: true,
  xsrfCookieName: 'XSRF-TOKEN',
  xsrfHeaderName: 'X-XSRF-TOKEN',
  timeout: 15000,
});


// Requests whose 401 is an answer, not an expired session: never refresh-and-retry them.
const NO_REFRESH = ['/auth/login', '/auth/register', '/auth/refresh', '/auth/logout', '/auth/forgot-password', '/auth/reset-password', '/auth/verify-email', '/auth/firebase'];

let inFlight = null;

/**
 * Access cookies live 15 minutes while the refresh cookie lives 14 days. On a 401 the client renews the session once.
 * Concurrent 401s in this tab share one refresh, and the Web Locks API (where available) serialises tabs so two tabs
 * never present the same single-use refresh token (the backend treats a replayed token as theft and ends all sessions).
 */
function refreshSession() {
  if (!inFlight) {
    const run = () => api.post('/auth/refresh');
    const locked = typeof navigator !== 'undefined' && navigator.locks?.request
      ? navigator.locks.request('teacode-session-refresh', run)
      : run();
    inFlight = Promise.resolve(locked).finally(() => { inFlight = null; });
  }
  return inFlight;
}

api.interceptors.response.use(
  (response) => response,
  async (error) => {
    const config = error.config;
    const url = config?.url ?? '';
    if (error.response?.status !== 401 || !config || config._retried || NO_REFRESH.some((p) => url.startsWith(p))) {
      throw error;
    }
    config._retried = true;
    try {
      await refreshSession();
    } catch {
      window.dispatchEvent(new Event(SESSION_EXPIRED_EVENT));
      throw error;
    }
    return api(config);
  },
);
