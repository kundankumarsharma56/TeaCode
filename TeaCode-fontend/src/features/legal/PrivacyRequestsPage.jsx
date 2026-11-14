import { Button } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import LegalLayout, { List, P, Section, Value } from './LegalLayout.jsx';
import { getLegalConfig, missingLegalFields } from '../../config/legal.js';

export default function PrivacyRequestsPage() {
  const cfg = getLegalConfig();
  return (
    <LegalLayout title="Account deletion and privacy requests" missing={missingLegalFields(cfg, ['privacyEmail', 'retentionNote'])}>
      <Section title="Delete your account yourself">
        <P>Signed-in users can delete their account from Settings. You will be asked to confirm by typing your account email address. Deletion is permanent.</P>
        <Button component={RouterLink} to="/settings" variant="outlined" sx={{ justifySelf: 'start' }}>Go to settings</Button>
      </Section>
      <Section title="What deletion removes">
        <List items={[
          'Your profile and sign-in details.',
          'Your submissions and source code.',
          'Your progress records and policy acceptance records.',
        ]} />
        <P>Some data may be kept where the law requires it or for security and backup purposes for a limited time. <Value value={cfg.retentionNote} label="retention periods" /></P>
      </Section>
      <Section title="Other privacy requests">
        <P>To ask for access to, correction of, or a copy of your data, or to raise a privacy concern, email <Value value={cfg.privacyEmail} label="privacy contact email" /> from the address on your account. We may need to verify your identity before acting on a request.</P>
      </Section>
    </LegalLayout>
  );
}
