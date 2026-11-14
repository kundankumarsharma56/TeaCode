import { useCallback, useEffect, useRef, useState } from 'react';
import { api } from '../../services/api.js';

export function formatElapsed(ms) {
  const total = Math.max(0, Math.floor(ms / 1000));
  const h = Math.floor(total / 3600);
  const m = Math.floor((total % 3600) / 60);
  const s = total % 60;
  const mm = String(m).padStart(2, '0');
  const ss = String(s).padStart(2, '0');
  return h > 0 ? `${String(h).padStart(2, '0')}:${mm}:${ss}` : `${mm}:${ss}`;
}

const SYNC_MS = 30000;

/**
 * Per-problem study timer. The SERVER owns the state (POST /timers/{slug}/start|pause|reset, GET /timers/{slug});
 * the browser only displays it. It counts wall-clock time between Start/Resume and Pause, capped per running stretch
 * by the server. Every response carries the server's total at that moment, so this hook shows
 * total + (time since the response) while running, and re-reads the server on focus and every 30 s. A second tab
 * therefore converges on the same value, and a reload never loses time.
 * status: idle | loading | ready | unavailable    state: IDLE | RUNNING | PAUSED
 */
export function useTimer(slug, enabled) {
  const [timer, setTimer] = useState({ status: 'idle', state: 'IDLE', baseMs: 0, at: 0 });
  const [now, setNow] = useState(() => Date.now());
  const [busy, setBusy] = useState(false);
  const live = useRef(true);

  const apply = useCallback((data) => {
    const state = ['IDLE', 'RUNNING', 'PAUSED'].includes(data?.state) ? data.state : null;
    if (!state || typeof data.elapsedMs !== 'number') {
      setTimer({ status: 'unavailable', state: 'IDLE', baseMs: 0, at: 0 });
      return;
    }
    setNow(Date.now());
    setTimer({ status: 'ready', state, baseMs: data.elapsedMs, at: Date.now() });
  }, []);

  const sync = useCallback(() => api.get(`/timers/${slug}`).then((r) => live.current && apply(r.data)).catch(() => {}), [slug, apply]);

  useEffect(() => {
    live.current = true;
    if (!enabled) {
      setTimer({ status: 'idle', state: 'IDLE', baseMs: 0, at: 0 });
      return undefined;
    }
    setTimer({ status: 'loading', state: 'IDLE', baseMs: 0, at: 0 });
    api.get(`/timers/${slug}`)
      .then((r) => live.current && apply(r.data))
      .catch(() => live.current && setTimer({ status: 'unavailable', state: 'IDLE', baseMs: 0, at: 0 }));
    return () => {
      live.current = false;
    };
  }, [slug, enabled, apply]);

  useEffect(() => {
    if (timer.status !== 'ready') return undefined;
    const tick = () => setNow(Date.now());
    const t = setInterval(tick, 1000);
    const resync = setInterval(sync, SYNC_MS);
    const onVisible = () => {
      tick();
      if (document.visibilityState === 'visible') sync();
    };
    document.addEventListener('visibilitychange', onVisible);
    window.addEventListener('focus', onVisible);
    return () => {
      clearInterval(t);
      clearInterval(resync);
      document.removeEventListener('visibilitychange', onVisible);
      window.removeEventListener('focus', onVisible);
    };
  }, [timer.status, sync]);

  const act = useCallback(async (action) => {
    setBusy(true);
    try {
      const r = await api.post(`/timers/${slug}/${action}`);
      if (live.current) apply(r.data);
    } finally {
      if (live.current) setBusy(false);
    }
  }, [slug, apply]);

  const elapsedMs = timer.state === 'RUNNING' ? timer.baseMs + Math.max(0, now - timer.at) : timer.baseMs;
  return {
    status: timer.status,
    state: timer.state,
    elapsedMs,
    busy,
    start: () => act('start'),
    pause: () => act('pause'),
    reset: () => act('reset'),
  };
}
