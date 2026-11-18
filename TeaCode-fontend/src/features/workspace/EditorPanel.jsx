import { useState } from 'react';
import { Autocomplete, Box, IconButton, InputAdornment, Stack, TextField, Tooltip } from '@mui/material';
import Editor from '@monaco-editor/react';
import RestartAltIcon from '@mui/icons-material/RestartAlt';
import ContentCopyIcon from '@mui/icons-material/ContentCopy';
import { useColorMode } from '../../hooks/useColorMode.js';
import LanguageIcon from '../../components/LanguageIcon.jsx';
import { monacoLanguage } from './languages.js';
import './monacoSetup.js';

const FONT_SIZES = [12, 14, 16, 18, 20];

const FIELD_SX = { '& .MuiOutlinedInput-root': { borderRadius: '8px' } };
const ICON_BTN_SX = { color: 'text.secondary', borderRadius: 1.5, '&:hover': { color: 'text.primary', bgcolor: 'action.hover' }, '&.Mui-disabled': { opacity: 0.4 } };

/** Copies text with the async clipboard API; reports whether it worked (it can be blocked by the browser). */
export async function copyText(text) {
  try {
    await navigator.clipboard.writeText(text);
    return true;
  } catch {
    return false;
  }
}

/**
 * Editor with one compact toolbar row: language, font size, copy, reset, and an optional `actions` slot at the right end
 * (the Problems page puts Run and Submit there). With `fill` the editor takes the height of its parent.
 */
export default function EditorPanel({ languages, language, onLanguageChange, code, onCodeChange, fontSize, onFontSizeChange, onReset, resetLabel = 'Reset code', height = '420px', fill = false, actions = null }) {
  const { mode } = useColorMode();
  const [copied, setCopied] = useState('');
  const selected = languages.find((l) => l.key === language) ?? null;
  const idx = FONT_SIZES.indexOf(fontSize);
  const at = idx < 0 ? 1 : idx;

  const copy = async () => {
    setCopied((await copyText(code)) ? 'Copied' : 'Copy failed');
    setTimeout(() => setCopied(''), 2000);
  };

  return (
    <Stack spacing={0} sx={{ flex: '1 1 auto', minHeight: 0, minWidth: 0 }}>
      <Stack direction="row" spacing={0.5} useFlexGap sx={{ flexWrap: 'wrap', alignItems: 'center', px: 1.25, py: 0.75, borderBottom: 1, borderColor: 'divider', bgcolor: 'background.default' }}>
        {/* Searchable: type to filter the language list; keyboard and screen-reader friendly (combobox). */}
        <Autocomplete
          size="small"
          sx={{ ...FIELD_SX, width: { xs: '100%', sm: 200 }, mr: 0.5 }}
          options={languages}
          value={selected}
          disableClearable
          getOptionLabel={(l) => l.name}
          isOptionEqualToValue={(a, b) => a.key === b.key}
          onChange={(_, l) => onLanguageChange(l.key)}
          renderOption={(props, l) => {
            const { key, ...rest } = props;
            return <li key={key} {...rest}><LanguageIcon language={l.key} size={18} /><Box component="span" sx={{ ml: 1.25 }}>{l.name}</Box>{l.version ? <Box component="span" sx={{ ml: 1, color: 'text.secondary', fontSize: 12 }}>{l.version}</Box> : null}</li>;
          }}
          renderInput={(params) => <TextField {...params} label="Language" InputProps={{ ...params.InputProps, startAdornment: selected ? <InputAdornment position="start" sx={{ mr: 0.75 }}><LanguageIcon language={selected.key} size={16} /></InputAdornment> : null }} />}
        />
        <Tooltip title="Smaller text"><span><IconButton size="small" aria-label="Smaller editor text" disabled={at <= 0} onClick={() => onFontSizeChange(FONT_SIZES[Math.max(0, at - 1)])} sx={ICON_BTN_SX}><Box component="span" sx={{ fontSize: 12, fontWeight: 700, lineHeight: 1 }}>A-</Box></IconButton></span></Tooltip>
        <Tooltip title="Larger text"><span><IconButton size="small" aria-label="Larger editor text" disabled={at >= FONT_SIZES.length - 1} onClick={() => onFontSizeChange(FONT_SIZES[Math.min(FONT_SIZES.length - 1, at + 1)])} sx={ICON_BTN_SX}><Box component="span" sx={{ fontSize: 15, fontWeight: 700, lineHeight: 1 }}>A+</Box></IconButton></span></Tooltip>
        <Tooltip title={copied || 'Copy code'}><IconButton size="small" aria-label="Copy code" onClick={copy} sx={ICON_BTN_SX}><ContentCopyIcon sx={{ fontSize: 18 }} /></IconButton></Tooltip>
        <Tooltip title={resetLabel}><IconButton size="small" aria-label={resetLabel} onClick={onReset} sx={ICON_BTN_SX}><RestartAltIcon sx={{ fontSize: 19 }} /></IconButton></Tooltip>
        <Box role="status" aria-live="polite" sx={{ position: 'absolute', width: 1, height: 1, overflow: 'hidden', clip: 'rect(0 0 0 0)' }}>{copied}</Box>
        {actions}
      </Stack>
      <Box sx={{ flex: '1 1 auto', minHeight: 0, bgcolor: 'background.paper', overflow: 'hidden' }}>
        <Editor
          height={fill ? '100%' : height}
          path={`solution.${language}`}
          language={monacoLanguage(language)}
          value={code}
          theme={mode === 'dark' ? 'vs-dark' : 'light'}
          onChange={(v) => onCodeChange(v ?? '')}
          options={{ fontSize, automaticLayout: true, minimap: { enabled: false }, scrollBeyondLastLine: false, tabSize: 4, ariaLabel: 'Code editor', padding: { top: 12, bottom: 12 } }}
          loading="Loading editor..."
        />
      </Box>
    </Stack>
  );
}