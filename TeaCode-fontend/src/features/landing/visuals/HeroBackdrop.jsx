import { Box, GlobalStyles } from '@mui/material';
import { useReducedMotion } from 'framer-motion';

// Decorative hero background: a faint dot grid, two slow terracotta glows, and code symbols that drift upward like steam.
// Only transform and opacity are animated (CSS, no per-frame JavaScript). With "reduce motion" the glows stay still
// and the symbols are not drawn.

const KEYFRAMES = {
  '@keyframes tcGlowA': {
    from: { transform: 'translate3d(0, 0, 0) scale(1)' },
    to: { transform: 'translate3d(7vw, 5vh, 0) scale(1.18)' },
  },
  '@keyframes tcGlowB': {
    from: { transform: 'translate3d(0, 0, 0) scale(1.12)' },
    to: { transform: 'translate3d(-6vw, -4vh, 0) scale(0.94)' },
  },
  '@keyframes tcRise': {
    '0%': { transform: 'translate3d(0, 0, 0) rotate(0deg)', opacity: 0 },
    '15%': { opacity: 0.3 },
    '75%': { opacity: 0.18 },
    '100%': { transform: 'translate3d(var(--tc-sway), -280px, 0) rotate(var(--tc-rot))', opacity: 0 },
  },
};

const GLYPHS = [
  { g: '{ }', left: '6%', top: '64%', size: 28, dur: 18, delay: 0, sway: '16px', rot: '6deg', mobile: true },
  { g: '</>', left: '14%', top: '40%', size: 24, dur: 22, delay: 4, sway: '-14px', rot: '-5deg', mobile: true },
  { g: '=>', left: '10%', top: '82%', size: 22, dur: 20, delay: 9, sway: '12px', rot: '4deg', mobile: false },
  { g: ';', left: '23%', top: '72%', size: 26, dur: 16, delay: 2, sway: '-10px', rot: '-4deg', mobile: false },
  { g: '[ ]', left: '89%', top: '60%', size: 26, dur: 19, delay: 1, sway: '-16px', rot: '-6deg', mobile: true },
  { g: '( )', left: '94%', top: '36%', size: 24, dur: 23, delay: 6, sway: '14px', rot: '5deg', mobile: true },
  { g: '//', left: '81%', top: '78%', size: 22, dur: 17, delay: 10, sway: '-12px', rot: '-3deg', mobile: false },
  { g: '&&', left: '74%', top: '26%', size: 22, dur: 21, delay: 7, sway: '10px', rot: '4deg', mobile: false },
  { g: '#', left: '28%', top: '24%', size: 24, dur: 24, delay: 12, sway: '-12px', rot: '-5deg', mobile: false },
  { g: '0x', left: '67%', top: '68%', size: 20, dur: 20, delay: 5, sway: '12px', rot: '3deg', mobile: false },
];

const FILL = { position: 'absolute', top: 0, right: 0, bottom: 0, left: 0 };
const MONO = 'ui-monospace, SFMono-Regular, Menlo, Consolas, monospace';
const GRID_MASK = 'radial-gradient(ellipse 78% 64% at 50% 26%, #000 22%, transparent 80%)';

export default function HeroBackdrop() {
  const reduce = useReducedMotion();
  const drift = (name, seconds) => (reduce ? {} : {
    animationName: name,
    animationDuration: `${seconds}s`,
    animationIterationCount: 'infinite',
    animationDirection: 'alternate',
    animationTimingFunction: 'ease-in-out',
  });
  const glow = { position: 'absolute', width: { xs: 340, md: 640 }, height: { xs: 340, md: 640 }, borderRadius: '50%' };

  return (
    <Box aria-hidden="true" sx={{ ...FILL, overflow: 'hidden', pointerEvents: 'none', userSelect: 'none', zIndex: 0 }}>
      <GlobalStyles styles={KEYFRAMES} />
      <Box
        sx={{
          ...FILL,
          backgroundImage: (t) => `radial-gradient(${t.palette.mode === 'dark' ? 'rgba(255,255,255,.08)' : 'rgba(0,0,0,.08)'} 1px, transparent 1.6px)`,
          backgroundSize: '30px 30px',
          maskImage: GRID_MASK,
          WebkitMaskImage: GRID_MASK,
        }}
      />
      <Box sx={{ ...glow, top: '-14%', left: '-10%', background: 'radial-gradient(circle, rgba(224,123,84,.20) 0%, rgba(224,123,84,0) 68%)', ...drift('tcGlowA', 26) }} />
      <Box sx={{ ...glow, top: '6%', right: '-12%', background: 'radial-gradient(circle, rgba(224,123,84,.14) 0%, rgba(224,123,84,0) 68%)', ...drift('tcGlowB', 32) }} />
      {!reduce && GLYPHS.map((s) => (
        <Box
          key={s.g}
          sx={{
            position: 'absolute',
            left: s.left,
            top: s.top,
            opacity: 0,
            color: 'primary.main',
            fontFamily: MONO,
            fontSize: s.size,
            fontWeight: 600,
            lineHeight: 1,
            display: { xs: s.mobile ? 'block' : 'none', md: 'block' },
            '--tc-sway': s.sway,
            '--tc-rot': s.rot,
            animationName: 'tcRise',
            animationDuration: `${s.dur}s`,
            animationDelay: `${s.delay}s`,
            animationIterationCount: 'infinite',
            animationTimingFunction: 'linear',
            animationFillMode: 'backwards',
          }}
        >
          {s.g}
        </Box>
      ))}
    </Box>
  );
}