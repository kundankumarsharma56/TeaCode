import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { screen, within } from '@testing-library/react';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));

const FIELDS = ['LEGAL_ENTITY_NAME', 'LEGAL_ADDRESS', 'PRIVACY_CONTACT_EMAIL', 'SUPPORT_EMAIL', 'HOSTING_PROVIDER', 'EMAIL_PROVIDER', 'RETENTION_NOTE'];

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
  api.get.mockImplementation((p) => (p === '/auth/me' ? Promise.reject({ response: { status: 401 } }) : Promise.resolve({ data: { items: [] } })));
  FIELDS.forEach((f) => vi.stubEnv(`VITE_${f}`, ''));
});
afterEach(() => vi.unstubAllEnvs());

const PAGES = [
  ['/terms', 'Terms and Conditions'],
  ['/privacy', 'Privacy Policy'],
  ['/cookies', 'Cookie Policy'],
  ['/acceptable-use', 'Acceptable Use Policy'],
  ['/privacy-requests', 'Account deletion and privacy requests'],
  ['/contact', 'Contact and support'],
];

describe('legal pages', () => {
  it.each(PAGES)('%s renders its own page', async (path, title) => {
    renderApp(path);
    expect(await screen.findByRole('heading', { level: 1, name: title })).toBeInTheDocument();
  });

  it.each(PAGES.filter(([p]) => p !== '/contact'))('%s is clearly marked as an unreviewed draft with a version', async (path) => {
    renderApp(path);
    expect(await screen.findByText(/Draft for legal review/)).toBeInTheDocument();
    expect(screen.getByText(/Version 2026-10-14-draft/)).toBeInTheDocument();
  });

  it('shows gaps instead of inventing business details when config is missing', async () => {
    renderApp('/privacy');
    await screen.findByRole('heading', { level: 1, name: 'Privacy Policy' });
    expect(screen.getByRole('note')).toHaveTextContent(/legal entity name.*registered address.*privacy contact email/);
    expect(screen.getAllByText(/operator to provide/).length).toBeGreaterThan(0);
  });

  it('uses operator-provided values when configured', async () => {
    vi.stubEnv('VITE_LEGAL_ENTITY_NAME', 'Example Labs Pvt Ltd');
    vi.stubEnv('VITE_PRIVACY_CONTACT_EMAIL', 'privacy@example.test');
    renderApp('/privacy');
    await screen.findByRole('heading', { level: 1, name: 'Privacy Policy' });
    expect(screen.getAllByText('Example Labs Pvt Ltd').length).toBeGreaterThan(0);
    expect(screen.getByRole('note')).not.toHaveTextContent(/legal entity name/);
    expect(screen.getByRole('note')).toHaveTextContent(/registered address/);
  });

  it('privacy policy discloses code processing by JDoodle and states what is not logged', async () => {
    renderApp('/privacy');
    expect(await screen.findByText(/source code and the test inputs are sent to the JDoodle Compiler API/)).toBeInTheDocument();
    expect(screen.getByText(/do not contain passwords, tokens or cookies/)).toBeInTheDocument();
  });

  it('cookie policy lists essential cookies and states no analytics are used', async () => {
    renderApp('/cookies');
    expect(await screen.findByText(/Access session cookie/)).toBeInTheDocument();
    expect(screen.getByText(/does not currently use analytics or advertising/)).toBeInTheDocument();
  });

  it('contact shows a mailto link only when a support email is configured', async () => {
    const { unmount } = renderApp('/contact');
    expect(await screen.findByText(/not yet provided a support email/)).toBeInTheDocument();
    unmount();
    vi.stubEnv('VITE_SUPPORT_EMAIL', 'help@example.test');
    renderApp('/contact');
    expect(await screen.findByRole('link', { name: 'help@example.test' })).toHaveAttribute('href', 'mailto:help@example.test');
  });

  it('deletion page points signed-in users to settings', async () => {
    renderApp('/privacy-requests');
    expect(await screen.findByRole('link', { name: 'Go to settings' })).toHaveAttribute('href', '/settings');
  });

  it('footer navigation links to every legal page; each legal page is also reached by its own route (see PAGES above)', async () => {
    renderApp('/');
    const footer = await screen.findByRole('contentinfo');
    const nav = within(footer).getByRole('navigation', { name: 'Footer' });
    for (const href of ['/terms', '/privacy', '/cookies', '/acceptable-use', '/privacy-requests', '/contact']) {
      expect(nav.querySelector(`a[href="${href}"]`)).not.toBeNull();
    }
  });
});
