// Small, dependency-free Markdown parser for problem statements. It produces a plain AST that React renders as
// elements, so problem text can never inject HTML. Supported: ATX headings, fenced code, unordered and ordered
// lists, block quotes, paragraphs, and inline code / bold / italic / links (http, https and mailto only).

const FENCE = /^\s{0,3}(`{3,}|~{3,})\s*([A-Za-z0-9_+#.-]*)\s*$/;
const HEADING = /^\s{0,3}(#{1,6})\s+(.*?)\s*#*\s*$/;
const UL = /^\s{0,3}[-*+]\s+(.*)$/;
const OL = /^\s{0,3}(\d{1,9})[.)]\s+(.*)$/;
const QUOTE = /^\s{0,3}>\s?(.*)$/;
const RULE = /^\s{0,3}([-*_])(\s*\1){2,}\s*$/;

const SAFE_URL = /^(https?:\/\/|mailto:)/i;

export function parseInline(text) {
  const out = [];
  let i = 0;
  let buf = '';
  const flush = () => { if (buf) { out.push({ type: 'text', text: buf }); buf = ''; } };
  while (i < text.length) {
    const ch = text[i];
    if (ch === '\\' && i + 1 < text.length && /[\\`*_{}[\]()#+\-.!>~|]/.test(text[i + 1])) {
      buf += text[i + 1];
      i += 2;
    } else if (ch === '`') {
      let run = 1;
      while (text[i + run] === '`') run += 1;
      const ticks = '`'.repeat(run);
      const end = text.indexOf(ticks, i + run);
      if (end === -1) { buf += ticks; i += run; } else {
        flush();
        out.push({ type: 'code', text: text.slice(i + run, end).replace(/^ (.*) $/, '$1') });
        i = end + run;
      }
    } else if ((ch === '*' || ch === '_') && text[i + 1] === ch) {
      const end = text.indexOf(ch + ch, i + 2);
      if (end > i + 2) { flush(); out.push({ type: 'strong', children: parseInline(text.slice(i + 2, end)) }); i = end + 2; } else { buf += ch + ch; i += 2; }
    } else if (ch === '*' || (ch === '_' && (i === 0 || /\W/.test(text[i - 1])))) {
      const end = text.indexOf(ch, i + 1);
      const inner = end > i + 1 ? text.slice(i + 1, end) : '';
      if (end > i + 1 && inner.trim() === inner && (ch === '*' || end + 1 >= text.length || /\W/.test(text[end + 1]))) {
        flush(); out.push({ type: 'em', children: parseInline(inner) }); i = end + 1;
      } else { buf += ch; i += 1; }
    } else if (ch === '[') {
      const close = text.indexOf('](', i + 1);
      const end = close === -1 ? -1 : text.indexOf(')', close + 2);
      if (close !== -1 && end !== -1) {
        const href = text.slice(close + 2, end).trim();
        flush();
        if (SAFE_URL.test(href)) out.push({ type: 'link', href, children: parseInline(text.slice(i + 1, close)) });
        else out.push({ type: 'text', text: text.slice(i + 1, close) }); // unsafe scheme: keep the label, drop the link
        i = end + 1;
      } else { buf += ch; i += 1; }
    } else { buf += ch; i += 1; }
  }
  flush();
  return out;
}

const startsBlock = (line) => FENCE.test(line) || HEADING.test(line) || UL.test(line) || OL.test(line) || QUOTE.test(line) || RULE.test(line);

export function parseMarkdown(source) {
  const lines = String(source ?? '').replace(/\r\n?/g, '\n').split('\n');
  const blocks = [];
  let i = 0;
  while (i < lines.length) {
    const line = lines[i];
    if (!line.trim()) { i += 1; continue; }

    const fence = line.match(FENCE);
    if (fence) {
      const marker = fence[1];
      const body = [];
      i += 1;
      const isClose = (l) => { const m = l.match(/^\s{0,3}(`{3,}|~{3,})\s*$/); return Boolean(m) && m[1][0] === marker[0] && m[1].length >= marker.length; };
      while (i < lines.length && !isClose(lines[i])) { body.push(lines[i]); i += 1; }
      i += 1; // closing fence (or end of input for an unterminated block)
      blocks.push({ type: 'code', lang: fence[2] || '', text: body.join('\n') });
      continue;
    }
    const heading = line.match(HEADING);
    if (heading) { blocks.push({ type: 'heading', level: heading[1].length, children: parseInline(heading[2]) }); i += 1; continue; }
    if (RULE.test(line)) { blocks.push({ type: 'rule' }); i += 1; continue; }

    if (UL.test(line) || OL.test(line)) {
      const ordered = OL.test(line);
      const re = ordered ? OL : UL;
      const items = [];
      while (i < lines.length && re.test(lines[i])) {
        const m = lines[i].match(re);
        let text = ordered ? m[2] : m[1];
        i += 1;
        while (i < lines.length && lines[i].trim() && !startsBlock(lines[i]) && /^\s{2,}\S/.test(lines[i])) { text += ' ' + lines[i].trim(); i += 1; }
        items.push(parseInline(text));
        if (i < lines.length && !lines[i].trim() && i + 1 < lines.length && re.test(lines[i + 1])) i += 1; // loose list
      }
      blocks.push({ type: 'list', ordered, start: ordered ? Number(line.match(OL)[1]) : 1, items });
      continue;
    }
    if (QUOTE.test(line)) {
      const body = [];
      while (i < lines.length && QUOTE.test(lines[i])) { body.push(lines[i].match(QUOTE)[1]); i += 1; }
      blocks.push({ type: 'quote', children: parseMarkdown(body.join('\n')) });
      continue;
    }
    const para = [];
    while (i < lines.length && lines[i].trim() && (para.length === 0 || !startsBlock(lines[i]))) { para.push(lines[i].trim()); i += 1; }
    blocks.push({ type: 'paragraph', children: parseInline(para.join('\n')) });
  }
  return blocks;
}

export const inlineText = (nodes) => nodes.map((n) => n.text ?? (n.children ? inlineText(n.children) : '')).join('');

/** Lower-cased text of every heading, and the text of every fenced block: used to avoid repeating content. */
export function describe(blocks) {
  const headings = [];
  const code = [];
  const walk = (list) => list.forEach((b) => {
    if (b.type === 'heading') headings.push(inlineText(b.children).trim().toLowerCase());
    else if (b.type === 'code') code.push(b.text.trim());
    else if (b.type === 'quote') walk(b.children);
  });
  walk(blocks);
  return { headings, code };
}
