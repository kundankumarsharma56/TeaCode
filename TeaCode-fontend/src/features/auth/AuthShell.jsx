import { Box, Container, Typography, useMediaQuery } from '@mui/material';
import { motion } from 'framer-motion';
import { useLocation } from 'react-router-dom';
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';
import Brand from '../../components/Brand.jsx';
import DeveloperCredit from '../../components/DeveloperCredit.jsx';
import { FORBIDDEN_MESSAGE } from '../../services/apiErrors.js';

const POINTS = ['Real code execution', 'Judged on real test cases', 'Your submissions, saved'];
// Decorative code-window lines: width in percent, indent level, accent colour or not.
const LINES = [[38, 0, true], [64, 1, false], [52, 1, false], [30, 2, true], [70, 1, false], [24, 0, true], [58, 1, false]];
const FILL = { position: 'absolute', top: 0, right: 0, bottom: 0, left: 0 };

function BrandPanel() {
  return (
    <Box
      sx={{
        display: { xs: 'none', md: 'flex' },
        position: 'relative',
        overflow: 'hidden',
        flexDirection: 'column',
        justifyContent: 'space-between',
        gap: 4,
        p: 5,
        bgcolor: '#0B0B0C',
        color: '#F2EFEC',
        borderRight: 1,
        borderColor: 'divider',
      }}
    >
      <Box aria-hidden="true" sx={{ ...FILL, pointerEvents: 'none', background: 'radial-gradient(60% 45% at 20% 0%, rgba(224,123,84,.22) 0%, transparent 70%), radial-gradient(50% 40% at 100% 100%, rgba(224,123,84,.12) 0%, transparent 70%)' }} />
      <Box aria-hidden="true" sx={{ ...FILL, pointerEvents: 'none', backgroundImage: 'radial-gradient(rgba(255,255,255,.07) 1px, transparent 1.6px)', backgroundSize: '28px 28px', maskImage: 'radial-gradient(ellipse 90% 80% at 40% 30%, #000 20%, transparent 80%)', WebkitMaskImage: 'radial-gradient(ellipse 90% 80% at 40% 30%, #000 20%, transparent 80%)' }} />

      <Box sx={{ position: 'relative' }}>
        <Box sx={{ display: 'inline-block', px: 1.5, py: 0.5, mb: 2.5, border: 1, borderColor: 'rgba(224,123,84,.45)', borderRadius: 99, color: '#E07B54', fontSize: 12, fontWeight: 700, letterSpacing: '.08em', textTransform: 'uppercase' }}>Your coding workspace</Box>
        <Typography component="p" sx={{ fontSize: { md: '1.9rem', lg: '2.2rem' }, fontWeight: 700, lineHeight: 1.15, letterSpacing: '-0.02em', maxWidth: 420 }}>
          Write code, solve problems, keep your progress.
        </Typography>
        <Box component="ul" sx={{ listStyle: 'none', p: 0, m: 0, mt: 3, display: 'grid', gap: 1.25 }}>
          {POINTS.map((p) => (
            <Box key={p} component="li" sx={{ display: 'flex', alignItems: 'center', gap: 1, color: '#A8A29C', fontSize: 15 }}>
              <CheckCircleOutlineIcon aria-hidden="true" sx={{ fontSize: 19, color: '#E07B54' }} />
              {p}
            </Box>
          ))}
        </Box>
      </Box>

      <Box aria-hidden="true" sx={{ position: 'relative', border: 1, borderColor: '#2A2A2E', borderRadius: 3, bgcolor: '#141415', overflow: 'hidden' }}>
        <Box sx={{ display: 'flex', gap: 0.75, px: 2, py: 1.5, borderBottom: 1, borderColor: '#2A2A2E' }}>
          {[0, 1, 2].map((i) => <Box key={i} sx={{ width: 9, height: 9, borderRadius: '50%', bgcolor: i === 0 ? '#E07B54' : '#3a3a3f' }} />)}
        </Box>
        <Box sx={{ p: 2.5, display: 'grid', gap: 1.25 }}>
          {LINES.map(([w, indent, accent], i) => (
            <Box key={i} sx={{ height: 8, width: `${w}%`, ml: `${indent * 4}%`, borderRadius: 1, bgcolor: accent ? 'rgba(224,123,84,.55)' : 'rgba(255,255,255,.11)' }} />
          ))}
        </Box>
      </Box>
    </Box>
  );
}

export default function AuthShell({ title, subtitle, children }) {
  const { pathname } = useLocation();
  const bare = ['/login', '/register'].includes(pathname); // no Navbar on these two routes
  const reduce = useMediaQuery('(prefers-reduced-motion: reduce)');
  const enter = reduce ? {} : { initial: { opacity: 0, y: 14 }, animate: { opacity: 1, y: 0 }, transition: { duration: 0.35, ease: 'easeOut' } };
  return (
    <Box sx={{ minHeight: bare ? '100dvh' : 'calc(100dvh - 64px)', width: '100%', boxSizing: 'border-box', overflowX: 'hidden', display: 'flex', alignItems: 'center', px: { xs: 1.5, sm: 3 }, py: { xs: 3, md: 6 } }}>
      <Container maxWidth={false} disableGutters sx={{ maxWidth: 1120 }}>
        <Box component={motion.div} {...enter}>
          <Box
            sx={{
              display: 'grid',
              gridTemplateColumns: { xs: 'minmax(0, 1fr)', md: 'minmax(0, 5fr) minmax(0, 6fr)' },
              minHeight: { md: 620 },
              border: 1,
              borderColor: 'divider',
              borderRadius: 3,
              bgcolor: 'background.paper',
              boxShadow: 'none',
              backgroundImage: 'none',
              overflow: 'hidden',
            }}
          >
            <BrandPanel />
            <Box sx={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', px: { xs: 2.5, sm: 6 }, py: { xs: 4, md: 6 } }}>
              <Box sx={{ width: '100%', maxWidth: 400 }}>
                <Box sx={{ display: 'flex', justifyContent: 'center', mb: 3.5 }}><Brand variant="auth" /></Box>
                <Typography variant="h5" component="h1" gutterBottom sx={{ fontSize: 26, fontWeight: 700, letterSpacing: '-0.02em' }}>{title}</Typography>
                {subtitle && <Typography color="text.secondary" sx={{ mb: 3, fontSize: 14, lineHeight: 1.6 }}>{subtitle}</Typography>}
                {children}
              </Box>
            </Box>
          </Box>
          <DeveloperCredit align="center" sx={{ mt: 3 }} />
        </Box>
      </Container>
    </Box>
  );
}

/** Message to show for a failed auth call without leaking details; honors the API's safe message. */
export function errorMessage(err, fallback = 'Something went wrong. Please try again.') {
  const status = err?.response?.status;
  if (status === 429) return 'Too many attempts. Please wait a moment and try again.';
  if (status === 403 && err?.response?.data?.code === 'EMAIL_UNVERIFIED') return 'Verify your email address before signing in. Enter the code we emailed you.';
  if (status === 403) return FORBIDDEN_MESSAGE;
  if (!err?.response) return 'Could not reach the server. Check your connection and try again.';
  return err.response.data?.message || fallback;
}