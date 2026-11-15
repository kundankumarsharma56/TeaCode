import { Alert, Box, Container, Skeleton, Typography } from '@mui/material';
import { useApiData } from '../../hooks/useApiData.js';
import LanguageIcon from '../../components/LanguageIcon.jsx';
import Reveal from '../../components/Reveal.jsx';
import SectionHeading from './SectionHeading.jsx';

const GRID = {
  display: 'grid', gap: 1.5, listStyle: 'none', p: 0, m: 0,
  gridTemplateColumns: { xs: 'repeat(2, minmax(0, 1fr))', sm: 'repeat(3, minmax(0, 1fr))', md: 'repeat(4, minmax(0, 1fr))' },
};

/**
 * Languages come from the backend, which offers only the languages it can currently run.
 * Expected: GET /api/v1/execution/languages -> [{ key, name }]. Nothing is advertised that the API does not return.
 * The items are informational: the terminal cannot yet open with a language preselected, so they are not links.
 */
export default function Languages() {
  const { status, data } = useApiData('/execution/languages');
  const langs = Array.isArray(data) ? data : [];

  if (status === 'success' && langs.length === 0) return null;

  let body;
  if (status === 'loading') {
    body = (
      <Box sx={GRID} component="div" aria-busy="true">
        {[0, 1, 2, 3, 4, 5, 6, 7].map((k) => <Skeleton key={k} variant="rounded" height={60} />)}
      </Box>
    );
  } else if (status === 'error') {
    body = <Alert severity="warning" variant="outlined">The list of supported languages is unavailable right now.</Alert>;
  } else if (langs.length === 0) {
    body = <Alert severity="info" variant="outlined">No languages are enabled yet.</Alert>;
  } else {
    body = (
      <Box component="ul" aria-label="Supported languages" sx={GRID}>
        {langs.map((l, i) => (
          <Box component="li" key={l.key}>
            <Reveal delay={Math.min(i, 8) * 0.03}>
              <Box
                sx={{
                  display: 'flex', alignItems: 'center', gap: 1.5, px: 2, py: 1.5, minHeight: 64, border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper',
                  transition: 'border-color .2s ease',
                  '&:hover': { borderColor: 'primary.main' },
                  '@media (prefers-reduced-motion: reduce)': { transition: 'none' },
                }}
              >
                <LanguageIcon language={l.key} size={28} />
                <Typography component="span" sx={{ fontWeight: 500, lineHeight: 1.3 }}>{l.name}</Typography>
              </Box>
            </Reveal>
          </Box>
        ))}
      </Box>
    );
  }

  return (
    <Box id="languages" component="section" aria-labelledby="lang-title" sx={{ py: { xs: 8, md: 12 } }}>
      <Container maxWidth="lg">
        <SectionHeading id="lang-title" title="One Platform. Multiple Programming Languages." lead="Explore, practice, and execute code using" highlight="the programming languages you love." />
        {body}
      </Container>
    </Box>
  );
}