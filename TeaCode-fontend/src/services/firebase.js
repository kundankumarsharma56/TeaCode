// Firebase is used for one thing: proving that the person controls an email address (passwordless email link).
// The resulting ID token is sent to our backend, which verifies it and starts the normal HttpOnly cookie session.
// The SDK is loaded on demand so it is not part of the main bundle.
const config = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  appId: import.meta.env.VITE_FIREBASE_APP_ID,
};

export const firebaseConfigured = Boolean(config.apiKey && config.authDomain && config.projectId);

const EMAIL_KEY = 'teacode.emailForSignIn';

/** The browser remembers the address between sending the link and opening it. Storage can be blocked, so it is optional. */
export function rememberEmail(email) {
  try { window.localStorage.setItem(EMAIL_KEY, email); } catch { /* the user will be asked to type it again */ }
}
export function recalledEmail() {
  try { return window.localStorage.getItem(EMAIL_KEY) || ''; } catch { return ''; }
}
export function forgetEmail() {
  try { window.localStorage.removeItem(EMAIL_KEY); } catch { /* ignore */ }
}

async function load() {
  const [{ getApp, getApps, initializeApp }, auth] = await Promise.all([import('@firebase/app'), import('@firebase/auth')]);
  const app = getApps().length ? getApp() : initializeApp(config);
  // In-memory only, and without the popup/redirect resolver: nothing is stored in the browser, and the SDK never loads
  // the hidden iframe or Google script that this site's Content-Security-Policy (correctly) does not allow.
  let instance;
  try {
    instance = auth.initializeAuth(app, { persistence: auth.inMemoryPersistence });
  } catch {
    instance = auth.getAuth(app); // already initialised
  }
  return { auth, instance };
}

/** Emails a one-time sign-in link that returns to /login on this site. */
export async function sendLoginLink(email) {
  const { auth, instance } = await load();
  await auth.sendSignInLinkToEmail(instance, email, { url: `${window.location.origin}/login`, handleCodeInApp: true });
}

/** True when the current page address is a Firebase sign-in link. */
export async function isLoginLink(href = window.location.href) {
  if (!firebaseConfigured) return false;
  const { auth, instance } = await load();
  return auth.isSignInWithEmailLink(instance, href);
}

/** Completes the link and returns the Firebase ID token. The Firebase session itself is discarded straight away. */
export async function completeLoginLink(email, href = window.location.href) {
  const { auth, instance } = await load();
  const credential = await auth.signInWithEmailLink(instance, email, href);
  const idToken = await credential.user.getIdToken();
  await auth.signOut(instance);
  return idToken;
}

/** Maps Firebase error codes to messages a person can act on. */
export function firebaseErrorMessage(error) {
  switch (error?.code) {
    case 'auth/invalid-email': return 'That email address does not look right.';
    case 'auth/expired-action-code': return 'This sign-in link has expired. Request a new one.';
    case 'auth/invalid-action-code': return 'This sign-in link is invalid or was already used. Request a new one.';
    case 'auth/too-many-requests': return 'Too many attempts. Please wait a few minutes and try again.';
    case 'auth/network-request-failed': return 'Could not reach the sign-in service. Check your connection and try again.';
    case 'auth/unauthorized-continue-uri':
    case 'auth/invalid-continue-uri': return 'This site is not authorised for sign-in yet. Ask the site owner to add its domain in Firebase.';
    case 'auth/operation-not-allowed': return 'Email-link sign-in is not enabled for this project.';
    default: return 'Could not complete sign-in. Please try again.';
  }
}
