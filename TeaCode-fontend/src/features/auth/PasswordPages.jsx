import { useState } from 'react';
import { Alert, Button, Stack, TextField } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import AuthShell, { errorMessage } from './AuthShell.jsx';
import { useCooldown } from './useCooldown.js';
import { api } from '../../services/api.js';

// TeaCode auth form styling.
const FIELD_SX = { '& .MuiOutlinedInput-root': { borderRadius: '10px' } };
const PRIMARY_SX = { minHeight: 48, fontWeight: 700, borderRadius: 1.5 };
const BACK_SX = { color: 'text.secondary', '&:hover': { color: 'text.primary', bgcolor: 'action.hover' } };

/** Password reset by emailed code: 1) enter the email, 2) enter the code and a new password. */
export function ForgotPasswordPage() {
  const [step, setStep] = useState('email'); // email | reset | done
  const [email, setEmail] = useState('');
  const [code, setCode] = useState('');
  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');
  const [busy, setBusy] = useState(false);
  const [left, startCooldown] = useCooldown();

  const requestCode = async () => {
    setError(''); setNotice('');
    if (!/^\S+@\S+\.\S+$/.test(email.trim())) { setError('Enter a valid email address.'); return; }
    setBusy(true);
    try {
      await api.post('/auth/forgot-password', { email: email.trim() });
      startCooldown(60);
      setStep('reset');
      setNotice('If an account exists for that email, we sent a 6-digit code. It expires in 10 minutes.');
    } catch (e) { setError(errorMessage(e, 'Could not send the code.')); }
    finally { setBusy(false); }
  };

  const reset = async () => {
    setError(''); setNotice('');
    if (!/^\d{6}$/.test(code)) { setError('Enter the 6-digit code.'); return; }
    if (password.length < 10 || password.length > 128) { setError('Use a password between 10 and 128 characters.'); return; }
    if (password !== confirm) { setError('Passwords do not match.'); return; }
    setBusy(true);
    try {
      await api.post('/auth/reset-password', { email: email.trim(), code, password });
      setStep('done');
    } catch (e) { setError(errorMessage(e, 'This code is invalid or has expired.')); }
    finally { setBusy(false); }
  };

  const onSubmit = (event) => { event.preventDefault(); return step === 'email' ? requestCode() : reset(); };
  const subtitle = step === 'email' ? 'Enter your account email and we\u2019ll send a 6-digit code.' : step === 'reset' ? 'Enter the code and choose a new password.' : 'You can sign in now.';

  return <AuthShell title="Reset your password" subtitle={subtitle}>
    <Stack component="form" spacing={2} onSubmit={onSubmit} noValidate>
      {step === 'done' ? <Alert severity="success" variant="outlined">Password updated. Sign in with your new password.</Alert> : <>
        {notice && <Alert severity="success" variant="outlined">{notice}</Alert>}
        {error && <Alert severity="error" variant="outlined">{error}</Alert>}
        <TextField sx={FIELD_SX} label="Email address" type="email" autoComplete="email" required value={email} disabled={step === 'reset'} onChange={(e) => setEmail(e.target.value)} />
        {step === 'reset' && <>
          <TextField sx={FIELD_SX} label="6-digit code" value={code} autoFocus autoComplete="one-time-code"
            onChange={(e) => setCode(e.target.value.replace(/\D/g, '').slice(0, 6))}
            inputProps={{ inputMode: 'numeric', maxLength: 6, style: { letterSpacing: '0.4em', textAlign: 'center', fontSize: 22 } }} />
          <TextField sx={FIELD_SX} label="New password" type="password" autoComplete="new-password" required value={password} onChange={(e) => setPassword(e.target.value)} inputProps={{ maxLength: 128 }} />
          <TextField sx={FIELD_SX} label="Confirm password" type="password" autoComplete="new-password" required value={confirm} onChange={(e) => setConfirm(e.target.value)} inputProps={{ maxLength: 128 }} />
        </>}
        <Button type="submit" variant="contained" disabled={busy} sx={PRIMARY_SX}>{busy ? 'Please wait\u2026' : step === 'email' ? 'Send code' : 'Update password'}</Button>
        {step === 'reset' && <Button variant="outlined" disabled={busy || left > 0} onClick={requestCode} sx={{ minHeight: 44, borderRadius: 1.5 }}>{left > 0 ? `Send a new code in ${left}s` : 'Send a new code'}</Button>}
      </>}
      <Button component={RouterLink} to="/login" sx={BACK_SX}>{step === 'done' ? 'Go to sign in' : 'Back to sign in'}</Button>
    </Stack>
  </AuthShell>;
}

/** The old /reset-password?token= link page no longer exists; the same code flow is shown here. */
export const ResetPasswordPage = ForgotPasswordPage;
