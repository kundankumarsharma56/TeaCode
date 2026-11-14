import { describe, it, expect, vi, beforeEach } from 'vitest';
import { screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn(), patch: vi.fn(), delete: vi.fn() } }));
vi.mock('../features/workspace/monacoSetup.js', () => ({}));
vi.mock('@monaco-editor/react', () => ({
  default: ({ value, onChange }) => <textarea aria-label="Code editor" value={value} onChange={(e) => onChange(e.target.value)} />,
}));

const ME = { username: 'ada', email: 'ada@example.com', emailVerified: true, createdAt: '2026-01-02T03:04:05Z', authProviders: ['GITHUB'] };
const PROBLEM = { slug: 'two-sum', title: 'Two Sum', difficulty: 'EASY', description: 'd', constraints: 'c', tags: [], sampleCases: [] };

function setup({ me = ME, timer = { state: 'IDLE', elapsedMs: 0 } } = {}) {
  api.get.mockImplementation((path) => {
    if (path === '/auth/me') return me ? Promise.resolve({ data: me }) : Promise.reject({ response: { status: 401 } });
    if (path === '/users/me') return Promise.resolve({ data: me });
    if (path === '/problems/two-sum') return Promise.resolve({ data: PROBLEM });
    if (path === '/problems/two-sum/starter-code') return Promise.resolve({ data: [{ language: 'python', code: 'x' }] });
    if (path === '/execution/languages') return Promise.resolve({ data: [{ key: 'python', name: 'Python 3' }] });
    if (path === '/timers/two-sum') return timer instanceof Error ? Promise.reject(timer) : Promise.resolve({ data: timer });
    return Promise.reject(new Error(`unexpected ${path}`));
  });
  api.post.mockImplementation((path) => {
    if (path === '/timers/two-sum/start') return Promise.resolve({ data: { state: 'RUNNING', elapsedMs: 125000 } });
    if (path === '/timers/two-sum/pause') return Promise.resolve({ data: { state: 'PAUSED', elapsedMs: 185000 } });
    if (path === '/timers/two-sum/reset') return Promise.resolve({ data: { state: 'PAUSED', elapsedMs: 0 } });
    if (path === '/users/me/avatar') return Promise.resolve({ data: { avatarUrl: '/a.png', avatarSource: 'CUSTOM' } });
    return Promise.resolve({ data: {} });
  });
}

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
  URL.createObjectURL = vi.fn(() => 'blob:preview');
  URL.revokeObjectURL = vi.fn();
});

describe('problem timer', () => {
  it('shows the server total and sends start, pause and reset to the server', async () => {
    setup({ timer: { state: 'PAUSED', elapsedMs: 65000 } });
    renderApp('/problems/two-sum');
    const timer = await screen.findByRole('timer');
    expect(timer).toHaveTextContent('01:05');
    await userEvent.click(screen.getByRole('button', { name: 'Resume' }));
    expect(api.post).toHaveBeenCalledWith('/timers/two-sum/start');
    await waitFor(() => expect(screen.getByRole('button', { name: 'Pause' })).toBeInTheDocument());
    expect(screen.getByRole('timer').textContent).toMatch(/^02:0[5-9]$/);
    await userEvent.click(screen.getByRole('button', { name: 'Pause' }));
    expect(api.post).toHaveBeenCalledWith('/timers/two-sum/pause');
    await waitFor(() => expect(screen.getByRole('timer')).toHaveTextContent('03:05'));
    await userEvent.click(screen.getByRole('button', { name: 'Reset' }));
    expect(api.post).toHaveBeenCalledWith('/timers/two-sum/reset');
    await waitFor(() => expect(screen.getByRole('timer')).toHaveTextContent('00:00'));
  });

  it('says so honestly when the timer service fails', async () => {
    setup({ timer: new Error('down') });
    renderApp('/problems/two-sum');
    expect(await screen.findByText(/timer is unavailable/)).toBeInTheDocument();
    expect(screen.queryByRole('timer')).not.toBeInTheDocument();
  });

  it('does not touch the timer for anonymous visitors', async () => {
    setup({ me: null });
    renderApp('/problems/two-sum');
    await screen.findByRole('heading', { name: 'Two Sum' });
    expect(api.get).not.toHaveBeenCalledWith('/timers/two-sum');
  });
});

describe('avatar upload', () => {
  it('rejects unsupported types client-side', async () => {
    setup();
    renderApp('/profile');
    const input = await screen.findByLabelText('Choose avatar image');
    await userEvent.upload(input, new File(['x'], 'a.gif', { type: 'image/gif' }), { applyAccept: false });
    expect(await screen.findByText('Choose a PNG, JPEG or WebP image.')).toBeInTheDocument();
    expect(api.post).not.toHaveBeenCalledWith('/users/me/avatar', expect.anything());
  });

  it('previews then uploads multipart to POST /users/me/avatar', async () => {
    setup();
    renderApp('/profile');
    const input = await screen.findByLabelText('Choose avatar image');
    await userEvent.upload(input, new File(['x'], 'a.png', { type: 'image/png' }));
    expect(await screen.findByAltText('Selected avatar preview')).toBeInTheDocument();
    await userEvent.click(screen.getByRole('button', { name: 'Save avatar' }));
    expect(await screen.findByText('Avatar updated.')).toBeInTheDocument();
    expect(api.post.mock.calls.find(([p]) => p === '/users/me/avatar')[1]).toBeInstanceOf(FormData);
  });
});
