import { createContext, useMemo } from 'react';
import { ThemeProvider, CssBaseline, GlobalStyles } from '@mui/material';
import { buildTheme } from '../theme/theme.js';

export const ColorModeContext = createContext(null);

// TeaCode ships one theme: dark. The logo artwork is designed for dark surfaces and there is
// no light/dark switch. `mode` stays in the context so the code editor and terminal can keep
// asking which palette to use.
const MODE = 'dark';
const VALUE = { mode: MODE };

export function ColorModeProvider({ children }) {
  const theme = useMemo(() => buildTheme(MODE), []);

  return (
    <ColorModeContext.Provider value={VALUE}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <GlobalStyles
          styles={{
            // Anchored sections (/#faq) must not slide underneath the sticky 64px navbar.
            '[id]': { scrollMarginTop: '80px' },
            html: { colorScheme: MODE },
          }}
        />
        {children}
      </ThemeProvider>
    </ColorModeContext.Provider>
  );
}
