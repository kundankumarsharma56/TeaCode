import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import {
  Alert,
  Box,
  Button,
  CircularProgress,
  Container,
  Autocomplete,
  IconButton,
  Paper,
  Skeleton,
  Stack,
  TextField,
  Tooltip,
  Typography,
} from '@mui/material';
import PlayArrowRoundedIcon from '@mui/icons-material/PlayArrowRounded';
import StopRoundedIcon from '@mui/icons-material/StopRounded';
import RestartAltRoundedIcon from '@mui/icons-material/RestartAltRounded';
import DeleteSweepOutlinedIcon from '@mui/icons-material/DeleteSweepOutlined';
import ContentCopyRoundedIcon from '@mui/icons-material/ContentCopyRounded';
import DownloadRoundedIcon from '@mui/icons-material/DownloadRounded';
import TerminalRoundedIcon from '@mui/icons-material/TerminalRounded';
import CodeRoundedIcon from '@mui/icons-material/CodeRounded';
import { useApiData } from '../../hooks/useApiData.js';
import LanguageIcon from '../../components/LanguageIcon.jsx';
import { useColorMode } from '../../hooks/useColorMode.js';
import { api } from '../../services/api.js';
import { FORBIDDEN_MESSAGE } from '../../services/apiErrors.js';
import { MONO_FONT } from '../../theme/theme.js';
import Editor from '@monaco-editor/react';
import { monacoLanguage } from '../workspace/languages.js';
import { DeveloperName } from '../../components/DeveloperCredit.jsx';
import '../workspace/monacoSetup.js';
import { copyText } from '../workspace/EditorPanel.jsx';
import { MAX_SOURCE_CHARS, MAX_STDIN_CHARS, templateFor } from '../workspace/languages.js';
import { CODE_KIND, ERROR_TEXT } from '../workspace/ResultsPanel.jsx';
import { useJob } from '../workspace/useJob.js';

const EDITOR_FONT_SIZE = 14;
const DRAFT_KEY = 'teacode.compiler.drafts.v1';
const SURFACE = '#0E0E10';
const CANVAS = '#0B0B0C';
const BORDER = '#2A2A2E';
const INK = '#e8edf5';
const MUTED = '#A8A29C';
const ACCENT = '#E07B54';

const DARK_PALETTE = {
  '#ffffff': '#141415',
  '#fff': '#141415',
  '#f6f8fa': '#0B0B0C',
  '#dce2e8': '#2f3a31',
  '#1d2733': '#F2EFEC',
  '#687586': '#A8A29C',
  '#64748b': '#A8A29C',
  '#7b8796': '#8f9c93',
  '#16852B': '#E07B54',
  '#116B22': '#59CC73',
  '#E8F5EA': '#1f3324',
  '#CFE8D3': '#2a3a2d',
  '#f8fafc': '#1f2620',
  '#f1f5f9': '#262f28',
  '#fbfcfe': '#141a15',
  '#eef2f6': '#222b24',
  '#475569': '#C3CEC6',
  '#334155': '#DCE5DE',
  '#253143': '#E3EAE5',
  '#0f172a': '#FFFFFF',
  '#a8b3c2': '#5b695f',
  '#b91c1c': '#FF8C85',
  '#d97706': '#F2B53A',
  '#92400e': '#F5C970',
  '#fff7ed': '#33280f',
  '#15803d': '#E07B54',
  '#166534': '#8BE0A0',
  '#f0fdf4': '#14301a',
  '#dc2626': '#FF7B72',
  '#991b1b': '#FFB0AA',
  '#fef2f2': '#3a1a18',
  '#b45309': '#F2B53A',
  '#fffbeb': '#33280f',
  'rgba(255,255,255,.97)': 'rgba(25,31,26,.97)',
};

/** Terminal chrome colors. Light values are the defaults used in the code; dark mode swaps in the dark equivalents. */
function useT() {
  const { mode } = useColorMode();
  return useCallback((color) => (mode === 'dark' ? DARK_PALETTE[color] ?? color : color), [mode]);
}

function getExecutionStatus(phase, job, error) {
  if (phase === 'starting' || phase === 'polling') return { label: 'Running', tone: 'running' };
  if (phase === 'error') return error?.kind === 'timeout'
    ? { label: 'Timed out', tone: 'warning' }
    : { label: 'Error', tone: 'error' };
  if (job?.state === 'FAILED') return job.errorCode === 'EXECUTION_TIMEOUT'
    ? { label: 'Timed out', tone: 'warning' }
    : { label: 'Error', tone: 'error' };
  if (job?.status === 'TIME_LIMIT_EXCEEDED') return { label: 'Timed out', tone: 'warning' };
  if (job?.status === 'RUNTIME_ERROR' || job?.status === 'COMPILATION_ERROR') return { label: 'Error', tone: 'error' };
  if (phase === 'done') return { label: 'Finished', tone: 'success' };
  return { label: 'Ready', tone: 'neutral' };
}

function StatusIndicator({ status }) {
  const T = useT();
  const colors = {
    running: { dot: T('#d97706'), text: T('#92400e'), bg: T('#fff7ed') },
    success: { dot: T('#15803d'), text: T('#166534'), bg: T('#f0fdf4') },
    error: { dot: T('#dc2626'), text: T('#991b1b'), bg: T('#fef2f2') },
    warning: { dot: T('#b45309'), text: T('#92400e'), bg: T('#fffbeb') },
    neutral: { dot: T('#64748b'), text: T('#475569'), bg: T('#f1f5f9') },
  };
  const color = colors[status.tone] ?? colors.neutral;
  return (
    <Box role="status" aria-live="polite" sx={{ display: 'inline-flex', alignItems: 'center', gap: 0.75, borderRadius: 99, px: 1, py: 0.45, bgcolor: color.bg, color: color.text, fontSize: 12, fontWeight: 650, whiteSpace: 'nowrap' }}>
      <Box sx={{ width: 6, height: 6, borderRadius: '50%', bgcolor: color.dot }} />
      {status.label}
    </Box>
  );
}

function OutputLine({ label, value, tone = 'normal' }) {
  if (!value) return null;
  return (
    <Box sx={{ mb: 1.5 }}>
      <Typography component="div" sx={{ mb: 0.5, color: tone === 'error' ? '#ff8c85' : '#A8A29C', fontSize: 10, fontWeight: 750, letterSpacing: '.08em', textTransform: 'uppercase' }}>{label}</Typography>
      <Box component="pre" sx={{ m: 0, color: tone === 'error' ? '#ff8c85' : '#e3eae5', fontFamily: MONO_FONT, fontSize: 13, lineHeight: 1.65, whiteSpace: 'pre-wrap', overflowWrap: 'anywhere', tabSize: 4 }}>{value}</Box>
    </Box>
  );
}

function getTerminalStatus(state) {
  const values = {
    idle: { label: 'Ready', tone: 'neutral' },
    connecting: { label: 'Connecting', tone: 'running' },
    preparing: { label: 'Preparing runtime', tone: 'running' },
    running: { label: 'Running', tone: 'running' },
    waiting: { label: 'Waiting for input', tone: 'running' },
    compiling: { label: 'Compiling', tone: 'running' },
    stopping: { label: 'Stopping', tone: 'warning' },
    finished: { label: 'Finished', tone: 'success' },
    stopped: { label: 'Stopped', tone: 'neutral' },
    timed_out: { label: 'Timed out', tone: 'warning' },
    compile_error: { label: 'Compilation error', tone: 'error' },
    memory_limit: { label: 'Memory limit', tone: 'error' },
    disconnected: { label: 'Disconnected', tone: 'error' },
    error: { label: 'Error', tone: 'error' },
  };
  return values[state] ?? values.idle;
}

// Free live demo: there is no interactive runner, so every language uses the one-shot run (VITE_TERMINAL_BATCH=true).
const BATCH_ALL = import.meta.env.VITE_TERMINAL_BATCH === 'true';
// Replay-style console for the one-shot runner. JDoodle cannot pause for input, so a program that asks for input ends
// with a time-out or an end-of-input error. The console then shows an input line; each value typed runs the program
// again with all values so far, and the typed values are shown after the prompts like in a real terminal.
const EMPTY_REPLAY = { committed: '', prevRaw: '', count: 0, inputs: [] };
const MAX_REPLAY_INPUTS = 20;
const WAIT_TIMEOUT = /\s*JDoodle\s*-\s*Timeout[\s\S]*$/i;
const WAIT_EOF = /\s*(Traceback \(most recent call last\)|Exception in thread)[\s\S]*$/;

function replayView(result) {
  const raw = [result?.compileOutput, result?.stdout, result?.stderr].filter(Boolean).join('\n');
  if (!result || result.state === 'FAILED' || result.compileOutput) return { text: raw, waiting: false };
  if (result.status === 'TIME_LIMIT_EXCEEDED' && WAIT_TIMEOUT.test(raw)) return { text: raw.replace(WAIT_TIMEOUT, ''), waiting: true };
  if (result.status === 'RUNTIME_ERROR' && /EOFError|NoSuchElementException/.test(raw)) return { text: raw.replace(WAIT_EOF, ''), waiting: true };
  return { text: raw, waiting: false };
}

export default function TerminalPage() {
  const T = useT();
  const langs = useApiData(BATCH_ALL ? '/execution/languages' : '/terminal/languages');
  const job = useJob(); // Retained for SQL's existing one-shot compiler path.
  const [language, setLanguage] = useState('');
  // The public Terminal never saves code: it lives in memory only and is gone when the tab closes.
  const [codeByLang, setCodeByLang] = useState({});
  const [stdin, setStdin] = useState('');
  // Set when the interactive runner is unavailable (for example the free live demo): runs then use the one-shot compiler.
  const [oneShot, setOneShot] = useState(false);
  const [replay, setReplay] = useState(EMPTY_REPLAY);
  const [terminalDraft, setTerminalDraft] = useState('');
  const [terminalChunks, setTerminalChunks] = useState([]);
  const [terminalStatus, setTerminalStatus] = useState('idle');
  const [split, setSplit] = useState(50); // Equal-width editor and terminal by default.
  const [activeView, setActiveView] = useState('editor');
  const [isMobile, setIsMobile] = useState(() => typeof window !== 'undefined' && window.innerWidth < 900);
  const [copied, setCopied] = useState(false);
  const workspaceRef = useRef(null);
  const outputRef = useRef(null);
  const dragging = useRef(false);
  const initialised = useRef(false);
  const socketRef = useRef(null);
  const generationRef = useRef(0);
  const terminalInputRef = useRef(null);
  const languages = useMemo(() => Array.isArray(langs.data) ? langs.data : [], [langs.data]);
  const selectedLanguage = languages.find((item) => item.key === language);
  const isSql = language === 'sql';
  // Only SQL uses the one-shot compiler. Every other language runs on the isolated interactive runner; if the runner is
  // unavailable the page says so instead of silently sending the source to a different service.
  const batch = isSql || BATCH_ALL || oneShot;
  const replayMode = batch && !isSql;

  useEffect(() => {
    if (!initialised.current && languages.length) {
      initialised.current = true;
      setLanguage(languages[0].key);
    }
  }, [languages]);

  useEffect(() => {
    // Remove code that an earlier version of this page stored in the browser.
    try { window.localStorage.removeItem(DRAFT_KEY); } catch { /* Storage may be unavailable. */ }
  }, []);

  useEffect(() => {
    const updateViewport = () => setIsMobile(window.innerWidth < 900);
    window.addEventListener('resize', updateViewport);
    return () => window.removeEventListener('resize', updateViewport);
  }, []);

  useEffect(() => {
    const move = (event) => {
      if (!dragging.current || !workspaceRef.current) return;
      const rect = workspaceRef.current.getBoundingClientRect();
      if (!rect.width) return;
      setSplit(Math.max(30, Math.min(70, ((event.clientX - rect.left) / rect.width) * 100)));
    };
    const stop = () => {
      dragging.current = false;
      document.body.style.cursor = '';
      document.body.style.userSelect = '';
    };
    window.addEventListener('pointermove', move);
    window.addEventListener('pointerup', stop);
    window.addEventListener('pointercancel', stop);
    return () => {
      window.removeEventListener('pointermove', move);
      window.removeEventListener('pointerup', stop);
      window.removeEventListener('pointercancel', stop);
      stop();
    };
  }, []);

  useEffect(() => {
    const viewport = window.visualViewport;
    if (!viewport) return undefined;
    const keepInputVisible = () => {
      const input = terminalInputRef.current;
      if (input && document.activeElement === input) input.scrollIntoView?.({ block: 'nearest' });
    };
    viewport.addEventListener('resize', keepInputVisible);
    return () => viewport.removeEventListener('resize', keepInputVisible);
  }, []);

  useEffect(() => () => {
    generationRef.current += 1;
    const socket = socketRef.current;
    socketRef.current = null;
    if (socket && socket.readyState < WebSocket.CLOSING) {
      try { socket.send(JSON.stringify({ type: 'stop' })); } catch { /* Socket may already be gone. */ }
      socket.close();
    }
  }, []);

  const selectLanguage = (nextLanguage) => {
    if (!nextLanguage || nextLanguage === language) return;
    setReplay(EMPTY_REPLAY);
    setLanguage(nextLanguage);
    setStdin('');
    setTerminalDraft('');
    setTerminalChunks([]);
    setTerminalStatus('idle');
    job.reset();
    setCopied(false);
  };

  const code = codeByLang[language] ?? templateFor(language);
  const sourceTooLong = code.length > MAX_SOURCE_CHARS;
  const stdinTooLong = stdin.length > MAX_STDIN_CHARS;
  const sqlBusy = job.phase === 'starting' || job.phase === 'polling';
  const terminalBusy = ['connecting', 'preparing', 'compiling', 'running', 'waiting', 'stopping'].includes(terminalStatus);
  const busy = batch ? sqlBusy : terminalBusy;
  const result = job.job;
  const status = replayMode && job.phase === 'done' && replayView(result).waiting ? { label: 'Waiting for input', tone: 'running' } : batch ? getExecutionStatus(job.phase, result, job.error) : getTerminalStatus(terminalStatus);
  const canRun = Boolean(language) && code.trim().length > 0 && !sourceTooLong && (!batch || !stdinTooLong) && !busy;
  const outputText = batch
    ? [result?.compileOutput, result?.stdout, result?.stderr].filter(Boolean).join('\n')
    : terminalChunks.map((chunk) => chunk.data).join('');
  const failed = batch
    ? job.phase === 'error' || result?.state === 'FAILED' || ['COMPILATION_ERROR', 'RUNTIME_ERROR', 'TIME_LIMIT_EXCEEDED'].includes(result?.status)
    : ['error', 'timed_out', 'disconnected', 'compile_error', 'memory_limit'].includes(terminalStatus);

  const view = replayMode && job.phase === 'done' ? replayView(result) : { text: '', waiting: false };
  const waitingForInput = view.waiting;
  const replayText = replay.count > 0 && view.text.startsWith(replay.prevRaw)
    ? replay.committed + view.text.slice(replay.prevRaw.length).replace(/^[ \t]/, '')
    : view.text;

  useEffect(() => {
    if (waitingForInput) terminalInputRef.current?.focus({ preventScroll: true });
  }, [waitingForInput]);

  const appendTerminal = useCallback((data, stream = 'stdout') => {
    if (!data) return;
    setTerminalChunks((previous) => {
      const next = [...previous, { data, stream }];
      let total = next.reduce((sum, item) => sum + item.data.length, 0);
      while (total > 200_000 && next.length > 1) total -= next.shift().data.length;
      return next;
    });
  }, []);

  useEffect(() => {
    if (activeView === 'console' && outputRef.current) {
      outputRef.current.scrollTop = outputRef.current.scrollHeight;
    }
  }, [activeView, job.phase, result?.stdout, result?.stderr, result?.compileOutput, terminalChunks, terminalStatus]);

  useEffect(() => {
    // Focus the input line as soon as the program runs, not only when "waiting" is reported: the runner cannot detect a
    // blocked read for every runtime (for example Node or Go), and a person who pressed Run expects to be able to type.
    if (!['running', 'waiting'].includes(terminalStatus)) return undefined;
    if (typeof window.requestAnimationFrame !== 'function') {
      terminalInputRef.current?.focus();
      return undefined;
    }
    const frame = window.requestAnimationFrame(() => terminalInputRef.current?.focus({ preventScroll: true }));
    return () => window.cancelAnimationFrame(frame);
  }, [terminalStatus]);

  // Clicking the console puts the cursor on the input line (unless the person is selecting text to copy).
  const focusTerminalInput = useCallback(() => {
    if (window.getSelection?.()?.toString()) return;
    terminalInputRef.current?.focus({ preventScroll: true });
  }, []);

  const stopInteractive = useCallback(() => {
    const socket = socketRef.current;
    if (!socket || socket.readyState !== WebSocket.OPEN) return;
    setTerminalStatus('stopping');
    socket.send(JSON.stringify({ type: 'stop' }));
  }, []);

  const runCode = useCallback(async () => {
    if (!canRun) return;
    setCopied(false);
    // Keep the current workspace view when Run is clicked. Desktop shows editor and console side by side;
    // on mobile, the user can choose the Console tab unless the program is waiting for interactive input.
    if (replayMode) {
      // Replay style: a fresh Run starts with no input; each value typed afterwards re-runs the program (see submitReplayInput).
      setReplay(EMPTY_REPLAY);
      setTerminalDraft('');
      job.start('terminal', { language, sourceCode: code, stdin: '' });
      return;
    }
    if (batch) {
      job.start('terminal', { language, sourceCode: code, stdin });
      return;
    }
    job.reset();

    const generation = ++generationRef.current;
    const previous = socketRef.current;
    socketRef.current = null;
    if (previous && previous.readyState < WebSocket.CLOSING) previous.close();
    setTerminalChunks([]);
    setTerminalDraft('');
    setTerminalStatus('connecting');
    try {
      const response = await api.post('/terminal/sessions', { language });
      if (generation !== generationRef.current) return;
      const { sessionId, token } = response.data ?? {};
      if (!sessionId || !token) throw new Error('The terminal service returned an invalid session.');
      const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
      const socket = new WebSocket(`${protocol}//${window.location.host}/terminal-ws/${encodeURIComponent(sessionId)}`);
      socketRef.current = socket;
      let ended = false; // true once the runner reported an exit/error, so a later close is not a lost connection
      socket.onopen = () => {
        if (generation !== generationRef.current) { socket.close(); return; }
        socket.send(JSON.stringify({ type: 'auth', token }));
      };
      socket.onmessage = (event) => {
        if (generation !== generationRef.current) return;
        let message;
        try { message = JSON.parse(event.data); } catch { appendTerminal('\nReceived an invalid message from the execution service.\n', 'stderr'); setTerminalStatus('error'); return; }
        if (message.type === 'authenticated') {
          socket.send(JSON.stringify({ type: 'start', language, sourceCode: code }));
        } else if (message.type === 'status') {
          setTerminalStatus(['preparing', 'compiling', 'waiting'].includes(message.state) ? message.state : 'running');
        } else if (message.type === 'output') {
          appendTerminal(message.data, message.stream === 'stderr' ? 'stderr' : 'stdout');
        } else if (message.type === 'error') {
          appendTerminal(`${message.message || 'Execution error.'}\n`, 'stderr');
          setTerminalStatus('error');
        } else if (message.type === 'exit') {
          ended = true;
          const bar = '\n────────────────────────────────────────────\n';
          const code = Number.isInteger(message.exitCode) ? message.exitCode : null;
          if (message.state === 'finished') {
            appendTerminal(`${bar}● Process finished with exit code ${code ?? 0}\n`, 'system');
            setTerminalStatus('finished');
          } else if (message.state === 'timed_out') {
            appendTerminal(`\n${message.message || 'Process timed out.'}\n`, 'stderr');
            setTerminalStatus('timed_out');
          } else if (message.state === 'stopped') {
            appendTerminal('\nProcess stopped.\n', 'system');
            setTerminalStatus('stopped');
          } else if (message.state === 'output_limit') {
            appendTerminal(`\n${message.message || 'Output limit exceeded.'}\n`, 'stderr');
            setTerminalStatus('error');
          } else if (message.state === 'memory_limit') {
            appendTerminal(`${bar}● ${message.message || 'Memory limit exceeded.'}${code != null ? ` (exit code ${code})` : ''}\n`, 'stderr');
            setTerminalStatus('memory_limit');
          } else if (message.state === 'busy') {
            appendTerminal(`\n${message.message || 'The interactive runner is busy. Try again shortly.'}\n`, 'stderr');
            setTerminalStatus('error');
          } else if (message.state === 'error' && message.phase === 'compile') {
            appendTerminal(`${bar}● Compilation failed${code != null ? ` with exit code ${code}` : ''}\n`, 'stderr');
            setTerminalStatus('compile_error');
          } else {
            if (message.message) appendTerminal(`\n${message.message}\n`, 'stderr');
            if (code != null) appendTerminal(`${bar}● Process finished with exit code ${code}\n`, 'stderr');
            setTerminalStatus('error');
          }
          if (socketRef.current === socket) socketRef.current = null;
        }
      };
      socket.onerror = () => {
        if (generation === generationRef.current && !ended) {
          ended = true;
          appendTerminal('\nCould not connect to the interactive execution service.\n', 'stderr');
          setTerminalStatus('error');
        }
      };
      socket.onclose = () => {
        if (socketRef.current === socket) socketRef.current = null;
        if (generation === generationRef.current && !ended) {
          // The connection dropped while the program was still running: its container is destroyed by the runner.
          ended = true;
          appendTerminal('\nThe connection to the execution service was lost, so the program was stopped. Press Run to start it again.\n', 'stderr');
          setTerminalStatus('disconnected');
        }
      };
    } catch (error) {
      if (generation !== generationRef.current) return;
      const status = error?.response?.status;
      if (status === 503 && !oneShot) {
        // No interactive runner on this host: switch to the one-shot compiler and run the code that way.
        setOneShot(true);
        setTerminalStatus('idle');
        job.start('terminal', { language, sourceCode: code, stdin });
        return;
      }
      const text = status === 403 ? FORBIDDEN_MESSAGE
        : status === 429 ? 'The interactive runner is busy or you are sending requests too fast. Wait a moment and try again.'
        : error?.response?.data?.message || (error?.response ? null : error?.message) || 'Interactive execution is unavailable.';
      appendTerminal(`\n${text}\n`, 'stderr');
      setTerminalStatus('error');
    }
  }, [appendTerminal, batch, canRun, code, job, language, oneShot, replayMode, stdin]);

  const submitReplayInput = (event) => {
    if (event.key !== 'Enter' || event.shiftKey) return;
    event.preventDefault();
    if (!waitingForInput || replay.count >= MAX_REPLAY_INPUTS) return;
    const line = terminalDraft;
    const inputs = [...replay.inputs, line];
    setReplay({ committed: `${replayText.replace(/\s+$/, '')} ${line}\n`, prevRaw: view.text.replace(/\s+$/, ''), count: inputs.length, inputs });
    setTerminalDraft('');
    job.start('terminal', { language, sourceCode: code, stdin: `${inputs.join('\n')}\n` });
  };

  const submitTerminalInput = (event) => {
    // Ctrl+D (Cmd+D is left to the browser) ends standard input, like a real terminal. Programs that read until
    // end-of-input need it to finish.
    if (event.key.toLowerCase() === 'd' && event.ctrlKey && !event.metaKey && !event.altKey) {
      event.preventDefault();
      const eofSocket = socketRef.current;
      if (eofSocket && eofSocket.readyState === WebSocket.OPEN && ['running', 'waiting'].includes(terminalStatus)) {
        appendTerminal('^D\n', 'input');
        eofSocket.send(JSON.stringify({ type: 'eof' }));
      }
      return;
    }
    if (event.key !== 'Enter' || event.shiftKey) return;
    event.preventDefault();
    const socket = socketRef.current;
    if (!socket || socket.readyState !== WebSocket.OPEN || !['running', 'waiting'].includes(terminalStatus)) return;
    const line = terminalDraft;
    appendTerminal(`${line}\n`, 'input');
    socket.send(JSON.stringify({ type: 'input', data: `${line}\n` }));
    setTerminalDraft('');
  };

  const resetCode = () => {
    setReplay(EMPTY_REPLAY);
    if (socketRef.current) {
      const socket = socketRef.current;
      socketRef.current = null;
      try { if (socket.readyState === WebSocket.OPEN) socket.send(JSON.stringify({ type: 'stop' })); } catch { /* Ignore shutdown race. */ }
      socket.close();
    }
    generationRef.current += 1;
    setCodeByLang((previous) => {
      const next = { ...previous };
      delete next[language];
      return next;
    });
    setStdin('');
    setTerminalDraft('');
    setTerminalChunks([]);
    setTerminalStatus('idle');
    job.reset();
    setCopied(false);
    setActiveView('editor');
  };

  const clearConsole = () => {
    if (busy) return;
    if (batch) { job.reset(); setReplay(EMPTY_REPLAY); }
    setStdin('');
    setTerminalChunks([]);
    setTerminalDraft('');
    setCopied(false);
  };

  const copyOutput = async () => {
    setCopied(await copyText(outputText));
    window.setTimeout(() => setCopied(false), 1800);
  };

  const downloadOutput = () => {
    const blob = new Blob([outputText], { type: 'text/plain;charset=utf-8' });
    const url = URL.createObjectURL(blob);
    const anchor = document.createElement('a');
    anchor.href = url;
    anchor.download = `teacode-${language || 'console'}-output.txt`;
    document.body.appendChild(anchor);
    anchor.click();
    anchor.remove();
    URL.revokeObjectURL(url);
  };

  const renderConsole = () => {
    if (replayMode) {
      const running = job.phase === 'starting' || job.phase === 'polling';
      if (job.phase === 'idle' && !replay.committed) {
        return <Box sx={{ py: 2, color: '#A8A29C' }}><Typography sx={{ fontFamily: MONO_FONT, fontSize: 13 }}>Ready to run.</Typography><Typography sx={{ mt: 0.75, fontSize: 12, lineHeight: 1.65 }}>Write your code and click Run. If the program asks for input, type it here after the prompt and press Enter. Each input runs the program again with your values, so every step uses one run of the daily limit.</Typography></Box>;
      }
      const shown = job.phase === 'done' && result?.state !== 'FAILED' ? replayText : replay.committed;
      const finished = job.phase === 'done' && result?.state !== 'FAILED' && !waitingForInput;
      return (
        <Box aria-live="polite">
          <Box component="pre" onClick={() => terminalInputRef.current?.focus({ preventScroll: true })} sx={{ m: 0, minHeight: 120, fontFamily: MONO_FONT, fontSize: 13, lineHeight: 1.65, whiteSpace: 'pre-wrap', overflowWrap: 'anywhere', tabSize: 4, color: '#e3eae5' }}>
            {shown}
            {waitingForInput && <Box component="input" ref={terminalInputRef} aria-label="Program input" autoComplete="off" autoCapitalize="off" spellCheck="false" value={terminalDraft} onChange={(event) => setTerminalDraft(event.target.value)} onKeyDown={submitReplayInput} sx={{ display: 'inline-block', verticalAlign: 'baseline', width: `${Math.max(1, Math.min(70, terminalDraft.length + 1))}ch`, maxWidth: '100%', minWidth: '1ch', p: 0, m: 0, border: 0, outline: 0, borderRadius: 0, bgcolor: 'transparent', color: '#9ecbff', font: 'inherit', caretColor: '#E07B54' }} />}
          </Box>
          {running && <Stack direction="row" spacing={1.25} alignItems="center" role="status" sx={{ py: 1, color: '#A8A29C' }}><CircularProgress size={16} sx={{ color: '#E07B54' }} /><Typography sx={{ fontSize: 13 }}>Running your code...</Typography></Stack>}
          {job.phase === 'error' && <Alert variant="outlined" severity={job.error?.kind === 'service' ? 'warning' : 'error'} role="alert" sx={{ fontSize: 13, mt: 1 }}>{ERROR_TEXT[job.error?.kind] ?? ERROR_TEXT.other}</Alert>}
          {job.phase === 'done' && result?.state === 'FAILED' && <Alert severity="error" variant="outlined" role="alert" sx={{ fontSize: 13, mt: 1 }}>{ERROR_TEXT[CODE_KIND[result.errorCode] ?? 'other']}</Alert>}
          {waitingForInput && <Typography sx={{ mt: 1, color: '#A8A29C', fontSize: 11 }}>The program is waiting for input. Type it above and press Enter. Run starts again from the beginning.</Typography>}
          {finished && <Box sx={{ mt: 2, pt: 1.25, borderTop: `1px solid ${T(BORDER)}`, color: '#A8A29C', fontFamily: MONO_FONT, fontSize: 11 }}>{status.label}{result?.executionTimeMs != null ? ` - ${result.executionTimeMs} ms` : ''}{result?.memoryKb != null ? ` - ${result.memoryKb} KB` : ''}</Box>}
          {finished && replayText && <Stack direction="row" alignItems="center" spacing={1} sx={{ mt: 1.5 }}><Button size="small" startIcon={<ContentCopyRoundedIcon />} onClick={async () => { setCopied(await copyText(replayText)); window.setTimeout(() => setCopied(false), 1800); }} sx={{ color: '#E07B54', textTransform: 'none', minHeight: 32 }}>Copy output</Button><Typography role="status" sx={{ color: '#A8A29C', fontSize: 11 }}>{copied ? 'Copied' : ''}</Typography></Stack>}
        </Box>
      );
    }
    if (!batch) {
      if (terminalStatus === 'idle' && terminalChunks.length === 0) {
        return <Box sx={{ py: 2, color: '#A8A29C' }}><Typography sx={{ fontFamily: MONO_FONT, fontSize: 13 }}>Ready to run.</Typography><Typography sx={{ mt: 0.75, fontSize: 12, lineHeight: 1.65 }}>Program prompts, standard output, and runtime errors appear here. When the program is running, type directly after its prompt and press Enter.</Typography></Box>;
      }
      return (
        <Box aria-live="polite">
          {(terminalStatus === 'connecting' || terminalStatus === 'preparing') && <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 1, color: '#A8A29C' }}><CircularProgress size={14} sx={{ color: '#E07B54' }} /><Typography sx={{ fontSize: 12 }}>{terminalStatus === 'connecting' ? 'Connecting to interactive runner…' : 'Preparing isolated runtime…'}</Typography></Stack>}
          <Box component="pre" onClick={focusTerminalInput} sx={{ m: 0, minHeight: 180, fontFamily: MONO_FONT, fontSize: 13, lineHeight: 1.65, whiteSpace: 'pre-wrap', overflowWrap: 'anywhere', tabSize: 4, color: '#e3eae5' }}>
            {terminalChunks.map((chunk, index) => <Box component="span" key={`${index}-${chunk.data.length}`} sx={{ color: chunk.stream === 'stderr' ? '#ff8c85' : chunk.stream === 'system' ? '#7ddc95' : chunk.stream === 'input' ? '#9ecbff' : '#e3eae5' }}>{chunk.data}</Box>)}
            {['running', 'waiting'].includes(terminalStatus) && <Box component="input" ref={terminalInputRef} aria-label="Terminal input" autoComplete="off" autoCapitalize="off" spellCheck="false" value={terminalDraft} onChange={(event) => setTerminalDraft(event.target.value)} onKeyDown={submitTerminalInput} sx={{ display: 'inline-block', verticalAlign: 'baseline', width: `${Math.max(1, Math.min(70, terminalDraft.length + 1))}ch`, maxWidth: '100%', minWidth: '1ch', p: 0, m: 0, border: 0, outline: 0, borderRadius: 0, bgcolor: 'transparent', color: '#ffffff', font: 'inherit', caretColor: '#E07B54' }} />}
          </Box>
          {terminalStatus === 'finished' && terminalChunks.length === 0 && <Typography sx={{ color: '#A8A29C', fontSize: 13 }}>The program finished without output.</Typography>}
          {outputText && <Stack direction="row" alignItems="center" spacing={1} sx={{ mt: 1.5 }}><Button size="small" startIcon={<ContentCopyRoundedIcon />} onClick={copyOutput} sx={{ color: '#E07B54', textTransform: 'none', minHeight: 32 }}>Copy output</Button><Button size="small" startIcon={<DownloadRoundedIcon />} onClick={downloadOutput} sx={{ color: '#A8A29C', textTransform: 'none', minHeight: 32 }}>Download</Button><Typography role="status" sx={{ color: '#A8A29C', fontSize: 11 }}>{copied ? 'Copied' : ''}</Typography></Stack>}
        </Box>
      );
    }

    if (job.phase === 'idle') return <Box sx={{ py: 2, color: '#A8A29C' }}><Typography sx={{ fontFamily: MONO_FONT, fontSize: 13 }}>Ready to run.</Typography><Typography sx={{ mt: 0.75, fontSize: 12, lineHeight: 1.65 }}>{(BATCH_ALL || oneShot) ? 'Write your code, type any input for your program at the top of this console, then click Run. The output appears here.' : "SQL uses the configured compiler's existing one-shot execution path."}</Typography></Box>;
    if (job.phase === 'starting' || job.phase === 'polling') return <Stack direction="row" spacing={1.25} alignItems="center" role="status" aria-live="polite" sx={{ py: 1, color: '#A8A29C' }}><CircularProgress size={16} sx={{ color: '#E07B54' }} /><Typography sx={{ fontSize: 13 }}>{job.phase === 'starting' ? 'Submitting code to the execution service…' : result?.state === 'RUNNING' ? 'Execution service is running your code…' : 'Waiting for the execution service…'}</Typography></Stack>;
    if (job.phase === 'error') return <Alert variant="outlined" severity={job.error?.kind === 'service' ? 'warning' : 'error'} role="alert" sx={{ fontSize: 13 }}>{ERROR_TEXT[job.error?.kind] ?? ERROR_TEXT.other}</Alert>;
    if (result?.state === 'FAILED') return <Alert severity="error" variant="outlined" role="alert" sx={{ fontSize: 13 }}>{ERROR_TEXT[CODE_KIND[result.errorCode] ?? 'other']}</Alert>;
    return <Box aria-live="polite">{result?.compileOutput && <OutputLine label="Compiler output" value={result.compileOutput} tone="error" />}{result?.stdout && <OutputLine label="Program output" value={result.stdout} tone={failed ? 'error' : 'normal'} />}{result?.stderr && <OutputLine label="Standard error" value={result.stderr} tone="error" />}{!result?.compileOutput && !result?.stdout && !result?.stderr && <Typography sx={{ color: '#A8A29C', fontSize: 13 }}>The program finished without output.</Typography>}<Box sx={{ mt: 2, pt: 1.25, borderTop: `1px solid ${T(BORDER)}`, color: '#A8A29C', fontFamily: MONO_FONT, fontSize: 11 }}>{status.label}{result?.executionTimeMs != null ? ` · ${result.executionTimeMs} ms` : ''}{result?.memoryKb != null ? ` · ${result.memoryKb} KB` : ''}</Box>{outputText && <Stack direction="row" alignItems="center" spacing={1} sx={{ mt: 1.5 }}><Button size="small" startIcon={<ContentCopyRoundedIcon />} onClick={copyOutput} sx={{ color: '#E07B54', textTransform: 'none', minHeight: 32 }}>Copy output</Button><Button size="small" startIcon={<DownloadRoundedIcon />} onClick={downloadOutput} sx={{ color: '#A8A29C', textTransform: 'none', minHeight: 32 }}>Download</Button><Typography role="status" sx={{ color: '#A8A29C', fontSize: 11 }}>{copied ? 'Copied' : ''}</Typography></Stack>}</Box>;
  };

  if (langs.status === 'loading') return <Container maxWidth="xl" sx={{ py: 3 }} aria-busy="true"><Skeleton variant="rounded" height={620} /></Container>;

  if (langs.status === 'error' || languages.length === 0) {
    return <Container maxWidth="xl" sx={{ py: 3 }}><Alert severity="warning" variant="outlined">No executable languages are available right now. Check the execution service configuration and try again.</Alert></Container>;
  }

  return (
    <Box sx={{ minHeight: 'calc(100dvh - 64px)', width: '100%', overflowX: 'hidden', bgcolor: T(CANVAS), color: T(INK), py: { xs: 1.25, md: 2.5 } }}>
      <Container maxWidth="xl" sx={{ px: { xs: 1, sm: 2, lg: 3 } }}>
        <Stack direction="row" alignItems="center" justifyContent="space-between" spacing={2} sx={{ mb: 1.5 }}>
          <Box sx={{ minWidth: 0 }}>
            <Typography component="h1" sx={{ fontSize: { xs: 21, sm: 25 }, fontWeight: 700, letterSpacing: '-0.02em', lineHeight: 1.2 }}>Online Compiler</Typography>
            <Typography sx={{ mt: 0.5, color: T(MUTED), fontSize: { xs: 11, sm: 12 } }}>Write, run, and inspect your code.</Typography>
          </Box>
          <Box sx={{ display: { xs: 'none', sm: 'flex' }, alignItems: 'center', gap: 0.75, color: T(MUTED), fontSize: 12 }}><TerminalRoundedIcon sx={{ fontSize: 18 }} /><span>TeaCode Terminal</span></Box>
        </Stack>

        <Paper elevation={0} aria-label="Online compiler workspace" sx={{ overflow: 'hidden', border: `1px solid ${T(BORDER)}`, borderRadius: 3, bgcolor: T(SURFACE), boxShadow: 'none' }}>
          <Box sx={{ minHeight: 72, px: { xs: 1.25, sm: 2 }, py: 1.75, display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: 1, borderBottom: `1px solid ${T(BORDER)}`, bgcolor: T('#141415') }}>
            <Stack direction="row" spacing={1} alignItems="center" sx={{ minWidth: 0, flex: '1 1 220px' }}>
              <LanguageIcon language={selectedLanguage?.key} size={20} />
              <Autocomplete
                size="small"
                sx={{
                  width: { xs: 155, sm: 205 }, maxWidth: '100%',
                  '& .MuiOutlinedInput-root': { py: 0.15, borderRadius: '10px', bgcolor: '#0B0B0C', color: INK, '& fieldset': { borderColor: BORDER }, '&.Mui-focused fieldset': { borderColor: '#E07B54' } },
                  '& .MuiInputLabel-root': { fontSize: 13, color: MUTED, '&.Mui-focused': { color: '#E07B54' } },
                  '& .MuiSvgIcon-root': { color: MUTED },
                }}
                options={languages}
                value={selectedLanguage ?? null}
                disableClearable
                disabled={busy}
                getOptionLabel={(item) => item.name}
                isOptionEqualToValue={(a, b) => a.key === b.key}
                onChange={(_, item) => selectLanguage(item.key)}
                renderOption={(props, item) => {
                  const { key, ...rest } = props;
                  return <li key={key} {...rest}><LanguageIcon language={item.key} size={18} /><Box component="span" sx={{ ml: 1.25 }}>{item.name}</Box>{item.version ? <Box component="span" sx={{ ml: 1, color: T(MUTED), fontSize: 11 }}>{item.version}</Box> : null}</li>;
                }}
                renderInput={(params) => <TextField {...params} label="Language" />}
              />
              <Typography sx={{ display: { xs: 'none', lg: 'block' }, color: T(MUTED), fontFamily: MONO_FONT, fontSize: 11, whiteSpace: 'nowrap' }}>{selectedLanguage?.extension ? `main${selectedLanguage.extension}` : 'source'}</Typography>
            </Stack>
            <Stack direction="row" spacing={0.75} alignItems="center" sx={{ flexWrap: 'nowrap', ml: 'auto' }}>
              <Tooltip title={batch ? 'One-shot runs cannot be cancelled.' : 'Terminate the current interactive process.'}>
                <span><Button size="small" disabled={batch || !terminalBusy} onClick={stopInteractive} startIcon={<StopRoundedIcon />} sx={{ minWidth: 0, px: { xs: 0.75, sm: 1.25 }, minHeight: 36, color: INK, textTransform: 'none', '&.Mui-disabled': { color: MUTED, opacity: 0.65 } }} aria-label={batch ? 'Stop execution (unsupported for one-shot runs)' : 'Stop execution'}>Stop</Button></span>
              </Tooltip>
              <Button size="small" disabled={batch && sqlBusy} onClick={resetCode} startIcon={<RestartAltRoundedIcon />} sx={{ minWidth: 0, px: { xs: 0.75, sm: 1.25 }, minHeight: 36, color: INK, textTransform: 'none', '&.Mui-disabled': { color: MUTED, opacity: 0.65 } }}>Reset</Button>
              <Button variant="contained" size="small" disabled={!canRun} onClick={runCode} startIcon={busy ? <CircularProgress size={14} color="inherit" /> : <PlayArrowRoundedIcon />} sx={{ minHeight: 36, px: { xs: 1.25, sm: 1.75 }, bgcolor: '#E07B54', color: '#0B0B0C', fontWeight: 700, textTransform: 'none', boxShadow: 'none', '&:hover': { bgcolor: '#EE8C66', boxShadow: 'none' }, '&.Mui-disabled': { bgcolor: 'rgba(224,123,84,.22)', color: '#8f857e' } }}>{busy ? 'Running' : 'Run'}</Button>
            </Stack>
          </Box>

          <Box ref={workspaceRef} sx={{ display: 'grid', gridTemplateColumns: isMobile ? 'minmax(0, 1fr)' : `minmax(0, ${split}fr) 8px minmax(0, ${100 - split}fr)`, minHeight: isMobile ? 'auto' : 640, bgcolor: T('#0B0B0C') }}>
            <Box sx={{ minWidth: 0, display: isMobile && activeView !== 'editor' ? 'none' : 'flex', flexDirection: 'column', p: 0, border: `1px solid ${T(BORDER)}`, borderRadius: 0, overflow: 'hidden', bgcolor: T('#0B0B0C'), '& .MuiAutocomplete-root': { display: 'none' }, '& .MuiOutlinedInput-root': { bgcolor: T(SURFACE) }, '& .MuiOutlinedInput-notchedOutline': { borderColor: T(BORDER) }, '& .MuiButton-outlined': { borderColor: T(BORDER), color: T('#475569') } }}>
              <Stack direction="row" alignItems="center" justifyContent="space-between" sx={{ mb: 0, minHeight: 47, px: 1.75, flexShrink: 0, bgcolor: T('#141415'), borderBottom: `1px solid ${T(BORDER)}` }}>
                <Stack direction="row" spacing={0.75} alignItems="center"><CodeRoundedIcon sx={{ fontSize: 16, color: T(MUTED) }} /><Typography sx={{ fontSize: 11, fontWeight: 800, letterSpacing: '.08em', textTransform: 'uppercase', color: T('#C5CFDD') }}>Code Editor</Typography></Stack>
                <Typography sx={{ color: T(MUTED), fontSize: 11 }}>{selectedLanguage?.extension ? `main${selectedLanguage.extension}` : 'source'} · {code.split('\n').length} lines</Typography>
              </Stack>
              <Box sx={{ border: 0, borderRadius: 0, overflow: 'hidden', flex: '1 1 auto', minHeight: isMobile ? 420 : 590, bgcolor: '#0B0B0C' }}>
                <Editor
                  height={isMobile ? 'min(68dvh, 620px)' : '590px'}
                  path={`terminal.${language}`}
                  language={monacoLanguage(language)}
                  value={code}
                  theme="vs-dark"
                  onChange={(value) => setCodeByLang((previous) => ({ ...previous, [language]: value ?? '' }))}
                  options={{ fontSize: EDITOR_FONT_SIZE, automaticLayout: true, minimap: { enabled: false }, scrollBeyondLastLine: false, tabSize: 4, ariaLabel: 'Code editor', padding: { top: 16, bottom: 16 }, roundedSelection: false, overviewRulerBorder: false, scrollbar: { verticalScrollbarSize: 10, horizontalScrollbarSize: 10 } }}
                  loading="Loading editor…"
                />
              </Box>
              {sourceTooLong && <Alert severity="error" variant="outlined" sx={{ mt: 1, fontSize: 12 }}>Source exceeds the {MAX_SOURCE_CHARS.toLocaleString()} character limit.</Alert>}
            </Box>

            <Box role="separator" aria-label="Resize editor and console panels" aria-orientation="vertical" tabIndex={0}
              onPointerDown={(event) => { if (isMobile) return; dragging.current = true; document.body.style.cursor = 'col-resize'; document.body.style.userSelect = 'none'; event.preventDefault(); }}
              onKeyDown={(event) => { if (event.key === 'ArrowLeft') setSplit((value) => Math.max(30, value - 2)); if (event.key === 'ArrowRight') setSplit((value) => Math.min(70, value + 2)); }}
              sx={{ display: isMobile ? 'none' : 'block', cursor: 'col-resize', touchAction: 'none', bgcolor: T('#141415'), borderLeft: `1px solid ${T(BORDER)}`, borderRight: `1px solid ${T(BORDER)}`, position: 'relative', outlineOffset: -2, '&::after': { content: '""', position: 'absolute', width: 2, height: 40, top: '50%', left: '50%', transform: 'translate(-50%, -50%)', borderRadius: 2, bgcolor: '#6b6560' }, '&:hover::after, &:focus-visible::after': { bgcolor: T(ACCENT) } }}
            />

            <Box sx={{ minWidth: 0, display: isMobile && activeView !== 'console' ? 'none' : 'flex', flexDirection: 'column', borderLeft: { xs: 0, md: 0 }, borderTop: { xs: `1px solid ${T(BORDER)}`, md: 0 }, minHeight: isMobile ? 'min(68dvh, 680px)' : 610, bgcolor: '#0B0B0C', border: `1px solid ${T(BORDER)}`, borderRadius: 0 }}>
              <Box sx={{ minHeight: 47, px: 1.5, display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 1, borderBottom: '1px solid #2A2A2E', bgcolor: '#141415' }}>
                <Stack direction="row" spacing={0.75} alignItems="center"><TerminalRoundedIcon sx={{ fontSize: 17, color: '#A8A29C' }} /><Typography sx={{ color: '#c8d6cc', fontSize: 11, fontWeight: 800, letterSpacing: '.08em', textTransform: 'uppercase' }}>Console</Typography></Stack>
                <Stack direction="row" spacing={1} alignItems="center">
                  <StatusIndicator status={status} />
                  <Tooltip title="Clear console history">
                    <span><IconButton size="small" aria-label="Clear console" disabled={busy} onClick={clearConsole} sx={{ color: '#A8A29C', borderRadius: 1, '&.Mui-disabled': { color: '#4d5d52' } }}><DeleteSweepOutlinedIcon fontSize="small" /></IconButton></span>
                  </Tooltip>
                </Stack>
              </Box>

              <Box ref={outputRef} sx={{ flex: '1 1 auto', minHeight: 190, p: { xs: 1.5, sm: 2 }, overflow: 'auto', overscrollBehavior: 'contain', bgcolor: '#0B0B0C', fontFamily: MONO_FONT, fontSize: 13 }}>
                {batch && !replayMode && (
                  <Box sx={{ mb: 1.5, pb: 1.25, borderBottom: '1px dashed #2A2A2E' }}>
                    <Typography component="label" htmlFor="terminal-stdin" sx={{ display: 'block', color: '#7ddc95', fontFamily: MONO_FONT, fontSize: 11.5, mb: 0.5 }}>Input (one value per line, before you click Run)</Typography>
                    <Box component="textarea" id="terminal-stdin" value={stdin} onChange={(event) => setStdin(event.target.value)} rows={2} spellCheck="false" disabled={busy} placeholder="Type the input your program reads, then click Run" sx={{ width: '100%', boxSizing: 'border-box', resize: 'vertical', p: 0, m: 0, border: 0, outline: 0, bgcolor: 'transparent', color: '#9ecbff', fontFamily: MONO_FONT, fontSize: 13, lineHeight: 1.65, '&::placeholder': { color: '#6b7a70' } }} />
                    {stdinTooLong && <Typography sx={{ color: '#ff8c85', fontSize: 11, mt: 0.5 }}>The input is too long.</Typography>}
                  </Box>
                )}
                {renderConsole()}
              </Box>

              {!batch && <Box sx={{ px: 1.5, py: 1, borderTop: '1px solid #2A2A2E', bgcolor: '#141415' }}>
                <Typography sx={{ color: '#A8A29C', fontSize: 10.5, lineHeight: 1.6 }}>
                  {['running', 'waiting'].includes(terminalStatus)
                    ? 'Type directly after the program prompt and press Enter. Empty lines are submitted as input too. Press Ctrl+D to end input.'
                    : 'Interactive input appears directly on the terminal line while the program is running.'}
                </Typography>
              </Box>}
            </Box>
          </Box>

          <Box sx={{ display: isMobile ? 'flex' : 'none', position: 'sticky', bottom: 0, zIndex: 2, gap: 0.75, p: 0.75, pb: 'calc(8px + env(safe-area-inset-bottom))', borderTop: `1px solid ${T(BORDER)}`, bgcolor: '#141415' }}>
            <Button fullWidth onClick={() => setActiveView('editor')} startIcon={<CodeRoundedIcon />} aria-pressed={activeView === 'editor'} sx={{ minHeight: 42, borderRadius: 1.5, color: activeView === 'editor' ? T(ACCENT) : T(MUTED), bgcolor: activeView === 'editor' ? 'rgba(224,123,84,.14)' : 'transparent', fontWeight: activeView === 'editor' ? 750 : 600, textTransform: 'none', '&:hover': { bgcolor: 'rgba(255,255,255,.06)' } }}>Editor</Button>
            <Button fullWidth onClick={() => setActiveView('console')} startIcon={<TerminalRoundedIcon />} aria-pressed={activeView === 'console'} sx={{ minHeight: 42, borderRadius: 1.5, color: activeView === 'console' ? T(ACCENT) : T(MUTED), bgcolor: activeView === 'console' ? 'rgba(224,123,84,.14)' : 'transparent', fontWeight: activeView === 'console' ? 750 : 600, textTransform: 'none', '&:hover': { bgcolor: 'rgba(255,255,255,.06)' } }}>Console</Button>
            {isMobile && (
              <Button
                variant="contained"
                disabled={!batch && terminalBusy ? false : !canRun}
                onClick={() => { if (!batch && terminalBusy) stopInteractive(); else runCode(); }}
                aria-label={!batch && terminalBusy ? 'Stop program' : 'Run program'}
                startIcon={!batch && terminalBusy ? <StopRoundedIcon /> : <PlayArrowRoundedIcon />}
                sx={{ flex: '0 0 auto', minHeight: 42, px: 2, borderRadius: 1.5, bgcolor: '#E07B54', color: '#0B0B0C', fontWeight: 700, textTransform: 'none', boxShadow: 'none', '&:hover': { bgcolor: '#EE8C66', boxShadow: 'none' }, '&.Mui-disabled': { bgcolor: 'rgba(224,123,84,.22)', color: '#8f857e' } }}
              >{!batch && terminalBusy ? 'Stop' : 'Run'}</Button>
            )}
          </Box>
        </Paper>

        <Stack direction="row" alignItems="center" justifyContent="space-between" spacing={1} sx={{ px: 0.5, pt: 1.25, color: T(MUTED), fontSize: 11 }}>
          <Stack direction="row" alignItems="center" spacing={0.75}><StatusIndicator status={status} /><Typography sx={{ fontSize: 11, color: T(MUTED) }}>{selectedLanguage?.name ?? 'No language selected'}</Typography></Stack>
          <Typography sx={{ display: { xs: 'none', sm: 'block' }, fontSize: 11, color: T(MUTED) }}>{code.split('\n').length} lines · {code.length.toLocaleString()} chars</Typography>
        </Stack>
        <Typography component="p" sx={{ px: 0.5, pt: 0.5, pb: 1.5, fontSize: 11, color: T(MUTED), textAlign: 'center' }}>Backend developed by <DeveloperName forceDark /></Typography>

      </Container>
    </Box>
  );
}