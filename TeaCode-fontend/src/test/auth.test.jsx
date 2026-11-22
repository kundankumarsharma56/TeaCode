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

async function fillRegister({ confirm = 'correct horse battery', accept = true } = {}) {
  await userEvent.type(await screen.findByLabelText(/^Username/), 'ada_dev');
  await userEvent.type(screen.getByLabelText(/^Email address/), 'ada@example.com');
  await userEvent.type(screen.getByLabelText(/^Password/), 'correct horse battery');
  await userEvent.type(screen.getByLabelText(/^Confirm password/), confirm);
  if (accept) await userEvent.click(screen.getByRole('checkbox'));
  await userEvent.click(screen.getByRole('button', { name: 'Create account' }));
}

describe('password authentication', () => {
  it('signs in with email and password', async () => {
    renderApp('/login');
    await userEvent.type(await screen.findByLabelText(/^Email address/), 'ada@example.com');
    await userEvent.type(screen.getByLabelText(/^Password/), 'correct horse battery');
    await userEvent.click(screen.getByRole('button', { name: 'Sign in' }));
    expect(api.post).toHaveBeenCalledWith('/auth/login', { email: 'ada@example.com', password: 'correct horse battery', rememberMe: true });
    expect(await screen.findByRole('heading', { name: 'Dashboard' })).toBeInTheDocument();
  });

  it('opens the code step when sign-in says the email is not verified', async () => {
    api.post.mockRejectedValueOnce({ response: { status: 403, data: { code: 'EMAIL_UNVERIFIED' } } });
    renderApp('/login');
    await userEvent.type(await screen.findByLabelText(/^Email address/), 'ada@example.com');
    await userEvent.type(screen.getByLabelText(/^Password/), 'correct horse battery');
    await userEvent.click(screen.getByRole('button', { name: 'Sign in' }));
    expect(await screen.findByRole('heading', { name: 'Check your email' })).toBeInTheDocument();
  });

  it('creates an account, asks for the emailed code and signs in with it', async () => {
    api.post.mockResolvedValueOnce({ data: { verificationRequired: true } });
    renderApp('/register');
    await fillRegister();
    expect(api.post).toHaveBeenCalledWith('/auth/register', expect.objectContaining({ username: 'ada_dev', email: 'ada@example.com', acceptPolicies: true }));
    expect(await screen.findByRole('heading', { name: 'Check your email' })).toBeInTheDocument();
    await userEvent.type(screen.getByLabelText(/^6-digit code/), '123456');
    await userEvent.click(screen.getByRole('button', { name: 'Verify and continue' }));
    expect(api.post).toHaveBeenCalledWith('/auth/verify-otp', { email: 'ada@example.com', code: '123456' });
    expect(await screen.findByRole('heading', { name: 'Dashboard' })).toBeInTheDocument();
  });

  it('does not submit registration when the passwords differ', async () => {
    renderApp('/register');
    await fillRegister({ confirm: 'something else entirely' });
    expect(await screen.findByText('Passwords do not match.')).toBeInTheDocument();
    expect(api.post).not.toHaveBeenCalledWith('/auth/register', expect.anything());
  });

  it('does not submit registration without policy acceptance', async () => {
    renderApp('/register');
    await fillRegister({ accept: false });
    expect(await screen.findByText(/Accept the Terms and Conditions/)).toBeInTheDocument();
    expect(api.post).not.toHaveBeenCalledWith('/auth/register', expect.anything());
  });

  it('verifies an email using the token in the verification URL', async () => {
    renderApp('/verify-email?token=verification-token');
    expect(await screen.findByText(/Your email is verified/)).toBeInTheDocument();
    expect(api.post).toHaveBeenCalledWith('/auth/verify-email', { token: 'verification-token' });
  });

  it('resets a password with an emailed code without revealing account existence', async () => {
    renderApp('/forgot-password');
    await userEvent.type(await screen.findByLabelText(/^Email address/), 'ada@example.com');
    await userEvent.click(screen.getByRole('button', { name: 'Send code' }));
    expect(api.post).toHaveBeenCalledWith('/auth/forgot-password', { email: 'ada@example.com' });
    expect(await screen.findByText(/If an account exists/)).toBeInTheDocument();
    await userEvent.type(screen.getByLabelText(/^6-digit code/), '123456');
    await userEvent.type(screen.getByLabelText(/^New password/), 'a brand new passphrase');
    await userEvent.type(screen.getByLabelText(/^Confirm password/), 'a brand new passphrase');
    await userEvent.click(screen.getByRole('button', { name: 'Update password' }));
    expect(api.post).toHaveBeenCalledWith('/auth/reset-password', { email: 'ada@example.com', code: '123456', password: 'a brand new passphrase' });
    expect(await screen.findByText('Password updated. Sign in with your new password.')).toBeInTheDocument();
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
