import { Box, Button, Container, Stack, Typography } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import Reveal from '../../components/Reveal.jsx';

export default function FinalCta() {
  return (
    <Box id="get-started" component="section" aria-labelledby="cta-title" sx={{ py: { xs: 8, md: 12 } }}>
      <Container maxWidth="lg">
        <Reveal>
          <Box sx={{ textAlign: 'center', p: { xs: 4, md: 8 }, border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper', backgroundImage: 'radial-gradient(60% 80% at 50% 0%, rgba(224,123,84,.16) 0%, transparent 70%)' }}>
            <Typography id="cta-title" variant="h3" component="h2" sx={{ fontWeight: 600, letterSpacing: '-0.03em', mb: 2 }}>Your Coding Journey Starts Here.</Typography>
            <Typography sx={{ mb: 4, color: 'text.secondary', maxWidth: 640, mx: 'auto', fontSize: '1.05rem', lineHeight: 1.7 }}>
              Whether you&apos;re learning your first programming language or improving your problem-solving skills, TeaCode gives you a place to practice and grow.
            </Typography>
            <Stack direction={{ xs: 'column', sm: 'row' }} spacing={2} justifyContent="center">
              <Button
                component={RouterLink}
                to={import.meta.env.VITE_TERMINAL_ENABLED === 'false' ? '/problems' : '/terminal'}
                size="large"
                variant="contained"
                sx={{ minHeight: 50, px: 4, fontWeight: 700, borderRadius: 1.5, boxShadow: 'none' }}
              >
                Start Coding
              </Button>
              <Button
                component={RouterLink}
                to="/problems"
                size="large"
                variant="outlined"
                sx={{ minHeight: 50, px: 4, fontWeight: 700, borderRadius: 1.5, color: 'text.primary', borderColor: 'divider', '&:hover': { borderColor: 'text.secondary', bgcolor: 'action.hover' } }}
              >
                Explore Problems
              </Button>
            </Stack>
          </Box>
        </Reveal>
      </Container>
    </Box>
  );
}