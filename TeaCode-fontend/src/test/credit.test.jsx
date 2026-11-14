import { describe, it, expect, vi, beforeEach } from 'vitest';
import { screen } from '@testing-library/react';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));
vi.mock('../features/workspace/monacoSetup.js', () => ({}));
vi.mock('@monaco-editor/react', () => ({ default: () => <textarea aria-label="Code editor" /> }));

beforeEach(() => {
  vi.clearAllMocks();
  api.get.mockImplementation((path) => {
    if (path === '/auth/me') return Promise.reject({ response: { status: 401 } });
    if (path === '/terminal/languages') return Promise.resolve({ data: [{ key: 'python', name: 'Python 3' }] });
    return Promise.resolve({ data: [] });
  });
});

describe('backend developer credit', () => {
  it.each(['/', '/about', '/login', '/register', '/terminal'])('is shown on %s', async (path) => {
    renderApp(path);
    expect((await screen.findAllByText(/Kundan Kumar Sharma/)).length).toBeGreaterThan(0);
  });
});
