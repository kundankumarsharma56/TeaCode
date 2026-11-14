import { Box, Container, Link as MuiLink, Typography } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import DeveloperCredit from './DeveloperCredit.jsx';

const FOOTER_LINKS = [
  ['About', '/about'],
  ['Problems', '/problems'],
  ['Contact', '/contact'],
  ['Terms', '/terms'],
  ['Privacy', '/privacy'],
  ['Cookies', '/cookies'],
  ['Acceptable use', '/acceptable-use'],
  ['Privacy requests', '/privacy-requests'],
];

const LINK_SX = { fontSize: 13, color: 'text.secondary', '&:hover, &:focus-visible': { color: 'primary.main' } };

export default function Footer() {
  return (
    <Box component="footer" sx={{ borderTop: 1, borderColor: 'divider', bgcolor: 'background.default', mt: 'auto', py: 3 }}>
      <Container maxWidth="lg" sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
        <Box component="nav" aria-label="Footer" sx={{ display: 'flex', flexWrap: 'wrap', columnGap: 3, rowGap: 1 }}>
          {FOOTER_LINKS.map(([label, to]) => (
            <MuiLink key={to} component={RouterLink} to={to} underline="hover" sx={LINK_SX}>{label}</MuiLink>
          ))}
        </Box>
        <Box sx={{ display: 'flex', flexWrap: 'wrap', alignItems: 'center', justifyContent: 'space-between', gap: 1 }}>
          <Typography variant="body2" color="text.secondary" sx={{ fontSize: 13 }}>
            &copy; {new Date().getFullYear()} TeaCode. All rights reserved.
          </Typography>
          <DeveloperCredit />
        </Box>
      </Container>
    </Box>
  );
}