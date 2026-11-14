import { useMemo } from 'react';
import { Alert, Box, Chip, Link, Stack, Typography } from '@mui/material';
import { difficultyLabel } from '../landing/PopularProblems.jsx';
import Markdown, { ExampleBox, headingSx } from '../../components/Markdown.jsx';
import { describe, parseMarkdown } from '../../utils/markdown.js';

const DIFFICULTY_COLOR = { EASY: 'success', MEDIUM: 'warning', HARD: 'error', UNRATED: 'default' };
const SOURCE_NAME = { PACKAGE: 'Imported problem package' };

// Sections that the statement itself may already contain as headings. When it does, the separate structured field is
// not shown again. Nothing is invented: a structured field that the statement does not cover is still displayed.
const COVERED_BY = {
  input: /^input( format)?$/,
  output: /^output( format)?$/,
  constraints: /^constraints?$/,
  examples: /^(examples?|sample( tests?| cases?)?)$/,
};
const covers = (headings, key) => headings.some((h) => COVERED_BY[key].test(h));

const norm = (s) => String(s ?? '').trim().replace(/\r\n?/g, '\n');

function Section({ title, children }) {
  return (
    <Box component="section" sx={{ minWidth: 0 }}>
      <Typography component="h2" sx={headingSx(2)}>{title}</Typography>
      {children}
    </Box>
  );
}

// Statement text is parsed to a safe AST and rendered as elements. Never as HTML.
const Plain = ({ children }) => <Typography sx={{ lineHeight: 1.75, whiteSpace: 'pre-wrap', overflowWrap: 'anywhere' }}>{children}</Typography>;

export default function ProblemPanel({ problem }) {
  const blocks = useMemo(() => (problem.statementAvailable === false ? [] : parseMarkdown(problem.description)), [problem.description, problem.statementAvailable]);
  const { headings, code } = useMemo(() => describe(blocks), [blocks]);

  // A sample whose input and output already appear as code blocks in the statement is not repeated.
  const extraSamples = (problem.sampleCases ?? [])
    .map((c, index) => ({ c, number: index + 1 }))
    .filter(({ c }) => !(code.includes(norm(c.input)) && code.includes(norm(c.expectedOutput))));
  const showSamples = extraSamples.length > 0;
  const samplesTitle = covers(headings, 'examples') ? 'More examples' : 'Examples';
  const hasStatement = problem.statementAvailable !== false;

  return (
    <Stack spacing={3} sx={{ minWidth: 0, maxWidth: 760, mx: 'auto', width: '100%' }}>
      <Box component="header">
        <Typography variant="h4" component="h1" sx={{ mb: 1.5, fontSize: { xs: '1.6rem', sm: '2rem' }, fontWeight: 700, letterSpacing: '-0.01em', lineHeight: 1.2, overflowWrap: 'anywhere' }}>{problem.title}</Typography>
        <Stack direction="row" spacing={1} useFlexGap sx={{ flexWrap: 'wrap', alignItems: 'center' }} aria-label="Problem details">
          <Chip size="small" variant="outlined" label={difficultyLabel(problem.difficulty)} color={DIFFICULTY_COLOR[problem.difficulty] ?? 'default'} sx={{ fontWeight: 600 }} />
          {problem.rating != null && <Chip size="small" variant="outlined" label={`Rating ${problem.rating}`} sx={{ borderColor: 'divider', color: 'text.secondary' }} />}
          {(problem.tags ?? []).map((t) => <Chip key={t.slug} size="small" variant="outlined" label={t.name} sx={{ borderColor: 'divider', color: 'text.secondary' }} />)}
        </Stack>
        {SOURCE_NAME[problem.source] && (
          <Typography variant="body2" color="text.secondary" sx={{ mt: 1.5 }}>
            Source: {SOURCE_NAME[problem.source]}
            {problem.sourceUrl && <> · <Link href={problem.sourceUrl} target="_blank" rel="noopener noreferrer">Original problem</Link></>}
          </Typography>
        )}
      </Box>

      {!hasStatement ? (
        <Alert severity="info" variant="outlined">
          The full statement and sample data for this problem are not stored here.
          {problem.sourceUrl ? <> <Link href={problem.sourceUrl} target="_blank" rel="noopener noreferrer">Open the original problem</Link>.</> : null}
          {' '}Code cannot be judged against it on this server.
        </Alert>
      ) : (
        <Markdown blocks={blocks} />
      )}

      {hasStatement && problem.testDataStatus === 'SAMPLES_ONLY' && (
        <Alert severity="warning" variant="outlined">Only sample tests are available for this problem. Passing them cannot be confirmed as Accepted (hidden tests unavailable).</Alert>
      )}

      {problem.inputFormat && !covers(headings, 'input') && <Section title="Input format"><Plain>{problem.inputFormat}</Plain></Section>}
      {problem.outputFormat && !covers(headings, 'output') && <Section title="Output format"><Plain>{problem.outputFormat}</Plain></Section>}
      {problem.constraints && !covers(headings, 'constraints') && <Section title="Constraints"><Plain>{problem.constraints}</Plain></Section>}

      {showSamples && (
        <Section title={samplesTitle}>
          <Stack spacing={1}>
            {extraSamples.map(({ c, number }) => (
              <Box key={number}>
                <Typography component="h3" sx={{ fontSize: '0.95rem', fontWeight: 700, mb: 0.5 }}>Example {number}</Typography>
                <ExampleBox items={[{ label: 'Input', text: c.input }, { label: 'Output', text: c.expectedOutput }]} />
              </Box>
            ))}
          </Stack>
        </Section>
      )}
    </Stack>
  );
}
