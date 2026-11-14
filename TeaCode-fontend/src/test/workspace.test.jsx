import { describe, it, expect, vi, beforeEach } from 'vitest';
import { getDefaultNormalizer, screen, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));
// Monaco needs a real browser (workers, layout); replace it with a textarea in unit tests.
vi.mock('../features/workspace/monacoSetup.js', () => ({}));
vi.mock('@monaco-editor/react', () => ({
  default: ({ value, onChange, language }) => (
    <textarea aria-label="Code editor" data-language={language} value={value} onChange={(e) => onChange(e.target.value)} />
  ),
}));

const PROBLEM = {
  slug: 'two-sum', title: 'Two Sum', difficulty: 'EASY', description: 'Find two numbers.',
  constraints: 'n <= 1000', tags: [{ name: 'Arrays', slug: 'arrays' }],
  sampleCases: [{ input: '2 7\n9', expectedOutput: '0 1' }],
};
const LANGS = [{ key: 'python', name: 'Python 3' }, { key: 'java', name: 'Java' }];
const STARTER = [{ language: 'python', code: 'def solve():\n    pass' }, { language: 'java', code: 'class Main {}' }];

function setup({ user = { username: 'ada' }, problem = PROBLEM, languages = LANGS, jobs = [] } = {}) {
  const queue = [...jobs];
  api.get.mockImplementation((path) => {
    if (path === '/auth/me') return user ? Promise.resolve({ data: user }) : Promise.reject({ response: { status: 401 } });
    if (path === '/problems/two-sum') return problem instanceof Error ? Promise.reject(problem) : Promise.resolve({ data: problem });
    if (path === '/problems/two-sum/starter-code') return Promise.resolve({ data: STARTER });
    if (path === '/execution/languages') return languages instanceof Error ? Promise.reject(languages) : Promise.resolve({ data: languages });
    if (path.startsWith('/submissions/jobs/')) return Promise.resolve({ data: queue.length > 1 ? queue.shift() : queue[0] });
    return Promise.reject(new Error(`unexpected ${path}`));
  });
  api.post.mockResolvedValue({ data: { jobId: 'job-1' } });
}

const done = (extra) => ({ state: 'COMPLETED', ...extra });

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
});

describe('workspace', () => {
  it('shows the problem, examples and starter code in the selected language', async () => {
    setup();
    renderApp('/problems/two-sum');
    expect(await screen.findByRole('heading', { name: 'Two Sum' })).toBeInTheDocument();
    expect(screen.getByText('Find two numbers.')).toBeInTheDocument();
    expect(screen.getByText('0 1')).toBeInTheDocument();
    const editor = await screen.findByLabelText('Code editor');
    expect(editor).toHaveValue('def solve():\n    pass');
    expect(editor).toHaveAttribute('data-language', 'python');
  });

  it('offers only the languages returned by the backend', async () => {
    setup();
    renderApp('/problems/two-sum');
    await userEvent.click(await screen.findByRole('combobox', { name: 'Language' }));
    expect(await screen.findByRole('option', { name: 'Java' })).toBeInTheDocument();
    expect(screen.queryByRole('option', { name: 'C++' })).not.toBeInTheDocument();
  });

  it('switches language, keeping separate code per language, and resets to starter code', async () => {
    setup();
    renderApp('/problems/two-sum');
    const editor = await screen.findByLabelText('Code editor');
    await userEvent.clear(editor);
    await userEvent.type(editor, 'x');
    await userEvent.click(screen.getByRole('combobox', { name: 'Language' }));
    await userEvent.click(await screen.findByRole('option', { name: 'Java' }));
    expect(screen.getByLabelText('Code editor')).toHaveValue('class Main {}');
    await userEvent.click(screen.getByRole('combobox', { name: 'Language' }));
    await userEvent.click(await screen.findByRole('option', { name: 'Python 3' }));
    expect(screen.getByLabelText('Code editor')).toHaveValue('x');
    await userEvent.click(screen.getByRole('button', { name: 'Reset code' }));
    expect(screen.getByLabelText('Code editor')).toHaveValue('def solve():\n    pass');
  });

  it('runs code via the backend and renders sample results', async () => {
    setup({ jobs: [done({ status: 'ACCEPTED', passedTests: 1, totalTests: 1, executionTimeMs: 12, memoryKb: 900, cases: [{ index: 1, sample: true, status: 'ACCEPTED', input: '2 7\n9', expected: '0 1', actual: '0 1' }] })] });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    await userEvent.click(screen.getByRole('button', { name: 'Run' }));
    expect(api.post).toHaveBeenCalledWith('/submissions/run', { problemSlug: 'two-sum', language: 'python', sourceCode: 'def solve():\n    pass' });
    expect(await screen.findByRole('heading', { name: 'Accepted' })).toBeInTheDocument();
    expect(screen.getByText('1/1 tests passed')).toBeInTheDocument();
    expect(screen.getByText('Your output')).toBeInTheDocument();
  });

  it('polls until the job finishes (queued, running, then done)', async () => {
    setup({ jobs: [{ state: 'QUEUED' }, { state: 'RUNNING' }, done({ status: 'WRONG_ANSWER', passedTests: 0, totalTests: 3, cases: [] })] });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    await userEvent.click(screen.getByRole('button', { name: 'Submit' }));
    expect(api.post).toHaveBeenCalledWith('/submissions/submit', expect.any(Object));
    expect(await screen.findByText('Running…', {}, { timeout: 4000 })).toBeInTheDocument();
    expect(await screen.findByRole('heading', { name: 'Wrong Answer' }, { timeout: 4000 })).toBeInTheDocument();
    expect(api.get.mock.calls.filter(([p]) => p.startsWith('/submissions/jobs/')).length).toBe(3);
  });

  it('never shows input or expected output for hidden cases', async () => {
    setup({ jobs: [done({ status: 'WRONG_ANSWER', passedTests: 1, totalTests: 2, cases: [
      { index: 1, sample: true, status: 'ACCEPTED', input: 'a', expected: 'b', actual: 'b' },
      { index: 2, sample: false, status: 'WRONG_ANSWER', input: 'LEAKED_IN', expected: 'LEAKED_OUT', actual: 'LEAKED_ACT' },
    ] })] });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    await userEvent.click(screen.getByRole('button', { name: 'Submit' }));
    await screen.findByRole('heading', { name: 'Wrong Answer' });
    expect(screen.getByText('Test 2')).toBeInTheDocument();
    expect(screen.queryByText(/LEAKED/)).not.toBeInTheDocument();
  });

  it('shows compiler output and runtime errors from the judge', async () => {
    setup({ jobs: [done({ status: 'COMPILATION_ERROR', compileOutput: 'error: missing semicolon', cases: [] })] });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    await userEvent.click(screen.getByRole('button', { name: 'Run' }));
    expect(await screen.findByRole('heading', { name: 'Compilation Error' })).toBeInTheDocument();
    expect(screen.getByText('error: missing semicolon')).toBeInTheDocument();
  });

  it('shows an explicit execution-service error and never a success', async () => {
    setup();
    api.post.mockRejectedValue({ response: { status: 503, data: {} } });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    await userEvent.click(screen.getByRole('button', { name: 'Submit' }));
    expect(await screen.findByText(/execution service is unavailable/)).toBeInTheDocument();
    expect(screen.queryByText('Accepted')).not.toBeInTheDocument();
  });

  it('handles rate limiting and failed jobs', async () => {
    setup({ jobs: [{ state: 'FAILED', errorCode: 'EXECUTION_SERVICE_UNAVAILABLE' }] });
    let first = true; // reject only the first run request; the timer calls are separate
    api.post.mockImplementation((path) => {
      if (path === '/submissions/run' && first) { first = false; return Promise.reject({ response: { status: 429, data: {} } }); }
      return Promise.resolve({ data: path.startsWith('/timers/') ? {} : { jobId: 'job-1' } });
    });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    await userEvent.click(screen.getByRole('button', { name: 'Run' }));
    expect(await screen.findByText(/too quickly/)).toBeInTheDocument();
    await userEvent.click(screen.getByRole('button', { name: 'Run' }));
    expect(await screen.findByText(/execution service is unavailable/)).toBeInTheDocument();
  });

  it('disables Run and Submit for anonymous users and links to login', async () => {
    setup({ user: null });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    expect(screen.getByRole('button', { name: 'Run' })).toBeDisabled();
    expect(screen.getByRole('button', { name: 'Submit' })).toBeDisabled();
    expect(within(screen.getByRole('main')).getByRole('link', { name: 'Log in' })).toHaveAttribute('href', '/login');
  });

  it('disables execution for empty code', async () => {
    setup();
    renderApp('/problems/two-sum');
    const editor = await screen.findByLabelText('Code editor');
    await userEvent.clear(editor);
    expect(screen.getByRole('button', { name: 'Run' })).toBeDisabled();
  });

  it('shows a not-found message for unknown or unpublished problems', async () => {
    setup({ problem: Object.assign(new Error('nf'), { response: { status: 404 } }) });
    renderApp('/problems/two-sum');
    expect(await screen.findByText(/does not exist or is not available/)).toBeInTheDocument();
  });

  it('tells the user when no languages are available', async () => {
    setup({ languages: [] });
    renderApp('/problems/two-sum');
    expect(await screen.findByText(/No languages are available/)).toBeInTheDocument();
    expect(screen.queryByLabelText('Code editor')).not.toBeInTheDocument();
  });
});

describe('verdict honesty and catalog problems', () => {
  it('never presents a sample-only run as Accepted', async () => {
    setup({ jobs: [done({ status: 'SAMPLES_PASSED', passedTests: 1, totalTests: 1, cases: [] })] });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    await userEvent.click(screen.getByRole('button', { name: 'Run' }));
    expect(await screen.findByText('Sample tests passed')).toBeInTheDocument();
    expect(screen.getByText(/not a final verdict/)).toBeInTheDocument();
    expect(screen.queryByText('Accepted')).not.toBeInTheDocument();
  });

  it('explains Insufficient verification instead of calling it Accepted', async () => {
    setup({ jobs: [done({ status: 'INSUFFICIENT_VERIFICATION', passedTests: 1, totalTests: 1, cases: [] })] });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    await userEvent.click(screen.getByRole('button', { name: 'Submit' }));
    expect(await screen.findByText('Insufficient verification')).toBeInTheDocument();
    expect(screen.getByText(/cannot be marked Accepted/)).toBeInTheDocument();
    expect(screen.queryByText('Accepted')).not.toBeInTheDocument();
  });

  it('shows the quota problem as an execution problem, not a wrong answer', async () => {
    setup({ jobs: [{ state: 'FAILED', errorCode: 'EXECUTION_QUOTA_EXCEEDED' }] });
    renderApp('/problems/two-sum');
    await screen.findByLabelText('Code editor');
    await userEvent.click(screen.getByRole('button', { name: 'Submit' }));
    expect(await screen.findByText(/quota is used up/)).toBeInTheDocument();
    expect(screen.queryByText('Wrong Answer')).not.toBeInTheDocument();
  });

  it('links to the original for a problem without a stored statement and disables running', async () => {
    setup({ problem: { ...PROBLEM, description: null, statementAvailable: false, judgeable: false, testDataStatus: 'NONE', source: 'PACKAGE', sourceUrl: 'https://problems.example.test/p/1', rating: 800, sampleCases: [] } });
    renderApp('/problems/two-sum');
    const link = await screen.findByRole('link', { name: 'Open the original problem' });
    expect(link).toHaveAttribute('href', 'https://problems.example.test/p/1');
    expect(link).toHaveAttribute('rel', expect.stringContaining('noopener'));
    expect(screen.getByText(/not stored here/)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Run' })).toBeDisabled();
    expect(screen.getByRole('button', { name: 'Submit' })).toBeDisabled();
  });

  it('renders a Markdown statement as real headings, lists and code, with organised metadata', async () => {
    const description = '## Challenge\n\nAt **Meadow Analytics**, sum the `n` values.\n\n- first\n- second\n\n## Input\nRead n.\n\n## Example\n**Input**\n```text\n5\n2 4\n```\n**Output**\n```text\n6\n```';
    setup({ problem: { ...PROBLEM, title: 'Meadow Analytics: Matrix Diagonal', difficulty: 'MEDIUM', rating: 1200, tags: [{ name: 'Matrices', slug: 'matrices' }], description, inputFormat: 'Standard input as described in the statement.', constraints: 'n <= 10', sampleCases: [{ input: '5\n2 4', expectedOutput: '6' }, { input: '1\n1', expectedOutput: '1' }] } });
    renderApp('/problems/two-sum');
    expect(await screen.findByRole('heading', { level: 1, name: 'Meadow Analytics: Matrix Diagonal' })).toBeInTheDocument();
    expect(screen.getByText('Medium')).toBeInTheDocument();
    expect(screen.getByText('Rating 1200')).toBeInTheDocument();
    expect(screen.getByText('Matrices')).toBeInTheDocument();
    expect(screen.getByRole('heading', { level: 2, name: 'Challenge' })).toBeInTheDocument();
    expect(screen.getByRole('heading', { level: 2, name: 'Input' })).toBeInTheDocument();
    expect(screen.getAllByRole('listitem').map((li) => li.textContent)).toEqual(expect.arrayContaining(['first', 'second']));
    expect(screen.getByText('Meadow Analytics').closest('strong')).not.toBeNull();
    expect(screen.getByText('n', { selector: 'code' })).toBeInTheDocument();
    expect(document.body.textContent).not.toMatch(/##|\*\*|```/);
    // The statement already has an Input section and shows sample 1, so neither is repeated, but sample 2 still appears.
    expect(screen.queryByRole('heading', { name: 'Input format' })).not.toBeInTheDocument();
    expect(screen.getAllByText('5\n2 4', { selector: 'code', normalizer: getDefaultNormalizer({ collapseWhitespace: false }) })).toHaveLength(1);
    expect(screen.getByRole('heading', { level: 2, name: 'More examples' })).toBeInTheDocument();
    expect(screen.getByText('Example 2')).toBeInTheDocument();
    // A structured field the statement does not cover is still shown.
    expect(screen.getByRole('heading', { level: 2, name: 'Constraints' })).toBeInTheDocument();
  });

  it('never turns statement text into HTML or unsafe links', async () => {
    setup({ problem: { ...PROBLEM, description: '<img src=x onerror=alert(1)> [click](javascript:alert(1)) [ok](https://example.test/a)' } });
    renderApp('/problems/two-sum');
    await screen.findByRole('heading', { name: 'Two Sum' });
    // Scoped to the statement: the app header legitimately contains the logo image.
    const statement = screen.getByRole('heading', { name: 'Two Sum' }).closest('main, section, article, div[class*="MuiBox"]') ?? document.body;
    expect(statement.querySelector('img[src="x"]')).toBeNull();
    expect(document.querySelector('img[src="x"]')).toBeNull();
    expect(screen.queryByRole('link', { name: 'click' })).not.toBeInTheDocument();
    expect(screen.getByRole('link', { name: 'ok' })).toHaveAttribute('href', 'https://example.test/a');
    expect(screen.getByText(/<img src=x/)).toBeInTheDocument();
  });
});


describe('language support', () => {
  it('maps every backend language key to a Monaco id and a terminal template', async () => {
    const { monacoLanguage, templateFor } = await import('../features/workspace/languages.js');
    const keys = ['java', 'python', 'c', 'cpp', 'javascript', 'typescript', 'csharp', 'go', 'rust', 'kotlin', 'swift',
      'php', 'ruby', 'dart', 'r', 'sql'];
    for (const k of keys) {
      expect(monacoLanguage(k), k).not.toBe('plaintext');
      expect(templateFor(k), k).not.toBe('');
    }
    expect(monacoLanguage('dart')).toBe('dart');
    expect(monacoLanguage('unknown')).toBe('plaintext');
  });

  it('registers a Monaco grammar contribution for every mapped language', async () => {
    const { default: setup } = await import('../features/workspace/monacoSetup.js?raw');
    for (const g of ['java', 'python', 'cpp', 'javascript', 'typescript', 'csharp', 'go', 'rust', 'kotlin', 'swift',
      'php', 'ruby', 'r', 'dart', 'mysql']) {
      expect(setup, g).toContain(`basic-languages/${g}/${g}.contribution`);
    }
  });
});
