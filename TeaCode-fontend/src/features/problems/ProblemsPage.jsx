import { useEffect, useState } from 'react';
import {
  Accordion, AccordionDetails, AccordionSummary, Alert, Box, Button, Checkbox, Chip, Container, FormControl, InputLabel, ListItemText, MenuItem, Pagination, Select,
  Skeleton, Stack, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, TextField, Typography, useMediaQuery,
} from '@mui/material';
import { useTheme } from '@mui/material/styles';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import ProblemsCalendar from './ProblemsCalendar.jsx';
import { Link as RouterLink, useSearchParams } from 'react-router-dom';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import { useApiData } from '../../hooks/useApiData.js';
import { useAuth } from '../../hooks/useAuth.js';
import { stackedTableSx } from '../../theme/responsiveTable.js';
import { difficultyLabel } from '../landing/PopularProblems.jsx';

const PAGE_SIZE = 20;
const DIFFICULTY_COLOR = { EASY: 'success', MEDIUM: 'warning', HARD: 'error', UNRATED: 'default' };
const DASH = '\u2014';

function formatSpent(ms) {
  if (!ms) return DASH;
  const m = Math.floor(ms / 60000);
  return m >= 60 ? `${Math.floor(m / 60)}h ${m % 60}m` : m > 0 ? `${m}m` : '<1m';
}
const SORTS = [
  { value: 'newest', label: 'Newest' },
  { value: 'oldest', label: 'Oldest' },
  { value: 'title', label: 'Title (A\u2013Z)' },
  { value: 'difficulty', label: 'Difficulty' },
  { value: 'rating_asc', label: 'Rating (low \u2192 high)' },
  { value: 'rating_desc', label: 'Rating (high \u2192 low)' },
];

/** Signed-in users only: solved count and per-difficulty progress, straight from /dashboard (real submissions, no placeholders). */
function ProgressStrip() {
  const summary = useApiData('/dashboard/summary');
  const progress = useApiData('/dashboard/progress');
  if (summary.status !== 'success') return null;
  const { solvedCount, totalProblems } = summary.data;
  return (
    <Stack direction="row" component="section" aria-label="Your progress" useFlexGap sx={{ gap: 1.5, alignItems: 'center', flexWrap: 'wrap', mb: 3 }}>
      <Typography sx={{ fontWeight: 700 }}>{solvedCount} / {totalProblems} solved</Typography>
      {(Array.isArray(progress.data) ? progress.data : []).filter((x) => x.difficulty !== 'UNRATED').map((x) => (
        <Chip key={x.difficulty} size="small" variant="outlined" color={DIFFICULTY_COLOR[x.difficulty] ?? 'default'} label={`${difficultyLabel(x.difficulty)} ${x.solved}/${x.total}`} />
      ))}
      <Button component={RouterLink} to="/submissions" size="small">Practice history</Button>
    </Stack>
  );
}

/** Debounces a fast-changing value so typing does not fire a request per keystroke. */
function useDebounced(value, ms = 300) {
  const [debounced, setDebounced] = useState(value);
  useEffect(() => {
    const t = setTimeout(() => setDebounced(value), ms);
    return () => clearTimeout(t);
  }, [value, ms]);
  return debounced;
}

/**
 * Filters, sorting and paging live in the URL and are executed by the backend
 * (GET /problems); the browser only ever holds one page of results.
 */
export default function ProblemsPage() {
  const [params, setParams] = useSearchParams();
  const difficulty = params.get('difficulty') ?? '';
  // Multiple topics are kept in the URL as ?topic=a&topic=b and sent as topics=a,b.
  const topics = params.getAll('topic');
  const solved = params.get('solved') ?? '';
  const minRating = params.get('minRating') ?? '';
  const maxRating = params.get('maxRating') ?? '';
  const { user } = useAuth();
  const wide = useMediaQuery(useTheme().breakpoints.up('lg'));
  const sort = params.get('sort') ?? 'newest';
  const page = Math.max(0, Number.parseInt(params.get('page') ?? '0', 10) || 0);
  const urlQuery = params.get('q') ?? '';

  const [text, setText] = useState(urlQuery);
  const debouncedText = useDebounced(text);

  const update = (changes) => {
    const next = new URLSearchParams(params);
    Object.entries(changes).forEach(([k, v]) => {
      next.delete(k);
      if (Array.isArray(v)) v.forEach((x) => next.append(k, x));
      else if (!(v === '' || v === null || v === undefined)) next.set(k, String(v));
    });
    setParams(next, { replace: true });
  };

  // Push the debounced search into the URL and reset to the first page.
  useEffect(() => {
    if (debouncedText !== urlQuery) update({ q: debouncedText.trim(), page: '' });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [debouncedText]);

  const tags = useApiData('/problems/topics');
  const list = useApiData('/problems', { search: urlQuery || undefined, difficulty: difficulty || undefined, topics: topics.length ? topics.join(',') : undefined, solved: user && solved ? solved : undefined, minRating: minRating || undefined, maxRating: maxRating || undefined, sort, page, size: PAGE_SIZE });
  const items = list.data?.items ?? [];
  const hasFilters = Boolean(urlQuery || difficulty || topics.length || solved || minRating || maxRating);

  const clear = () => {
    setText('');
    setParams({}, { replace: true });
  };

  let body;
  if (list.status === 'loading') {
    body = <Stack spacing={1} aria-busy="true" aria-label="Loading problems">{[0, 1, 2, 3, 4].map((k) => <Skeleton key={k} variant="rounded" height={52} />)}</Stack>;
  } else if (list.status === 'error') {
    body = <Alert severity="error" variant="outlined" action={<Button color="inherit" size="small" onClick={() => window.location.reload()}>Retry</Button>}>Problems could not be loaded. Please try again.</Alert>;
  } else if (items.length === 0) {
    body = (
      <Alert severity="info" variant="outlined" action={hasFilters ? <Button color="inherit" size="small" onClick={clear}>Clear filters</Button> : undefined}>
        {hasFilters ? 'No problems match your filters.' : 'No problems have been published yet.'}
      </Alert>
    );
  } else {
    body = (
      <>
        <Box sx={{ border: 1, borderColor: 'divider', borderRadius: 3, overflow: 'hidden' }}>
          <TableContainer>
            <Table aria-label="Problems list" sx={stackedTableSx}>
              <TableHead>
                <TableRow>
                  <TableCell sx={{ minWidth: 240 }}>Problem</TableCell>
                  <TableCell>Difficulty</TableCell>
                  <TableCell>Rating</TableCell>
                  <TableCell>Topics</TableCell>
                  <TableCell>Status</TableCell>
                  {user && <TableCell>Time spent</TableCell>}
                </TableRow>
              </TableHead>
              <TableBody>
                {items.map((p) => (
                  <TableRow key={p.slug} hover sx={{ '&:last-child td': { borderBottom: 0 } }}>
                    <TableCell>
                      <Typography component={RouterLink} to={`/problems/${p.slug}`} color="inherit" sx={{ fontWeight: 600, textDecoration: 'none', '&:hover': { color: 'primary.main' } }}>
                        {p.title}
                      </Typography>
                    </TableCell>
                    <TableCell data-label="Difficulty"><Chip size="small" variant="outlined" label={difficultyLabel(p.difficulty)} color={DIFFICULTY_COLOR[p.difficulty] ?? 'default'} /></TableCell>
                    <TableCell data-label="Rating">{p.rating ?? DASH}</TableCell>
                    <TableCell data-label="Topics">
                      <Stack direction="row" spacing={0.5} useFlexGap sx={{ flexWrap: 'wrap', justifyContent: { xs: 'flex-end', sm: 'flex-start' } }}>
                        {(p.tags ?? []).map((t) => <Chip key={t.slug ?? t.name} size="small" variant="outlined" label={t.name} sx={{ color: 'text.secondary' }} />)}
                      </Stack>
                    </TableCell>
                    <TableCell data-label="Status">
                      {p.solved ? <CheckCircleIcon color="success" titleAccess="Solved" fontSize="small" /> : <Typography variant="body2" color="text.secondary">{p.solved === false ? 'Unsolved' : DASH}</Typography>}
                    </TableCell>
                    {user && <TableCell data-label="Time spent">{formatSpent(p.timeSpentMs)}</TableCell>}
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Box>
        {list.data.totalPages > 1 && (
          <Box sx={{ display: 'flex', justifyContent: 'center', mt: 3 }}>
            <Pagination
              count={list.data.totalPages}
              page={page + 1}
              onChange={(_, value) => update({ page: value - 1 === 0 ? '' : value - 1 })}
              variant="outlined"
              shape="rounded"
              aria-label="Problems pagination"
            />
          </Box>
        )}
      </>
    );
  }

  return (
    <Container maxWidth="lg" sx={{ py: { xs: 5, md: 8 } }}>
      <Stack direction={{ xs: 'column', sm: 'row' }} sx={{ justifyContent: 'space-between', alignItems: { sm: 'flex-end' }, gap: 2, mb: { xs: 4, md: 5 } }}>
        <Box sx={{ maxWidth: 760 }}>
          <Box component="p" sx={{ display: 'inline-block', m: 0, mb: 2, px: 1.5, py: 0.5, border: 1, borderColor: 'divider', borderRadius: 5, fontSize: 13, color: 'text.secondary' }}>Practice</Box>
          <Typography variant="h3" component="h1" sx={{ fontWeight: 600, letterSpacing: '-0.03em', lineHeight: 1.1 }}>Explore Problems</Typography>
          <Typography sx={{ mt: 1.25, color: 'text.secondary', fontSize: { xs: '1rem', md: '1.1rem' }, lineHeight: 1.6 }}>
            Search, filter, and sort coding challenges by difficulty, topic, rating, and <Box component="span" sx={{ color: '#F3D9C9', fontWeight: 600 }}>progress.</Box>
          </Typography>
        </Box>
        {list.status === 'success' && (
          <Typography color="text.secondary" aria-live="polite">
            {list.data.totalItems != null ? `${list.data.totalItems} ${list.data.totalItems === 1 ? 'problem' : 'problems'}` : ''}{hasFilters ? ' match your filters' : ''}
          </Typography>
        )}
      </Stack>
      {user && <ProgressStrip />}
      <Box sx={{ display: 'grid', gap: 3, gridTemplateColumns: { xs: 'minmax(0, 1fr)', lg: 'minmax(0, 1fr) 320px' }, alignItems: 'start' }}>
        {!wide && (
          <Accordion disableGutters variant="outlined" sx={{ borderRadius: 3, bgcolor: 'transparent', '&:before': { display: 'none' } }}>
            <AccordionSummary expandIcon={<ExpandMoreIcon />} aria-controls="calendar-panel" id="calendar-header"><Typography sx={{ fontWeight: 700 }}>Calendar</Typography></AccordionSummary>
            <AccordionDetails id="calendar-panel" sx={{ pt: 0 }}><ProblemsCalendar /></AccordionDetails>
          </Accordion>
        )}
        <Box sx={{ minWidth: 0, gridRow: { lg: 1 } }}>
          <Box component="section" aria-label="Problem filters" sx={{ p: { xs: 2, md: 2.5 }, mb: 3, border: 1, borderColor: 'divider', borderRadius: 3 }}>
            <Box sx={{ display: 'grid', gap: 2, gridTemplateColumns: { xs: 'minmax(0, 1fr)', sm: 'repeat(2, minmax(0, 1fr))', md: 'repeat(4, minmax(0, 1fr))' }, '& .MuiFormControl-root, & .MuiTextField-root': { width: '100%', minWidth: '0 !important' } }}>
              <TextField label="Search by title" value={text} onChange={(e) => setText(e.target.value)} size="small" sx={{ gridColumn: { sm: '1 / -1', md: 'span 2' } }} slotProps={{ htmlInput: { maxLength: 100 } }} />
              <FormControl size="small" sx={{ minWidth: 150 }}>
                <InputLabel id="difficulty-label">Difficulty</InputLabel>
                <Select labelId="difficulty-label" label="Difficulty" value={difficulty} onChange={(e) => update({ difficulty: e.target.value, page: '' })}>
                  <MenuItem value="">All</MenuItem>
                  <MenuItem value="EASY">Easy</MenuItem>
                  <MenuItem value="MEDIUM">Medium</MenuItem>
                  <MenuItem value="HARD">Hard</MenuItem>
                  <MenuItem value="UNRATED">Unrated</MenuItem>
                </Select>
              </FormControl>
              <FormControl size="small" sx={{ minWidth: 200 }}>
                <InputLabel id="topic-label">Topics</InputLabel>
                <Select
                  labelId="topic-label"
                  label="Topics"
                  multiple
                  value={topics.filter((t) => (tags.data ?? []).some((x) => x.slug === t))}
                  onChange={(e) => update({ topic: e.target.value, page: '' })}
                  renderValue={(sel) => (sel.length === 1 ? ((tags.data ?? []).find((x) => x.slug === sel[0])?.name ?? sel[0]) : `${sel.length} topics`)}
                  MenuProps={{ slotProps: { paper: { sx: { maxHeight: 360 } } } }}
                >
                  {(tags.data ?? []).map((t) => (
                    <MenuItem key={t.slug} value={t.slug}>
                      <Checkbox checked={topics.includes(t.slug)} size="small" tabIndex={-1} disableRipple />
                      <ListItemText primary={t.name} />
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
              <TextField label="Min rating" type="number" size="small" value={minRating} onChange={(e) => update({ minRating: e.target.value, page: '' })} slotProps={{ htmlInput: { min: 0, max: 5000, step: 100 } }} />
              <TextField label="Max rating" type="number" size="small" value={maxRating} onChange={(e) => update({ maxRating: e.target.value, page: '' })} slotProps={{ htmlInput: { min: 0, max: 5000, step: 100 } }} />
              {user && (
                <FormControl size="small" sx={{ minWidth: 140 }}>
                  <InputLabel id="solved-label">Status</InputLabel>
                  <Select labelId="solved-label" label="Status" value={solved} onChange={(e) => update({ solved: e.target.value, page: '' })}>
                    <MenuItem value="">All</MenuItem>
                    <MenuItem value="true">Solved</MenuItem>
                    <MenuItem value="false">Unsolved</MenuItem>
                  </Select>
                </FormControl>
              )}
              <FormControl size="small" sx={{ minWidth: 160 }}>
                <InputLabel id="sort-label">Sort by</InputLabel>
                <Select labelId="sort-label" label="Sort by" value={SORTS.some((s) => s.value === sort) ? sort : 'newest'} onChange={(e) => update({ sort: e.target.value === 'newest' ? '' : e.target.value, page: '' })}>
                  {SORTS.map((s) => <MenuItem key={s.value} value={s.value}>{s.label}</MenuItem>)}
                </Select>
              </FormControl>
              {hasFilters && <Button onClick={clear} color="inherit" sx={{ justifySelf: { md: 'start' } }}>Clear filters</Button>}
            </Box>
          </Box>
          {body}
        </Box>
        {wide && <Box component="aside" aria-label="Calendar" sx={{ position: 'sticky', top: 88, gridRow: 1, gridColumn: 2 }}><ProblemsCalendar /></Box>}
      </Box>
    </Container>
  );
}