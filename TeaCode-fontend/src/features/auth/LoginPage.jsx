import { useState } from 'react';
import { Alert, Box, Button, Checkbox, Divider, FormControlLabel, Link as MuiLink, Stack, TextField, Typography } from '@mui/material';
import GitHub from '@mui/icons-material/GitHub';
import Google from '@mui/icons-material/Google';
import { Link as RouterLink, Navigate, useLocation } from 'react-router-dom';
import AuthShell, { errorMessage } from './AuthShell.jsx';
import { useCooldown } from './useCooldown.js';
import { api } from '../../services/api.js';
import { useAuth } from '../../hooks/useAuth.js';
import { POLICY_VERSION } from '../../config/legal.js';

const initial = { username: '', email: '', password: '', confirmPassword: '', acceptPolicies: false, rememberMe: true };
const CHECKBOXES = ['acceptPolicies', 'rememberMe'];
const OAUTH_ON = import.meta.env.VITE_OAUTH_ENABLED !== 'false';
const MAIL_ON = import.meta.env.VITE_MAIL_ENABLED !== 'false';

// TeaCode auth form styling.
const FIELD_SX = { '& .MuiOutlinedInput-root': { borderRadius: '10px' } };
const PRIMARY_SX = { minHeight: 48, fontWeight: 700, borderRadius: 1.5 };
const OAUTH_SX = { minHeight: 44, fontWeight: 600, borderRadius: 1.5, color: 'inherit', borderColor: 'divider', '&:hover': { borderColor: 'text.secondary', bgcolor: 'action.hover' } };
const BACK_SX = { color: 'text.secondary', '&:hover': { color: 'text.primary', bgcolor: 'action.hover' } };

export default function LoginPage() {
  const { user, setUser, logout } = useAuth();
  const location = useLocation();
  const isRegister = location.pathname === '/register';
  const [values, setValues] = useState(initial);
  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');
  const [busy, setBusy] = useState(false);
  const [justSignedIn, setJustSignedIn] = useState(false);
  const [step, setStep] = useState('form'); // form | code
  const [code, setCode] = useState('');
  const [left, startCooldown] = useCooldown();
  const target = location.state?.from?.pathname || '/dashboard';
  const update = (key) => (event) => setValues((old) => ({ ...old, [key]: CHECKBOXES.includes(key) ? event.target.checked : event.target.value }));

  const switchAccount = async () => {
    setBusy(true); setError('');
    try { await logout(); } catch (e) { setError(errorMessage(e, 'Could not sign out. Please try again.')); } finally { setBusy(false); }
  };

  // Right after signing in here, continue to the destination. If the browser is already signed in when this page is
  // opened, do not silently continue as that account: the person may want another.
  if (user && justSignedIn) return <Navigate to={target} replace />;
  if (user) {
    return (
      <AuthShell title="You are already signed in" subtitle="This browser has an active TeaCode session.">
        <Stack spacing={2}>
          {error && <Alert severity="error" variant="outlined">{error}</Alert>}
          <Alert severity="info" variant="outlined">Signed in as <strong>{user.username ?? user.email}</strong>{user.username && user.email ? ` (${user.email})` : ''}.</Alert>
          <Button component={RouterLink} to={target} variant="contained" size="large" sx={PRIMARY_SX}>Continue as this account</Button>
          <Button variant="outlined" size="large" disabled={busy} onClick={switchAccount} sx={{ ...OAUTH_SX, minHeight: 48 }}>Sign out and use a different account</Button>
        </Stack>
      </AuthShell>
    );
  }

  const openCodeStep = (message) => { setCode(''); setStep('code'); setError(''); setNotice(message); };

  const submit = async (event) => {
    event.preventDefault(); setError(''); setNotice('');
    if (!values.email.trim() || !/^\S+@\S+\.\S+$/.test(values.email.trim())) { setError('Enter a valid email address.'); return; }
    if (values.password.length < (isRegister ? 10 : 1)) { setError(isRegister ? 'Use a password with at least 10 characters.' : 'Enter your password.'); return; }
    if (isRegister && values.password !== values.confirmPassword) { setError('Passwords do not match.'); return; }
    if (isRegister && !/^[A-Za-z0-9_]{3,30}$/.test(values.username.trim())) { setError('Username must be 3\u201330 letters, numbers or underscores.'); return; }
    if (isRegister && !values.acceptPolicies) { setError('Accept the Terms and Conditions and Privacy Policy to continue.'); return; }
    setBusy(true);
    try {
      if (isRegister) {
        const response = await api.post('/auth/register', { username: values.username.trim(), email: values.email.trim(), password: values.password, acceptPolicies: true, policyVersion: POLICY_VERSION });
        if (response.data?.verificationRequired) {
          startCooldown(60);
          openCodeStep(`We sent a 6-digit code to ${values.email.trim()}. It expires in 10 minutes.`);
        } else {
          setNotice('Account created. Sign in with your email and password.');
          setValues(initial);
        }
      } else {
        const response = await api.post('/auth/login', { email: values.email.trim(), password: values.password, rememberMe: values.rememberMe });
        setJustSignedIn(true);
        setUser(response.data);
      }
    } catch (e) {
      if (!isRegister && e?.response?.status === 403 && e.response.data?.code === 'EMAIL_UNVERIFIED') {
        openCodeStep('Your email is not verified yet. Enter the code we emailed you, or send a new one.');
      } else {
        setError(errorMessage(e, isRegister ? 'Could not create your account.' : 'Sign-in failed.'));
      }
    } finally { setBusy(false); }
  };

  const verifyCode = async (event) => {
    event.preventDefault(); setError(''); setNotice('');
    if (!/^\d{6}$/.test(code)) { setError('Enter the 6-digit code.'); return; }
    setBusy(true);
    try {
      const response = await api.post('/auth/verify-otp', { email: values.email.trim(), code });
      setJustSignedIn(true);
      setUser(response.data);
    } catch (e) { setError(errorMessage(e, 'This code is invalid or has expired.')); }
    finally { setBusy(false); }
  };

  const resend = async () => {
    setError(''); setNotice(''); setBusy(true);
    try {
      await api.post('/auth/resend-otp', { email: values.email.trim() });
      startCooldown(60);
      setNotice('A new code was sent if this account still needs verification.');
    } catch (e) { setError(errorMessage(e, 'Could not send a new code.')); }
    finally { setBusy(false); }
  };

  const oauth = (provider) => { window.location.assign(`/oauth2/authorization/${provider}`); };

  if (step === 'code') {
    return (
      <AuthShell title="Check your email" subtitle={`Enter the 6-digit code we sent to ${values.email.trim()}.`}>
        <Stack component="form" spacing={2} onSubmit={verifyCode} noValidate>
          {notice && <Alert severity="success" variant="outlined">{notice}</Alert>}
          {error && <Alert severity="error" variant="outlined">{error}</Alert>}
          <TextField sx={FIELD_SX} label="6-digit code" value={code} autoFocus fullWidth autoComplete="one-time-code"
            onChange={(e) => setCode(e.target.value.replace(/\D/g, '').slice(0, 6))}
            inputProps={{ inputMode: 'numeric', maxLength: 6, style: { letterSpacing: '0.4em', textAlign: 'center', fontSize: 22 } }} />
          <Button type="submit" variant="contained" size="large" disabled={busy} sx={PRIMARY_SX}>{busy ? 'Please wait\u2026' : 'Verify and continue'}</Button>
          <Button variant="outlined" disabled={busy || left > 0} onClick={resend} sx={{ ...OAUTH_SX, minHeight: 48 }}>{left > 0 ? `Send a new code in ${left}s` : 'Send a new code'}</Button>
          <Button onClick={() => { setStep('form'); setCode(''); setError(''); setNotice(''); }} sx={BACK_SX}>Back</Button>
        </Stack>
      </AuthShell>
    );
  }

  return (
    <AuthShell title={isRegister ? 'Create your account' : 'Welcome back'} subtitle={isRegister ? 'Join TeaCode and build your coding skills.' : 'Sign in to continue to your workspace.'}>
      <Stack spacing={2.25}>
        {notice && <Alert severity="success" variant="outlined">{notice}</Alert>}
        {error && <Alert severity="error" variant="outlined">{error}</Alert>}
        <Box component="form" onSubmit={submit} noValidate>
          <Stack spacing={1.8}>
            {isRegister && <TextField sx={FIELD_SX} label="Username" autoComplete="username" value={values.username} onChange={update('username')} required fullWidth inputProps={{ maxLength: 30 }} />}
            <TextField sx={FIELD_SX} label="Email address" type="email" autoComplete="email" value={values.email} onChange={update('email')} required fullWidth />
            <TextField sx={FIELD_SX} label="Password" type="password" autoComplete={isRegister ? 'new-password' : 'current-password'} value={values.password} onChange={update('password')} required fullWidth inputProps={{ maxLength: 128 }} />
            {isRegister && <TextField sx={FIELD_SX} label="Confirm password" type="password" autoComplete="new-password" value={values.confirmPassword} onChange={update('confirmPassword')} required fullWidth inputProps={{ maxLength: 128 }} />}
            {isRegister ? (
              <FormControlLabel control={<Checkbox checked={values.acceptPolicies} onChange={update('acceptPolicies')} />} sx={{ alignItems: 'flex-start', ml: 0 }} label={<Typography variant="body2">I agree to the <MuiLink component={RouterLink} to="/terms">Terms and Conditions</MuiLink> and <MuiLink component={RouterLink} to="/privacy">Privacy Policy</MuiLink>.</Typography>} />
            ) : (
              <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap' }}>
                <FormControlLabel control={<Checkbox size="small" checked={values.rememberMe} onChange={update('rememberMe')} />} sx={{ ml: 0 }} label={<Typography variant="body2">Remember me</Typography>} />
                <Box sx={{ display: MAIL_ON ? 'block' : 'none' }}><MuiLink component={RouterLink} to="/forgot-password" underline="hover" variant="body2">Forgot password?</MuiLink></Box>
              </Box>
            )}
            <Button type="submit" variant="contained" size="large" disabled={busy} fullWidth sx={PRIMARY_SX}>{busy ? 'Please wait\u2026' : isRegister ? 'Create account' : 'Sign in'}</Button>
          </Stack>
        </Box>
        <Divider sx={OAUTH_ON ? undefined : { display: 'none' }}><Typography variant="caption" color="text.secondary" sx={{ px: 1 }}>OR CONTINUE WITH</Typography></Divider>
        <Stack direction={{ xs: 'column', sm: 'row' }} spacing={1.2} sx={OAUTH_ON ? undefined : { display: 'none' }}>
          <Button variant="outlined" fullWidth startIcon={<Google />} onClick={() => oauth('google')} sx={OAUTH_SX}>Google</Button>
          <Button variant="outlined" fullWidth startIcon={<GitHub />} onClick={() => oauth('github')} sx={OAUTH_SX}>GitHub</Button>
        </Stack>
        <Typography variant="body2" color="text.secondary" textAlign="center">
          {isRegister ? 'Already have an account? ' : "Don't have an account? "}
          <MuiLink component={RouterLink} to={isRegister ? '/login' : '/register'} underline="hover" fontWeight={700}>{isRegister ? 'Sign in' : 'Create account'}</MuiLink>
        </Typography>
      </Stack>
    </AuthShell>
  );
}
