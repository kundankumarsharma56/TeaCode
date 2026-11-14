// Business-specific legal details are never hardcoded or invented. The operator supplies them
// at build time (VITE_* variables). Anything missing is shown as an explicit gap on the page.
export const POLICY_VERSION = '2026-10-14-draft';

export function getLegalConfig() {
  const env = import.meta.env;
  const read = (k) => (env[k] ?? '').toString().trim();
  return {
    entityName: read('VITE_LEGAL_ENTITY_NAME'),
    address: read('VITE_LEGAL_ADDRESS'),
    privacyEmail: read('VITE_PRIVACY_CONTACT_EMAIL'),
    supportEmail: read('VITE_SUPPORT_EMAIL'),
    hostingProvider: read('VITE_HOSTING_PROVIDER'),
    emailProvider: read('VITE_EMAIL_PROVIDER'),
    retentionNote: read('VITE_RETENTION_NOTE'),
  };
}

export function missingLegalFields(cfg, keys) {
  return keys.filter((k) => !cfg[k]);
}
