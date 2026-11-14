import { Box, Typography } from '@mui/material';

export const BACKEND_DEVELOPER = 'Kundan Kumar Sharma';

/** The developer's name: green text on a soft green highlight. `forceDark` is for always-dark screens (Terminal). */
export function DeveloperName({ forceDark = false }) {
  return (
    <Box
      component="strong"
      sx={(t) => {
        const dark = forceDark || t.palette.mode === 'dark';
        return {
          color: dark ? '#7EE2A8' : '#1B6B3A',
          bgcolor: dark ? 'rgba(74, 222, 128, 0.14)' : 'rgba(27, 107, 58, 0.10)',
          fontWeight: 700,
          px: 0.75,
          py: 0.125,
          borderRadius: '6px',
          boxDecorationBreak: 'clone',
          WebkitBoxDecorationBreak: 'clone',
        };
      }}
    >
      {BACKEND_DEVELOPER}
    </Box>
  );
}

/** One-line credit shown in the footer, Terminal, auth pages and About. `sx` lets each place match its own colours. */
export default function DeveloperCredit({ sx, align = 'inherit' }) {
  return (
    <Typography component="p" variant="body2" color="text.secondary" sx={{ textAlign: align, ...sx }}>
      Backend developed by <DeveloperName />
    </Typography>
  );
}