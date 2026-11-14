import { Box, Typography } from '@mui/material';

/** Section title with a one-line subhead; `highlight` is set in warm cream. Left-aligned, shared by every home section. */
export default function SectionHeading({ id, title, lead, highlight }) {
  return (
    <Box sx={{ mb: { xs: 4, md: 6 }, maxWidth: 760 }}>
      <Typography id={id} variant="h3" component="h2" sx={{ fontWeight: 600, letterSpacing: '-0.03em', lineHeight: 1.15 }}>{title}</Typography>
      {(lead || highlight) && (
        <Typography sx={{ mt: 1.25, fontSize: { xs: '1rem', md: '1.15rem' }, lineHeight: 1.6, color: 'text.secondary' }}>
          {lead}{lead && highlight ? ' ' : ''}
          {highlight && <Box component="span" sx={{ color: '#F3D9C9', fontWeight: 600 }}>{highlight}</Box>}
        </Typography>
      )}
    </Box>
  );
}