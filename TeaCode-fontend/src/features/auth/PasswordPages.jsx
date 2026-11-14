import { useState } from 'react';
import { Alert, Button, Stack, TextField } from '@mui/material';
import { Link as RouterLink, useSearchParams } from 'react-router-dom';
import AuthShell, { errorMessage } from './AuthShell.jsx';
import { api } from '../../services/api.js';

// TeaCode auth form styling.
const FIELD_SX = { '& .MuiOutlinedInput-root': { borderRadius: '10px' } };
const PRIMARY_SX = { minHeight: 48, fontWeight: 700, borderRadius: 1.5 };
// (social-button style lives in LoginPage.jsx)
const BACK_SX = { color: 'text.secondary', '&:hover': { color: 'text.primary', bgcolor: 'action.hover' } };

export function ForgotPasswordPage() {
  const [email, setEmail] = useState(''); const [state, setState] = useState('idle'); const [error, setError] = useState('');
  const submit = async (event) => { event.preventDefault(); setError(''); try { await api.post('/auth/forgot-password', { email }); setState('sent'); } catch (e) { setError(errorMessage(e)); } };
  return <AuthShell title="Reset your password" subtitle="Enter your account email and we’ll send a secure reset link.">
    <Stack component="form" spacing={2} onSubmit={submit}>{state === 'sent' ? <Alert severity="success" variant="outlined">If an account exists for that address, a password reset link has been sent.</Alert> : <>
      {error && <Alert severity="error" variant="outlined">{error}</Alert>}<TextField sx={FIELD_SX} label="Email address" type="email" required value={email} onChange={(e) => setEmail(e.target.value)} />
      <Button type="submit" variant="contained" sx={PRIMARY_SX}>Send reset link</Button></>}
      <Button component={RouterLink} to="/login" sx={BACK_SX}>Back to sign in</Button>
    </Stack>
  </AuthShell>;
}

export function ResetPasswordPage() {
  const [params] = useSearchParams(); const token = params.get('token');
  const [password, setPassword] = useState(''); const [confirm, setConfirm] = useState(''); const [state, setState] = useState('idle'); const [error, setError] = useState('');
  const submit = async (event) => { event.preventDefault(); setError(''); if (!token) { setError('The reset link is missing its token.'); return; } if (password.length < 10 || password.length > 128) { setError('Use a password between 10 and 128 characters.'); return; } if (password !== confirm) { setError('Passwords do not match.'); return; } try { await api.post('/auth/reset-password', { token, password }); setState('success'); } catch (e) { setError(errorMessage(e, 'This reset link is invalid or expired.')); } };
  return <AuthShell title="Choose a new password" subtitle="Use at least 10 characters.">
    <Stack component="form" spacing={2} onSubmit={submit}>{state === 'success' ? <Alert severity="success" variant="outlined">Password updated. Sign in with your new password.</Alert> : <>
      {error && <Alert severity="error" variant="outlined">{error}</Alert>}<TextField sx={FIELD_SX} label="New password" type="password" required value={password} onChange={(e) => setPassword(e.target.value)} />
      <TextField sx={FIELD_SX} label="Confirm password" type="password" required value={confirm} onChange={(e) => setConfirm(e.target.value)} />
      <Button type="submit" variant="contained" sx={PRIMARY_SX}>Update password</Button></>}
      <Button component={RouterLink} to="/login" sx={BACK_SX}>Back to sign in</Button>
    </Stack>
  </AuthShell>;
}
