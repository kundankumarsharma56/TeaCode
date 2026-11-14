import { startTransition, useState } from 'react';
import {
  Alert, Box, Button, Container, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle,
  TextField, Typography,
} from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { api } from '../../services/api.js';
import { useAuth } from '../../hooks/useAuth.js';
import { errorMessage } from '../auth/AuthShell.jsx';
import PageHeader from '../../components/PageHeader.jsx';

function DeleteAccount() {
  const { user, setUser } = useAuth();
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);
  const [password, setPassword] = useState('');
  const [error, setError] = useState(null);
  const [busy, setBusy] = useState(false);

  const close = () => { setOpen(false); setPassword(''); setError(null); };
  const confirm = async () => {
    setBusy(true);
    setError(null);
    try {
      await api.delete('/users/me', { data: { password } });
      navigate('/', { replace: true });
      startTransition(() => setUser(null));
    } catch (e) {
      setError(errorMessage(e, 'That is not the email address of this account.'));
      setBusy(false);
    }
  };

  return (
    <>
      <Typography color="text.secondary" sx={{ mb: 2 }}>
        Deleting your account permanently removes your profile, submissions and progress. This cannot be undone.
      </Typography>
      <Button color="error" variant="outlined" onClick={() => setOpen(true)}>Delete my account</Button>
      <Dialog open={open} onClose={close} aria-labelledby="delete-title">
        <DialogTitle id="delete-title">Delete your account?</DialogTitle>
        <DialogContent>
          <DialogContentText sx={{ mb: 2 }}>To confirm, type your account email address{user?.email ? ` (${user.email})` : ''}. This action is permanent.</DialogContentText>
          {error && <Alert severity="error" sx={{ mb: 2 }}>{error}</Alert>}
          <TextField autoFocus fullWidth label="Email address" type="email" autoComplete="email" value={password} onChange={(e) => setPassword(e.target.value)} />
        </DialogContent>
        <DialogActions>
          <Button onClick={close}>Cancel</Button>
          <Button color="error" variant="contained" disabled={!password || busy} onClick={confirm}>Delete account</Button>
        </DialogActions>
      </Dialog>
    </>
  );
}

export default function SettingsPage() {
  return (
    <Container maxWidth="md" sx={{ py: { xs: 5, md: 8 } }}>
      <PageHeader label="Account" title="Settings" subtitle="Manage your account." sx={{ mb: 4 }} />
      <Box component="section" aria-labelledby="del-title" sx={{ p: { xs: 2.5, md: 3 }, border: 1, borderColor: 'divider', borderRadius: 3 }}>
        <Typography id="del-title" variant="h6" component="h2" gutterBottom sx={{ fontWeight: 600 }}>Delete account</Typography>
        <DeleteAccount />
      </Box>
    </Container>
  );
}
