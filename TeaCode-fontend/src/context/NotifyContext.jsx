import { createContext, useCallback, useMemo, useState } from 'react';
import { Snackbar, Alert } from '@mui/material';

export const NotifyContext = createContext(null);

/** Accessible notifications: MUI Snackbar + Alert (announced via role="alert"). */
export function NotifyProvider({ children }) {
  const [msg, setMsg] = useState(null);
  const notify = useCallback((message, severity = 'info') => setMsg({ message, severity, key: Date.now() }), []);
  const value = useMemo(() => notify, [notify]);

  return (
    <NotifyContext.Provider value={value}>
      {children}
      <Snackbar
        key={msg?.key}
        open={Boolean(msg)}
        autoHideDuration={6000}
        onClose={(_, reason) => reason !== 'clickaway' && setMsg(null)}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}
      >
        {msg ? <Alert severity={msg.severity} variant="filled" onClose={() => setMsg(null)}>{msg.message}</Alert> : undefined}
      </Snackbar>
    </NotifyContext.Provider>
  );
}
