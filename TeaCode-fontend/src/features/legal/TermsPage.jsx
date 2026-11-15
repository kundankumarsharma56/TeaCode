import LegalLayout, { List, P, Section, Value } from './LegalLayout.jsx';
import { getLegalConfig, missingLegalFields } from '../../config/legal.js';

export default function TermsPage() {
  const cfg = getLegalConfig();
  return (
    <LegalLayout title="Terms and Conditions" missing={missingLegalFields(cfg, ['entityName', 'address', 'supportEmail'])}>
      <Section title="1. Who we are">
        <P>TeaCode is a coding practice service operated by <Value value={cfg.entityName} label="legal entity name" />, <Value value={cfg.address} label="registered address" />. Contact: <Value value={cfg.supportEmail} label="support email" />.</P>
      </Section>
      <Section title="2. Your account">
        <List items={[
          'You must provide accurate information and keep your email account and password secure.',
          'You are responsible for activity under your account. Tell us promptly if you suspect unauthorised use.',
          'We may require email verification before some features are available.',
        ]} />
      </Section>
      <Section title="3. Permitted use">
        <P>You may use TeaCode to practise programming, run code against problem test cases and track your progress. Use of the service is also subject to the Acceptable Use Policy.</P>
      </Section>
      <Section title="4. Code you submit">
        <List items={[
          'You keep ownership of the code you write and submit.',
          'You grant us a limited licence to store, process and execute your code to provide the service, including sending it to our code execution provider.',
          'Do not submit code that you do not have the right to use, or that contains secrets or personal data.',
        ]} />
      </Section>
      <Section title="5. Our content and intellectual property">
        <P>Problem statements, test cases, branding and the software are owned by us or our licensors. You may not copy, scrape or redistribute problem content or hidden test cases except as the law allows.</P>
      </Section>
      <Section title="6. Prohibited activity">
        <P>See the Acceptable Use Policy for the full list, including attempts to attack the execution environment, extract hidden test cases or overload the service.</P>
      </Section>
      <Section title="7. Availability">
        <P>The service is provided on an as-available basis. Code execution depends on a third-party provider and may be unavailable at times. When it is, we show an error rather than a result.</P>
      </Section>
      <Section title="8. Suspension and termination">
        <P>We may suspend or close accounts that breach these terms or the Acceptable Use Policy. You can delete your account at any time from Settings.</P>
      </Section>
      <Section title="9. Liability">
        <P>[Liability, warranty disclaimer, governing law and dispute resolution terms depend on the operator&apos;s business and jurisdiction and must be drafted by qualified legal counsel.]</P>
      </Section>
      <Section title="10. Changes">
        <P>When these terms change we publish a new version, and may ask you to accept it again. The version in force is shown at the top of this page.</P>
      </Section>
    </LegalLayout>
  );
}
