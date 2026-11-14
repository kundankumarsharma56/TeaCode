import { Box, Button, Container, Typography } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import TerminalIcon from '@mui/icons-material/Terminal';
import FactCheckOutlinedIcon from '@mui/icons-material/FactCheckOutlined';
import BoltOutlinedIcon from '@mui/icons-material/BoltOutlined';
import TrendingUpIcon from '@mui/icons-material/TrendingUp';
import SectionHeading from './SectionHeading.jsx';

// Four distinct capabilities, each said once. The hero already shows the terminal, so there is no second code window here.
const FEATURES = [
  { id: 'run', icon: TerminalIcon, title: 'Run code in your browser', text: 'Write code in a syntax-highlighted editor and run it in an interactive console, in many languages. Nothing to install.' },
  { id: 'practice', icon: FactCheckOutlinedIcon, title: 'Practice real problems', text: 'Easy, Medium and Hard problems by topic. Every submission is judged on the full set of test cases.' },
  { id: 'feedback', icon: BoltOutlinedIcon, title: 'Get real feedback', text: 'See the program output, clear error messages and a verdict for your submission as soon as it runs.' },
  { id: 'progress', icon: TrendingUpIcon, title: 'Track your progress', text: 'Review your practice history and submissions to see where you are improving and what to work on next.' },
];

export default function Features() {
  return (
    <Box id="features" component="section" aria-labelledby="features-title" sx={{ py: { xs: 8, md: 12 } }}>
      <Container maxWidth="lg">
        <SectionHeading id="features-title" title="Everything you need to practice" lead="Write real code, get real results, and" highlight="see your progress." />
        <Box component="ul" sx={{ listStyle: 'none', p: 0, m: 0, display: 'grid', gap: 2, gridTemplateColumns: { xs: 'minmax(0, 1fr)', sm: 'repeat(2, minmax(0, 1fr))', lg: 'repeat(4, minmax(0, 1fr))' } }}>
          {FEATURES.map(({ id, icon: Icon, title, text }) => (
            <Box component="li" key={id} sx={{ display: 'flex' }}>
              <Box
                sx={{
                  width: '100%', p: 3, border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper', transition: 'border-color .2s ease',
                  '&:hover': { borderColor: 'primary.main' },
                  '@media (prefers-reduced-motion: reduce)': { transition: 'none' },
                }}
              >
                <Box aria-hidden="true" sx={{ width: 44, height: 44, display: 'grid', placeItems: 'center', border: 1, borderColor: 'divider', borderRadius: 2, bgcolor: 'background.default', mb: 3 }}><Icon sx={{ fontSize: 22, color: 'primary.main' }} /></Box>
                <Typography variant="h6" component="h3" sx={{ fontWeight: 600, mb: 1 }}>{title}</Typography>
                <Typography color="text.secondary" sx={{ fontSize: 15, lineHeight: 1.65 }}>{text}</Typography>
              </Box>
            </Box>
          ))}
        </Box>
        <Box sx={{ mt: 4, display: 'flex', flexWrap: 'wrap', alignItems: 'center', gap: 2 }}>
          <Button component={RouterLink} to={import.meta.env.VITE_TERMINAL_ENABLED === 'false' ? '/problems' : '/terminal'} variant="contained" size="large" sx={{ px: 3, minHeight: 48, fontWeight: 700, borderRadius: 1.5 }}>{import.meta.env.VITE_TERMINAL_ENABLED === 'false' ? 'Browse problems' : 'Open the terminal'}</Button>
          <Typography color="text.secondary" sx={{ fontSize: 15 }}>Open the editor and run your first program.</Typography>
        </Box>
      </Container>
    </Box>
  );
}