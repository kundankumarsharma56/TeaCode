import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { screen, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';
import { buildGrid, toKey } from '../features/problems/ProblemsCalendar.jsx';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));

const ME = { username: 'ada', emailVerified: true };
const LIST = { items: [], page: 0, size: 20, totalItems: 0, totalPages: 0 };

function mockApi({ loggedIn = true, calendar = [] } = {}) {
  api.get.mockImplementation((path) => {
    if (path === '/auth/me') return loggedIn ? Promise.resolve({ data: ME }) : Promise.reject({ response: { status: 401 } });
    if (path === '/problems/topics') return Promise.resolve({ data: [] });
    if (path === '/problems') return Promise.resolve({ data: LIST });
    if (path === '/dashboard/calendar') return Promise.resolve({ data: calendar });
    return Promise.reject(new Error(`unexpected ${path}`));
  });
}

beforeEach(() => { vi.clearAllMocks(); window.localStorage.clear(); });
afterEach(() => vi.useRealTimers());

describe('calendar grid maths', () => {
  it('builds 42 consecutive days starting on the requested weekday', () => {
    const g = buildGrid(new Date(2026, 9, 1), 0); // Oct 1 2026 is a Thursday
    expect(g).toHaveLength(42);
    expect(toKey(g[0])).toBe('2026-09-27');
    expect(toKey(g[4])).toBe('2026-10-01');
    const mon = buildGrid(new Date(2026, 9, 1), 1);
    expect(toKey(mon[0])).toBe('2026-09-28');
  });
});

describe('problems calendar', () => {
  it('marks today, navigates months and returns to today', async () => {
    mockApi({ loggedIn: false });
    renderApp('/problems');
    const now = new Date();
    const grid = (await screen.findAllByRole('grid'))[0];
    expect(within(grid).getByRole('button', { current: 'date' })).toHaveTextContent(String(now.getDate()));
    const title = screen.getByRole('heading', { name: now.toLocaleDateString(undefined, { month: 'long', year: 'numeric' }) });
    await userEvent.click(screen.getAllByRole('button', { name: 'Next month' })[0]);
    expect(title).not.toHaveTextContent(now.toLocaleDateString(undefined, { month: 'long', year: 'numeric' }));
    await userEvent.click(screen.getAllByRole('button', { name: /^Today$/ })[0]);
    expect(title).toHaveTextContent(now.toLocaleDateString(undefined, { month: 'long', year: 'numeric' }));
    expect(screen.getByText(/Log in to see the days you solved problems/)).toBeInTheDocument();
  });

  it('shows real submission counts for the selected day and requests the visible month', async () => {
    const today = new Date();
    mockApi({ calendar: [{ date: toKey(today), submissions: 3, accepted: 2 }] });
    renderApp('/problems');
    expect(await screen.findByText('3 submissions, 2 accepted')).toBeInTheDocument();
    const call = api.get.mock.calls.find(([p]) => p === '/dashboard/calendar');
    expect(call[1].params.month).toBe(toKey(today).slice(0, 7));
    expect(typeof call[1].params.offsetMinutes).toBe('number');
  });

  it('reports a failed load honestly', async () => {
    mockApi();
    api.get.mockImplementation((path) => (path === '/dashboard/calendar' ? Promise.reject(new Error('down'))
      : path === '/auth/me' ? Promise.resolve({ data: ME }) : path === '/problems/topics' ? Promise.resolve({ data: [] }) : Promise.resolve({ data: LIST })));
    renderApp('/problems');
    expect(await screen.findByText('Activity could not be loaded.')).toBeInTheDocument();
  });
});
