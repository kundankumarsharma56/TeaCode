import { Box } from '@mui/material';
import CodeRoundedIcon from '@mui/icons-material/CodeRounded';
import cIcon from 'devicon/icons/c/c-original.svg';
import cppIcon from 'devicon/icons/cplusplus/cplusplus-original.svg';
import csharpIcon from 'devicon/icons/csharp/csharp-original.svg';
import dartIcon from 'devicon/icons/dart/dart-original.svg';
import goIcon from 'devicon/icons/go/go-original.svg';
import javaIcon from 'devicon/icons/java/java-original.svg';
import javascriptIcon from 'devicon/icons/javascript/javascript-original.svg';
import kotlinIcon from 'devicon/icons/kotlin/kotlin-original.svg';
import phpIcon from 'devicon/icons/php/php-original.svg';
import pythonIcon from 'devicon/icons/python/python-original.svg';
import rIcon from 'devicon/icons/r/r-original.svg';
import rubyIcon from 'devicon/icons/ruby/ruby-original.svg';
import rustIcon from 'devicon/icons/rust/rust-original.svg';
import swiftIcon from 'devicon/icons/swift/swift-original.svg';
import typescriptIcon from 'devicon/icons/typescript/typescript-original.svg';
import mysqlIcon from 'devicon/icons/mysql/mysql-original.svg';

// Official language logos from the open-source Devicon set (MIT licence; the logos are trademarks of their owners and
// are used here only to identify each language). Keys are the backend language keys. "sql" is MySQL on this platform.
const ICONS = {
  c: cIcon, cpp: cppIcon, csharp: csharpIcon, dart: dartIcon, go: goIcon, java: javaIcon, javascript: javascriptIcon,
  kotlin: kotlinIcon, php: phpIcon, python: pythonIcon, r: rIcon, ruby: rubyIcon, rust: rustIcon, swift: swiftIcon,
  typescript: typescriptIcon, sql: mysqlIcon,
};

export const ICON_KEYS = Object.keys(ICONS);

/**
 * A language logo on a small white tile, so dark logos stay readable on the dark theme. Decorative only: the language
 * name is always shown next to it, so it is hidden from assistive technology. Unknown languages get a neutral icon.
 */
export default function LanguageIcon({ language, size = 22 }) {
  const src = ICONS[language];
  const tile = size + 10;
  return (
    <Box
      component="span"
      aria-hidden="true"
      sx={{
        width: tile, height: tile, flexShrink: 0, display: 'inline-grid', placeItems: 'center', verticalAlign: 'middle',
        borderRadius: '7px', bgcolor: '#ffffff', border: '1px solid rgba(15, 23, 42, 0.14)', lineHeight: 0,
      }}
    >
      {src
        ? <Box component="img" src={src} alt="" width={size} height={size} draggable={false} decoding="async" sx={{ display: 'block', objectFit: 'contain' }} />
        : <CodeRoundedIcon sx={{ fontSize: size, color: '#334155' }} />}
    </Box>
  );
}