import { useEffect, useState } from 'react';
import { Alert, Button, Stack } from '@mui/material';
import { Link as RouterLink, useSearchParams } from 'react-router-dom';
import AuthShell from './AuthShell.jsx';
import { api } from '../../services/api.js';

export default function VerifyEmailPage() {
  const [params] = useSearchParams();
  const token = params.get('token');
  const [state, setState] = useState(token ? 'verifying' : 'invalid');
  useEffect(() => {
    let active = true;
    if (!token) return undefined;
    api.post('/auth/verify-email', { token }).then(() => { if (active) setState('success'); })
      .catch(() => { if (active) setState('error'); });
    return () => { active = false; };
  }, [token]);
  return <AuthShell title="Email verification" subtitle="Confirming your TeaCode email address.">
    <Stack spacing={2}>
      {state === 'verifying' && <Alert severity="info" variant="outlined">Verifying your email…</Alert>}
      {state === 'success' && <Alert severity="success" variant="outlined">Your email is verified. You can now sign in.</Alert>}
      {state === 'invalid' && <Alert severity="warning" variant="outlined">This verification link is missing its token.</Alert>}
      {state === 'error' && <Alert severity="error" variant="outlined">This verification link is invalid or expired. Request a new account verification email.</Alert>}
      <Button component={RouterLink} to="/login" variant="contained" sx={{ minHeight: 48, fontWeight: 700, borderRadius: 1.5 }}>Continue to sign in</Button>
    </Stack>
  </AuthShell>;
}
