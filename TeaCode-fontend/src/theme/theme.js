import { createTheme } from '@mui/material/styles';

// Brand foundation: charcoal neutrals with a restrained terracotta accent (TeaCode). Dark mode uses a lighter
// terracotta so text and borders on #0B0B0C stay above WCAG AA contrast.
export const BRAND = { terracotta: '#E07B54', terracottaDeep: '#B4532F', ink: '#161412' };

export function buildTheme(mode) {
  const dark = mode === 'dark';
  return createTheme({
    palette: {
      mode,
      primary: { main: dark ? BRAND.terracotta : BRAND.terracottaDeep, contrastText: dark ? '#170B06' : '#FFFFFF' },
      secondary: { main: dark ? '#CFC8C1' : BRAND.ink },
      success: { main: dark ? '#4CC38A' : '#16794A' },
      warning: { main: dark ? '#E5B34A' : '#9A6700' },
      error: { main: dark ? '#FF7B72' : '#C62828' },
      text: dark ? { primary: '#F2EFEC', secondary: '#A8A29C' } : { primary: BRAND.ink, secondary: '#5C5650' },
      divider: dark ? 'rgba(255,255,255,.10)' : 'rgba(22,20,18,.14)',
      background: dark ? { default: '#0B0B0C', paper: '#141415' } : { default: '#FAF8F6', paper: '#FFFFFF' },
    },
    shape: { borderRadius: 12 },
    typography: {
      fontFamily: 'Inter, system-ui, -apple-system, "Segoe UI", Roboto, sans-serif',
      button: { textTransform: 'none', fontWeight: 600 },
      h1: { fontWeight: 800, letterSpacing: '-0.02em' },
      h2: { fontWeight: 700, letterSpacing: '-0.01em' },
      h3: { fontWeight: 800, letterSpacing: '-0.02em', fontSize: 'clamp(1.75rem, 1.2rem + 2vw, 2.5rem)' },
      h4: { fontWeight: 700, letterSpacing: '-0.015em' },
      h5: { fontWeight: 700, letterSpacing: '-0.01em', fontSize: '1.2rem' },
      h6: { fontWeight: 700 },
      overline: { fontWeight: 700, letterSpacing: '0.08em' },
    },
    components: {
      MuiButton: {
        defaultProps: { disableElevation: true },
        styleOverrides: {
          containedPrimary: {
            backgroundColor: dark ? '#F2EFEC' : BRAND.terracottaDeep,
            color: dark ? '#0B0B0C' : '#FFFFFF',
            '&:hover': { backgroundColor: dark ? '#FFFFFF' : '#9A4526' },
          },
          root: {
            transition: 'transform .12s ease, box-shadow .12s ease, background-color .2s ease',
            '&:active': { transform: 'scale(0.98)' },
            '@media (prefers-reduced-motion: reduce)': { transition: 'none', '&:active': { transform: 'none' } },
          },
        },
      },
      MuiCard: {
        styleOverrides: {
          root: {
            backgroundImage: 'none',
            border: '1px solid',
            borderColor: dark ? 'rgba(255,255,255,.10)' : 'rgba(32,32,32,.14)',
            boxShadow: dark ? 'none' : '0 1px 2px rgba(16,24,18,.04), 0 4px 16px rgba(16,24,18,.04)',
          },
        },
      },
      MuiFormHelperText: { styleOverrides: { root: { '&.Mui-disabled': { color: dark ? '#A8A29C' : '#5C5650' } } } },
      MuiPaper: { styleOverrides: { root: { backgroundImage: 'none' } } },
      MuiChip: { styleOverrides: { root: { fontWeight: 600 } } },
      MuiTableCell: {
        styleOverrides: {
          head: { fontWeight: 700, fontSize: '0.75rem', letterSpacing: '0.04em', textTransform: 'uppercase', color: dark ? '#A8A29C' : '#5C5650', whiteSpace: 'nowrap' },
        },
      },
      MuiLinearProgress: { styleOverrides: { root: { backgroundColor: dark ? 'rgba(160,190,165,.16)' : 'rgba(32,32,32,.08)' } } },
      MuiOutlinedInput: { styleOverrides: { root: { backgroundColor: dark ? 'rgba(255,255,255,.02)' : '#FFFFFF' } } },
      MuiDialog: { styleOverrides: { paper: { borderRadius: 16 } } },
    },
  });
}

export const MONO_FONT = '"JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Consolas, monospace';
