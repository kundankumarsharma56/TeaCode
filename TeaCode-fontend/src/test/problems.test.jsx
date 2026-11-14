import { describe, it, expect, vi, beforeEach } from 'vitest';
import { screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));

const TAGS = [{ name: 'Arrays', slug: 'arrays' }, { name: 'Graph', slug: 'graph' }];
const page = (items, extra = {}) => ({ items, page: 0, size: 20, totalItems: items.length, totalPages: 1, ...extra });
const ROW = { slug: 'two-sum', title: 'Two Sum', difficulty: 'EASY', tags: [{ name: 'Arrays', slug: 'arrays' }] };

function mockApi(listResponse) {
  api.get.mockImplementation((path, config) => {
    if (path === '/auth/me') return Promise.reject({ response: { status: 401 } });
    if (path === '/problems/topics') return Promise.resolve({ data: TAGS });
    if (path === '/problems') return typeof listResponse === 'function' ? listResponse(config) : listResponse instanceof Error ? Promise.reject(listResponse) : Promise.resolve({ data: listResponse });
    return Promise.reject(new Error(`unexpected ${path}`));
  });
}

const listCalls = () => api.get.mock.calls.filter(([p]) => p === '/problems').map(([, c]) => c.params);

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
});

describe('problem list', () => {
  it('renders rows from the backend with links to the workspace route', async () => {
    mockApi(page([ROW]));
    renderApp('/problems');
    expect(await screen.findByRole('link', { name: 'Two Sum' })).toHaveAttribute('href', '/problems/two-sum');
    // The difficulty appears both as a filter button and as the row's chip.
    expect(screen.getAllByText('Easy').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Arrays').length).toBeGreaterThan(0);
  });

  it('requests server-side paging with a fixed page size', async () => {
    mockApi(page([ROW]));
    renderApp('/problems');
    await screen.findByText('Two Sum');
    expect(listCalls()[0]).toMatchObject({ page: 0, size: 20, sort: 'newest' });
  });

  it('sends the difficulty filter to the backend and resets paging', async () => {
    mockApi(page([ROW]));
    renderApp('/problems?page=2');
    await screen.findByText('Two Sum');
    await userEvent.click(screen.getByRole('combobox', { name: 'Difficulty' }));
    await userEvent.click(await screen.findByRole('option', { name: 'Hard' }));
    await waitFor(() => expect(listCalls().at(-1)).toMatchObject({ difficulty: 'HARD', page: 0 }));
  });

  it('debounces search and sends it as q', async () => {
    mockApi(page([ROW]));
    renderApp('/problems');
    await screen.findByText('Two Sum');
    await userEvent.type(screen.getByLabelText('Search by title'), 'sum');
    await waitFor(() => expect(listCalls().at(-1)).toMatchObject({ search: 'sum' }), { timeout: 2000 });
    // Typing three characters must not have produced a request per keystroke.
    expect(listCalls().filter((c) => c.search).length).toBe(1);
  });

  it('shows pagination controls and requests the next page', async () => {
    mockApi(page([ROW], { totalItems: 45, totalPages: 3 }));
    renderApp('/problems');
    await screen.findByText('Two Sum');
    await userEvent.click(screen.getByRole('button', { name: /go to page 2/i }));
    await waitFor(() => expect(listCalls().at(-1)).toMatchObject({ page: 1 }));
  });

  it('shows a loading skeleton while the request is pending', async () => {
    mockApi(() => new Promise(() => {}));
    renderApp('/problems');
    expect(await screen.findByLabelText('Loading problems')).toBeInTheDocument();
  });

  it('shows an error state and no rows when the API fails', async () => {
    mockApi(new Error('down'));
    renderApp('/problems');
    expect(await screen.findByText(/could not be loaded/i)).toBeInTheDocument();
    expect(screen.queryByRole('table')).not.toBeInTheDocument();
  });

  it('shows an honest empty state, and offers to clear filters when filtered', async () => {
    mockApi(page([], { totalItems: 0, totalPages: 0 }));
    renderApp('/problems');
    expect(await screen.findByText('No problems have been published yet.')).toBeInTheDocument();
  });

  it('explains empty filtered results and clears filters', async () => {
    mockApi(page([], { totalItems: 0, totalPages: 0 }));
    renderApp('/problems?difficulty=HARD');
    expect(await screen.findByText('No problems match your filters.')).toBeInTheDocument();
    // Both the toolbar and the empty-state alert offer the action; either one clears the filters.
    await userEvent.click(screen.getAllByRole('button', { name: 'Clear filters' })[0]);
    expect(await screen.findByText('No problems have been published yet.')).toBeInTheDocument();
  });

  it('sends several topics together, preserves other filters and resets the page', async () => {
    mockApi(page([ROW]));
    renderApp('/problems?difficulty=EASY&page=3');
    await screen.findByText('Two Sum');
    await userEvent.click(screen.getByRole('combobox', { name: 'Topics' }));
    await userEvent.click(await screen.findByRole('option', { name: 'Arrays' }));
    await userEvent.click(await screen.findByRole('option', { name: 'Graph' }));
    await waitFor(() => expect(listCalls().at(-1)).toMatchObject({ topics: 'arrays,graph', difficulty: 'EASY', page: 0 }));
  });

  it('only offers the solved filter to signed-in users', async () => {
    mockApi(page([ROW]));
    renderApp('/problems');
    await screen.findByText('Two Sum');
    expect(screen.queryByRole('combobox', { name: 'Status' })).not.toBeInTheDocument();
  });
});
