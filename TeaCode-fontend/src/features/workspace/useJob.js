import { useCallback, useEffect, useRef, useState } from 'react';
import { api } from '../../services/api.js';
import { CODE_KIND } from './ResultsPanel.jsx';

export const POLL_INTERVAL_MS = 1000;
export const POLL_DEADLINE_MS = 120000;
const TERMINAL = new Set(['COMPLETED', 'FAILED']);

/**
 * Starts a run/submit job and polls its status with a bounded deadline.
 * mode: 'run' | 'submit' (problem workspace) or 'terminal' (standalone terminal, POST /terminal/run).
 * phase: idle | starting | polling | done | error
 * Only one job is tracked at a time; starting a new one cancels polling of the old one.
 */
export function useJob() {
  const [state, setState] = useState({ phase: 'idle', mode: null, job: null, error: null });
  const timer = useRef(null);
  const generation = useRef(0);

  const stop = useCallback(() => {
    generation.current += 1;
    if (timer.current) clearTimeout(timer.current);
    timer.current = null;
  }, []);

  useEffect(() => stop, [stop]);

  const start = useCallback(async (mode, payload) => {
    stop();
    const gen = generation.current;
    setState({ phase: 'starting', mode, job: null, error: null });
    const deadline = Date.now() + POLL_DEADLINE_MS;
    try {
      const res = await api.post(mode === 'terminal' ? '/terminal/run' : `/submissions/${mode}`, payload);
      if (gen !== generation.current) return;
      const jobId = res.data.jobId;
      setState({ phase: 'polling', mode, job: { state: 'QUEUED' }, error: null });

      const poll = async () => {
        try {
          const r = await api.get(`/submissions/jobs/${jobId}`);
          if (gen !== generation.current) return;
          const job = r.data;
          if (TERMINAL.has(job.state)) {
            setState({ phase: 'done', mode, job, error: null });
          } else if (Date.now() > deadline) {
            setState({ phase: 'error', mode, job: null, error: { kind: 'timeout' } });
          } else {
            setState({ phase: 'polling', mode, job, error: null });
            timer.current = setTimeout(poll, POLL_INTERVAL_MS);
          }
        } catch (e) {
          if (gen === generation.current) setState({ phase: 'error', mode, job: null, error: toError(e) });
        }
      };
      poll();
    } catch (e) {
      if (gen === generation.current) setState({ phase: 'error', mode, job: null, error: toError(e) });
    }
  }, [stop]);

  return { ...state, start, reset: () => { stop(); setState({ phase: 'idle', mode: null, job: null, error: null }); } };
}

function toError(e) {
  const status = e?.response?.status;
  if (status === 401) return { kind: 'auth' };
  if (status === 429) return { kind: 'rate' };
  const kind = CODE_KIND[e?.response?.data?.code];
  if ((status === 503 || status === 422) && kind) return { kind };
  if (status === 422) return { kind: 'unsupported', message: e.response.data?.message };
  if (status === 503) return { kind: 'service' };
  if (!e?.response) return { kind: 'network' };
  return { kind: 'other', message: e.response.data?.message };
}
