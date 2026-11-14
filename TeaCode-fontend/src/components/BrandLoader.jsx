import { Box } from '@mui/material';
import { keyframes } from '@mui/material/styles';
import { LOGO_SRC, LOGO_WIDTH, LOGO_HEIGHT, LOGO_WIDTHS } from './TeaCodeLogo.jsx';

// Loading indicator built from the TeaCode logo. A dim copy of the logo sits underneath and a full-colour copy is
// revealed by a soft band of light that travels across it, while the whole logo breathes slightly. The same animation
// is repeated in index.html so the first paint before JavaScript loads looks identical.
const sweep = keyframes`
  from { mask-position: 100% 0; -webkit-mask-position: 100% 0; }
  to   { mask-position: 0% 0;   -webkit-mask-position: 0% 0; }
`;
const breathe = keyframes`
  0%, 100% { transform: scale(1); }
  50%      { transform: scale(1.03); }
`;
const fade = keyframes`
  0%, 100% { opacity: .55; }
  50%      { opacity: 1; }
`;

const BAND = 'linear-gradient(105deg, transparent 30%, #000 50%, transparent 70%)';

/**
 * @param width  rendered width of the logo in px (height follows the artwork's aspect ratio)
 * @param label  accessible name announced to screen readers
 * @param inline when true, no vertical padding (for use inside a panel or button area)
 */
export default function BrandLoader({ width = LOGO_WIDTHS.loader, label = 'Loading', inline = false, sx }) {
  const img = { display: 'block', width: '100%', height: 'auto', userSelect: 'none' };
  return (
    <Box
      role="status"
      aria-live="polite"
      aria-label={label}
      sx={[{ display: 'grid', placeItems: 'center', py: inline ? 2 : 12 }, ...(Array.isArray(sx) ? sx : [sx])]}
    >
      <Box
        aria-hidden="true"
        sx={{
          position: 'relative',
          width,
          maxWidth: '70vw',
          animation: `${breathe} 1.8s ease-in-out infinite`,
          '@media (prefers-reduced-motion: reduce)': { animation: `${fade} 2.4s ease-in-out infinite` },
        }}
      >
        <Box component="img" src={LOGO_SRC} alt="" width={LOGO_WIDTH} height={LOGO_HEIGHT} draggable={false} sx={{ ...img, opacity: 0.25 }} />
        <Box
          component="img"
          src={LOGO_SRC}
          alt=""
          width={LOGO_WIDTH}
          height={LOGO_HEIGHT}
          draggable={false}
          sx={{
            ...img,
            position: 'absolute',
            top: 0,
            left: 0,
            maskImage: BAND,
            WebkitMaskImage: BAND,
            maskSize: '300% 100%',
            WebkitMaskSize: '300% 100%',
            maskRepeat: 'no-repeat',
            WebkitMaskRepeat: 'no-repeat',
            animation: `${sweep} 1.5s linear infinite`,
            // Reduced motion: no travelling band, just the gentle fade on the wrapper.
            '@media (prefers-reduced-motion: reduce)': { animation: 'none', maskImage: 'none', WebkitMaskImage: 'none' },
          }}
        />
      </Box>
    </Box>
  );
}