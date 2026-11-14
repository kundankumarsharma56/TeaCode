import LegalLayout, { List, P, Section, Value } from './LegalLayout.jsx';
import { getLegalConfig, missingLegalFields } from '../../config/legal.js';

export default function PrivacyPage() {
  const cfg = getLegalConfig();
  return (
    <LegalLayout title="Privacy Policy" missing={missingLegalFields(cfg, ['entityName', 'address', 'privacyEmail', 'hostingProvider', 'emailProvider', 'retentionNote'])}>
      <Section title="1. Who is responsible">
        <P><Value value={cfg.entityName} label="legal entity name" />, <Value value={cfg.address} label="registered address" />. Privacy contact: <Value value={cfg.privacyEmail} label="privacy contact email" />.</P>
      </Section>
      <Section title="2. Data we collect">
        <List items={[
          'Account data: username, email address, role, account status, email verification status, and timestamps for creation and last login. Sign-in uses one-time email links, so no password is needed; an older account may still hold a salted hash of a password chosen before this change (never the password itself).',
          'Submission data: the source code you run or submit, the language, verdict, test counts, execution time and memory, and when you submitted.',
          'Progress data: which problems you have attempted and solved.',
          'Policy acceptance records: which version of the Terms and Privacy Policy you accepted and when.',
          'Security and audit logs: security-relevant events (for example sign-ins) with a correlation ID and a hashed network address. They do not contain passwords, tokens or cookies.',
          'Technical logs: request logs for operating and securing the service. We do not log source code by default.',
        ]} />
      </Section>
      <Section title="3. Why we use it">
        <List items={[
          'To provide the service: authenticate you, run and judge your code, show your history and progress.',
          'To keep the service secure: detect abuse, enforce rate limits, investigate incidents.',
          'To let you sign in: a one-time sign-in link is emailed to you, which also confirms that you control the address.',
        ]} />
        <P>[The legal basis for each purpose, where the law requires one, must be confirmed by qualified legal counsel.]</P>
      </Section>
      <Section title="4. Cookies and similar storage">
        <P>We use essential cookies to keep you signed in and protect against cross-site request forgery. We also store your light/dark theme choice in your browser. See the Cookie Policy. We do not currently use analytics or advertising trackers.</P>
      </Section>
      <Section title="5. Who we share data with">
        <P>Firebase Authentication (Google): when you ask for a sign-in link, your email address is sent to Google's Firebase Authentication service, which sends the email and confirms the link. Google processes it under its own terms and privacy policy.</P>
        <P>JDoodle: your source code and the test inputs are sent to the JDoodle Compiler API to be compiled and run. Our server holds the JDoodle credentials; they are never sent to your browser.</P>
        <P>Hosting provider: <Value value={cfg.hostingProvider} label="hosting provider" />.</P>
        <P>Email delivery provider: <Value value={cfg.emailProvider} label="email delivery provider" />. It receives your email address and the content of the emails we send.</P>
        <P>We do not sell your personal data.</P>
      </Section>
      <Section title="6. How long we keep it">
        <P><Value value={cfg.retentionNote} label="retention periods" /></P>
        <P>When you delete your account, your profile, submissions and progress are deleted. Backups and security logs may be kept for a limited period as set out above.</P>
      </Section>
      <Section title="7. Your rights">
        <P>Depending on where you live, you may have rights to access, correct, delete or export your data, to object to or restrict some processing, and to complain to a regulator. See Account deletion and privacy requests for how to exercise them. [Applicable rights, including under Indian data-protection law and the laws of any other jurisdiction we serve, must be confirmed by qualified legal counsel.]</P>
      </Section>
      <Section title="8. Changes">
        <P>When this policy changes we publish a new version and may ask you to accept it again.</P>
      </Section>
    </LegalLayout>
  );
}
