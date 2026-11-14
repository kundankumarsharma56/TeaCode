import { Alert, Box, Button, Card, CardContent, Chip, Container, Skeleton, Stack, Typography } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import { useApiData } from '../../hooks/useApiData.js';

const DIFFICULTY_COLOR = { EASY: 'success', MEDIUM: 'warning', HARD: 'error' };

export function difficultyLabel(d) {
  return d ? d.charAt(0) + d.slice(1).toLowerCase() : '';
}

const PARAMS = { page: 0, size: 6, sort: 'newest' };

/**
 * Real published problems from GET /api/v1/problems (server-side paged).
 * Expected response: { items: [{ slug, title, difficulty, tags: [{ name }] }], ... }
 * No sample data is ever shown: failure and empty states are explicit.
 */
export default function PopularProblems() {
  const { status, data } = useApiData('/problems', PARAMS);
  const items = data?.items ?? [];

  let body;
  if (status === 'loading') {
    body = (
      <Box sx={{ display: 'grid', gap: 2, gridTemplateColumns: { xs: 'minmax(0, 1fr)', md: 'repeat(3, minmax(0, 1fr))' } }} aria-busy="true" aria-label="Loading problems">
        {[0, 1, 2].map((k) => <Skeleton key={k} variant="rounded" height={110} />)}
      </Box>
    );
  } else if (status === 'error') {
    body = <Alert severity="error" variant="outlined">Problems could not be loaded right now. Please try again later.</Alert>;
  } else if (items.length === 0) {
    body = (
      <Alert severity="info" variant="outlined">
        No problems have been published yet. Check back soon.
      </Alert>
    );
  } else {
    body = (
      <Box sx={{ display: 'grid', gap: 2, gridTemplateColumns: { xs: 'minmax(0, 1fr)', md: 'repeat(3, minmax(0, 1fr))' } }}>
        {items.map((p) => (
          <Card key={p.slug} variant="outlined" sx={{ borderRadius: 3, bgcolor: 'background.paper', boxShadow: 'none', backgroundImage: 'none', transition: 'border-color .2s ease', '&:hover': { borderColor: 'primary.main' } }}>
            <CardContent>
              <Typography variant="h6" component="h3" gutterBottom>
                <Typography component={RouterLink} to={`/problems/${p.slug}`} color="inherit" variant="inherit" sx={{ textDecoration: 'none', '&:hover': { color: 'primary.main' } }}>
                  {p.title}
                </Typography>
              </Typography>
              <Stack direction="row" spacing={1} useFlexGap sx={{ flexWrap: 'wrap' }}>
                <Chip size="small" variant="outlined" label={difficultyLabel(p.difficulty)} color={DIFFICULTY_COLOR[p.difficulty] ?? 'default'} sx={{ fontWeight: 600 }} />
                {(p.tags ?? []).slice(0, 2).map((t) => <Chip key={t.name} size="small" variant="outlined" label={t.name} sx={{ borderColor: 'divider', color: 'text.secondary' }} />)}
              </Stack>
            </CardContent>
          </Card>
        ))}
      </Box>
    );
  }

  return (
    <Box id="popular-problems" component="section" aria-labelledby="popular-title" sx={{ py: { xs: 8, md: 10 } }}>
      <Container maxWidth="lg">
        <Typography id="popular-title" variant="h4" component="h2" sx={{ mb: 4, textAlign: 'center', fontWeight: 600, letterSpacing: '-0.02em' }}>Popular problems</Typography>
        {body}
        <Box sx={{ textAlign: 'center', mt: 4 }}>
          <Button component={RouterLink} to="/problems" variant="outlined" color="inherit" sx={{ fontWeight: 600, borderRadius: 1.5, minHeight: 44, borderColor: 'divider', '&:hover': { borderColor: 'text.secondary', bgcolor: 'action.hover' } }}>View all problems</Button>
        </Box>
      </Container>
    </Box>
  );
}
