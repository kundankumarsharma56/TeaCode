import { useState } from 'react';
import { Alert, Box, Button, Card, Chip, Container, Skeleton, Stack, Tab, Tabs, Typography } from '@mui/material';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import ContentCopyIcon from '@mui/icons-material/ContentCopy';
import { Link as RouterLink, useParams } from 'react-router-dom';
import { useApiData } from '../../hooks/useApiData.js';
import { MONO_FONT } from '../../theme/theme.js';
import { STATUS_NOTE, statusInfo } from '../workspace/ResultsPanel.jsx';
import { formatDateTime, formatMemory } from '../../utils/format.js';

// TeaCode card surface: thin border, no shadow, no gradient.
const CARD_SX = { border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper', boxShadow: 'none', backgroundImage: 'none' };

function Metric({ label, children }) {
  return (
    <Card variant="outlined" sx={{ ...CARD_SX, p: 2, flex: 1, minWidth: 0 }}>
      <Typography variant="overline" color="text.secondary" component="h2">{label}</Typography>
      <Typography variant="h5" component="p" sx={{ fontWeight: 700 }}>{children}</Typography>
    </Card>
  );
}

function CodePanel({ code }) {
  const [copied, setCopied] = useState('');
  const copy = async () => {
    try {
      await navigator.clipboard.writeText(code);
      setCopied('Copied to clipboard.');
    } catch {
      setCopied('Copy is not available in this browser. Select the code and copy it manually.');
    }
  };
  return (
    <Box>
      <Stack direction="row" sx={{ justifyContent: 'flex-end', mb: 1 }}>
        <Button size="small" startIcon={<ContentCopyIcon />} onClick={copy}>Copy code</Button>
      </Stack>
      <Box component="pre" tabIndex={0} aria-label="Submitted source code (read only)"
        sx={{ m: 0, p: 2, border: 1, borderColor: 'divider', borderRadius: 2, bgcolor: 'background.paper', fontFamily: MONO_FONT, fontSize: 13, lineHeight: 1.6, whiteSpace: 'pre', overflow: 'auto', maxHeight: '65vh' }}>
        {code}
      </Box>
      <Typography role="status" variant="caption" color="text.secondary" sx={{ display: 'block', minHeight: 20, mt: 0.5 }}>{copied}</Typography>
    </Box>
  );
}

function ErrorState({ error, onRetry }) {
  const code = error?.response?.status;
  if (code === 404 || code === 403) {
    return <Alert severity="warning" variant="outlined" action={<Button component={RouterLink} to="/submissions" color="inherit" size="small">Back to history</Button>}>This submission does not exist or is not yours.</Alert>;
  }
  if (code === 401) {
    return <Alert severity="info" variant="outlined" action={<Button component={RouterLink} to="/login" color="inherit" size="small">Log in</Button>}>Log in to view your submissions.</Alert>;
  }
  return <Alert severity="error" variant="outlined" action={<Button color="inherit" size="small" onClick={onRetry}>Retry</Button>}>The submission could not be loaded. Please try again.</Alert>;
}

/** Owner-only view of one judged submission. Only aggregate results are shown: hidden test data never reaches the browser. */
export default function SubmissionDetailPage() {
  const { id } = useParams();
  const [attempt, setAttempt] = useState(0);
  const [tab, setTab] = useState('summary');
  const valid = /^\d+$/.test(id ?? '');
  const detail = useApiData(`/submissions/${id}`, { _: attempt }, !valid);
  const data = detail.data;
  const info = statusInfo(data?.status);
  const memory = formatMemory(data?.memoryKb);

  let body;
  if (!valid) {
    body = <Alert severity="warning" variant="outlined" action={<Button component={RouterLink} to="/submissions" color="inherit" size="small">Back to history</Button>}>This submission does not exist.</Alert>;
  } else if (detail.status === 'loading' || detail.status === 'idle') {
    body = <Stack spacing={2} aria-busy="true" aria-label="Loading submission"><Skeleton variant="rounded" height={64} /><Skeleton variant="rounded" height={96} /><Skeleton variant="rounded" height={240} /></Stack>;
  } else if (detail.status === 'error') {
    body = <ErrorState error={detail.error} onRetry={() => setAttempt((n) => n + 1)} />;
  } else {
    const accepted = data.status === 'ACCEPTED';
    body = (
      <Stack spacing={3}>
        <Box>
          <Box component="p" sx={{ display: 'inline-block', m: 0, mb: 2, px: 1.5, py: 0.5, border: 1, borderColor: 'divider', borderRadius: 5, fontSize: 13, color: 'text.secondary' }}>Submission</Box>
          <Typography variant="h4" component="h1" sx={{ fontWeight: 700, letterSpacing: '-0.02em', color: accepted ? 'success.main' : 'text.primary' }}>
            {info.label}
            {data.totalTests > 0 && <Typography component="span" color="text.secondary" sx={{ fontSize: 18, fontWeight: 500, ml: 1.5 }}>
              {data.passedTests} / {data.totalTests} test cases passed
            </Typography>}
          </Typography>
          <Stack direction="row" useFlexGap sx={{ flexWrap: 'wrap', gap: 1, mt: 1, alignItems: 'center' }}>
            <Chip size="small" label={data.language} />
            <Typography variant="body2" color="text.secondary">Submission #{data.id}</Typography>
            <Typography variant="body2" color="text.secondary">· {formatDateTime(data.createdAt)}</Typography>
          </Stack>
          {STATUS_NOTE[data.status] && <Alert severity="info" variant="outlined" sx={{ mt: 2 }}>{STATUS_NOTE[data.status]}</Alert>}
        </Box>

        <Stack direction={{ xs: 'column', sm: 'row' }} sx={{ gap: 2 }}>
          <Metric label="Runtime">{data.executionTimeMs != null ? <>{data.executionTimeMs} <Typography component="span" color="text.secondary">ms</Typography></> : '—'}</Metric>
          <Metric label="Memory">{memory ? <>{memory.value} <Typography component="span" color="text.secondary">{memory.unit}</Typography></> : '—'}</Metric>
        </Stack>
        <Typography variant="body2" color="text.secondary">
          Runtime and memory are the largest values the judge measured across the test cases. No percentile comparison is shown:
          TeaCode does not yet have enough accepted submissions in a comparable cohort (same problem and language) to compute one honestly.
        </Typography>

        <Box>
          <Tabs value={tab} onChange={(_, v) => setTab(v)} aria-label="Submission sections">
            <Tab value="summary" label="Summary" id="tab-summary" aria-controls="panel-summary" />
            <Tab value="code" label="Code" id="tab-code" aria-controls="panel-code" />
          </Tabs>
          <Box role="tabpanel" id={`panel-${tab}`} aria-labelledby={`tab-${tab}`} sx={{ pt: 2 }}>
            {tab === 'summary' ? (
              <Stack spacing={1}>
                <Typography>Problem: <Typography component={RouterLink} to={`/problems/${data.problemSlug}`} color="primary" sx={{ fontWeight: 600 }}>{data.problemTitle}</Typography></Typography>
                <Typography>Result: {info.label}{data.totalTests > 0 ? `, ${data.passedTests} of ${data.totalTests} test cases passed.` : '.'}</Typography>
                <Typography color="text.secondary" variant="body2">Hidden test inputs and expected outputs are never shown.</Typography>
              </Stack>
            ) : <CodePanel code={data.sourceCode ?? ''} />}
          </Box>
        </Box>
      </Stack>
    );
  }

  return (
    <Container maxWidth="md" sx={{ py: { xs: 5, md: 8 } }}>
      <Button component={RouterLink} to="/submissions" startIcon={<ArrowBackIcon />} color="inherit" sx={{ mb: 3, color: 'text.secondary', '&:hover': { color: 'text.primary', bgcolor: 'action.hover' } }}>Practice history</Button>
      {body}
    </Container>
  );
}
