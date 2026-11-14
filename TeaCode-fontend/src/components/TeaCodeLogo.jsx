import { styled } from '@mui/material/styles';

// The supplied TeaCode logo, shown unmodified. Its intrinsic size is declared as real width/height attributes
// so the logo never shifts layout while loading.
export const LOGO_SRC = '/brand/teacode-logo.png';
export const LOGO_WIDTH = 2172;
export const LOGO_HEIGHT = 724;

// Rendered width (px) per place. Height is always auto, so the artwork keeps its aspect ratio.
export const LOGO_WIDTHS = { navbar: { xs: 120, md: 145 }, landing: 260, auth: 220, footer: 130, loader: 240 };

// A styled <img> (not Box) so width/height stay HTML attributes instead of being turned into CSS.
const LogoImg = styled('img')({});

/** The one TeaCode logo. `variant` picks the specified width for that place; `width` overrides it. */
export default function TeaCodeLogo({ variant = 'navbar', width, decorative = false, sx, ...props }) {
  return (
    <LogoImg
      src={LOGO_SRC}
      alt={decorative ? '' : 'TeaCode'}
      width={LOGO_WIDTH}
      height={LOGO_HEIGHT}
      draggable={false}
      sx={[
        { display: 'block', width: width ?? LOGO_WIDTHS[variant], height: 'auto', maxWidth: '100%', objectFit: 'contain', userSelect: 'none' },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...props}
    />
  );
}