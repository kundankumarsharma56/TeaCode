import {
  Alert, Box, Button, Card, CardContent, Chip, Container, Skeleton, Stack, Typography,
} from '@mui/material';
import { alpha, useTheme } from '@mui/material/styles';
import { Link as RouterLink } from 'react-router-dom';
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';
import LibraryBooksOutlinedIcon from '@mui/icons-material/LibraryBooksOutlined';
import SendOutlinedIcon from '@mui/icons-material/SendOutlined';
import TaskAltIcon from '@mui/icons-material/TaskAlt';
import ExploreOutlinedIcon from '@mui/icons-material/ExploreOutlined';
import PercentIcon from '@mui/icons-material/Percent';
import TimerOutlinedIcon from '@mui/icons-material/TimerOutlined';
import LocalFireDepartmentIcon from '@mui/icons-material/LocalFireDepartment';
import ArrowForwardIcon from '@mui/icons-material/ArrowForward';
import { useApiData } from '../../hooks/useApiData.js';
import { useAuth } from '../../hooks/useAuth.js';
import { difficultyLabel } from '../landing/PopularProblems.jsx';
import { statusInfo } from '../workspace/ResultsPanel.jsx';
import PageHeader from '../../components/PageHeader.jsx';

const BAR_COLOR = { EASY: 'success', MEDIUM: 'warning', HARD: 'error', UNRATED: 'primary' };
const RECENT_SOLVED = { solved: true, sort: 'newest', page: 0, size: 6 };
const RECENT_SUBMISSIONS = { page: 0, size: 6 };

const visuallyHidden = { position: 'absolute', width: 1, height: 1, p: 0, m: -0.125, overflow: 'hidden', clip: 'rect(0 0 0 0)', whiteSpace: 'nowrap', border: 0 };
const asArray = (v) => (Array.isArray(v) ? v : []);

// TeaCode card surface: thin border, no shadow, no gradient.
const CARD_SX = { border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper', boxShadow: 'none', backgroundImage: 'none' };

function fmtDuration(ms) {
  const m = Math.round((ms || 0) / 60000);
  if (m < 1) return '0 min';
  return m >= 60 ? `${Math.floor(m / 60)} h ${m % 60} min` : `${m} min`;
}

const fmtDay = (iso) => new Date(`${iso}T00:00:00Z`).toLocaleDateString(undefined, { month: 'short', day: 'numeric', timeZone: 'UTC' });
const fmtWhen = (iso) => (iso ? new Date(iso).toLocaleDateString(undefined, { month: 'short', day: 'numeric' }) : '');

/** Current streak = consecutive UTC days with a submission, ending today (or yesterday if today is still empty). */
function currentStreak(days) {
  let i = days.length - 1;
  if (i >= 0 && days[i].submissions === 0) i -= 1;
  let n = 0;
  while (i >= 0 && days[i].submissions > 0) { n += 1; i -= 1; }
  return n;
}

function SectionCard({ id, title, action, children, sx }) {
  return (
    <Card component="section" aria-labelledby={id} sx={{ ...CARD_SX, height: '100%', ...sx }}>
      <CardContent sx={{ p: { xs: 2, sm: 3 }, height: '100%', display: 'flex', flexDirection: 'column' }}>
        <Stack direction="row" sx={{ alignItems: 'center', justifyContent: 'space-between', gap: 2, mb: 2 }}>
          <Typography id={id} variant="h6" component="h2" sx={{ fontWeight: 600 }}>{title}</Typography>
          {action}
        </Stack>
        {children}
      </CardContent>
    </Card>
  );
}

/** Two-tone meter: `part` out of `whole`, drawn against a track scaled to `scale`. Exact numbers stay in text. */
function Meter({ part, whole, scale, label, color = 'primary', height = 8 }) {
  const pct = (n) => (scale > 0 ? Math.min(100, (n / scale) * 100) : 0);
  return (
    <Box role="progressbar" aria-label={label} aria-valuemin={0} aria-valuemax={whole} aria-valuenow={part}
      sx={{ position: 'relative', height, borderRadius: height, overflow: 'hidden', bgcolor: 'action.hover' }}>
      <Box sx={{ position: 'absolute', inset: 0, width: `${pct(whole)}%`, bgcolor: (t) => alpha(t.palette[color].main, 0.28), borderRadius: height }} />
      <Box sx={{ position: 'absolute', inset: 0, width: `${pct(part)}%`, bgcolor: `${color}.main`, borderRadius: height, transition: 'width .5s ease', '@media (prefers-reduced-motion: reduce)': { transition: 'none' } }} />
    </Box>
  );
}

/** Ranked list: one labelled row per item, exact numbers as text (never colour alone). */
function BarList({ title, id, rows, empty, loading, failed, color = 'primary', action }) {
  const max = Math.max(1, ...rows.map((r) => r.total ?? r.value));
  let content;
  if (loading) content = <Stack spacing={1.5}>{[0, 1, 2].map((k) => <Skeleton key={k} variant="rounded" height={36} />)}</Stack>;
  else if (failed) content = <Typography color="text.secondary">This section could not be loaded.</Typography>;
  else if (rows.length === 0) content = <Typography color="text.secondary">{empty}</Typography>;
  else {
    content = (
      <Stack component="ul" spacing={1.75} sx={{ listStyle: 'none', p: 0, m: 0 }}>
        {rows.map((r) => (
          <Box component="li" key={r.key}>
            <Stack direction="row" sx={{ justifyContent: 'space-between', alignItems: 'center', gap: 2, mb: 0.5 }}>
              <Typography noWrap sx={{ fontWeight: 600, minWidth: 0 }}>
                {r.to ? <Box component={RouterLink} to={r.to} sx={{ color: 'inherit', textDecoration: 'none', '&:hover': { color: 'primary.main' } }}>{r.label}</Box> : r.label}
              </Typography>
              <Typography variant="body2" color="text.secondary" sx={{ whiteSpace: 'nowrap' }}>{r.detail}</Typography>
            </Stack>
            <Meter part={r.value} whole={r.total ?? r.value} scale={max} label={`${r.label}: ${r.detail}`} color={r.solved === false ? 'warning' : color} />
          </Box>
        ))}
      </Stack>
    );
  }
  return <SectionCard id={id} title={title} action={action}>{content}</SectionCard>;
}

function Tile({ label, value, icon, hint, accent = 'primary' }) {
  return (
    <Card sx={{ ...CARD_SX, height: '100%' }}>
      <CardContent sx={{ p: 2.5, '&:last-child': { pb: 2.5 } }}>
        <Stack direction="row" sx={{ alignItems: 'flex-start', justifyContent: 'space-between', gap: 1 }}>
          <Typography variant="body2" color="text.secondary" sx={{ fontWeight: 600 }}>{label}</Typography>
          <Box aria-hidden="true" sx={{ display: 'grid', placeItems: 'center', width: 34, height: 34, borderRadius: 2, flexShrink: 0, color: `${accent}.main`, bgcolor: (t) => alpha(t.palette[accent].main, 0.12) }}>{icon}</Box>
        </Stack>
        <Typography variant="h4" component="p" sx={{ fontWeight: 700, letterSpacing: '-0.02em', mt: 1, fontVariantNumeric: 'tabular-nums' }}>{value}</Typography>
        {hint && <Typography variant="caption" color="text.secondary">{hint}</Typography>}
      </CardContent>
    </Card>
  );
}

/** SVG progress ring; the label carries the exact numbers for assistive tech. */
function Ring({ solved, total }) {
  const theme = useTheme();
  const size = 176;
  const stroke = 14;
  const r = (size - stroke) / 2;
  const c = 2 * Math.PI * r;
  const pct = total > 0 ? Math.min(100, (solved / total) * 100) : 0;
  return (
    <Box role="img" aria-label={`${solved} of ${total} problems solved, ${Math.round(pct)} percent`} sx={{ position: 'relative', width: size, height: size, flexShrink: 0 }}>
      <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`} aria-hidden="true" focusable="false">
        <circle cx={size / 2} cy={size / 2} r={r} fill="none" stroke={theme.palette.action.hover} strokeWidth={stroke} />
        <circle cx={size / 2} cy={size / 2} r={r} fill="none" stroke={theme.palette.primary.main} strokeWidth={stroke} strokeLinecap="round"
          strokeDasharray={c} strokeDashoffset={c * (1 - pct / 100)} transform={`rotate(-90 ${size / 2} ${size / 2})`}
          style={{ transition: 'stroke-dashoffset .6s ease' }} />
      </svg>
      <Box aria-hidden="true" sx={{ position: 'absolute', inset: 0, display: 'grid', placeContent: 'center', textAlign: 'center' }}>
        <Typography component="span" sx={{ fontSize: 34, fontWeight: 800, lineHeight: 1, fontVariantNumeric: 'tabular-nums' }}>{Math.round(pct)}%</Typography>
        <Typography component="span" variant="caption" color="text.secondary">complete</Typography>
      </Box>
    </Box>
  );
}

function ActivityChart({ days }) {
  const maxDay = Math.max(1, ...days.map((d) => d.submissions));
  const total = days.reduce((a, d) => a + d.submissions, 0);
  const active = days.filter((d) => d.submissions > 0).length;
  const best = days.reduce((a, d) => (d.submissions > a.submissions ? d : a), days[0]);
  const stats = [
    { label: 'Last 30 days', value: total },
    { label: 'Active days', value: active },
    { label: 'Current streak', value: `${currentStreak(days)} d` },
    { label: 'Best day', value: best.submissions },
  ];
  return (
    <>
      <Box sx={{ display: 'grid', gap: 2, gridTemplateColumns: { xs: 'repeat(2, minmax(0, 1fr))', sm: 'repeat(4, minmax(0, 1fr))' }, mb: 3 }}>
        {stats.map((s) => (
          <Box key={s.label}>
            <Typography variant="caption" color="text.secondary">{s.label}</Typography>
            <Typography variant="h6" component="p" sx={{ fontVariantNumeric: 'tabular-nums' }}>{s.value}</Typography>
          </Box>
        ))}
      </Box>
      <Box component="ul" aria-label="Submissions per day" sx={{ listStyle: 'none', p: 0, m: 0, display: 'flex', alignItems: 'flex-end', gap: { xs: '2px', sm: '4px' }, height: 140, borderBottom: 1, borderColor: 'divider' }}>
        {days.map((d) => (
          <Box component="li" key={d.date} title={`${fmtDay(d.date)}: ${d.submissions}`}
            sx={{ position: 'relative', flex: 1, height: '100%', display: 'flex', alignItems: 'flex-end', '&:hover > span.bar, &:focus-within > span.bar': { filter: 'brightness(1.15)' } }}>
            <Box component="span" className="bar" sx={{ display: 'block', width: '100%', borderRadius: '4px 4px 0 0', bgcolor: 'primary.main', height: `${Math.max(3, (d.submissions / maxDay) * 100)}%`, opacity: d.submissions ? 1 : 0.22 }} />
            <Box component="span" sx={visuallyHidden}>{d.date}: {d.submissions} submissions</Box>
          </Box>
        ))}
      </Box>
      <Stack direction="row" aria-hidden="true" sx={{ justifyContent: 'space-between', mt: 0.75 }}>
        <Typography variant="caption" color="text.secondary">{fmtDay(days[0].date)}</Typography>
        <Typography variant="caption" color="text.secondary">{fmtDay(days[days.length - 1].date)}</Typography>
      </Stack>
    </>
  );
}

function SolvedList({ state }) {
  const items = state.data?.items ?? [];
  if (state.status === 'loading') return <Stack spacing={1}>{[0, 1, 2].map((k) => <Skeleton key={k} variant="rounded" height={44} />)}</Stack>;
  if (state.status === 'error') return <Typography color="text.secondary">Solved problems could not be loaded.</Typography>;
  if (items.length === 0) return <Typography color="text.secondary">Problems you solve are tracked here.</Typography>;
  return (
    <Stack component="ul" divider={<Box sx={{ borderTop: 1, borderColor: 'divider' }} />} sx={{ listStyle: 'none', p: 0, m: 0 }}>
      {items.map((p) => (
        <Stack component="li" key={p.slug} direction="row" sx={{ alignItems: 'center', gap: 1.5, py: 1.25 }}>
          <CheckCircleOutlineIcon color="success" fontSize="small" titleAccess="Solved" />
          <Typography component={RouterLink} to={`/problems/${p.slug}`} noWrap sx={{ flex: 1, minWidth: 0, fontWeight: 600, color: 'inherit', textDecoration: 'none', '&:hover': { color: 'primary.main' } }}>{p.title}</Typography>
          <Chip size="small" variant="outlined" label={difficultyLabel(p.difficulty)} color={p.difficulty === 'EASY' ? 'success' : p.difficulty === 'MEDIUM' ? 'warning' : p.difficulty === 'HARD' ? 'error' : 'default'} />
        </Stack>
      ))}
    </Stack>
  );
}

function RecentSubmissions({ state }) {
  const items = state.data?.items ?? [];
  if (state.status === 'loading') return <Stack spacing={1}>{[0, 1, 2].map((k) => <Skeleton key={k} variant="rounded" height={44} />)}</Stack>;
  if (state.status === 'error') return <Typography color="text.secondary">Recent submissions could not be loaded.</Typography>;
  if (items.length === 0) return <Typography color="text.secondary">Your latest submissions appear here.</Typography>;
  return (
    <Stack component="ul" divider={<Box sx={{ borderTop: 1, borderColor: 'divider' }} />} sx={{ listStyle: 'none', p: 0, m: 0 }}>
      {items.map((s) => {
        const info = statusInfo(s.status);
        return (
          <Stack component="li" key={s.id} direction="row" sx={{ alignItems: 'center', gap: 1.5, py: 1.25 }}>
            <Box sx={{ flex: 1, minWidth: 0 }}>
              <Typography component={RouterLink} to={`/problems/${s.problemSlug}`} noWrap sx={{ display: 'block', fontWeight: 600, color: 'inherit', textDecoration: 'none', '&:hover': { color: 'primary.main' } }}>{s.problemTitle}</Typography>
              <Typography variant="caption" color="text.secondary">{s.language} · {fmtWhen(s.createdAt)}</Typography>
            </Box>
            <Chip size="small" label={info.label} color={info.color} />
          </Stack>
        );
      })}
    </Stack>
  );
}

/** Real per-user data from /dashboard/*. Nothing is estimated or invented in the browser. */
export default function DashboardPage() {
  const { user } = useAuth();
  const summary = useApiData('/dashboard/summary');
  const progress = useApiData('/dashboard/progress');
  const activity = useApiData('/dashboard/activity');
  const languages = useApiData('/dashboard/languages');
  const topics = useApiData('/dashboard/topics');
  const time = useApiData('/dashboard/time');
  const solvedList = useApiData('/problems', RECENT_SOLVED);
  const recent = useApiData('/submissions/mine', RECENT_SUBMISSIONS);

  const failed = summary.status === 'error' || progress.status === 'error';
  const loading = summary.status === 'loading' || progress.status === 'loading';
  const days = asArray(activity.data);
  const s = summary.data;
  const remaining = s ? Math.max(0, s.totalProblems - s.solvedCount) : 0;

  return (
    <Container maxWidth="lg" sx={{ py: { xs: 5, md: 8 }, overflowX: 'clip' }}>
      <Stack direction={{ xs: 'column', md: 'row' }} sx={{ justifyContent: 'space-between', alignItems: { md: 'flex-end' }, gap: 3, mb: 4 }}>
        <PageHeader
          label={user?.username ? `Welcome back, ${user.username}` : 'Your progress'}
          title="Dashboard"
          subtitle="Your solved problems, submissions and activity, counted from your saved work."
          sx={{ flex: 1, minWidth: 0 }}
        />
        <Stack direction="row" spacing={1.5} useFlexGap sx={{ flexWrap: 'wrap' }}>
          <Button component={RouterLink} to="/problems" variant="contained" endIcon={<ArrowForwardIcon />} sx={{ minHeight: 44, fontWeight: 700 }}>Browse problems</Button>
          <Button component={RouterLink} to="/submissions" variant="outlined" color="inherit" sx={{ minHeight: 44, fontWeight: 700, borderColor: 'divider', '&:hover': { borderColor: 'text.secondary', bgcolor: 'action.hover' } }}>Submission history</Button>
        </Stack>
      </Stack>

      {user && user.emailVerified === false && (
        <Alert severity="warning" variant="outlined" sx={{ mb: 3 }}>Your email address is not verified yet. Check your inbox for the verification link.</Alert>
      )}

      {failed ? (
        <Alert severity="error" variant="outlined">Your dashboard could not be loaded. Please try again later.</Alert>
      ) : loading ? (
        <Box aria-busy="true" aria-label="Loading dashboard" sx={{ display: 'grid', gap: 2, gridTemplateColumns: { xs: 'repeat(2, minmax(0, 1fr))', md: 'repeat(4, minmax(0, 1fr))' } }}>
          <Skeleton variant="rounded" height={220} sx={{ gridColumn: '1 / -1' }} />
          {[0, 1, 2, 3].map((k) => <Skeleton key={k} variant="rounded" height={96} />)}
        </Box>
      ) : (
        <Stack spacing={3}>
          {/* Overall + difficulty progress */}
          <Card component="section" aria-labelledby="progress-title"
            sx={CARD_SX}>
            <CardContent sx={{ p: { xs: 2.5, sm: 4 } }}>
              <Box sx={{ display: 'grid', gap: { xs: 3, md: 5 }, gridTemplateColumns: { xs: 'minmax(0, 1fr)', md: 'auto minmax(0, 1fr)' }, alignItems: 'center' }}>
                <Stack direction={{ xs: 'column', sm: 'row', md: 'column' }} spacing={2} sx={{ alignItems: 'center' }}>
                  <Ring solved={s.solvedCount} total={s.totalProblems} />
                  <Box sx={{ textAlign: { xs: 'center', sm: 'left', md: 'center' } }}>
                    <Typography sx={{ fontWeight: 700 }}>{s.solvedCount} of {s.totalProblems} solved</Typography>
                    <Typography variant="body2" color="text.secondary">{remaining} {remaining === 1 ? 'problem' : 'problems'} to go</Typography>
                  </Box>
                </Stack>
                <Box>
                  <Typography id="progress-title" variant="h6" component="h2" sx={{ fontWeight: 600, mb: 2 }}>Progress by difficulty</Typography>
                  <Stack spacing={2.5}>
                    {asArray(progress.data).map((p) => {
                      const pct = p.total > 0 ? Math.min(100, (p.solved / p.total) * 100) : 0;
                      return (
                        <Box key={p.difficulty}>
                          <Stack direction="row" sx={{ justifyContent: 'space-between', alignItems: 'baseline', mb: 0.75 }}>
                            <Typography sx={{ fontWeight: 600 }}>{difficultyLabel(p.difficulty)}</Typography>
                            <Typography color="text.secondary" sx={{ fontVariantNumeric: 'tabular-nums' }}>{p.solved} / {p.total}</Typography>
                          </Stack>
                          <Box sx={{ position: 'relative' }}>
                            <Box sx={{ height: 10, borderRadius: 5, overflow: 'hidden', bgcolor: 'action.hover' }}>
                              <Box sx={{ height: '100%', width: `${pct}%`, borderRadius: 5, bgcolor: `${BAR_COLOR[p.difficulty] ?? 'primary'}.main`, transition: 'width .6s ease', '@media (prefers-reduced-motion: reduce)': { transition: 'none' } }} />
                            </Box>
                            <Box role="progressbar" aria-label={`${difficultyLabel(p.difficulty)} problems solved`} aria-valuemin={0} aria-valuemax={100} aria-valuenow={Math.round(pct)} sx={{ position: 'absolute', inset: 0, opacity: 0, pointerEvents: 'none' }} />
                          </Box>
                        </Box>
                      );
                    })}
                  </Stack>
                </Box>
              </Box>
            </CardContent>
          </Card>

          {/* KPI tiles */}
          <Box sx={{ display: 'grid', gap: 2, gridTemplateColumns: { xs: 'repeat(2, minmax(0, 1fr))', sm: 'repeat(3, minmax(0, 1fr))', lg: 'repeat(4, minmax(0, 1fr))' } }}>
            <Tile label="Problems solved" value={s.solvedCount} icon={<TaskAltIcon fontSize="small" />} accent="success" />
            <Tile label="Problems available" value={s.totalProblems} icon={<LibraryBooksOutlinedIcon fontSize="small" />} accent="secondary" />
            <Tile label="Submissions" value={s.totalSubmissions} icon={<SendOutlinedIcon fontSize="small" />} />
            <Tile label="Accepted submissions" value={s.acceptedSubmissions} icon={<CheckCircleOutlineIcon fontSize="small" />} accent="success" />
            <Tile label="Problems attempted" value={s.attemptedProblems ?? 0} icon={<ExploreOutlinedIcon fontSize="small" />} accent="warning" />
            <Tile label="Acceptance rate" value={s.acceptanceRate == null ? '—' : `${s.acceptanceRate}%`} icon={<PercentIcon fontSize="small" />} />
            <Tile label="Timer total" value={fmtDuration(s.totalTimeMs)} icon={<TimerOutlinedIcon fontSize="small" />} accent="secondary" />
            {activity.status === 'success' && days.length > 0 && (
              <Tile label="Current streak" value={`${currentStreak(days)} ${currentStreak(days) === 1 ? 'day' : 'days'}`} icon={<LocalFireDepartmentIcon fontSize="small" />} accent="warning" hint="Consecutive UTC days with a submission" />
            )}
          </Box>
          <Typography variant="caption" color="text.secondary" component="p" sx={{ px: 0.5 }}>
            Counted from your saved submissions. Acceptance rate excludes submissions the judge could not rule on (service problems, insufficient verification).
          </Typography>

          {/* Activity */}
          <SectionCard id="activity-title" title="Recent activity">
            {activity.status === 'error' ? (
              <Alert severity="warning" variant="outlined">Activity could not be loaded.</Alert>
            ) : activity.status === 'loading' ? (
              <Skeleton variant="rounded" height={180} />
            ) : days.length === 0 || days.every((d) => d.submissions === 0) ? (
              <Alert severity="info" variant="outlined" action={<Button component={RouterLink} to="/problems" color="inherit" size="small">Browse problems</Button>}>No submissions yet. Solve a problem to see your activity here.</Alert>
            ) : (
              <ActivityChart days={days} />
            )}
          </SectionCard>

          {/* Solved problems + recent submissions */}
          <Box sx={{ display: 'grid', gap: 3, gridTemplateColumns: { xs: 'minmax(0, 1fr)', md: 'repeat(2, minmax(0, 1fr))' } }}>
            <SectionCard id="solved-title" title="Solved problems"
              action={<Button component={RouterLink} to="/problems?solved=true" size="small" endIcon={<ArrowForwardIcon fontSize="small" />}>View all</Button>}>
              <SolvedList state={solvedList} />
            </SectionCard>
            <SectionCard id="recent-title" title="Latest submissions"
              action={<Button component={RouterLink} to="/submissions" size="small" endIcon={<ArrowForwardIcon fontSize="small" />}>View all</Button>}>
              <RecentSubmissions state={recent} />
            </SectionCard>
          </Box>

          {/* Breakdowns */}
          <Box sx={{ display: 'grid', gap: 3, gridTemplateColumns: { xs: 'minmax(0, 1fr)', md: 'repeat(2, minmax(0, 1fr))' } }}>
            <BarList id="lang-title" title="Submissions by language" empty="No language data yet."
              loading={languages.status === 'loading'} failed={languages.status === 'error'}
              rows={asArray(languages.data).map((l) => ({ key: l.language, label: l.language, value: l.accepted, total: l.submissions, detail: `${l.accepted} accepted / ${l.submissions}` }))} />
            <BarList id="topic-title" title="Solved by topic" empty="Solve a tagged problem to see topics." color="success"
              loading={topics.status === 'loading'} failed={topics.status === 'error'}
              rows={asArray(topics.data).map((t) => ({ key: t.slug, label: t.topic, value: t.solved, total: t.attempted, detail: `${t.solved} solved / ${t.attempted} attempted` }))} />
            <Box sx={{ gridColumn: { md: '1 / -1' } }}>
              <BarList id="time-title" title="Time per problem" empty="Start a problem timer to track time." color="primary"
                loading={time.status === 'loading'} failed={time.status === 'error'}
                rows={asArray(time.data).map((t) => ({ key: t.slug, label: t.title, to: `/problems/${t.slug}`, solved: t.solved, value: t.timeMs, detail: `${fmtDuration(t.timeMs)}${t.solved ? ' · solved' : ' · in progress'}` }))} />
            </Box>
          </Box>
        </Stack>
      )}
    </Container>
  );
}
