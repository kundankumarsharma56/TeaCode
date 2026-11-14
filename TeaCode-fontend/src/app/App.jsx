import { lazy, Suspense } from 'react';
import { Box } from '@mui/material';
import BrandLoader from '../components/BrandLoader.jsx';
import { Route, Routes, useLocation } from 'react-router-dom';
import Navbar from '../components/Navbar.jsx';
import Footer from '../components/Footer.jsx';
import PageTransition from '../components/PageTransition.jsx';
import RouteEffects from '../components/RouteEffects.jsx';
import RequireAuth from '../components/RequireAuth.jsx';
import LandingPage from '../pages/LandingPage.jsx';
import AboutPage from '../pages/AboutPage.jsx';
import NotFoundPage from '../pages/NotFoundPage.jsx';
import LoginPage from '../features/auth/LoginPage.jsx';
import VerifyEmailPage from '../features/auth/VerifyEmailPage.jsx';
import { ForgotPasswordPage, ResetPasswordPage } from '../features/auth/PasswordPages.jsx';
// The workspace pulls in Monaco, so it is loaded on demand.
const WorkspacePage = lazy(() => import('../features/workspace/WorkspacePage.jsx'));
const TerminalPage = lazy(() => import('../features/terminal/TerminalPage.jsx'));
import ProblemsPage from '../features/problems/ProblemsPage.jsx';
// Account and legal pages are loaded on demand to keep the first load small.
const DashboardPage = lazy(() => import('../features/dashboard/DashboardPage.jsx'));
const PracticeHistoryPage = lazy(() => import('../features/history/PracticeHistoryPage.jsx'));
const SubmissionDetailPage = lazy(() => import('../features/history/SubmissionDetailPage.jsx'));
const ProfilePage = lazy(() => import('../features/account/ProfilePage.jsx'));
const SettingsPage = lazy(() => import('../features/account/SettingsPage.jsx'));
const TermsPage = lazy(() => import('../features/legal/TermsPage.jsx'));
const PrivacyPage = lazy(() => import('../features/legal/PrivacyPage.jsx'));
const CookiesPage = lazy(() => import('../features/legal/CookiesPage.jsx'));
const AcceptableUsePage = lazy(() => import('../features/legal/AcceptableUsePage.jsx'));
const PrivacyRequestsPage = lazy(() => import('../features/legal/PrivacyRequestsPage.jsx'));
const ContactPage = lazy(() => import('../features/legal/ContactPage.jsx'));
const PageFallback = <BrandLoader />;

const SKIP_LINK_SX = {
  position: 'absolute', left: 8, top: -64, zIndex: (t) => t.zIndex.tooltip + 1, px: 2, py: 1, borderRadius: 1,
  bgcolor: 'primary.main', color: 'primary.contrastText', fontWeight: 700, textDecoration: 'none',
  '&:focus': { top: 8 },
};

export default function App() {
  const { pathname } = useLocation();
  const hideFooter = ['/terminal', '/login', '/register'].includes(pathname);
  const hideNavbar = ['/login', '/register'].includes(pathname);
  return (
    <Box sx={{ minHeight: '100vh', '@supports (min-height: 100dvh)': { minHeight: '100dvh' }, display: 'flex', flexDirection: 'column', overflowX: hideNavbar ? 'hidden' : 'visible' }}>
      <RouteEffects />
      <Box component="a" href="#main" sx={SKIP_LINK_SX}>Skip to main content</Box>
      {!hideNavbar && <Navbar />}
      <Box component="main" id="main" tabIndex={-1} sx={{ flex: 1, minWidth: 0, outline: 'none' }}>
        <PageTransition>
          <Suspense fallback={PageFallback}>
            <Routes>
            <Route path="/" element={<LandingPage />} />
            <Route path="/about" element={<AboutPage />} />
            <Route path="/problems" element={<ProblemsPage />} />
            <Route path="/problems/:slug" element={<WorkspacePage />} />
            {import.meta.env.VITE_TERMINAL_ENABLED !== 'false' && <Route path="/terminal" element={<TerminalPage />} />}
            <Route path="/login" element={<LoginPage />} />
            <Route path="/register" element={<LoginPage />} />
            {/* Password reset flow is handled separately; legacy paths remain safe redirects. */}
            <Route path="/forgot-password" element={<ForgotPasswordPage />} />
            <Route path="/reset-password" element={<ResetPasswordPage />} />
            <Route path="/verify-email" element={<VerifyEmailPage />} />
            <Route path="/contact" element={<ContactPage />} />
            <Route path="/terms" element={<TermsPage />} />
            <Route path="/privacy" element={<PrivacyPage />} />
            <Route path="/cookies" element={<CookiesPage />} />
            <Route path="/acceptable-use" element={<AcceptableUsePage />} />
            <Route path="/privacy-requests" element={<PrivacyRequestsPage />} />
            <Route path="/dashboard" element={<RequireAuth><DashboardPage /></RequireAuth>} />
            <Route path="/submissions" element={<RequireAuth><PracticeHistoryPage /></RequireAuth>} />
            <Route path="/submissions/:id" element={<RequireAuth><SubmissionDetailPage /></RequireAuth>} />
            <Route path="/profile" element={<RequireAuth><ProfilePage /></RequireAuth>} />
            <Route path="/settings" element={<RequireAuth><SettingsPage /></RequireAuth>} />
            <Route path="*" element={<NotFoundPage />} />
          </Routes>
          </Suspense>
        </PageTransition>
      </Box>
      {!hideFooter && <Footer />}
    </Box>
  );
}
