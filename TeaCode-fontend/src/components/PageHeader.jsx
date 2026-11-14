import { Box, Typography } from '@mui/material';

/**
 * The header used across TeaCode pages: a small pill label, a large heading and an optional subtitle.
 * The title is the page's single h1.
 */
export default function PageHeader({ label, title, subtitle, align = 'left', children, sx }) {
  return (
    <Box sx={[{ maxWidth: 760, textAlign: align, mx: align === 'center' ? 'auto' : 0 }, ...(Array.isArray(sx) ? sx : [sx])]}>
      {label && (
        <Box component="p" sx={{ display: 'inline-block', m: 0, mb: 2, px: 1.5, py: 0.5, border: 1, borderColor: 'divider', borderRadius: 5, fontSize: 13, color: 'text.secondary' }}>
          {label}
        </Box>
      )}
      <Typography variant="h3" component="h1" sx={{ fontWeight: 600, letterSpacing: '-0.03em', lineHeight: 1.1 }}>{title}</Typography>
      {subtitle && (
        <Typography sx={{ mt: 1.25, color: 'text.secondary', fontSize: { xs: '1rem', md: '1.1rem' }, lineHeight: 1.6 }}>{subtitle}</Typography>
      )}
      {children}
    </Box>
  );
}