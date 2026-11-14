import { describe, it, expect, vi, beforeEach } from 'vitest';
import { screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { renderApp } from './renderApp.jsx';
import { api } from '../services/api.js';

vi.mock('../services/api.js', () => ({ api: { get: vi.fn(), post: vi.fn() } }));
const ME = { username: 'ada', email: 'ada@example.com', emailVerified: true, createdAt: '2026-01-02T03:04:05Z' };

beforeEach(() => {
  vi.clearAllMocks();
  api.get.mockImplementation((path) => (path === '/auth/me' ? Promise.reject({ response: { status: 401 } }) : Promise.resolve({ data: { items: [] } })));
  api.post.mockResolvedValue({ data: ME });
});

describe('password authentication', () => {
  it('signs in with email and password', async () => {
    renderApp('/login');
    await userEvent.type(await screen.findByLabelText(/^Email address/), 'ada@example.com');
    await userEvent.type(screen.getByLabelText(/^Password/), 'correct horse battery');
    await userEvent.click(screen.getByRole('button', { name: 'Sign in' }));
    expect(api.post).toHaveBeenCalledWith('/auth/login', { email: 'ada@example.com', password: 'correct horse battery' });
    expect(await screen.findByRole('heading', { name: 'Dashboard' })).toBeInTheDocument();
  });

  it('creates an account with required policy acceptance', async () => {
    renderApp('/register');
    await userEvent.type(await screen.findByLabelText(/^Username/), 'ada_dev');
    await userEvent.type(screen.getByLabelText(/^Email address/), 'ada@example.com');
    await userEvent.type(screen.getByLabelText(/^Password/), 'correct horse battery');
    await userEvent.click(screen.getByRole('checkbox'));
    await userEvent.click(screen.getByRole('button', { name: 'Create account' }));
    expect(api.post).toHaveBeenCalledWith('/auth/register', expect.objectContaining({ username: 'ada_dev', email: 'ada@example.com', acceptPolicies: true }));
    expect(await screen.findByText(/Check your email for the verification link/)).toBeInTheDocument();
  });

  it('does not submit registration without policy acceptance', async () => {
    renderApp('/register');
    await userEvent.type(await screen.findByLabelText(/^Username/), 'ada_dev');
    await userEvent.type(screen.getByLabelText(/^Email address/), 'ada@example.com');
    await userEvent.type(screen.getByLabelText(/^Password/), 'correct horse battery');
    await userEvent.click(screen.getByRole('button', { name: 'Create account' }));
    expect(await screen.findByText(/Accept the Terms and Conditions/)).toBeInTheDocument();
    expect(api.post).not.toHaveBeenCalledWith('/auth/register', expect.anything());
  });

  it('verifies an email using the token in the verification URL', async () => {
    renderApp('/verify-email?token=verification-token');
    expect(await screen.findByText(/Your email is verified/)).toBeInTheDocument();
    expect(api.post).toHaveBeenCalledWith('/auth/verify-email', { token: 'verification-token' });
  });

  it('sends a password reset request without revealing account existence', async () => {
    renderApp('/forgot-password');
    await userEvent.type(await screen.findByLabelText(/^Email address/), 'ada@example.com');
    await userEvent.click(screen.getByRole('button', { name: 'Send reset link' }));
    expect(api.post).toHaveBeenCalledWith('/auth/forgot-password', { email: 'ada@example.com' });
    expect(await screen.findByText(/If an account exists/)).toBeInTheDocument();
  });
});

describe('signed-in visitors on the sign-in page', () => {
  it('shows the active account and offers to switch, instead of redirecting silently', async () => {
    api.get.mockImplementation((path) => (path === '/auth/me' ? Promise.resolve({ data: ME }) : Promise.resolve({ data: { items: [] } })));
    renderApp('/login');
    expect(await screen.findByText('You are already signed in')).toBeInTheDocument();
    expect(screen.getByText(/ada@example.com/)).toBeInTheDocument();
    api.post.mockResolvedValue({ data: null });
    await userEvent.click(screen.getByRole('button', { name: 'Sign out and use a different account' }));
    expect(api.post).toHaveBeenCalledWith('/auth/logout');
    expect(await screen.findByRole('button', { name: 'Sign in' })).toBeInTheDocument();
  });
});