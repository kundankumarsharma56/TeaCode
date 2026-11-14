import { describe, it, expect, vi, beforeEach } from 'vitest';
import { screen, within } from '@testing-library/react';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));
vi.mock('../services/firebase.js', () => ({
  firebaseConfigured: true, sendLoginLink: vi.fn(), isLoginLink: vi.fn().mockResolvedValue(false), completeLoginLink: vi.fn(),
  rememberEmail: vi.fn(), recalledEmail: vi.fn().mockReturnValue(''), forgetEmail: vi.fn(), firebaseErrorMessage: () => 'error',
}));
vi.mock('../features/workspace/monacoSetup.js', () => ({}));
vi.mock('@monaco-editor/react', () => ({
  default: ({ value }) => <textarea aria-label="Code editor" defaultValue={value} />,
}));

const LANGS = [{ key: 'java', name: 'Java' }, { key: 'python', name: 'Python 3' }, { key: 'sql', name: 'SQL (MySQL)' }];
const ROUTES = {
  '/problems': { items: [{ slug: 'two-sum', title: 'Two Sum', difficulty: 'EASY', tags: [] }], page: 0, size: 6, totalItems: 1, totalPages: 1 },
  '/execution/languages': LANGS,
};

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
  api.get.mockImplementation((p) => (p === '/auth/me' ? Promise.reject({ response: { status: 401 } }) : ROUTES[p] ? Promise.resolve({ data: ROUTES[p] }) : Promise.reject(new Error(p))));
});

describe('redesigned home page', () => {
  it('has the new headline and two hero calls to action to real routes', async () => {
    renderApp('/');
    expect(await screen.findByRole('heading', { level: 1, name: 'Code. Learn. Build. Become a Better Developer.' })).toBeInTheDocument();
    for (const l of screen.getAllByRole('link', { name: 'Start Coding' })) expect(l).toHaveAttribute('href', '/terminal');
    for (const l of screen.getAllByRole('link', { name: 'Explore Problems' })) expect(l).toHaveAttribute('href', '/problems');
  });

  it('shows the TeaCode logo in the hero', async () => {
    const { container } = renderApp('/');
    await screen.findByRole('heading', { level: 1 });
    expect(container.querySelector('#home img[src$="/brand/teacode-logo.png"]')).not.toBeNull();
  });

  it('shows four distinct feature cards in order and one call to action, with no repeated terminal illustration', async () => {
    const { container } = renderApp('/');
    await screen.findByRole('heading', { level: 1 });
    const section = container.querySelector('#features');
    expect([...section.querySelectorAll('h3')].map((h) => h.textContent)).toEqual([
      'Run code in your browser',
      'Practice real problems',
      'Get real feedback',
      'Track your progress',
    ]);
    expect(within(section).getAllByRole('link')).toHaveLength(1);
    expect(within(section).getByRole('link', { name: 'Open the terminal' })).toHaveAttribute('href', '/terminal');
    expect(container.querySelectorAll('[role="img"][aria-label^="Illustration of the TeaCode online terminal"]')).toHaveLength(1);
  });

  it('lists one item with a logo per language the backend returns, and the items are not links', async () => {
    renderApp('/');
    const list = await screen.findByRole('list', { name: 'Supported languages' });
    const items = within(list).getAllByRole('listitem');
    expect(items.map((li) => li.textContent)).toEqual(['Java', 'Python 3', 'SQL (MySQL)']);
    for (const li of items) {
      expect(li.querySelector('img')).not.toBeNull();
      expect(within(li).queryByRole('link')).toBeNull();
    }
  });

  it('has the three How TeaCode works steps in order', async () => {
    renderApp('/');
    const section = (await screen.findByRole('heading', { name: 'How TeaCode works' })).closest('section');
    const titles = within(section).getAllByRole('heading', { level: 3 }).map((h) => h.textContent);
    expect(titles).toEqual(['Choose Your Language', 'Write and Execute Code', 'Practice and Improve']);
  });

  it('hides decorative illustrations from assistive technology and gives every image an alt attribute', async () => {
    const { container } = renderApp('/');
    await screen.findByRole('heading', { level: 1 });
    expect(container.querySelectorAll('#home [aria-hidden="true"]').length).toBeGreaterThan(0);
    for (const img of container.querySelectorAll('img')) expect(img.getAttribute('alt')).not.toBeNull();
  });

  it('closes with the final call to action', async () => {
    renderApp('/');
    expect(await screen.findByRole('heading', { name: 'Your Coding Journey Starts Here.' })).toBeInTheDocument();
  });
});