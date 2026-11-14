import { motion, useReducedMotion } from 'framer-motion';
import { useLocation } from 'react-router-dom';

/** Short fade/slide on every route change; disabled under prefers-reduced-motion. */
export default function PageTransition({ children }) {
  const reduce = useReducedMotion();
  const { pathname } = useLocation();
  if (reduce) return children;
  // Keyed by path so the animation replays on navigation (without a key it ran only on first load).
  return (
    <motion.div key={pathname} initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.2, ease: 'easeOut' }}>
      {children}
    </motion.div>
  );
}
