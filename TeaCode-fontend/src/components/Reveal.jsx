import { motion, useReducedMotion } from 'framer-motion';

/** Scroll-triggered entrance. `delay` enables staggering; skipped for reduced motion. */
export default function Reveal({ children, delay = 0, ...rest }) {
  const reduce = useReducedMotion();
  if (reduce) return <div {...rest}>{children}</div>;
  return (
    <motion.div
      initial={{ opacity: 0, y: 16 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: '-60px' }}
      transition={{ duration: 0.35, delay, ease: 'easeOut' }}
      {...rest}
    >
      {children}
    </motion.div>
  );
}
