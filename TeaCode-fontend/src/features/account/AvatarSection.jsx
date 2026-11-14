import { useEffect, useRef, useState } from 'react';
import { Alert, Box, Button, Stack, Typography } from '@mui/material';
import { api } from '../../services/api.js';
import { useAuth } from '../../hooks/useAuth.js';
import UserAvatar from '../../components/UserAvatar.jsx';
import { errorMessage } from '../auth/AuthShell.jsx';

export const AVATAR_MAX_BYTES = 2 * 1024 * 1024;
export const AVATAR_TYPES = ['image/png', 'image/jpeg', 'image/webp'];

/**
 * Client checks are only a convenience. The backend re-validates size, real image content and
 * dimensions, and re-encodes the file; it never trusts this browser-supplied type.
 * POST /users/me/avatar (multipart "file") and DELETE /users/me/avatar both return the updated profile.
 */
export default function AvatarSection({ profile }) {
  const { setUser } = useAuth();
  const input = useRef(null);
  const [file, setFile] = useState(null);
  const [preview, setPreview] = useState(null);
  const [busy, setBusy] = useState(false);
  const [status, setStatus] = useState(null);

  useEffect(() => {
    if (!file) { setPreview(null); return undefined; }
    const url = URL.createObjectURL(file);
    setPreview(url);
    return () => URL.revokeObjectURL(url);
  }, [file]);

  const choose = (e) => {
    const f = e.target.files?.[0];
    e.target.value = '';
    setStatus(null);
    if (!f) return;
    if (!AVATAR_TYPES.includes(f.type)) return setStatus({ severity: 'error', text: 'Choose a PNG, JPEG or WebP image.' });
    if (f.size > AVATAR_MAX_BYTES) return setStatus({ severity: 'error', text: 'The image must be 2 MB or smaller.' });
    setFile(f);
  };

  const run = async (fn, ok) => {
    setBusy(true);
    setStatus(null);
    try {
      const res = await fn();
      setUser((u) => ({ ...(u ?? {}), ...res.data }));
      setFile(null);
      setStatus({ severity: 'success', text: ok });
    } catch (e) {
      setStatus({ severity: 'error', text: errorMessage(e, 'The avatar could not be updated.') });
    } finally {
      setBusy(false);
    }
  };

  const upload = () => {
    const form = new FormData();
    form.append('file', file);
    return run(() => api.post('/users/me/avatar', form), 'Avatar updated.');
  };

  return (
    <Stack spacing={2} component="section" aria-labelledby="avatar-title">
      <Typography id="avatar-title" variant="h6" component="h2">Avatar</Typography>
      <Stack direction="row" spacing={2} sx={{ alignItems: 'center' }}>
        {preview ? <Box component="img" src={preview} alt="Selected avatar preview" sx={{ width: 72, height: 72, borderRadius: '50%', objectFit: 'cover' }} /> : <UserAvatar user={profile} size={72} />}
        <Typography variant="body2" color="text.secondary">
          {preview ? 'Preview — not saved yet.' : profile.avatarSource === 'CUSTOM' ? 'Using your uploaded image.' : profile.avatarUrl ? 'Using your sign-in provider image.' : 'No image set.'}
        </Typography>
      </Stack>
      {status && <Alert severity={status.severity}>{status.text}</Alert>}
      <input ref={input} type="file" accept={AVATAR_TYPES.join(',')} hidden onChange={choose} aria-label="Choose avatar image" />
      <Stack direction="row" spacing={1.5} useFlexGap sx={{ flexWrap: 'wrap' }}>
        <Button variant="outlined" onClick={() => input.current?.click()} disabled={busy}>Choose image</Button>
        {file && <Button variant="contained" onClick={upload} disabled={busy}>{busy ? 'Uploading…' : 'Save avatar'}</Button>}
        {file && <Button onClick={() => setFile(null)} disabled={busy}>Cancel</Button>}
        {!file && profile.avatarSource === 'CUSTOM' && (
          <Button color="error" disabled={busy} onClick={() => run(() => api.delete('/users/me/avatar'), 'Custom avatar removed.')}>
            {profile.providerAvatarAvailable ? 'Use provider avatar' : 'Remove avatar'}
          </Button>
        )}
      </Stack>
    </Stack>
  );
}
