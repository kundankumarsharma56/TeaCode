import { Box, Button, Container, Typography } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';

export default function NotFoundPage() {
  return (
    <Container maxWidth="sm" sx={{ py: { xs: 10, md: 16 }, textAlign: 'center' }}>
      <Box component="p" sx={{ display: 'inline-block', m: 0, mb: 2, px: 1.5, py: 0.5, border: 1, borderColor: 'divider', borderRadius: 5, fontSize: 13, color: 'text.secondary' }}>
        Page not found
      </Box>
      <Typography variant="h2" component="h1" sx={{ fontWeight: 600, letterSpacing: '-0.03em', color: 'primary.main' }}>404</Typography>
      <Typography color="text.secondary" sx={{ mt: 1.5, mb: 4, fontSize: '1.05rem' }}>We could not find the page you were looking for.</Typography>
      <Button component={RouterLink} to="/" variant="contained" size="large">Back to home</Button>
    </Container>
  );
}