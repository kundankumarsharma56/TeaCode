import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { Alert, Box, Button, Container, IconButton, Paper, Skeleton, Stack, Tooltip, Typography, useMediaQuery } from '@mui/material';
import { useTheme } from '@mui/material/styles';
import { Link as RouterLink, useParams } from 'react-router-dom';
import PlayArrowIcon from '@mui/icons-material/PlayArrow';
import SendIcon from '@mui/icons-material/Send';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import DescriptionOutlinedIcon from '@mui/icons-material/DescriptionOutlined';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import ExpandLessIcon from '@mui/icons-material/ExpandLess';
import HistoryIcon from '@mui/icons-material/History';
import { useApiData } from '../../hooks/useApiData.js';
import { useAuth } from '../../hooks/useAuth.js';
import ProblemPanel from './ProblemPanel.jsx';
import EditorPanel from './EditorPanel.jsx';
import ResultsPanel from './ResultsPanel.jsx';
import { useJob } from './useJob.js';
import { useTimer } from './useTimer.js';
import SolveTimer from './SolveTimer.jsx';
import { MAX_SOURCE_CHARS } from './languages.js';
import { clearDraft, loadDraft, saveDraft } from './drafts.js';

export { MAX_SOURCE_CHARS };

const SPLIT_KEY = 'teacode.workspace.split';
const SPLIT_MIN = 25;
const SPLIT_MAX = 75;
const SPLIT_DEFAULT = 45;
const clampSplit = (v) => Math.min(SPLIT_MAX, Math.max(SPLIT_MIN, Math.round(v)));

// TeaCode panel surface: thin border, rounded, no shadow, no gradient.
const PANEL_SX = { border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper', boxShadow: 'none', backgroundImage: 'none' };

// A saved width is a per-device convenience only; storage can be blocked or empty, so every access is guarded.
function readSplit() {
  try {
    const n = Number(window.localStorage.getItem(SPLIT_KEY));
    return Number.isFinite(n) && n > 0 ? clampSplit(n) : SPLIT_DEFAULT;
  } catch {
    return SPLIT_DEFAULT;
  }
}
function writeSplit(v) {
  try { window.localStorage.setItem(SPLIT_KEY, String(v)); } catch { /* storage unavailable */ }
}

export default function WorkspacePage() {
  const { slug } = useParams();
  const { user } = useAuth();
  const problem = useApiData(`/problems/${slug}`);
  const starter = useApiData(`/problems/${slug}/starter-code`);
  const langs = useApiData('/execution/languages');
  const job = useJob();
  const timer = useTimer(slug, Boolean(user) && problem.status === 'success');

  const [language, setLanguage] = useState('');
  const [codeByLang, setCodeByLang] = useState({});
  const [fontSize, setFontSize] = useState(14);
  const [resultOpen, setResultOpen] = useState(false);
  const initialised = useRef(false);

  const languages = useMemo(() => (Array.isArray(langs.data) ? langs.data : []), [langs.data]);
  const starterByLang = useMemo(
    () => Object.fromEntries((Array.isArray(starter.data) ? starter.data : []).map((s) => [s.language, s.code])),
    [starter.data],
  );

  useEffect(() => {
    if (!initialised.current && languages.length > 0) {
      initialised.current = true;
      setLanguage(languages[0].key);
    }
  }, [languages]);

  const userId = user?.id ?? user?.email ?? null;
  // Edited in this session, else a saved draft from an earlier visit, else the starter code.
  const draft = useMemo(() => loadDraft(userId, slug, language), [userId, slug, language]);
  const code = codeByLang[language] ?? draft ?? starterByLang[language] ?? '';
  const tooLong = code.length > MAX_SOURCE_CHARS;
  const busy = job.phase === 'starting' || job.phase === 'polling';
  const judgeable = problem.data?.judgeable !== false;
  const languageOk = languages.find((l) => l.key === language)?.kind !== 'DATABASE';
  const canExecute = Boolean(user) && Boolean(language) && code.trim().length > 0 && !tooLong && !busy && judgeable && languageOk;

  const theme = useTheme();
  const isWide = useMediaQuery(theme.breakpoints.up('lg'));
  const [split, setSplit] = useState(readSplit);
  const workspaceRef = useRef(null);
  const dragging = useRef(false);

  // The result panel under the editor opens by itself as soon as a run or submit starts.
  useEffect(() => {
    if (job.phase !== 'idle') setResultOpen(true);
  }, [job.phase]);

  const moveSplit = useCallback((clientX) => {
    const box = workspaceRef.current?.getBoundingClientRect();
    if (!box || box.width <= 0) return;
    setSplit(clampSplit(((clientX - box.left) / box.width) * 100));
  }, []);

  useEffect(() => {
    const move = (e) => { if (dragging.current) moveSplit(e.clientX); };
    const stop = () => {
      if (!dragging.current) return;
      dragging.current = false;
      document.body.style.cursor = '';
      document.body.style.userSelect = '';
      setSplit((v) => { writeSplit(v); return v; });
    };
    window.addEventListener('pointermove', move);
    window.addEventListener('pointerup', stop);
    window.addEventListener('pointercancel', stop);
    return () => {
      window.removeEventListener('pointermove', move);
      window.removeEventListener('pointerup', stop);
      window.removeEventListener('pointercancel', stop);
    };
  }, [moveSplit]);

  const onSplitKey = (e) => {
    const step = e.shiftKey ? 10 : 2;
    let next = null;
    if (e.key === 'ArrowLeft') next = split - step;
    else if (e.key === 'ArrowRight') next = split + step;
    else if (e.key === 'Home') next = SPLIT_MIN;
    else if (e.key === 'End') next = SPLIT_MAX;
    else if (e.key === 'Enter') next = SPLIT_DEFAULT;
    if (next === null) return;
    e.preventDefault();
    const v = clampSplit(next);
    setSplit(v);
    writeSplit(v);
  };

  const execute = (mode) => job.start(mode, { problemSlug: slug, language, sourceCode: code });

  if (problem.status === 'loading' || starter.status === 'loading' || langs.status === 'loading') {
    return <Container maxWidth="xl" sx={{ py: 4 }} aria-busy="true"><Skeleton variant="rounded" height={500} /></Container>;
  }
  if (problem.status === 'error') {
    const notFound = problem.error?.response?.status === 404;
    return (
      <Container maxWidth="md" sx={{ py: 8 }}>
        <Alert severity={notFound ? 'info' : 'error'} variant="outlined" sx={{ mb: 2 }}>{notFound ? 'This problem does not exist or is not available.' : 'The problem could not be loaded. Please try again.'}</Alert>
        <Button component={RouterLink} to="/problems" variant="outlined">Back to problems</Button>
      </Container>
    );
  }

  const editorHeight = 'clamp(320px, 52vh, 600px)';
  const actions = (
    <Stack direction="row" spacing={1} sx={{ ml: 'auto', flex: '0 0 auto' }}>
      <Button variant="outlined" size="small" startIcon={<PlayArrowIcon />} disabled={!canExecute} onClick={() => execute('run')} color="inherit" sx={{ fontWeight: 700, borderRadius: 1.5, px: 1.75, borderColor: 'divider', '&:hover': { borderColor: 'text.secondary', bgcolor: 'action.hover' } }}>Run</Button>
      <Button variant="contained" size="small" startIcon={<SendIcon />} disabled={!canExecute} onClick={() => execute('submit')} sx={{ fontWeight: 700, borderRadius: 1.5, px: 1.75, boxShadow: 'none' }}>Submit</Button>
    </Stack>
  );

  return (
    <Box sx={{ minWidth: 0, display: 'flex', flexDirection: 'column', height: { lg: 'calc(100dvh - 64px)' } }}>
      {/* Slim top bar: back link left, solve timer right. */}
      <Box sx={{ flex: '0 0 auto', borderBottom: '1px solid', borderColor: 'divider', bgcolor: 'background.paper', px: { xs: 1.5, lg: 2 }, py: 0.5, display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 2 }}>
        <Button component={RouterLink} to="/problems" size="small" color="inherit" startIcon={<ArrowBackIcon />} sx={{ color: 'text.secondary', '&:hover': { color: 'text.primary', bgcolor: 'action.hover' } }}>All problems</Button>
        <SolveTimer timer={timer} />
      </Box>

      <Box
        ref={workspaceRef}
        sx={{
          flex: '1 1 auto',
          minHeight: 0,
          display: 'grid',
          gap: { xs: 1.5, lg: 0 },
          p: { xs: 1.5, lg: 1 },
          gridTemplateColumns: { xs: 'minmax(0, 1fr)', lg: `minmax(0, ${split}fr) 10px minmax(0, ${100 - split}fr)` },
          gridTemplateRows: { lg: 'minmax(0, 1fr)' },
        }}
      >
        {/* LEFT: description */}
        <Paper variant="outlined" component="section" aria-label="Problem description" sx={{ ...PANEL_SX, p: 0, overflow: 'hidden', minWidth: 0, minHeight: 0, display: 'flex', flexDirection: 'column', maxHeight: { xs: '75vh', lg: 'none' } }}>
          <Box sx={{ flex: '0 0 auto', display: 'flex', alignItems: 'center', justifyContent: 'space-between', minHeight: 44, px: 1.5, borderBottom: '1px solid', borderColor: 'divider', bgcolor: 'background.default' }}>
            <Stack direction="row" spacing={0.75} sx={{ alignItems: 'center' }}>
              <DescriptionOutlinedIcon fontSize="small" aria-hidden="true" />
              <Typography component="h2" sx={{ fontSize: 14, fontWeight: 700 }}>Description</Typography>
            </Stack>
            {user && <Button component={RouterLink} to="/submissions" size="small" color="inherit" startIcon={<HistoryIcon fontSize="small" />} sx={{ color: 'text.secondary', '&:hover': { color: 'text.primary', bgcolor: 'action.hover' } }}>History</Button>}
          </Box>
          <Box sx={{ p: { xs: 2, sm: 3 }, overflow: 'auto', minHeight: 0, flex: 1 }}>
            <ProblemPanel problem={problem.data} />
          </Box>
        </Paper>

        {/* Draggable, keyboard-adjustable divider (desktop only). */}
        <Box
          role="separator"
          aria-orientation="vertical"
          aria-label="Resize problem and editor panels"
          aria-valuemin={SPLIT_MIN}
          aria-valuemax={SPLIT_MAX}
          aria-valuenow={split}
          tabIndex={isWide ? 0 : -1}
          onKeyDown={onSplitKey}
          onDoubleClick={() => { setSplit(SPLIT_DEFAULT); writeSplit(SPLIT_DEFAULT); }}
          onPointerDown={(e) => { if (!isWide) return; dragging.current = true; document.body.style.cursor = 'col-resize'; document.body.style.userSelect = 'none'; e.preventDefault(); }}
          sx={{
            display: { xs: 'none', lg: 'block' }, cursor: 'col-resize', touchAction: 'none', position: 'relative', outlineOffset: -2,
            '&::after': { content: '""', position: 'absolute', width: 3, height: 44, top: '50%', left: '50%', transform: 'translate(-50%, -50%)', borderRadius: 2, bgcolor: 'text.disabled' },
            '&:hover::after, &:focus-visible::after': { bgcolor: 'primary.main' },
          }}
        />

        {/* RIGHT: toolbar + editor + result panel */}
        <Box sx={{ minWidth: 0, minHeight: 0, display: 'flex', flexDirection: 'column', gap: 1, height: { lg: '100%' } }}>
          {!user && (
            <Alert severity="info" variant="outlined" sx={{ flex: '0 0 auto' }}>
              <Button component={RouterLink} to="/login" state={{ from: { pathname: `/problems/${slug}` } }} size="small">Log in</Button> to run and submit code.
            </Alert>
          )}
          {!judgeable && <Alert severity="info" variant="outlined" sx={{ flex: '0 0 auto' }}>This problem cannot be run or judged on this server{problem.data?.testDataStatus === 'NONE' ? ' because no test data is available' : ''}. Use the original source to solve it there.</Alert>}
          {judgeable && !languageOk && <Alert severity="info" variant="outlined" sx={{ flex: '0 0 auto' }}>SQL is available in the Online Compiler but cannot be used to judge problems. Pick another language.</Alert>}
          {tooLong && <Alert severity="error" variant="outlined" sx={{ flex: '0 0 auto' }}>Your code is longer than {MAX_SOURCE_CHARS.toLocaleString()} characters.</Alert>}

          {langs.status === 'error' || languages.length === 0 ? (
            <Alert severity="warning" variant="outlined">Running and submitting code is switched off on this free live demo, so there is no code editor here. You can still read the problem and its examples. Code execution works in the local Docker version.</Alert>
          ) : (
            <Paper variant="outlined" sx={{ ...PANEL_SX, p: 0, minWidth: 0, minHeight: { xs: 0, lg: 0 }, overflow: 'hidden', display: 'flex', flexDirection: 'column', flex: { lg: '1 1 auto' } }}>
              <EditorPanel
                languages={languages}
                language={language}
                onLanguageChange={setLanguage}
                code={code}
                onCodeChange={(v) => { setCodeByLang((prev) => ({ ...prev, [language]: v })); saveDraft(userId, slug, language, v ?? ''); }}
                fontSize={fontSize}
                onFontSizeChange={setFontSize}
                onReset={() => { clearDraft(userId, slug, language); setCodeByLang((prev) => ({ ...prev, [language]: starterByLang[language] ?? '' })); }}
                height={editorHeight}
                fill={isWide}
                actions={actions}
              />
              <Box sx={{ flex: resultOpen && isWide ? '0 0 38%' : '0 0 auto', minHeight: 0, display: 'flex', flexDirection: 'column', borderTop: 1, borderColor: 'divider', bgcolor: 'background.paper' }}>
                <Box sx={{ flex: '0 0 auto', display: 'flex', alignItems: 'center', justifyContent: 'space-between', minHeight: 38, pl: 1.5, pr: 0.5, bgcolor: 'background.default' }}>
                  <Typography component="h2" sx={{ fontSize: 13, fontWeight: 700 }}>Result</Typography>
                  <Tooltip title={resultOpen ? 'Fold result' : 'Show result'}>
                    <IconButton size="small" aria-label={resultOpen ? 'Fold result panel' : 'Show result panel'} aria-expanded={resultOpen} onClick={() => setResultOpen((open) => !open)} sx={{ color: 'text.secondary' }}>
                      {resultOpen ? <ExpandMoreIcon fontSize="small" /> : <ExpandLessIcon fontSize="small" />}
                    </IconButton>
                  </Tooltip>
                </Box>
                {resultOpen && (
                  <Box aria-live="polite" sx={{ p: 1.5, overflow: 'auto', minHeight: 0, flex: '1 1 auto', maxHeight: isWide ? 'none' : 360 }}>
                    <ResultsPanel phase={job.phase} mode={job.mode} job={job.job} error={job.error} />
                  </Box>
                )}
              </Box>
            </Paper>
          )}
        </Box>
      </Box>
    </Box>
  );
}