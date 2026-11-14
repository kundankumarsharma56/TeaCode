import LegalLayout, { List, P, Section } from './LegalLayout.jsx';

export default function CookiesPage() {
  return (
    <LegalLayout title="Cookie Policy">
      <Section title="1. What this covers">
        <P>This page explains the cookies and similar browser storage TeaCode uses.</P>
      </Section>
      <Section title="2. Essential cookies">
        <P>These are required for sign-in and security. The service does not work without them, so they do not require consent.</P>
        <List items={[
          'Access session cookie: a short-lived, HttpOnly cookie that proves you are signed in.',
          'Refresh session cookie: a longer-lived, HttpOnly cookie used to renew your session. It can be revoked by logging out.',
          'CSRF cookie: lets the app prove that state-changing requests come from the TeaCode site.',
        ]} />
        <P>These cookies are set by TeaCode only, are not readable by page scripts (except the CSRF value, which the app must read), and are marked Secure in production.</P>
      </Section>
      <Section title="3. Preference storage">
        <P>Your light or dark theme choice is saved in your browser&apos;s local storage so it is remembered. It is not sent to our servers and contains no personal data.</P>
      </Section>
      <Section title="4. Analytics and advertising">
        <P>TeaCode does not currently use analytics or advertising cookies or trackers. If that changes, optional tracking will stay off until you give consent, and this policy will be updated first.</P>
      </Section>
      <Section title="5. Managing cookies">
        <P>You can delete or block cookies in your browser settings. Blocking essential cookies will prevent you from signing in.</P>
      </Section>
    </LegalLayout>
  );
}
