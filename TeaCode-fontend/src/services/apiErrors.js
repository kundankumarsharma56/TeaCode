/**
 * Shown for HTTP 403. A 403 on a state-changing request almost always means the server's security checks
 * (CORS origin or CSRF token) refused it, not that the person's credentials or code were wrong, so the UI must
 * not describe it as "invalid password" or a program error. The cause is recorded in the server log.
 */
export const FORBIDDEN_MESSAGE = 'The server refused this request (HTTP 403). Reload the page and try again. If it keeps happening, the site address may be misconfigured: please contact the site operator.';
