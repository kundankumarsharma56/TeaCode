import { Box, Container, Typography } from '@mui/material';
import TranslateIcon from '@mui/icons-material/Translate';
import TerminalIcon from '@mui/icons-material/Terminal';
import TrendingUpIcon from '@mui/icons-material/TrendingUp';
import SectionHeading from './SectionHeading.jsx';

const STEPS = [
  { n: '01', icon: TranslateIcon, title: 'Choose Your Language', text: 'Select the programming language you want to learn or practice.' },
  { n: '02', icon: TerminalIcon, title: 'Write and Execute Code', text: 'Use the interactive editor to write, run, and experiment with code.' },
  { n: '03', icon: TrendingUpIcon, title: 'Practice and Improve', text: 'Solve challenges, review results, and improve your programming skills.' },
];

export default function HowItWorks() {
  return (
    <Box id="how-it-works" component="section" aria-labelledby="how-title" sx={{ py: { xs: 8, md: 12 } }}>
      <Container maxWidth="lg">
        <SectionHeading id="how-title" title="How TeaCode works" lead="Three steps from your first line of code to" highlight="steady progress." />
        <Box component="ol" sx={{ listStyle: 'none', p: 0, m: 0, display: 'grid', gap: 2, gridTemplateColumns: { xs: 'minmax(0, 1fr)', md: 'repeat(3, minmax(0, 1fr))' } }}>
          {STEPS.map(({ n, icon: Icon, title, text }) => (
            <Box component="li" key={title} sx={{ display: 'flex' }}>
              <Box sx={{ width: '100%', p: 3, border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper' }}>
                <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', mb: 3 }}>
                  <Box aria-hidden="true" sx={{ width: 44, height: 44, display: 'grid', placeItems: 'center', border: 1, borderColor: 'divider', borderRadius: 2, bgcolor: 'background.default' }}><Icon sx={{ fontSize: 22, color: 'primary.main' }} /></Box>
                  <Typography aria-hidden="true" variant="overline" color="primary" sx={{ lineHeight: 1 }}>{n}</Typography>
                </Box>
                <Typography variant="h6" component="h3" sx={{ fontWeight: 600, mb: 1 }}>{title}</Typography>
                <Typography color="text.secondary" sx={{ fontSize: 15, lineHeight: 1.65 }}>{text}</Typography>
              </Box>
            </Box>
          ))}
        </Box>
      </Container>
    </Box>
  );
}