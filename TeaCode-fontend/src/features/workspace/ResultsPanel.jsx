import { Alert, Box, Chip, CircularProgress, Stack, Typography } from '@mui/material';

const STATUS = {
  ACCEPTED: { label: 'Accepted', color: 'success' },
  WRONG_ANSWER: { label: 'Wrong Answer', color: 'error' },
  COMPILATION_ERROR: { label: 'Compilation Error', color: 'error' },
  RUNTIME_ERROR: { label: 'Runtime Error', color: 'error' },
  TIME_LIMIT_EXCEEDED: { label: 'Time Limit Exceeded', color: 'warning' },
  MEMORY_LIMIT_EXCEEDED: { label: 'Memory Limit Exceeded', color: 'warning' },
  SAMPLES_PASSED: { label: 'Sample tests passed', color: 'info' },
  INSUFFICIENT_VERIFICATION: { label: 'Insufficient verification', color: 'warning' },
  SERVICE_UNAVAILABLE: { label: 'Service unavailable', color: 'default' },
  FINISHED: { label: 'Finished', color: 'default' },
  NOT_RUN: { label: 'Not run', color: 'default' },
  EXECUTION_SERVICE_ERROR: { label: 'Execution service error', color: 'default' },
};

export function statusInfo(status) {
  return STATUS[status] ?? { label: status ?? 'Unknown', color: 'default' };
}

// Plain-language explanation shown under a verdict where the label alone could mislead.
export const STATUS_NOTE = {
  SAMPLES_PASSED: 'Only the sample tests were run. This is not a final verdict; use Submit to be judged on the full test suite.',
  INSUFFICIENT_VERIFICATION: 'Your code passed every available test, but this problem has no private tests on this server, so it cannot be marked Accepted.',
  FINISHED: 'The program returned output. The compiler service does not report an exit status.',
};

// Backend error codes (job.errorCode or response code) mapped to what the person can do about them.
export const CODE_KIND = {
  EXECUTION_SERVICE_UNAVAILABLE: 'service',
  EXECUTION_NOT_CONFIGURED: 'not_configured',
  EXECUTION_CREDENTIALS_REJECTED: 'credentials',
  EXECUTION_QUOTA_EXCEEDED: 'quota',
  EXECUTION_BUSY: 'busy',
  TEST_DATA_UNAVAILABLE: 'no_tests',
  TEST_SUITE_TOO_LARGE: 'too_large',
  EXECUTION_TIMEOUT: 'timeout',
};

export const ERROR_TEXT = {
  not_configured: 'Code execution is not set up on this server yet, so nothing was run.',
  credentials: 'The execution service rejected this server\'s credentials. The operator needs to check them. Your code was not judged.',
  quota: 'The free daily limit for running code is used up, so your code was not run. It resets at 12:00 AM UTC (5:30 AM IST). Please try again after that.',
  busy: 'The execution service is busy right now. Your code was not judged. Please try again shortly.',
  no_tests: 'No test data is available for this problem, so it cannot be judged.',
  too_large: 'This problem has more tests than this server is configured to run in one submission.',
  unsupported: 'This problem or language combination is not supported for judging.',
  auth: 'Log in to run or submit code.',
  rate: 'You are sending requests too quickly. Please wait a moment and try again.',
  service: 'The code execution service is unavailable right now. Your code was not judged. Please try again later.',
  network: 'Could not reach the server. Check your connection and try again.',
  timeout: 'Judging is taking longer than expected. Check your submission history later for the result.',
  other: 'The request failed. Please try again.',
};

const Mono = ({ children }) => (
  <Box component="pre" sx={{ m: 0, p: 1.5, bgcolor: 'background.default', border: 1, borderColor: 'divider', borderRadius: 2, overflow: 'auto', fontFamily: 'ui-monospace, Menlo, monospace', fontSize: 13, whiteSpace: 'pre-wrap', wordBreak: 'break-word' }}>{children}</Box>
);

function CaseResult({ c }) {
  const info = statusInfo(c.status);
  return (
    <Box sx={{ border: 1, borderColor: 'divider', borderRadius: 3, p: 1.75, '& pre': { mt: 0.5, mb: 1 } }}>
      <Stack direction="row" spacing={1} sx={{ alignItems: 'center', flexWrap: 'wrap', mb: 1 }} useFlexGap>
        <Typography component="h4" sx={{ fontWeight: 600 }}>{c.sample ? `Sample ${c.index}` : `Test ${c.index}`}</Typography>
        <Chip size="small" variant="outlined" label={info.label} color={info.color} sx={{ fontWeight: 600 }} />
        {c.timeMs != null && <Typography variant="caption" color="text.secondary">{c.timeMs} ms</Typography>}
        {c.memoryKb != null && <Typography variant="caption" color="text.secondary">{c.memoryKb} KB</Typography>}
      </Stack>
      {/* Hidden cases never include input/expected output; only sample cases may. */}
      {c.sample && c.input != null && <><Typography variant="caption" color="text.secondary">Input</Typography><Mono>{c.input}</Mono></>}
      {c.sample && c.expected != null && <><Typography variant="caption" color="text.secondary">Expected</Typography><Mono>{c.expected}</Mono></>}
      {c.sample && c.actual != null && <><Typography variant="caption" color="text.secondary">Your output</Typography><Mono>{c.actual}</Mono></>}
      {c.stderr && <><Typography variant="caption" color="text.secondary">Error output</Typography><Mono>{c.stderr}</Mono></>}
    </Box>
  );
}

export default function ResultsPanel({ phase, mode, job, error }) {
  if (phase === 'idle') {
    return <Typography color="text.secondary">Run your code against the sample cases, or submit it to be judged on all tests.</Typography>;
  }
  if (phase === 'starting' || phase === 'polling') {
    const label = job?.state === 'RUNNING' ? 'Running…' : 'Queued…';
    return (
      <Stack direction="row" spacing={1.5} sx={{ alignItems: 'center' }} role="status" aria-live="polite">
        <CircularProgress size={20} aria-hidden="true" />
        <Typography>{phase === 'starting' ? `Sending your ${mode === 'submit' ? 'submission' : 'code'}…` : label}</Typography>
      </Stack>
    );
  }
  if (phase === 'error') {
    return <Alert severity={error?.kind === 'service' ? 'warning' : 'error'} variant="outlined" role="alert">{ERROR_TEXT[error?.kind] ?? ERROR_TEXT.other}</Alert>;
  }

  // phase === 'done'
  if (job.state === 'FAILED') {
    return <Alert severity="warning" variant="outlined" role="alert">{ERROR_TEXT[CODE_KIND[job.errorCode] ?? 'other']}</Alert>;
  }
  const info = statusInfo(job.status);
  return (
    <Stack spacing={2} aria-live="polite">
      <Stack direction="row" spacing={1.5} sx={{ alignItems: 'center', flexWrap: 'wrap' }} useFlexGap>
        <Typography variant="h6" component="h3" sx={{ fontWeight: 700 }} color={info.color === 'default' ? 'text.primary' : `${info.color}.main`}>{info.label}</Typography>
        {job.totalTests != null && <Typography color="text.secondary">{job.passedTests}/{job.totalTests} tests passed</Typography>}
        {job.executionTimeMs != null && <Typography variant="body2" color="text.secondary">{job.executionTimeMs} ms</Typography>}
        {job.memoryKb != null && <Typography variant="body2" color="text.secondary">{job.memoryKb} KB</Typography>}
      </Stack>
      {STATUS_NOTE[job.status] && <Alert severity={job.status === 'SAMPLES_PASSED' ? 'info' : 'warning'} variant="outlined">{STATUS_NOTE[job.status]}</Alert>}
      {job.compileOutput && <><Typography variant="subtitle2" component="h3">Compiler output</Typography><Mono>{job.compileOutput}</Mono></>}
      {(job.cases ?? []).map((c) => <CaseResult key={`${c.sample}-${c.index}`} c={c} />)}
    </Stack>
  );
}
