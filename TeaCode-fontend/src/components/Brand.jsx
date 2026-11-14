import { Box } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import TeaCodeLogo from './TeaCodeLogo.jsx';

/** The TeaCode logo as a link to the home page (or as a plain image when not linked). */
export default function Brand({ to = '/', variant = 'navbar', linked = true }) {
  const sx = { display: 'inline-flex', alignItems: 'center', justifyContent: 'flex-start', textDecoration: 'none', lineHeight: 0, flexShrink: 0 };

  // The link carries the accessible name, so the image inside it is decorative.
  return linked ? (
    <Box
      component={RouterLink}
      to={to}
      aria-label="TeaCode home"
      sx={{ ...sx, borderRadius: 1, '&:focus-visible': { outline: '2px solid', outlineColor: 'primary.main', outlineOffset: 4 } }}
    >
      <TeaCodeLogo variant={variant} decorative />
    </Box>
  ) : (
    <Box component="span" sx={sx}>
      <TeaCodeLogo variant={variant} />
    </Box>
  );
}