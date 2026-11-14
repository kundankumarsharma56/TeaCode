import { Box, Button, Container, Stack, Typography } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import { motion, useReducedMotion } from 'framer-motion';
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';
import TerminalPreview from './visuals/TerminalPreview.jsx';
import TeaCodeLogo from '../../components/TeaCodeLogo.jsx';
import HeroVideoBackdrop from './visuals/HeroVideoBackdrop.jsx';

// Capabilities that exist today. No numbers, no user counts.
const HIGHLIGHTS = ['Real code execution', 'Judged on real test cases', 'Your submissions, saved'];

export default function Hero() {
  const reduce = useReducedMotion();
  const enter = (delay, x = 0) => (reduce ? {} : { initial: { opacity: 0, y: 22, x }, animate: { opacity: 1, y: 0, x: 0 }, transition: { duration: 0.55, delay, ease: 'easeOut' } });

  return (
    <Box
      id="home"
      component="section"
      aria-labelledby="hero-title"
      sx={{
        position: 'relative',
        overflow: 'hidden',
        pt: { xs: 6, md: 9 },
        pb: { xs: 7, md: 11 },
        background: 'radial-gradient(55% 42% at 50% 0%, rgba(224,123,84,.14) 0%, transparent 72%)',
      }}
    >
      <HeroVideoBackdrop />
      <Container maxWidth="xl" sx={{ position: 'relative', zIndex: 1 }}>
        <Stack spacing={{ xs: 3, md: 3.5 }} sx={{ alignItems: 'center', textAlign: 'center' }}>
          <motion.div {...enter(0)}><TeaCodeLogo variant="landing" /></motion.div>
          <motion.div {...enter(0.05)}>
            <Typography
              id="hero-title"
              variant="h1"
              sx={{ fontSize: { xs: '2.5rem', sm: '3.5rem', md: '4.75rem' }, fontWeight: 700, lineHeight: 1.04, letterSpacing: '-0.035em', maxWidth: 980 }}
            >
              Code. Learn. Build.{' '}
              <Box component="span" sx={{ color: '#F3D9C9' }}>Become a Better Developer.</Box>
            </Typography>
          </motion.div>
          <motion.div {...enter(0.1)}>
            <Typography variant="h6" component="p" color="text.secondary" sx={{ fontWeight: 400, maxWidth: 640, lineHeight: 1.6 }}>
              Master programming through hands-on coding, real-world challenges, and interactive learning. Write code, solve problems, and build your developer journey with TeaCode.
            </Typography>
          </motion.div>
          <motion.div {...enter(0.2)}>
            <Stack direction={{ xs: 'column', sm: 'row' }} spacing={2} sx={{ justifyContent: 'center' }}>
              <Button component={RouterLink} to={import.meta.env.VITE_TERMINAL_ENABLED === 'false' ? '/problems' : '/terminal'} size="large" variant="contained" sx={{ px: 3.5, minHeight: 50, fontWeight: 700, borderRadius: 1.5 }}>Start Coding</Button>
              <Button
                component={RouterLink}
                to="/problems"
                size="large"
                variant="outlined"
                color="inherit"
                sx={{ px: 3.5, minHeight: 50, fontWeight: 700, borderRadius: 1.5, borderColor: 'divider', '&:hover': { borderColor: 'text.secondary', bgcolor: 'action.hover' } }}
              >
                Explore Problems
              </Button>
            </Stack>
          </motion.div>
          <motion.div {...enter(0.3)}>
            <Stack component="ul" direction="row" useFlexGap spacing={2.5} aria-label="Platform highlights" sx={{ flexWrap: 'wrap', justifyContent: 'center', listStyle: 'none', p: 0, m: 0 }}>
              {HIGHLIGHTS.map((h) => (
                <Box key={h} component="li" sx={{ display: 'flex', alignItems: 'center', gap: 0.75, color: 'text.secondary', fontSize: 14 }}>
                  <CheckCircleOutlineIcon aria-hidden="true" sx={{ fontSize: 18, color: 'primary.main' }} />
                  {h}
                </Box>
              ))}
            </Stack>
          </motion.div>
        </Stack>

        <motion.div {...enter(0.4, 0)}>
          <Box sx={{ mt: { xs: 6, md: 9 }, mx: 'auto', maxWidth: 1360, display: 'flex', justifyContent: 'center', textAlign: 'left' }}>
            <TerminalPreview />
          </Box>
        </motion.div>
      </Container>
    </Box>
  );
}