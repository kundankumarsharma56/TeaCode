import { createContext, useCallback, useEffect, useMemo, useState } from 'react';
import { api } from '../services/api.js';
import { SESSION_EXPIRED_EVENT } from '../services/sessionEvents.js';

export const AuthContext = createContext(null);

/**
 * Reflects the real backend session (GET /auth/me). This is for UI only;
 * every protected backend operation enforces authorization itself.
 */
export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [status, setStatus] = useState('loading'); // loading | ready

  useEffect(() => {
    let active = true;
    api
      .get('/auth/me')
      .then((res) => {
        if (active) setUser(res.data);
      })
      .catch(() => {
        if (active) setUser(null);
      })
      .finally(() => {
        if (active) setStatus('ready');
      });
    return () => {
      active = false;
    };
  }, []);

  // The API client could not renew the session (refresh token expired or revoked): reflect that in the UI.
  useEffect(() => {
    const onExpired = () => setUser(null);
    window.addEventListener(SESSION_EXPIRED_EVENT, onExpired);
    return () => window.removeEventListener(SESSION_EXPIRED_EVENT, onExpired);
  }, []);

  // Clears the UI session only after the backend confirms revocation; errors propagate.
  const logout = useCallback(async () => {
    await api.post('/auth/logout');
    setUser(null);
  }, []);

  const value = useMemo(() => ({ user, status, setUser, logout }), [user, status, logout]);
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}
