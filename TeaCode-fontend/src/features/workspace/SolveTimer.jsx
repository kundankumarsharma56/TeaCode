import { useState } from 'react';
import { Button, Stack, Tooltip, Typography } from '@mui/material';
import TimerOutlinedIcon from '@mui/icons-material/TimerOutlined';
import PlayArrowIcon from '@mui/icons-material/PlayArrow';
import PauseIcon from '@mui/icons-material/Pause';
import RestartAltIcon from '@mui/icons-material/RestartAlt';
import { formatElapsed } from './useTimer.js';

const BTN_SX = { color: 'text.secondary', minHeight: 32, fontWeight: 600, '&:hover': { color: 'text.primary', bgcolor: 'action.hover' } };
const NOTE = 'Counts the time between Start/Resume and Pause, kept on the server. It is not coding time and it does not stop by itself when you leave the page. One running stretch counts at most 4 hours.';

export default function SolveTimer({ timer }) {
  const [error, setError] = useState(false);
  if (timer.status === 'idle' || timer.status === 'loading') return null;
  if (timer.status === 'unavailable') {
    return <Typography variant="caption" color="text.secondary">The timer is unavailable right now. Your code can still be run and submitted.</Typography>;
  }
  const run = (fn) => fn().then(() => setError(false)).catch(() => setError(true));
  const running = timer.state === 'RUNNING';
  return (
    <Stack direction="row" spacing={1.5} sx={{ alignItems: 'center', flexWrap: 'wrap' }} useFlexGap>
      <Tooltip title={NOTE}><TimerOutlinedIcon aria-label="About the timer" sx={{ color: 'text.secondary' }} /></Tooltip>
      <Typography component="span" role="timer" aria-label="Time spent on this problem" sx={{ fontVariantNumeric: 'tabular-nums', fontWeight: 700, fontFamily: 'ui-monospace, Menlo, monospace', fontSize: '0.95rem' }}>
        {formatElapsed(timer.elapsedMs)}
      </Typography>
      <Typography variant="body2" color="text.secondary">{running ? 'Running' : timer.state === 'PAUSED' ? 'Paused' : 'Not started'}</Typography>
      {running ? (
        <Button size="small" color="inherit" sx={BTN_SX} startIcon={<PauseIcon />} disabled={timer.busy} onClick={() => run(timer.pause)}>Pause</Button>
      ) : (
        <Button size="small" color="inherit" sx={BTN_SX} startIcon={<PlayArrowIcon />} disabled={timer.busy} onClick={() => run(timer.start)}>{timer.state === 'PAUSED' ? 'Resume' : 'Start'}</Button>
      )}
      <Button size="small" color="inherit" sx={BTN_SX} startIcon={<RestartAltIcon />} disabled={timer.busy || timer.state === 'IDLE'} onClick={() => run(timer.reset)}>Reset</Button>
      {error && <Typography variant="caption" color="error" role="alert">The timer could not be updated. Try again.</Typography>}
    </Stack>
  );
}
