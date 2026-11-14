import { Box, Typography } from '@mui/material';
import { MONO_FONT } from '../../../theme/theme.js';

// A drawn replica of the TeaCode problem workspace: the problem on the left, the Java solution and terminal on the
// right. It is built from markup, not a screenshot, and it is labelled as an illustration. The program is real:
// Total Set Bits From 1 to N prints 4 for 3 and 13 for 8 (1+1+2+1+2+2+3+1).
const C = { kw: '#E07B54', fn: '#F3D9C9', num: '#7DD3FC', typ: '#C4B5FD', txt: '#F2EFEC', dim: '#A8A29C', gutter: '#8A847E', ok: '#4CC38A', hard: '#FF7B72', line: '#2A2A2E' };

const LINES = [
  'public class Main {',
  '    static long solve(long n) {',
  '        long total = 0;',
  '        for (int i = 0; (1L << i) <= n; i++) {',
  '            long p = 1L << (i + 1), h = 1L << i;',
  '            total += (n + 1) / p * h + Math.max(0, (n + 1) % p - h);',
  '        }',
  '        return total;',
  '    }',
  '',
  '    public static void main(String[] a) {',
  '        long n = new java.util.Scanner(System.in).nextLong();',
  '        System.out.println(solve(n));',
  '    }',
  '}',
];

const CONSTRAINT = '1 <= N <= 1000000000000';
const TOPICS = ['Bit Manipulation', 'Math'];
const EXAMPLES = [
  { n: 1, input: '3', output: '4', why: '1 = 1, 2 = 10, 3 = 11 contain 1 + 1 + 2 = 4 set bits.' },
  { n: 2, input: '8', output: '13', why: '1..8 have 1, 1, 2, 1, 2, 2, 3, 1 set bits.' },
];

const TOKEN = /\b(public|class|static|long|int|for|return|new)\b|(\b\d+L?\b)|(\b[A-Z]\w*\b)|(\b[a-z]\w*(?=\())/g;

// Tiny highlighter: keywords, numbers, class names, called methods. Everything else is plain text.
function tokenize(line) {
  const out = [];
  let last = 0;
  for (const m of line.matchAll(TOKEN)) {
    if (m.index > last) out.push(['txt', line.slice(last, m.index)]);
    out.push([m[1] ? 'kw' : m[2] ? 'num' : m[3] ? 'typ' : 'fn', m[0]]);
    last = m.index + m[0].length;
  }
  if (last < line.length) out.push(['txt', line.slice(last)]);
  return out;
}

function Mono({ children }) {
  return <Box component="span" sx={{ fontFamily: MONO_FONT, fontSize: '0.92em', px: 0.6, py: 0.1, borderRadius: 0.75, bgcolor: '#1C1C1F', color: C.fn }}>{children}</Box>;
}

function Label({ children }) {
  return <Typography component="div" sx={{ fontSize: 11, fontWeight: 700, letterSpacing: '0.1em', textTransform: 'uppercase', color: C.dim, mt: 2, mb: 0.5 }}>{children}</Typography>;
}

function Tag({ children, color = C.dim }) {
  return <Box component="span" sx={{ px: 1, py: 0.2, border: 1, borderColor: C.line, borderRadius: 5, fontSize: 11.5, fontWeight: 600, color }}>{children}</Box>;
}

export default function TerminalPreview() {
  return (
    <Box
      role="img"
      aria-label="Illustration of the TeaCode online terminal: the problem Total Set Bits From 1 to N, a Java solution run with the input 8, printing 13."
      sx={{ width: '100%', maxWidth: 1360, mx: 'auto', border: 1, borderColor: C.line, borderRadius: 3, overflow: 'hidden', bgcolor: '#0E0E10', boxShadow: '0 30px 80px rgba(0,0,0,.45)', textAlign: 'left' }}
    >
      {/* top bar */}
      <Box sx={{ display: 'flex', alignItems: 'center', gap: 1.5, px: 2, py: 1.25, bgcolor: '#141415', borderBottom: 1, borderColor: C.line }}>
        <Box sx={{ display: 'flex', gap: 0.75 }}>
          {['#FF5F57', '#FEBC2E', '#28C840'].map((c) => <Box key={c} sx={{ width: 11, height: 11, borderRadius: '50%', bgcolor: c }} />)}
        </Box>
        <Typography component="span" sx={{ fontSize: 12.5, color: C.dim, display: { xs: 'none', sm: 'inline' } }}>Total Set Bits From 1 to N</Typography>
        <Box sx={{ ml: 'auto', display: 'flex', alignItems: 'center', gap: 1.25 }}>
          <Typography component="span" sx={{ display: { xs: 'none', sm: 'inline' }, fontSize: 12, color: C.dim }}>Illustrative preview</Typography>
          <Box sx={{ px: 1.25, py: 0.4, border: 1, borderColor: C.line, borderRadius: 1.5, fontSize: 12.5, color: C.txt }}>Java</Box>
          <Box sx={{ px: 1.75, py: 0.5, borderRadius: 1.5, bgcolor: '#F2EFEC', color: '#0B0B0C', fontSize: 12.5, fontWeight: 700 }}>Run</Box>
        </Box>
      </Box>

      <Box sx={{ display: 'grid', gridTemplateColumns: { xs: 'minmax(0, 1fr)', md: 'minmax(0, 0.95fr) minmax(0, 1.05fr)' } }}>
        {/* problem */}
        <Box sx={{ p: { xs: 2, sm: 2.5 }, fontSize: 13.5, lineHeight: 1.65, color: C.txt, borderBottom: { xs: 1, md: 0 }, borderRight: { md: 1 }, borderColor: C.line }}>
          <Typography component="div" sx={{ fontSize: 18, fontWeight: 700, lineHeight: 1.3 }}>Total Set Bits From 1 to N</Typography>
          <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 0.75, mt: 1 }}>
            <Tag color={C.hard}>Hard</Tag>
            {TOPICS.map((t) => <Tag key={t}>{t}</Tag>)}
          </Box>

          <Box sx={{ mt: 2 }}>
            The set bits of a number are the <Mono>1</Mono>s in its binary representation (<Mono>5 = 101</Mono> has two). Print the total number of set bits over all integers from <Mono>1</Mono> to <Mono>N</Mono> inclusive.
          </Box>
          <Box sx={{ mt: 1, color: C.dim }}>
            <Mono>N</Mono> can be as large as <Mono>10^12</Mono>, so you cannot loop over every number. In every bit position the pattern of 0s and 1s repeats with a fixed period.
          </Box>

          <Label>Input</Label>
          <Box>One integer <Mono>N</Mono>.</Box>
          <Label>Output</Label>
          <Box>Print the total number of set bits.</Box>
          <Label>Constraints</Label>
          <Box><Mono>{CONSTRAINT}</Mono></Box>

          {EXAMPLES.map((e) => (
            <Box key={e.n}>
              <Label>{`Example ${e.n}`}</Label>
              <Box sx={{ border: 1, borderColor: C.line, borderRadius: 1.5, bgcolor: '#141415', px: 1.5, py: 1, fontFamily: MONO_FONT, fontSize: 12.5, lineHeight: 1.7 }}>
                <Box>{`Input: ${e.input}`}</Box>
                <Box>{`Output: ${e.output}`}</Box>
              </Box>
              <Box sx={{ mt: 0.5, fontSize: 12.5, color: C.dim }}>{e.why}</Box>
            </Box>
          ))}

          <Label>Expected complexity</Label>
          <Box sx={{ color: C.dim }}>Time <Mono>O(log N)</Mono> · Space <Mono>O(1)</Mono></Box>
        </Box>

        {/* code + terminal */}
        <Box sx={{ display: 'flex', flexDirection: 'column', minWidth: 0 }}>
          <Box sx={{ px: 2, py: 0.75, bgcolor: '#141415', borderBottom: 1, borderColor: C.line, fontFamily: MONO_FONT, fontSize: 12.5, color: C.dim }}>Main.java</Box>
          <Box sx={{ flex: 1, px: 2, py: 2, fontFamily: MONO_FONT, fontSize: { xs: 12, sm: 13 }, lineHeight: 1.75, overflowX: 'auto' }}>
            {LINES.map((line, i) => (
              <Box key={i} sx={{ display: 'flex', whiteSpace: 'pre', minHeight: '1.75em' }}>
                <Box component="span" sx={{ width: 28, flexShrink: 0, color: C.gutter, userSelect: 'none' }}>{i + 1}</Box>
                <Box component="span">{tokenize(line).map(([k, t], j) => <Box key={j} component="span" sx={{ color: C[k] }}>{t}</Box>)}</Box>
              </Box>
            ))}
          </Box>
          <Box sx={{ px: 2, py: 1.75, bgcolor: '#0B0B0C', borderTop: 1, borderColor: C.line, fontFamily: MONO_FONT, fontSize: { xs: 12, sm: 13 }, lineHeight: 1.8, overflowX: 'auto' }}>
            <Typography component="div" sx={{ fontFamily: 'inherit', fontSize: 11, letterSpacing: '0.12em', color: C.dim, mb: 0.5 }}>TERMINAL</Typography>
            <Box sx={{ color: C.txt, whiteSpace: 'pre' }}><Box component="span" sx={{ color: C.dim }}>$ </Box>javac Main.java &amp;&amp; java Main</Box>
            <Box sx={{ color: C.txt }}>8</Box>
            <Box sx={{ color: C.txt }}>13</Box>
            <Box sx={{ color: C.dim }}><Box component="span" sx={{ color: C.ok }}>● </Box>Process finished with exit code 0</Box>
          </Box>
        </Box>
      </Box>
    </Box>
  );
}