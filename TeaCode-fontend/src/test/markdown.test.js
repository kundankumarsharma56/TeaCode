import { describe, it, expect } from 'vitest';
import { parseMarkdown, parseInline, describe as describeBlocks } from '../utils/markdown.js';

describe('markdown parser', () => {
  it('parses headings, paragraphs, lists and fenced code', () => {
    const blocks = parseMarkdown('## Challenge\n\nText line one\nline two\n\n- a\n- b\n\n1. x\n2. y\n\n```python\nprint(1)\n```');
    expect(blocks.map((b) => b.type)).toEqual(['heading', 'paragraph', 'list', 'list', 'code']);
    expect(blocks[0].level).toBe(2);
    expect(blocks[2]).toMatchObject({ ordered: false });
    expect(blocks[2].items).toHaveLength(2);
    expect(blocks[3]).toMatchObject({ ordered: true, start: 1 });
    expect(blocks[4]).toMatchObject({ lang: 'python', text: 'print(1)' });
  });

  it('ends a paragraph at a fence that follows it directly (as in "**Input**\\n```text")', () => {
    const blocks = parseMarkdown('**Input**\n```text\n5\n2 4\n```\n**Output**\n```text\n6\n```');
    expect(blocks.map((b) => b.type)).toEqual(['paragraph', 'code', 'paragraph', 'code']);
    expect(blocks[1].text).toBe('5\n2 4');
  });

  it('keeps markdown markers inside code blocks literal', () => {
    const blocks = parseMarkdown('```\n## not a heading\n**not bold**\n```');
    expect(blocks).toHaveLength(1);
    expect(blocks[0].text).toBe('## not a heading\n**not bold**');
  });

  it('handles an unterminated fence and empty input without throwing', () => {
    expect(parseMarkdown('```\nabc')[0]).toMatchObject({ type: 'code', text: 'abc' });
    expect(parseMarkdown('')).toEqual([]);
    expect(parseMarkdown(null)).toEqual([]);
  });

  it('parses inline code, bold, italic and links, dropping unsafe URL schemes', () => {
    const nodes = parseInline('Use `a*b` with **bold** and *it* and [ok](https://x.test) and [bad](javascript:alert(1))');
    expect(nodes.find((n) => n.type === 'code').text).toBe('a*b');
    expect(nodes.some((n) => n.type === 'strong')).toBe(true);
    expect(nodes.some((n) => n.type === 'em')).toBe(true);
    expect(nodes.filter((n) => n.type === 'link')).toHaveLength(1);
    expect(nodes.filter((n) => n.type === 'link')[0].href).toBe('https://x.test');
  });

  it('does not treat snake_case or a lone asterisk as emphasis', () => {
    expect(parseInline('my_var_name and 2 * 3')).toEqual([{ type: 'text', text: 'my_var_name and 2 * 3' }]);
  });

  it('describes headings and code for de-duplication', () => {
    const d = describeBlocks(parseMarkdown('## Input\nx\n## Example\n```\n1\n```'));
    expect(d.headings).toEqual(['input', 'example']);
    expect(d.code).toEqual(['1']);
  });
});
