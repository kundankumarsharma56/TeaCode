import { Box, Link, Typography } from '@mui/material';
import { MONO_FONT } from '../theme/theme.js';
import { inlineText } from '../utils/markdown.js';

// Renders the AST from utils/markdown.js as React elements. Nothing here uses dangerouslySetInnerHTML.

export const CodeBlock = ({ children, label, lang }) => (
  <Box sx={{ minWidth: 0 }}>
    {label && <Typography component="div" sx={{ mb: 0.5, color: 'text.secondary', fontSize: 11, fontWeight: 700, letterSpacing: '.08em', textTransform: 'uppercase' }}>{label}</Typography>}
    <Box
      component="pre"
      tabIndex={0}
      aria-label={label ? `${label}${lang ? ` (${lang})` : ''}` : 'Code'}
      sx={{
        m: 0, p: 1.5, maxWidth: '100%', overflow: 'auto', borderRadius: 1.5, border: '1px solid', borderColor: 'divider',
        bgcolor: 'action.hover', color: 'text.primary', fontFamily: MONO_FONT, fontSize: 13, lineHeight: 1.6, tabSize: 4, whiteSpace: 'pre',
        '&:focus-visible': { outline: '2px solid', outlineColor: 'primary.main', outlineOffset: 2 },
      }}
    >
      <code>{children}</code>
    </Box>
  </Box>
);

function Inline({ nodes }) {
  return nodes.map((n, i) => {
    switch (n.type) {
      case 'code':
        return <Box key={i} component="code" sx={{ px: 0.6, py: 0.1, borderRadius: 0.75, bgcolor: 'action.hover', border: '1px solid', borderColor: 'divider', fontFamily: MONO_FONT, fontSize: '0.88em', overflowWrap: 'anywhere' }}>{n.text}</Box>;
      case 'strong':
        return <strong key={i}><Inline nodes={n.children} /></strong>;
      case 'em':
        return <em key={i}><Inline nodes={n.children} /></em>;
      case 'link':
        return <Link key={i} href={n.href} target="_blank" rel="noopener noreferrer"><Inline nodes={n.children} /></Link>;
      default:
        return <span key={i}>{n.text}</span>;
    }
  });
}

export function ExampleBox({ items }) {
  return (
    <Box sx={{ my: 1.5, p: 1.5, minWidth: 0, borderLeft: '3px solid', borderColor: 'primary.main', borderRadius: '0 8px 8px 0', bgcolor: 'action.hover', display: 'grid', gap: 1.25 }}>
      {items.map((it, j) => (
        <Box key={j} sx={{ minWidth: 0 }}>
          <Typography component="div" sx={{ fontWeight: 700, fontSize: 13 }}>{it.label}:</Typography>
          <Box component="pre" tabIndex={0} aria-label={it.label} sx={{ m: 0, mt: 0.25, maxWidth: '100%', overflow: 'auto', fontFamily: MONO_FONT, fontSize: 13, lineHeight: 1.6, whiteSpace: 'pre', '&:focus-visible': { outline: '2px solid', outlineColor: 'primary.main', outlineOffset: 2 } }}><code>{it.text}</code></Box>
        </Box>
      ))}
    </Box>
  );
}

const isLabel = (b) => b.type === 'paragraph' && b.children.length === 1 && b.children[0].type === 'strong';

export const headingSx = (level) => ({
  mt: level <= 2 ? 3 : 2, mb: 1, fontWeight: 700, lineHeight: 1.3, overflowWrap: 'anywhere',
  fontSize: level <= 2 ? '1.05rem' : '1rem',
});

// "**Input**" + code block pairs that follow each other become one example box, like a LeetCode example.
function groupExamples(blocks) {
  const out = [];
  let i = 0;
  while (i < blocks.length) {
    if (isLabel(blocks[i]) && blocks[i + 1]?.type === 'code') {
      const items = [];
      while (i < blocks.length && isLabel(blocks[i]) && blocks[i + 1]?.type === 'code') {
        items.push({ label: inlineText(blocks[i].children[0].children).trim(), text: blocks[i + 1].text });
        i += 2;
      }
      out.push({ type: 'example', items });
    } else { out.push(blocks[i]); i += 1; }
  }
  return out;
}

function Blocks({ blocks }) {
  return groupExamples(blocks).map((b, i) => {
    switch (b.type) {
      case 'heading': {
        // The page title is the h1, so statement headings start at h2.
        const level = Math.min(6, Math.max(2, b.level));
        return <Typography key={i} component={`h${level}`} sx={headingSx(level)}><Inline nodes={b.children} /></Typography>;
      }
      case 'paragraph':
        if (isLabel(b)) {
          return <Typography key={i} component="div" sx={{ mt: 1.5, mb: 0.5, color: 'text.secondary', fontSize: 11, fontWeight: 700, letterSpacing: '.08em', textTransform: 'uppercase' }}><Inline nodes={b.children[0].children} /></Typography>;
        }
        return <Typography key={i} sx={{ my: 1.25, lineHeight: 1.75, overflowWrap: 'anywhere', whiteSpace: 'pre-line' }}><Inline nodes={b.children} /></Typography>;
      case 'example':
        return <ExampleBox key={i} items={b.items} />;
      case 'code':
        return <Box key={i} sx={{ my: 1 }}><CodeBlock lang={b.lang}>{b.text}</CodeBlock></Box>;
      case 'list': {
        const Tag = b.ordered ? 'ol' : 'ul';
        return (
          <Box key={i} component={Tag} start={b.ordered ? b.start : undefined} sx={{ my: 1.25, pl: 3, '& li': { lineHeight: 1.7, overflowWrap: 'anywhere', mb: 0.5 } }}>
            {b.items.map((item, j) => <li key={j}><Inline nodes={item} /></li>)}
          </Box>
        );
      }
      case 'quote':
        return <Box key={i} component="blockquote" sx={{ my: 1.5, mx: 0, pl: 2, borderLeft: '3px solid', borderColor: 'divider', color: 'text.secondary' }}><Blocks blocks={b.children} /></Box>;
      case 'rule':
        return <Box key={i} component="hr" sx={{ my: 2, border: 0, borderTop: '1px solid', borderColor: 'divider' }} />;
      default:
        return null;
    }
  });
}

export default function Markdown({ blocks }) {
  return <Box sx={{ minWidth: 0, maxWidth: '100%', '& > :first-of-type': { mt: 0 } }}><Blocks blocks={blocks} /></Box>;
}
