import { alpha } from '@mui/material/styles';
import { Alert, Box, Container, Typography } from '@mui/material';
import { POLICY_VERSION } from '../../config/legal.js';
import PageHeader from '../../components/PageHeader.jsx';

const LABELS = {
  entityName: 'legal entity name',
  address: 'registered address',
  privacyEmail: 'privacy contact email',
  supportEmail: 'support email',
  hostingProvider: 'hosting provider',
  emailProvider: 'email delivery provider',
  retentionNote: 'data retention periods',
};

/** Shared page frame. Always flags draft status and any business details the operator has not supplied. */
export default function LegalLayout({ title, missing = [], children }) {
  return (
    <Container maxWidth="md" sx={{ py: { xs: 5, md: 8 } }}>
      <PageHeader label="Legal" title={title} sx={{ mb: 1.5 }} />
      <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>Version {POLICY_VERSION}</Typography>
      <Alert severity="warning" variant="outlined" sx={{ mb: 2 }}>
        Draft for legal review. This text describes how TeaCode is built to work. It has not been reviewed by qualified legal counsel
        and must be reviewed, and the missing details below completed, before public launch.
      </Alert>
      {missing.length > 0 && (
        <Alert severity="info" variant="outlined" sx={{ mb: 3 }} role="note">
          The operator has not yet provided: {missing.map((k) => LABELS[k] ?? k).join(', ')}.
        </Alert>
      )}
      <Box sx={{ display: 'grid', gap: 3 }}>{children}</Box>
    </Container>
  );
}

export function Section({ title, children }) {
  return (
    <Box component="section" sx={{ p: { xs: 2.5, md: 3 }, border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper' }}>
      <Typography variant="h6" component="h2" gutterBottom sx={{ fontWeight: 600 }}>{title}</Typography>
      <Box sx={{ display: 'grid', gap: 1.5, '& ul': { m: 0, pl: 3 } }}>{children}</Box>
    </Box>
  );
}

export const P = ({ children }) => <Typography color="text.secondary">{children}</Typography>;
export const List = ({ items }) => (
  <Box component="ul">{items.map((i) => <Typography component="li" color="text.secondary" key={i}>{i}</Typography>)}</Box>
);

/** Inline value from config, or a visible gap marker (never a made-up value). */
export function Value({ value, label }) {
  return value
    ? <strong>{value}</strong>
    : <Box component="span" sx={{ bgcolor: (t) => alpha(t.palette.warning.main, 0.16), color: 'text.primary', border: '1px dashed', borderColor: 'warning.main', px: 0.5, borderRadius: 0.5 }}>[{label}: operator to provide]</Box>;
}
