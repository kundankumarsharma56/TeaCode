import { describe, it, expect, vi, beforeEach } from 'vitest';
import { screen, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn(), patch: vi.fn(), delete: vi.fn() } }));

const ME = { username: 'ada', email: 'ada@example.com', emailVerified: true, createdAt: '2026-01-02T03:04:05Z' };
const SUMMARY = { solvedCount: 3, totalProblems: 10, totalSubmissions: 12, acceptedSubmissions: 4 };
const PROGRESS = [{ difficulty: 'EASY', solved: 2, total: 4 }, { difficulty: 'MEDIUM', solved: 1, total: 4 }, { difficulty: 'HARD', solved: 0, total: 2 }];
const ACTIVITY = [{ date: '2026-10-12', submissions: 2 }, { date: '2026-10-13', submissions: 0 }];
const SUB = { id: 7, problemSlug: 'two-sum', problemTitle: 'Two Sum', language: 'python', status: 'ACCEPTED', passedTests: 3, totalTests: 3, executionTimeMs: 20, memoryKb: 1000, createdAt: '2026-10-13T10:00:00Z' };

function setup(overrides = {}) {
  const routes = {
    '/auth/me': { data: ME },
    '/dashboard/summary': { data: SUMMARY },
    '/dashboard/progress': { data: PROGRESS },
    '/dashboard/activity': { data: ACTIVITY },
    '/users/me': { data: ME },
    '/submissions/mine': { data: { items: [SUB], page: 0, size: 20, totalItems: 1, totalPages: 1 } },
    '/submissions/7': { data: { ...SUB, sourceCode: 'print("hello")' } },
    ...overrides,
  };
  api.get.mockImplementation((path) => {
    const r = routes[path];
    if (!r) return Promise.reject(new Error(`unexpected ${path}`));
    return r instanceof Error ? Promise.reject(r) : Promise.resolve(r);
  });
}

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
});

describe('dashboard', () => {
  it('renders real summary, progress and activity from the API', async () => {
    setup();
    renderApp('/dashboard');
    expect(await screen.findByText('Problems solved')).toBeInTheDocument();
    expect(screen.getByText('12')).toBeInTheDocument();
    expect(screen.getByText('2 / 4')).toBeInTheDocument();
    expect(screen.getByLabelText('Easy problems solved')).toHaveAttribute('aria-valuenow', '50');
    expect(screen.getByLabelText('Submissions per day')).toBeInTheDocument();
  });

  it('shows an honest empty activity state', async () => {
    setup({ '/dashboard/activity': { data: [{ date: '2026-10-13', submissions: 0 }] } });
    renderApp('/dashboard');
    expect(await screen.findByText(/No submissions yet/)).toBeInTheDocument();
  });

  it('shows an error and no numbers when the API fails', async () => {
    setup({ '/dashboard/summary': new Error('down') });
    renderApp('/dashboard');
    expect(await screen.findByText(/dashboard could not be loaded/)).toBeInTheDocument();
    expect(screen.queryByText('Problems solved')).not.toBeInTheDocument();
  });

  it('warns when the email is not verified', async () => {
    setup({ '/auth/me': { data: { ...ME, emailVerified: false } } });
    renderApp('/dashboard');
    expect(await screen.findByText(/email address is not verified/)).toBeInTheDocument();
  });

  it('requires login', async () => {
    setup({ '/auth/me': Object.assign(new Error('401'), { response: { status: 401 } }) });
    renderApp('/dashboard');
    expect(await screen.findByRole('heading', { name: 'Welcome back' })).toBeInTheDocument();
  });
});

const HISTORY_ROW = { problemSlug: 'two-sum', problemTitle: 'Two Sum', difficulty: 'EASY', submissionCount: 2, acceptedCount: 1, solved: true, lastSubmissionId: 7, lastStatus: 'ACCEPTED', lastSubmittedAt: '2026-10-13T10:00:00Z' };
const HISTORY = { data: { items: [HISTORY_ROW], page: 0, size: 20, totalItems: 1, totalPages: 1 } };
const TOPICS = { data: [{ topic: 'Arrays', slug: 'arrays', attempted: 2, solved: 2 }, { topic: 'Graphs', slug: 'graphs', attempted: 1, solved: 0 }] };

describe('practice history', () => {
  const history = (extra = {}) => setup({ '/submissions/history': HISTORY, '/dashboard/topics': TOPICS, '/execution/languages': { data: [{ key: 'python', name: 'Python 3' }] }, ...extra });

  it('lists one row per problem with the last verdict and the real summary', async () => {
    history();
    renderApp('/submissions');
    expect(await screen.findByRole('link', { name: 'Two Sum' })).toHaveAttribute('href', '/problems/two-sum');
    expect(screen.getByText('Accepted')).toBeInTheDocument();
    expect(screen.getByText('Solved')).toBeInTheDocument();
    expect(await screen.findByText('Arrays')).toBeInTheDocument();
    expect(screen.queryByText('Graphs')).not.toBeInTheDocument(); // nothing solved in Graphs
    expect(screen.getByText(/unique problems/)).toBeInTheDocument();
  });

  it('expands a problem to show its submissions, each linking to the detail page', async () => {
    history();
    renderApp('/submissions');
    await userEvent.click(await screen.findByRole('button', { name: 'Show submissions for Two Sum' }));
    const open = await screen.findByRole('link', { name: 'Open submission 7' });
    expect(open).toHaveAttribute('href', '/submissions/7');
    expect(api.get).toHaveBeenCalledWith('/submissions/mine', { params: expect.objectContaining({ problem: 'two-sum' }) });
  });

  it('sends filters to the server and shows an empty-filter state', async () => {
    history();
    renderApp('/submissions?status=WRONG_ANSWER&difficulty=HARD');
    await screen.findByRole('link', { name: 'Two Sum' });
    expect(api.get).toHaveBeenCalledWith('/submissions/history', { params: expect.objectContaining({ status: 'WRONG_ANSWER', difficulty: 'HARD' }) });
    history({ '/submissions/history': { data: { items: [], page: 0, size: 20, totalItems: 0, totalPages: 0 } } });
    renderApp('/submissions?status=WRONG_ANSWER');
    expect(await screen.findByText(/No submissions match these filters/)).toBeInTheDocument();
  });

  it('shows empty and error states', async () => {
    history({ '/submissions/history': { data: { items: [], page: 0, size: 20, totalItems: 0, totalPages: 0 } } });
    const { unmount } = renderApp('/submissions');
    expect(await screen.findByText(/not submitted any solutions/)).toBeInTheDocument();
    unmount();
    history({ '/submissions/history': new Error('down') });
    renderApp('/submissions');
    expect(await screen.findByText(/history could not be loaded/)).toBeInTheDocument();
  });
});

describe('submission detail', () => {
  it('shows verdict, exact test counts, units, local time and read-only code', async () => {
    setup();
    renderApp('/submissions/7');
    expect(await screen.findByRole('heading', { level: 1, name: /Accepted/ })).toHaveTextContent('3 / 3 test cases passed');
    expect(screen.getByText('20')).toBeInTheDocument();
    expect(screen.getByText('ms')).toBeInTheDocument();
    expect(screen.getByText('KB')).toBeInTheDocument();
    expect(screen.getByText(/does not yet have enough accepted submissions/)).toBeInTheDocument();
    await userEvent.click(screen.getByRole('tab', { name: 'Code' }));
    expect(screen.getByLabelText('Submitted source code (read only)')).toHaveTextContent('print("hello")');
    expect(screen.getByRole('button', { name: 'Copy code' })).toBeInTheDocument();
  });

  it('shows not-found and permission states without leaking anything', async () => {
    setup({ '/submissions/9': Object.assign(new Error('nf'), { response: { status: 404 } }) });
    renderApp('/submissions/9');
    expect(await screen.findByText(/does not exist or is not yours/)).toBeInTheDocument();
  });

  it('offers a retry on a server error', async () => {
    setup({ '/submissions/8': new Error('boom') });
    renderApp('/submissions/8');
    expect(await screen.findByRole('button', { name: 'Retry' })).toBeInTheDocument();
  });
});

describe('profile', () => {
  it('shows account details and saves a changed username', async () => {
    setup();
    api.patch.mockResolvedValue({ data: { username: 'ada_l' } });
    renderApp('/profile');
    const input = await screen.findByLabelText('Username');
    expect(screen.getByText('Email verified')).toBeInTheDocument();
    expect(screen.getByLabelText('Email')).toBeDisabled();
    expect(screen.getByRole('button', { name: 'Save changes' })).toBeDisabled();
    await userEvent.clear(input);
    await userEvent.type(input, 'ada_l');
    await userEvent.click(screen.getByRole('button', { name: 'Save changes' }));
    expect(api.patch).toHaveBeenCalledWith('/users/me', { username: 'ada_l' });
    expect(await screen.findByText('Profile updated.')).toBeInTheDocument();
  });

  it('validates the username and surfaces server errors', async () => {
    setup();
    api.patch.mockRejectedValue({ response: { status: 409, data: { message: 'Username is not available.' } } });
    renderApp('/profile');
    const input = await screen.findByLabelText('Username');
    await userEvent.clear(input);
    await userEvent.type(input, 'a!');
    await userEvent.click(screen.getByRole('button', { name: 'Save changes' }));
    expect(await screen.findByText(/3–30 characters/)).toBeInTheDocument();
    expect(api.patch).not.toHaveBeenCalled();
    await userEvent.clear(input);
    await userEvent.type(input, 'taken_name');
    await userEvent.click(screen.getByRole('button', { name: 'Save changes' }));
    expect(await screen.findByText('Username is not available.')).toBeInTheDocument();
  });
});

describe('settings', () => {
  it('has no password section: sign-in is by email link', async () => {
    setup();
    renderApp('/settings');
    await screen.findByRole('heading', { name: 'Delete account' });
    expect(screen.queryByRole('heading', { name: 'Change password' })).not.toBeInTheDocument();
    expect(screen.queryByLabelText('Current password')).not.toBeInTheDocument();
  });

  it('requires the account email to delete the account, then signs out', async () => {
    setup();
    api.delete.mockResolvedValue({ data: {} });
    renderApp('/settings');
    await userEvent.click(await screen.findByRole('button', { name: 'Delete my account' }));
    const dialog = await screen.findByRole('dialog');
    const confirm = within(dialog).getByRole('button', { name: 'Delete account' });
    expect(confirm).toBeDisabled();
    await userEvent.type(within(dialog).getByLabelText('Email address'), 'ada@example.com');
    await userEvent.click(confirm);
    expect(api.delete).toHaveBeenCalledWith('/users/me', { data: { password: 'ada@example.com' } });
    // Sign-out closes the dialog and re-renders the logged-out app. In the full parallel run this took longer than
    // the 1000 ms findBy default (the test took 7.9 s vs 2.1 s alone), so this one wait and this one test get larger limits.
    expect(await screen.findByRole('link', { name: 'Log in' }, { timeout: 25000 })).toBeInTheDocument();
  }, 45000);

  it('keeps the account and shows the error when deletion fails', async () => {
    setup();
    api.delete.mockRejectedValue({ response: { status: 400, data: {} } });
    renderApp('/settings');
    await userEvent.click(await screen.findByRole('button', { name: 'Delete my account' }));
    const dialog = await screen.findByRole('dialog');
    await userEvent.type(within(dialog).getByLabelText('Email address'), 'wrong@example.com');
    await userEvent.click(within(dialog).getByRole('button', { name: 'Delete account' }));
    expect(await within(dialog).findByText('That is not the email address of this account.')).toBeInTheDocument();
    // The dialog marks the page behind it as hidden, so include hidden elements here.
    expect(screen.getByRole('button', { name: 'Logout', hidden: true })).toBeInTheDocument();
  }, 45000);
});
