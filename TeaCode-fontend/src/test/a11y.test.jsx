import { describe, it, expect, vi, beforeEach } from 'vitest';
import { screen } from '@testing-library/react';
import { axe, toHaveNoViolations } from 'jest-axe';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

expect.extend(toHaveNoViolations);

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));
vi.mock('../services/firebase.js', () => ({
  firebaseConfigured: true, sendLoginLink: vi.fn(), isLoginLink: vi.fn().mockResolvedValue(false), completeLoginLink: vi.fn(),
  rememberEmail: vi.fn(), recalledEmail: vi.fn().mockReturnValue(''), forgetEmail: vi.fn(), firebaseErrorMessage: () => 'error',
}));
vi.mock('../features/workspace/monacoSetup.js', () => ({}));
vi.mock('@monaco-editor/react', () => ({
  default: ({ value }) => <textarea aria-label="Code editor" defaultValue={value} />,
}));

const PROBLEM = { slug: 'two-sum', title: 'Two Sum', difficulty: 'EASY', description: 'Find two numbers.', tags: [{ name: 'Arrays', slug: 'arrays' }], sampleCases: [{ input: '1', expectedOutput: '2' }] };
const ROUTES = {
  '/problems': { items: [{ slug: 'two-sum', title: 'Two Sum', difficulty: 'EASY', tags: [{ name: 'Arrays', slug: 'arrays' }] }], page: 0, size: 20, totalItems: 1, totalPages: 1 },
  '/problems/tags': [{ name: 'Arrays', slug: 'arrays' }],
  '/problems/two-sum': PROBLEM,
  '/problems/two-sum/starter-code': [{ language: 'python', code: 'pass' }],
  '/execution/languages': [{ key: 'python', name: 'Python 3' }],
};

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
  api.get.mockImplementation((p) => (p === '/auth/me' ? Promise.reject({ response: { status: 401 } }) : ROUTES[p] ? Promise.resolve({ data: ROUTES[p] }) : Promise.reject(new Error(p))));
});

// jsdom cannot compute colour contrast, so contrast is not covered by these checks.
const PAGES = [
  ['/', 'Code. Learn. Build. Become a Better Developer.', 'heading'],
  ['/problems', 'Two Sum', 'link'],
  ['/problems/two-sum', 'Code editor', 'label'],
  ['/login', 'Welcome back', 'heading'],
  ['/about', 'About TeaCode', 'heading'],
  ['/terms', 'Terms and Conditions', 'heading'],
  ['/privacy', 'Privacy Policy', 'heading'],
  ['/cookies', 'Cookie Policy', 'heading'],
  ['/nope', '404', 'heading'],
];

describe('accessibility (axe)', () => {
  it.each(PAGES)('%s has no detectable violations', async (path, text, kind) => {
    const { container } = renderApp(path);
    if (kind === 'label') await screen.findByLabelText(text);
    else if (kind === 'link') await screen.findByRole('link', { name: text });
    else await screen.findByRole('heading', { name: text });
    // Let async sections (e.g. landing problem list) settle so loading skeletons aren't audited.
    await new Promise((r) => setTimeout(r, 50));
    const results = await axe(container, { rules: { 'color-contrast': { enabled: false }, region: { enabled: false } } });
    expect(results).toHaveNoViolations();
  }, 90000); // the landing page is large; axe needs more than the default on a slow PC
});
