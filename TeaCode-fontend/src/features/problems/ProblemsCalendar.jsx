import { useEffect, useMemo, useRef, useState } from 'react';
import { Box, Button, Card, IconButton, Skeleton, Stack, Tooltip, Typography } from '@mui/material';
import { alpha } from '@mui/material/styles';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import TodayIcon from '@mui/icons-material/Today';
import { useApiData } from '../../hooks/useApiData.js';
import { useAuth } from '../../hooks/useAuth.js';

const pad = (n) => String(n).padStart(2, '0');
export const toKey = (d) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
const monthKey = (d) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}`;
const sameDay = (a, b) => toKey(a) === toKey(b);
const startOfDay = (d) => new Date(d.getFullYear(), d.getMonth(), d.getDate());

/** First day of the week for the viewer's locale (0 = Sunday); falls back to Monday-agnostic Sunday. */
function weekStart() {
  try {
    const info = new Intl.Locale(navigator.language).weekInfo ?? new Intl.Locale(navigator.language).getWeekInfo?.();
    return info ? info.firstDay % 7 : 0;
  } catch {
    return 0;
  }
}

/** Builds the 6x7 grid of local dates for the month containing `cursor`. */
export function buildGrid(cursor, firstDay) {
  const first = new Date(cursor.getFullYear(), cursor.getMonth(), 1);
  const lead = (first.getDay() - firstDay + 7) % 7;
  return Array.from({ length: 42 }, (_, i) => new Date(first.getFullYear(), first.getMonth(), 1 - lead + i));
}

/** Milliseconds until the next local midnight, so "today" rolls over while the page stays open. */
const untilMidnight = () => {
  const n = new Date();
  return new Date(n.getFullYear(), n.getMonth(), n.getDate() + 1).getTime() - n.getTime() + 500;
};

/**
 * A real month calendar: highlights today (and moves to the next day at midnight), navigates by month,
 * and for signed-in users marks the days they submitted solutions (GET /dashboard/calendar). No data is invented.
 */
export default function ProblemsCalendar() {
  const { user } = useAuth();
  const firstDay = useMemo(weekStart, []);
  const [today, setToday] = useState(() => startOfDay(new Date()));
  const [cursor, setCursor] = useState(() => new Date(today.getFullYear(), today.getMonth(), 1));
  const [selected, setSelected] = useState(today);
  const gridRef = useRef(null);

  useEffect(() => {
    const t = setTimeout(() => setToday(startOfDay(new Date())), untilMidnight());
    return () => clearTimeout(t);
  }, [today]);

  const month = monthKey(cursor);
  const offsetMinutes = -new Date(cursor.getFullYear(), cursor.getMonth(), 15).getTimezoneOffset();
  const activity = useApiData('/dashboard/calendar', { month, offsetMinutes }, !user);
  const byDay = useMemo(() => {
    const m = new Map();
    (Array.isArray(activity.data) ? activity.data : []).forEach((d) => m.set(d.date, d));
    return m;
  }, [activity.data]);

  const grid = useMemo(() => buildGrid(cursor, firstDay), [cursor, firstDay]);
  const weekdays = useMemo(() => Array.from({ length: 7 }, (_, i) => {
    const d = new Date(2023, 0, 1 + ((firstDay + i) % 7)); // 2023-01-01 is a Sunday
    return { short: d.toLocaleDateString(undefined, { weekday: 'narrow' }), long: d.toLocaleDateString(undefined, { weekday: 'long' }) };
  }), [firstDay]);

  const title = cursor.toLocaleDateString(undefined, { month: 'long', year: 'numeric' });
  const shift = (n) => setCursor((c) => new Date(c.getFullYear(), c.getMonth() + n, 1));
  const goToday = () => { setCursor(new Date(today.getFullYear(), today.getMonth(), 1)); setSelected(today); };
  const pick = (d) => { setSelected(d); if (d.getMonth() !== cursor.getMonth()) setCursor(new Date(d.getFullYear(), d.getMonth(), 1)); };

  const onKeyDown = (e) => {
    const step = { ArrowLeft: -1, ArrowRight: 1, ArrowUp: -7, ArrowDown: 7 }[e.key];
    if (step === undefined) return;
    e.preventDefault();
    const next = new Date(selected.getFullYear(), selected.getMonth(), selected.getDate() + step);
    pick(next);
    requestAnimationFrame(() => gridRef.current?.querySelector(`[data-date="${toKey(next)}"]`)?.focus());
  };

  const sel = byDay.get(toKey(selected));
  const selLabel = selected.toLocaleDateString(undefined, { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
  const viewingCurrent = cursor.getFullYear() === today.getFullYear() && cursor.getMonth() === today.getMonth();
  const monthTotal = [...byDay.values()].reduce((a, d) => a + d.submissions, 0);

  return (
    <Card component="section" aria-labelledby="calendar-title" sx={{ p: 2 }}>
      <Stack direction="row" sx={{ alignItems: 'center', justifyContent: 'space-between', mb: 1 }}>
        <Typography id="calendar-title" variant="h6" component="h2" aria-live="polite">{title}</Typography>
        <Stack direction="row" spacing={0.5}>
          <IconButton size="small" aria-label="Previous month" onClick={() => shift(-1)}><ChevronLeftIcon /></IconButton>
          <IconButton size="small" aria-label="Next month" onClick={() => shift(1)}><ChevronRightIcon /></IconButton>
        </Stack>
      </Stack>

      <Box role="grid" aria-labelledby="calendar-title" ref={gridRef} onKeyDown={onKeyDown} sx={{ display: 'grid', gridTemplateColumns: 'repeat(7, minmax(0, 1fr))', gap: '2px', textAlign: 'center' }}>
        <Box role="row" sx={{ display: 'contents' }}>
          {weekdays.map((w, i) => (
            <Typography key={i} role="columnheader" aria-label={w.long} variant="caption" color="text.secondary" sx={{ fontWeight: 700, py: 0.5 }}>{w.short}</Typography>
          ))}
        </Box>
        {Array.from({ length: 6 }, (_, row) => (
          <Box key={row} role="row" sx={{ display: 'contents' }}>
            {grid.slice(row * 7, row * 7 + 7).map((d) => {
              const key = toKey(d);
              const inMonth = d.getMonth() === cursor.getMonth();
              const isToday = sameDay(d, today);
              const isSel = sameDay(d, selected);
              const a = byDay.get(key);
              const fullLabel = `${d.toLocaleDateString(undefined, { weekday: 'long', month: 'long', day: 'numeric' })}${isToday ? ', today' : ''}${a ? `, ${a.submissions} ${a.submissions === 1 ? 'submission' : 'submissions'}, ${a.accepted} accepted` : ''}`;
              return (
                <Box key={key} role="gridcell" aria-selected={isSel} sx={{ display: 'flex', justifyContent: 'center' }}>
                  <Tooltip title={a ? `${a.submissions} submitted · ${a.accepted} accepted` : ''} disableHoverListener={!a} arrow>
                    <Box component="button" type="button" data-date={key} aria-label={fullLabel} aria-current={isToday ? 'date' : undefined}
                      tabIndex={isSel ? 0 : -1} onClick={() => pick(d)}
                      sx={(t) => ({
                        position: 'relative', width: '100%', maxWidth: 40, aspectRatio: '1', border: 0, borderRadius: '50%', cursor: 'pointer', font: 'inherit', fontSize: '0.85rem',
                        fontWeight: isToday || isSel ? 800 : inMonth ? 500 : 400, fontVariantNumeric: 'tabular-nums',
                        color: isToday ? t.palette.primary.contrastText : inMonth ? t.palette.text.primary : t.palette.text.secondary,
                        bgcolor: isToday ? t.palette.primary.main : a ? alpha(t.palette.primary.main, a.accepted ? 0.22 : 0.1) : 'transparent',
                        outline: isSel && !isToday ? `2px solid ${t.palette.primary.main}` : 'none', outlineOffset: -2,
                        '&:hover': { bgcolor: isToday ? t.palette.primary.dark : t.palette.action.hover },
                        '&:focus-visible': { outline: `2px solid ${t.palette.text.primary}`, outlineOffset: 1 },
                      })}>
                      {d.getDate()}
                      {a && <Box aria-hidden="true" component="span" sx={{ position: 'absolute', bottom: 3, left: '50%', width: 4, height: 4, ml: '-2px', borderRadius: '50%', bgcolor: isToday ? 'primary.contrastText' : a.accepted ? 'success.main' : 'warning.main' }} />}
                    </Box>
                  </Tooltip>
                </Box>
              );
            })}
          </Box>
        ))}
      </Box>

      <Stack direction="row" sx={{ alignItems: 'center', justifyContent: 'space-between', mt: 1.5 }}>
        <Button size="small" startIcon={<TodayIcon />} onClick={goToday} disabled={viewingCurrent && sameDay(selected, today)}>Today</Button>
        {user && activity.status === 'success' && <Typography variant="caption" color="text.secondary">{monthTotal} {monthTotal === 1 ? 'submission' : 'submissions'} this month</Typography>}
      </Stack>

      <Box aria-live="polite" sx={{ mt: 1.5, pt: 1.5, borderTop: 1, borderColor: 'divider' }}>
        <Typography variant="body2" sx={{ fontWeight: 700 }}>{selLabel}</Typography>
        {!user ? (
          <Typography variant="body2" color="text.secondary">Log in to see the days you solved problems.</Typography>
        ) : activity.status === 'loading' ? (
          <Skeleton width="60%" />
        ) : activity.status === 'error' ? (
          <Typography variant="body2" color="text.secondary">Activity could not be loaded.</Typography>
        ) : sel ? (
          <Typography variant="body2" color="text.secondary">{sel.submissions} {sel.submissions === 1 ? 'submission' : 'submissions'}, {sel.accepted} accepted</Typography>
        ) : (
          <Typography variant="body2" color="text.secondary">No submissions on this day.</Typography>
        )}
      </Box>
    </Card>
  );
}
