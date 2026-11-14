import { useState } from 'react';
import { Alert, Box, Button, Chip, Container, Skeleton, Stack, TextField, Typography } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { useApiData } from '../../hooks/useApiData.js';
import { api } from '../../services/api.js';
import { useAuth } from '../../hooks/useAuth.js';
import { errorMessage } from '../auth/AuthShell.jsx';
import AvatarSection from './AvatarSection.jsx';
import PageHeader from '../../components/PageHeader.jsx';

const schema = z.object({ username: z.string().trim().regex(/^[A-Za-z0-9_]{3,30}$/, '3–30 characters: letters, numbers, underscore') });

function ProfileForm({ profile }) {
  const { setUser } = useAuth();
  const [status, setStatus] = useState(null); // { severity, text }
  const { register, handleSubmit, formState: { errors, isSubmitting, isDirty } } = useForm({
    resolver: zodResolver(schema),
    defaultValues: { username: profile.username },
  });

  const onSubmit = async (values) => {
    setStatus(null);
    try {
      const res = await api.patch('/users/me', values);
      setUser((u) => ({ ...(u ?? {}), ...res.data }));
      setStatus({ severity: 'success', text: 'Profile updated.' });
    } catch (e) {
      setStatus({ severity: 'error', text: errorMessage(e) });
    }
  };

  return (
    <Box component="form" onSubmit={handleSubmit(onSubmit)} noValidate>
      <Stack spacing={2} sx={{ maxWidth: 420 }}>
        {status && <Alert severity={status.severity}>{status.text}</Alert>}
        <TextField label="Username" {...register('username')} error={Boolean(errors.username)} helperText={errors.username?.message} />
        <TextField label="Email" value={profile.email} disabled helperText="Email changes are not supported yet." />
        <Box>
          <Button type="submit" variant="contained" disabled={isSubmitting || !isDirty}>{isSubmitting ? 'Saving…' : 'Save changes'}</Button>
        </Box>
      </Stack>
    </Box>
  );
}

export default function ProfilePage() {
  const me = useApiData('/users/me');
  return (
    <Container maxWidth="md" sx={{ py: { xs: 5, md: 8 } }}>
      <PageHeader label="Account" title="Profile" sx={{ mb: 4 }} />
      {me.status === 'loading' && <Skeleton variant="rounded" height={200} aria-label="Loading profile" />}
      {me.status === 'error' && <Alert severity="error">Your profile could not be loaded. Please try again later.</Alert>}
      {me.status === 'success' && (
        <Stack spacing={3}>
          <Stack direction="row" spacing={1} sx={{ alignItems: 'center' }}>
            <Chip size="small" color={me.data.emailVerified ? 'success' : 'warning'} label={me.data.emailVerified ? 'Email verified' : 'Email not verified'} />
            {me.data.authProviders?.length > 0 && <Typography variant="body2" color="text.secondary">Sign-in: {me.data.authProviders.join(', ')}</Typography>}
            {me.data.createdAt && <Typography variant="body2" color="text.secondary">Member since {new Date(me.data.createdAt).toLocaleDateString()}</Typography>}
          </Stack>
          <AvatarSection profile={me.data} />
          <ProfileForm profile={me.data} />
          <Box><Button component={RouterLink} to="/settings" variant="outlined">Password and account settings</Button></Box>
        </Stack>
      )}
    </Container>
  );
}
