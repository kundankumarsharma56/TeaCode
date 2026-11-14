import { describe, it, expect, vi, beforeEach } from 'vitest';
import { screen, within, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));

const PROBLEMS = { items: [{ slug: 'two-sum', title: 'Two Sum', difficulty: 'EASY', tags: [{ name: 'Arrays' }] }] };

function mockApi({ me = 'anon', problems = PROBLEMS, languages = [{ key: 'python', name: 'Python 3' }] } = {}) {
  api.get.mockImplementation((path) => {
    if (path === '/auth/me') return me === 'anon' ? Promise.reject({ response: { status: 401 } }) : Promise.resolve({ data: me });
    if (path === '/problems') return problems instanceof Error ? Promise.reject(problems) : Promise.resolve({ data: problems });
    if (path === '/execution/languages') return languages instanceof Error ? Promise.reject(languages) : Promise.resolve({ data: languages });
    return Promise.reject(new Error(`unexpected ${path}`));
  });
  api.post.mockResolvedValue({ data: {} });
}

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
});

describe('navbar routing', () => {
  it('shows brand, nav links and auth actions for anonymous users', async () => {
    mockApi();
    renderApp('/');
    const nav = await screen.findByRole('navigation', { name: 'Primary' });
    expect(within(nav).getByRole('link', { name: 'Home' })).toHaveAttribute('href', '/');
    expect(within(nav).getByRole('link', { name: 'Problem' })).toHaveAttribute('href', '/problems');
    expect(within(nav).getByRole('link', { name: 'Terminal' })).toHaveAttribute('href', '/terminal');
    expect(within(nav).getAllByRole('link')).toHaveLength(4);
    expect(within(nav).getByRole('link', { name: 'About' })).toHaveAttribute('href', '/about');
    expect(await screen.findByRole('link', { name: 'Log in' })).toHaveAttribute('href', '/login');
    expect(screen.queryByRole('button', { name: 'Logout' })).not.toBeInTheDocument();
  });

  it('navigates to About and marks it active', async () => {
    mockApi();
    renderApp('/');
    const nav = await screen.findByRole('navigation', { name: 'Primary' });
    await userEvent.click(within(nav).getByRole('link', { name: 'About' }));
    expect(await screen.findByRole('heading', { name: 'About TeaCode' })).toBeInTheDocument();
    expect(within(nav).getByRole('link', { name: 'About' })).toHaveClass('active');
  });

  it('shows Dashboard, Profile and Logout for authenticated users and logs out via the backend', async () => {
    mockApi({ me: { username: 'ada' } });
    renderApp('/');
    expect(await screen.findByRole('link', { name: 'Dashboard' })).toBeInTheDocument();
    expect(screen.getByRole('link', { name: 'Profile' })).toBeInTheDocument();
    await userEvent.click(screen.getByRole('button', { name: 'Logout' }));
    expect(api.post).toHaveBeenCalledWith('/auth/logout');
    expect(await screen.findByRole('link', { name: 'Log in' })).toBeInTheDocument();
  });

  it('keeps the user signed in and reports an error when logout fails', async () => {
    mockApi({ me: { username: 'ada' } });
    api.post.mockRejectedValue(new Error('boom'));
    renderApp('/');
    await userEvent.click(await screen.findByRole('button', { name: 'Logout' }));
    expect(await screen.findByText(/Could not log out/)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Logout' })).toBeInTheDocument();
  });
});

describe('route protection (UI only)', () => {
  it('redirects anonymous users from /dashboard to the login route', async () => {
    mockApi();
    renderApp('/dashboard');
    expect(await screen.findByRole('heading', { name: 'Welcome back' })).toBeInTheDocument();
  });

  it('renders the 404 page for unknown routes', async () => {
    mockApi();
    renderApp('/nope');
    expect(await screen.findByRole('heading', { name: '404' })).toBeInTheDocument();
  });
});

describe('landing page', () => {
  it('renders all section ids', async () => {
    mockApi();
    const { container } = renderApp('/');
    await screen.findByText('Two Sum');
    for (const id of ['home', 'features', 'how-it-works', 'popular-problems', 'languages', 'faq', 'get-started']) {
      expect(container.querySelector(`#${id}`)).not.toBeNull();
    }
  });

  it('lists real problems linking to the workspace route', async () => {
    mockApi();
    renderApp('/');
    expect(await screen.findByRole('link', { name: 'Two Sum' })).toHaveAttribute('href', '/problems/two-sum');
  });

  it('shows an honest empty state when no problems are published', async () => {
    mockApi({ problems: { items: [] } });
    renderApp('/');
    expect(await screen.findByText(/No problems have been published yet/)).toBeInTheDocument();
  });

  it('shows an error state, not fake data, when the API fails', async () => {
    mockApi({ problems: new Error('down'), languages: new Error('down') });
    renderApp('/');
    expect(await screen.findByText(/Problems could not be loaded/)).toBeInTheDocument();
    expect(screen.getByText(/supported languages is unavailable/)).toBeInTheDocument();
    expect(screen.queryByText('Two Sum')).not.toBeInTheDocument();
  });

  it('lists only languages returned by the backend', async () => {
    mockApi({ languages: [{ key: 'java', name: 'Java' }] });
    renderApp('/');
    expect(await screen.findByText('Java')).toBeInTheDocument();
    expect(screen.queryByText('C++')).not.toBeInTheDocument();
  });

  it('scrolls to the section named in the URL hash', async () => {
    mockApi();
    renderApp('/#faq');
    await waitFor(() => expect(window.HTMLElement.prototype.scrollIntoView).toHaveBeenCalled());
  });

  it('hero CTAs point to real routes', async () => {
    mockApi();
    renderApp('/');
    for (const l of await screen.findAllByRole('link', { name: 'Start Coding' })) expect(l).toHaveAttribute('href', '/terminal');
    for (const l of screen.getAllByRole('link', { name: 'Explore Problems' })) expect(l).toHaveAttribute('href', '/problems');
  });
});

describe('footer', () => {
  it('shows only the copyright line and the backend developer credit', async () => {
    mockApi();
    renderApp('/');
    const footer = await screen.findByRole('contentinfo');
    expect(footer).toHaveTextContent(`\u00A9 ${new Date().getFullYear()} TeaCode. All rights reserved.`);
    expect(footer).toHaveTextContent('Backend developed by Kundan Kumar Sharma');
    expect(within(footer).getByRole('navigation', { name: 'Footer' })).toBeInTheDocument();
    expect(within(footer).getAllByRole('link').length).toBeGreaterThanOrEqual(5);
    expect(footer.querySelector('img')).toBeNull();
  });
});

describe('mobile navigation', () => {
  it('opens an accessible drawer with the nav links', async () => {
    mockApi();
    const original = window.matchMedia;
    window.matchMedia = (query) => ({ ...original(query), matches: false });
    try {
      renderApp('/');
      await userEvent.click(await screen.findByRole('button', { name: 'Open navigation menu' }));
      const nav = await screen.findByRole('navigation', { name: 'Mobile' });
      expect(within(nav).getByRole('link', { name: 'Problem' })).toHaveAttribute('href', '/problems');
      await userEvent.click(within(nav).getByRole('link', { name: 'About' }));
      expect(await screen.findByRole('heading', { name: 'About TeaCode' })).toBeInTheDocument();
    } finally {
      window.matchMedia = original;
    }
  });
});
