import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';

const SITE = 'TeaCode';

// Most specific first. A page title is what browser tabs, history and screen readers announce on navigation.
const TITLES = [
  [/^\/$/, `${SITE} - Code. Learn. Build.`],
  [/^\/about\/?$/, `About - ${SITE}`],
  [/^\/problems\/?$/, `Problems - ${SITE}`],
  [/^\/problems\/.+/, `Problem - ${SITE}`],
  [/^\/terminal\/?$/, `Terminal - ${SITE}`],
  [/^\/login\/?$/, `Log in - ${SITE}`],
  [/^\/register\/?$/, `Sign up - ${SITE}`],
  [/^\/forgot-password\/?$/, `Forgot password - ${SITE}`],
  [/^\/reset-password\/?$/, `Reset password - ${SITE}`],
  [/^\/verify-email\/?$/, `Verify email - ${SITE}`],
  [/^\/contact\/?$/, `Contact - ${SITE}`],
  [/^\/terms\/?$/, `Terms and Conditions - ${SITE}`],
  [/^\/privacy\/?$/, `Privacy Policy - ${SITE}`],
  [/^\/cookies\/?$/, `Cookie Policy - ${SITE}`],
  [/^\/acceptable-use\/?$/, `Acceptable Use Policy - ${SITE}`],
  [/^\/privacy-requests\/?$/, `Account deletion and privacy requests - ${SITE}`],
  [/^\/dashboard\/?$/, `Dashboard - ${SITE}`],
  [/^\/submissions\/?$/, `Practice History - ${SITE}`],
  [/^\/submissions\/\d+\/?$/, `Submission - ${SITE}`],
  [/^\/profile\/?$/, `Profile - ${SITE}`],
  [/^\/settings\/?$/, `Settings - ${SITE}`],
];

export function titleFor(pathname) {
  const hit = TITLES.find(([re]) => re.test(pathname));
  return hit ? hit[1] : `Page not found - ${SITE}`;
}

/**
 * Per-navigation housekeeping a single-page app must do itself:
 * - reset the scroll position (otherwise a footer link opens the next page already scrolled to the bottom),
 *   except for in-page anchors (/#faq), which the landing page scrolls to itself;
 * - give every route its own document title.
 */
export default function RouteEffects() {
  const { pathname, hash } = useLocation();

  useEffect(() => {
    document.title = titleFor(pathname);
  }, [pathname]);

  useEffect(() => {
    if (hash) return;
    window.scrollTo?.(0, 0);
  }, [pathname, hash]);

  return null;
}
