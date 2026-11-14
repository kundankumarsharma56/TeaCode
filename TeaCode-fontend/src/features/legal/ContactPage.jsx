import { Alert, Box, Container, Link, Typography } from '@mui/material';
import PageHeader from '../../components/PageHeader.jsx';
import { getLegalConfig } from '../../config/legal.js';

export default function ContactPage() {
  const cfg = getLegalConfig();
  return (
    <Container maxWidth="md" sx={{ py: { xs: 5, md: 8 } }}>
      <PageHeader label="Support" title="Contact and support" sx={{ mb: 4 }} />
      {cfg.supportEmail ? (
        <Box sx={{ display: 'grid', gap: 2, p: { xs: 2.5, md: 3 }, border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper' }}>
          <Typography color="text.secondary">
            For help with your account, a problem statement or a judging result, email{' '}
            <Link href={`mailto:${cfg.supportEmail}`}>{cfg.supportEmail}</Link>. Please include your username and, for a judging issue, the problem name and the time of your submission. Never send your password.
          </Typography>
          <Typography color="text.secondary">To report a security issue or abuse, use the same address and put &quot;Security&quot; in the subject.</Typography>
          {cfg.privacyEmail && (
            <Typography color="text.secondary">Privacy requests: <Link href={`mailto:${cfg.privacyEmail}`}>{cfg.privacyEmail}</Link>.</Typography>
          )}
        </Box>
      ) : (
        <Alert severity="info" variant="outlined">The operator has not yet provided a support email address, so no contact details can be shown yet.</Alert>
      )}
    </Container>
  );
}