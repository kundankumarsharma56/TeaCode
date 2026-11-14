import LegalLayout, { List, P, Section } from './LegalLayout.jsx';

export default function AcceptableUsePage() {
  return (
    <LegalLayout title="Acceptable Use Policy">
      <Section title="Purpose">
        <P>TeaCode runs untrusted code for many users on shared infrastructure. These rules keep it safe and fair.</P>
      </Section>
      <Section title="You must not">
        <List items={[
          'Attack, probe or try to escape the code execution sandbox, or attack the service, other users or third parties.',
          'Attempt to read, infer or extract hidden test cases or expected outputs, for example by writing code designed to leak them.',
          'Submit malware, code intended to harm systems, or code that mines cryptocurrency.',
          'Send excessive requests or run code intended to overload the service, or evade rate limits.',
          'Use the service to infringe intellectual property or break the law.',
          'Share accounts, impersonate others, or create accounts to evade a suspension.',
          'Scrape or redistribute problem content in bulk.',
        ]} />
      </Section>
      <Section title="Enforcement">
        <P>We may remove content, limit access or suspend accounts that break these rules. To report abuse or a security issue, use the details on the Contact page.</P>
      </Section>
    </LegalLayout>
  );
}
