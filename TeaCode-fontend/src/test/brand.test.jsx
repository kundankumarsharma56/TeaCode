import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen } from '@testing-library/react';
import { ThemeProvider } from '@mui/material';
import { MemoryRouter } from 'react-router-dom';
import Brand from '../components/Brand.jsx';
import BrandLoader from '../components/BrandLoader.jsx';
import TeaCodeLogo, { LOGO_SRC, LOGO_WIDTH, LOGO_HEIGHT, LOGO_WIDTHS } from '../components/TeaCodeLogo.jsx';
import { buildTheme } from '../theme/theme.js';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn(), patch: vi.fn(), delete: vi.fn() } }));

const inTheme = (mode, ui) =>
  render(<ThemeProvider theme={buildTheme(mode)}><MemoryRouter>{ui}</MemoryRouter></ThemeProvider>);

beforeEach(() => {
  vi.clearAllMocks();
  window.localStorage.clear();
  api.get.mockRejectedValue({ response: { status: 401 } });
});

describe('logo', () => {
  it('uses the one supplied TeaCode logo file, with its intrinsic size declared so it cannot shift layout', () => {
    inTheme('dark', <TeaCodeLogo variant="landing" />);
    const img = screen.getByAltText('TeaCode');
    expect(LOGO_SRC).toBe('/brand/teacode-logo.png');
    expect(img).toHaveAttribute('src', LOGO_SRC);
    expect(img).toHaveAttribute('width', String(LOGO_WIDTH));
    expect(img).toHaveAttribute('height', String(LOGO_HEIGHT));
    expect(img).toHaveStyle({ height: 'auto' });
  });

  it('is rendered at the width specified for each place', () => {
    expect(LOGO_WIDTHS).toEqual({ navbar: { xs: 120, md: 145 }, landing: 260, auth: 220, footer: 130, loader: 240 });
    for (const [variant, width] of [['landing', 260], ['auth', 220], ['footer', 130], ['loader', 240]]) {
      const { unmount } = inTheme('dark', <TeaCodeLogo variant={variant} />);
      expect(screen.getByAltText('TeaCode')).toHaveStyle({ width: `${width}px` });
      unmount();
    }
  });

  it('keeps the to / variant / linked API: linked logo is one named link, unlinked is a plain image', () => {
    const { unmount } = inTheme('dark', <Brand to="/problems" />);
    expect(screen.getByRole('link', { name: 'TeaCode home' })).toHaveAttribute('href', '/problems');
    unmount();
    inTheme('dark', <Brand linked={false} />);
    expect(screen.queryByRole('link')).not.toBeInTheDocument();
    expect(screen.getByAltText('TeaCode')).toBeInTheDocument();
  });

  it('shows the logo in the navbar and keeps the footer text-only', async () => {
    renderApp('/about');
    await screen.findAllByRole('link', { name: 'TeaCode home' });
    const srcs = [...document.querySelectorAll('header img')].map((i) => i.getAttribute('src'));
    expect(srcs.length).toBeGreaterThan(0);
    srcs.forEach((s) => expect(s).toBe('/brand/teacode-logo.png'));
    expect(document.querySelectorAll('footer img')).toHaveLength(0);
  });
});

describe('no theme switch', () => {
  it('offers no light/dark toggle and stores no colour preference', async () => {
    renderApp('/about');
    await screen.findAllByRole('link', { name: 'TeaCode home' });
    expect(screen.queryByRole('button', { name: /Switch to (dark|light) theme/ })).not.toBeInTheDocument();
    expect(window.localStorage.getItem('codevibs-color-mode')).toBeNull();
    expect(getComputedStyle(document.body).backgroundColor).toBe('rgb(11, 11, 12)'); // the one dark theme
  });
});

describe('logo loader', () => {
  it('is an announced status built from the logo, with no spinner icon', () => {
    render(<BrandLoader label="Loading page" />);
    const status = screen.getByRole('status', { name: 'Loading page' });
    expect(status.querySelectorAll('img[src="/brand/teacode-logo.png"]').length).toBe(2);
    expect(status.querySelector('[role="progressbar"]')).toBeNull();
  });

  it('replaces the spinner while a protected page waits for the session', async () => {
    api.get.mockReturnValue(new Promise(() => {}));
    renderApp('/dashboard');
    expect(await screen.findByRole('status', { name: 'Loading' })).toBeInTheDocument();
  });
});