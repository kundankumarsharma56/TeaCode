import { Fragment, useEffect, useState } from 'react';
import {
  Alert, Box, Button, Card, Chip, Container, IconButton, LinearProgress, MenuItem, Pagination, Skeleton, Stack, Table,
  TableBody, TableCell, TableContainer, TableHead, TableRow, TextField, Typography,
} from '@mui/material';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import { Link as RouterLink, useSearchParams } from 'react-router-dom';
import { useApiData } from '../../hooks/useApiData.js';
import { stackedTableSx } from '../../theme/responsiveTable.js';
import { statusInfo } from '../workspace/ResultsPanel.jsx';
import { formatDateTime, formatShortDate, utcOffsetMinutes } from '../../utils/format.js';
import PageHeader from '../../components/PageHeader.jsx';

const PAGE_SIZE = 20;

// TeaCode card surface: thin border, no shadow, no gradient.
const CARD_SX = { border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper', boxShadow: 'none', backgroundImage: 'none' };
const DIFFICULTY_COLOR = { EASY: 'success', MEDIUM: 'warning', HARD: 'error', UNRATED: 'default' };
const VERDICTS = ['ACCEPTED', 'WRONG_ANSWER', 'COMPILATION_ERROR', 'RUNTIME_ERROR', 'TIME_LIMIT_EXCEEDED', 'MEMORY_LIMIT_EXCEEDED', 'INSUFFICIENT_VERIFICATION'];
const DIFFICULTIES = [['EASY', 'Easy'], ['MEDIUM', 'Medium'], ['HARD', 'Hard']];

function useDebounced(value, ms = 300) {
  const [v, setV] = useState(value);
  useEffect(() => { const t = setTimeout(() => setV(value), ms); return () => clearTimeout(t); }, [value, ms]);
  return v;
}

function Summary() {
  const summary = useApiData('/dashboard/summary');
  const progress = useApiData('/dashboard/progress');
  const topics = useApiData('/dashboard/topics');
  const s = summary.data;
  const solvedTopics = (Array.isArray(topics.data) ? topics.data : []).filter((t) => t.solved > 0).sort((a, b) => b.solved - a.solved || a.topic.localeCompare(b.topic));
  const maxSolved = Math.max(1, ...solvedTopics.map((t) => t.solved));
  return (
    <Stack component="aside" aria-label="Summary" spacing={2}>
      <Typography variant="h6" component="h2" sx={{ fontWeight: 600 }}>Summary</Typography>
      {summary.status === 'error' && <Alert severity="error" variant="outlined">The summary could not be loaded.</Alert>}
      {summary.status === 'loading' && <Skeleton variant="rounded" height={120} />}
      {s && (
        <>
          <Card variant="outlined" sx={{ ...CARD_SX, p: 2 }}>
            <Typography variant="overline" color="text.secondary">Problems solved</Typography>
            <Typography variant="h4" component="p" sx={{ fontWeight: 700, letterSpacing: '-0.02em' }}>{s.solvedCount}<Typography component="span" color="text.secondary" sx={{ fontSize: 16 }}> / {s.totalProblems}</Typography></Typography>
            <Stack direction="row" sx={{ gap: 1, mt: 1, flexWrap: 'wrap' }}>
              {(Array.isArray(progress.data) ? progress.data : []).filter((p) => p.difficulty !== 'UNRATED').map((p) => (
                <Chip key={p.difficulty} size="small" color={DIFFICULTY_COLOR[p.difficulty] ?? 'default'} variant="outlined" label={`${p.difficulty[0]}${p.difficulty.slice(1).toLowerCase()} ${p.solved}/${p.total}`} />
              ))}
            </Stack>
          </Card>
          <Stack direction="row" sx={{ gap: 2 }}>
            <Card variant="outlined" sx={{ ...CARD_SX, p: 2, flex: 1 }}>
              <Typography variant="overline" color="text.secondary">Submissions</Typography>
              <Typography variant="h5" component="p" sx={{ fontWeight: 700 }}>{s.totalSubmissions}</Typography>
              <Typography variant="caption" color="text.secondary">{s.acceptedSubmissions} accepted</Typography>
            </Card>
            <Card variant="outlined" sx={{ ...CARD_SX, p: 2, flex: 1 }}>
              <Typography variant="overline" color="text.secondary">Acceptance</Typography>
              <Typography variant="h5" component="p" sx={{ fontWeight: 700 }}>{s.acceptanceRate == null ? '—' : `${s.acceptanceRate.toFixed(1)}%`}</Typography>
              <Typography variant="caption" color="text.secondary">accepted ÷ judged</Typography>
            </Card>
          </Stack>
          <Typography variant="caption" color="text.secondary">
            “Problems solved” counts unique problems. “Accepted” counts submissions, so one problem can account for several.
          </Typography>
        </>
      )}
      <Card variant="outlined" sx={{ ...CARD_SX, p: 2 }}>
        <Typography variant="subtitle1" component="h3" sx={{ fontWeight: 700, mb: 1 }}>Solved by topic</Typography>
        {topics.status === 'loading' && <Skeleton variant="rounded" height={80} />}
        {topics.status === 'error' && <Alert severity="error" variant="outlined">Topics could not be loaded.</Alert>}
        {topics.status === 'success' && solvedTopics.length === 0 && <Typography color="text.secondary" variant="body2">Solve a problem to see your topic distribution.</Typography>}
        {solvedTopics.length > 0 && (
          <Box component="ul" sx={{ listStyle: 'none', m: 0, p: 0, display: 'grid', gap: 1 }}>
            {solvedTopics.map((t) => (
              <li key={t.slug}>
                <Stack direction="row" sx={{ justifyContent: 'space-between' }}><Typography variant="body2">{t.topic}</Typography><Typography variant="body2" color="text.secondary">{t.solved} solved</Typography></Stack>
                <LinearProgress variant="determinate" aria-hidden="true" value={(t.solved / maxSolved) * 100} />
              </li>
            ))}
          </Box>
        )}
      </Card>
    </Stack>
  );
}

function ProblemSubmissions({ slug }) {
  const list = useApiData('/submissions/mine', { problem: slug, size: 10, offsetMinutes: utcOffsetMinutes() });
  if (list.status === 'loading') return <Skeleton variant="rounded" height={48} aria-label="Loading submissions" />;
  if (list.status === 'error') return <Alert severity="error" variant="outlined">Submissions could not be loaded.</Alert>;
  return (
    <Box component="ul" aria-label="Submissions for this problem" sx={{ listStyle: 'none', m: 0, p: 0, display: 'grid', gap: 0.5 }}>
      {list.data.items.map((s) => {
        const info = statusInfo(s.status);
        return (
          <li key={s.id}>
            <Stack direction="row" sx={{ gap: 1.5, alignItems: 'center', flexWrap: 'wrap' }}>
              <Chip size="small" color={info.color} label={info.label} />
              <Typography variant="body2">{s.language}</Typography>
              <Typography variant="body2" color="text.secondary">{s.passedTests}/{s.totalTests} tests · {formatDateTime(s.createdAt)}</Typography>
              <Button component={RouterLink} to={`/submissions/${s.id}`} size="small" aria-label={`Open submission ${s.id}`}>Open</Button>
            </Stack>
          </li>
        );
      })}
      {list.data.totalItems > list.data.items.length && <Typography variant="caption" color="text.secondary">Showing the latest {list.data.items.length} of {list.data.totalItems}.</Typography>}
    </Box>
  );
}

/** Per-problem history with server-side filters and paging. All state lives in the URL. */
export default function PracticeHistoryPage() {
  const [params, setParams] = useSearchParams();
  const page = Math.max(0, Number.parseInt(params.get('page') ?? '0', 10) || 0);
  const q = params.get('q') ?? '';
  const status = params.get('status') ?? '';
  const language = params.get('language') ?? '';
  const difficulty = params.get('difficulty') ?? '';
  const from = params.get('from') ?? '';
  const to = params.get('to') ?? '';
  const [text, setText] = useState(q);
  const debounced = useDebounced(text);
  const [open, setOpen] = useState(null);
  const languages = useApiData('/execution/languages');

  const update = (patch) => {
    const next = new URLSearchParams(params);
    Object.entries(patch).forEach(([k, v]) => (v === '' || v == null ? next.delete(k) : next.set(k, String(v))));
    setParams(next, { replace: true });
  };
  useEffect(() => {
    if (debounced.trim() !== q) {
      const next = new URLSearchParams(params);
      if (debounced.trim()) next.set('q', debounced.trim()); else next.delete('q');
      next.delete('page');
      setParams(next, { replace: true });
    }
    // Only the debounced text should trigger this; the URL values are read fresh when it fires.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [debounced]);

  const invalidRange = Boolean(from && to && from > to);
  const list = useApiData('/submissions/history', {
    page, size: PAGE_SIZE, q: q || undefined, status: status || undefined, language: language || undefined,
    difficulty: difficulty || undefined, from: from || undefined, to: to || undefined, offsetMinutes: utcOffsetMinutes(),
  }, invalidRange);
  const items = list.data?.items ?? [];
  const filtered = Boolean(q || status || language || difficulty || from || to);
  const clear = () => { setText(''); setParams({}, { replace: true }); };

  let body;
  if (invalidRange) {
    body = <Alert severity="warning" variant="outlined">The start date must not be after the end date.</Alert>;
  } else if (list.status === 'loading' || list.status === 'idle') {
    body = <Stack spacing={1} aria-busy="true" aria-label="Loading history">{[0, 1, 2, 3].map((k) => <Skeleton key={k} variant="rounded" height={56} />)}</Stack>;
  } else if (list.status === 'error') {
    body = <Alert severity="error" variant="outlined" action={<Button color="inherit" size="small" onClick={() => update({ page: page || '' })}>Retry</Button>}>Your history could not be loaded. Please try again.</Alert>;
  } else if (items.length === 0) {
    body = filtered
      ? <Alert severity="info" variant="outlined" action={<Button color="inherit" size="small" onClick={clear}>Clear filters</Button>}>No submissions match these filters.</Alert>
      : <Alert severity="info" variant="outlined" action={<Button component={RouterLink} to="/problems" color="inherit" size="small">Browse problems</Button>}>You have not submitted any solutions yet.</Alert>;
  } else {
    body = (
      <>
        <Card sx={CARD_SX}><TableContainer>
          <Table aria-label="Practice history" sx={stackedTableSx}>
            <TableHead>
              <TableRow>
                <TableCell>Last submitted</TableCell><TableCell>Problem</TableCell><TableCell>Last result</TableCell><TableCell>Submissions</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {items.map((r) => {
                const info = statusInfo(r.lastStatus);
                const expanded = open === r.problemSlug;
                return (
                  <Fragment key={r.problemSlug}>
                    <TableRow hover>
                      <TableCell data-label="Last submitted" title={formatDateTime(r.lastSubmittedAt)}>{formatShortDate(r.lastSubmittedAt)}</TableCell>
                      <TableCell>
                        <Typography component={RouterLink} to={`/problems/${r.problemSlug}`} color="inherit" sx={{ fontWeight: 600, textDecoration: 'none', '&:hover': { color: 'primary.main' } }}>{r.problemTitle}</Typography>
                        <Box><Chip size="small" variant="outlined" color={DIFFICULTY_COLOR[r.difficulty] ?? 'default'} label={r.difficulty[0] + r.difficulty.slice(1).toLowerCase()} />{r.solved && <Chip size="small" color="success" label="Solved" sx={{ ml: 0.75 }} />}</Box>
                      </TableCell>
                      <TableCell data-label="Last result"><Chip size="small" color={info.color} label={info.label} /></TableCell>
                      <TableCell data-label="Submissions">
                        {r.submissionCount}
                        <IconButton size="small" aria-expanded={expanded} aria-label={`${expanded ? 'Hide' : 'Show'} submissions for ${r.problemTitle}`}
                          onClick={() => setOpen(expanded ? null : r.problemSlug)}>
                          <ExpandMoreIcon sx={{ transform: expanded ? 'rotate(180deg)' : 'none', transition: 'transform .15s' }} />
                        </IconButton>
                      </TableCell>
                    </TableRow>
                    {expanded && <TableRow><TableCell colSpan={4}><ProblemSubmissions slug={r.problemSlug} /></TableCell></TableRow>}
                  </Fragment>
                );
              })}
            </TableBody>
          </Table>
        </TableContainer></Card>
        {list.data.totalPages > 1 && (
          <Box sx={{ display: 'flex', justifyContent: 'center', mt: 3 }}>
            <Pagination count={list.data.totalPages} page={page + 1} color="primary" aria-label="History pagination" onChange={(_, v) => update({ page: v === 1 ? '' : v - 1 })} />
          </Box>
        )}
      </>
    );
  }

  const langs = Array.isArray(languages.data) ? languages.data : [];
  return (
    <Container maxWidth="xl" sx={{ py: { xs: 5, md: 8 } }}>
      <PageHeader label="History" title="Practice History" subtitle="Every problem you have submitted to, with your latest result." sx={{ mb: 4 }} />
      <Box sx={{ display: 'grid', gap: 4, gridTemplateColumns: { xs: '1fr', lg: 'minmax(0, 1fr) 360px' }, alignItems: 'start' }}>
        <Box component="section" aria-label="History" sx={{ minWidth: 0 }}>
          <Stack direction="row" component="form" role="search" aria-label="Filter history" onSubmit={(e) => e.preventDefault()} sx={{ gap: 1.5, flexWrap: 'wrap', mb: 2 }}>
            <TextField size="small" label="Search problems" value={text} onChange={(e) => setText(e.target.value)} sx={{ minWidth: 200, flex: 1 }} slotProps={{ htmlInput: { maxLength: 100 } }} />
            <TextField select size="small" label="Result" value={status} onChange={(e) => update({ status: e.target.value, page: '' })} sx={{ minWidth: 150 }}>
              <MenuItem value="">Any result</MenuItem>{VERDICTS.map((v) => <MenuItem key={v} value={v}>{statusInfo(v).label}</MenuItem>)}
            </TextField>
            <TextField select size="small" label="Language" value={language} onChange={(e) => update({ language: e.target.value, page: '' })} sx={{ minWidth: 140 }}>
              <MenuItem value="">Any language</MenuItem>{langs.map((l) => <MenuItem key={l.key} value={l.key}>{l.name}</MenuItem>)}
            </TextField>
            <TextField select size="small" label="Difficulty" value={difficulty} onChange={(e) => update({ difficulty: e.target.value, page: '' })} sx={{ minWidth: 130 }}>
              <MenuItem value="">Any difficulty</MenuItem>{DIFFICULTIES.map(([v, l]) => <MenuItem key={v} value={v}>{l}</MenuItem>)}
            </TextField>
            <TextField size="small" type="date" label="From" value={from} onChange={(e) => update({ from: e.target.value, page: '' })} slotProps={{ inputLabel: { shrink: true } }} />
            <TextField size="small" type="date" label="To" value={to} onChange={(e) => update({ to: e.target.value, page: '' })} slotProps={{ inputLabel: { shrink: true } }} />
            {filtered && <Button onClick={clear}>Clear filters</Button>}
          </Stack>
          <Typography role="status" variant="body2" color="text.secondary" sx={{ mb: 1 }}>
            {list.status === 'success' ? `${list.data.totalItems} problem${list.data.totalItems === 1 ? '' : 's'}${filtered ? ' match' : ''}` : ''}
          </Typography>
          {body}
        </Box>
        <Summary />
      </Box>
    </Container>
  );
}
