import { useCallback, useEffect, useRef } from 'react';
import { Box } from '@mui/material';

// Hero background video: muted, looping, decorative, like a live GIF. It always plays (also with "reduce motion").
// If the browser blocks autoplay, the first click, tap, key press or scroll starts it.

const VIDEO = '/HeroSectionBG.mp4';
const POSTER = '/HeroSectionBG-poster.jpg';
const FILL = { position: 'absolute', top: 0, right: 0, bottom: 0, left: 0 };
const OVERLAY = 'linear-gradient(180deg, rgba(11,11,12,.35) 0%, rgba(11,11,12,.45) 55%, #0B0B0C 100%)';

export default function HeroVideoBackdrop() {
  const ref = useRef(null);

  const tryPlay = useCallback(() => {
    const v = ref.current;
    if (!v) return;
    const p = v.play();
    if (p && typeof p.catch === 'function') p.catch(() => { /* autoplay blocked; retried on interaction */ });
  }, []);

  useEffect(() => {
    tryPlay();
    const events = ['pointerdown', 'keydown', 'scroll', 'touchstart'];
    const once = () => { tryPlay(); events.forEach((e) => window.removeEventListener(e, once)); };
    events.forEach((e) => window.addEventListener(e, once, { passive: true }));
    return () => events.forEach((e) => window.removeEventListener(e, once));
  }, [tryPlay]);

  return (
    <Box aria-hidden="true" sx={{ ...FILL, overflow: 'hidden', pointerEvents: 'none', userSelect: 'none', zIndex: 0 }}>
      <Box
        component="video"
        ref={ref}
        src={VIDEO}
        poster={POSTER}
        autoPlay
        muted
        loop
        playsInline
        preload="auto"
        tabIndex={-1}
        disablePictureInPicture
        sx={{ ...FILL, width: '100%', height: '100%', objectFit: 'cover' }}
      />
      <Box sx={{ ...FILL, background: OVERLAY }} />
    </Box>
  );
}