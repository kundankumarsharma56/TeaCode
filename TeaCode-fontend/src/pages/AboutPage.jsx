import { Box, Container, Link as MuiLink, Typography } from '@mui/material';
import LinkedInIcon from '@mui/icons-material/LinkedIn';
import GitHubIcon from '@mui/icons-material/GitHub';
import { Link as RouterLink } from 'react-router-dom';
import PageHeader from '../components/PageHeader.jsx';
import HeroBackdrop from '../features/landing/visuals/HeroBackdrop.jsx';
import { BACKEND_DEVELOPER, DeveloperName } from '../components/DeveloperCredit.jsx';

const CARD_SX = { border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper', boxShadow: 'none', backgroundImage: 'none', p: { xs: 2.5, md: 3 }, display: 'flex', flexDirection: 'column', gap: 1.5 };
const CARD_TITLE_SX = { fontSize: 13, fontWeight: 700, letterSpacing: '.08em', textTransform: 'uppercase', color: 'primary.main' };
const ICON_LINK_SX = { display: 'inline-flex', verticalAlign: 'middle', p: 0.5, color: 'text.secondary', transition: 'color .15s', '&:hover, &:focus-visible': { color: 'primary.main' } };

const LINKEDIN_URL = 'https://linkedin.com/in/kundankrsharma65/';
const GITHUB_URL = 'https://github.com/kundankumarsharma56';

export default function AboutPage() {
  return (
    <Box component="section" sx={{ position: 'relative', overflow: 'hidden' }}>
      <HeroBackdrop />
      <Container maxWidth="lg" sx={{ position: 'relative', zIndex: 1, py: { xs: 5, md: 8 } }}>
        <PageHeader
          label="About"
          title="About TeaCode"
          subtitle="A coding practice platform: read a problem, write a solution, run it, and get it judged."
          sx={{ mb: { xs: 4, md: 6 } }}
        />
        <Box sx={{ display: 'grid', gap: 2.5, gridTemplateColumns: { xs: 'minmax(0, 1fr)', md: 'repeat(3, minmax(0, 1fr))' } }}>
          <Box sx={CARD_SX}>
            <Typography component="h2" sx={CARD_TITLE_SX}>What it is</Typography>
            <Typography color="text.secondary" sx={{ lineHeight: 1.7 }}>
              TeaCode is a coding practice platform. You read a problem, write a solution in an in-browser editor, run it against sample cases, and submit it to be judged on the full set of test cases.
            </Typography>
          </Box>
          <Box sx={CARD_SX}>
            <Typography component="h2" sx={CARD_TITLE_SX}>How code runs</Typography>
            <Typography color="text.secondary" sx={{ lineHeight: 1.7 }}>
              Code is executed by the JDoodle Compiler API. Verdicts, compiler messages and timings come from that service rather than being simulated.
            </Typography>
          </Box>
          <Box sx={CARD_SX}>
            <Typography component="h2" sx={CARD_TITLE_SX}>Who built it</Typography>
            <Typography color="text.secondary" sx={{ lineHeight: 1.7 }}>
              The backend (API, authentication, judging and database) was developed by <DeveloperName />
              <MuiLink href={LINKEDIN_URL} target="_blank" rel="noopener noreferrer" underline="none" aria-label={`${BACKEND_DEVELOPER} on LinkedIn (opens in a new tab)`} sx={{ ...ICON_LINK_SX, ml: 1 }}>
                <LinkedInIcon />
              </MuiLink>
              <MuiLink href={GITHUB_URL} target="_blank" rel="noopener noreferrer" underline="none" aria-label={`${BACKEND_DEVELOPER} on GitHub (opens in a new tab)`} sx={ICON_LINK_SX}>
                <GitHubIcon />
              </MuiLink>
            </Typography>
            <Typography color="text.secondary" sx={{ lineHeight: 1.7, fontSize: 14 }}>
              Want to get in touch? Find me on LinkedIn or GitHub, or use the{' '}
              <MuiLink component={RouterLink} to="/contact" color="primary" underline="hover">Contact page</MuiLink>.
            </Typography>
          </Box>
        </Box>
      </Container>
    </Box>
  );
}