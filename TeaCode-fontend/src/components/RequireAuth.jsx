import { Navigate, useLocation } from 'react-router-dom';
import BrandLoader from './BrandLoader.jsx';
import { useAuth } from '../hooks/useAuth.js';

/** UI convenience only. The backend enforces authorization on every protected endpoint. */
export default function RequireAuth({ children }) {
  const { user, status } = useAuth();
  const location = useLocation();
  if (status === 'loading') {
    return <BrandLoader />;
  }
  if (!user) return <Navigate to="/login" replace state={{ from: location }} />;
  return children;
}
