import { useState } from 'react';
import { Autocomplete, Box, Button, FormControl, InputAdornment, InputLabel, MenuItem, Select, Stack, TextField } from '@mui/material';
import Editor from '@monaco-editor/react';
import RestartAltIcon from '@mui/icons-material/RestartAlt';
import ContentCopyIcon from '@mui/icons-material/ContentCopy';
import { useColorMode } from '../../hooks/useColorMode.js';
import LanguageIcon from '../../components/LanguageIcon.jsx';
import { monacoLanguage } from './languages.js';
import './monacoSetup.js';

const FONT_SIZES = [12, 14, 16, 18, 20];

// TeaCode quiet toolbar button and rounded field outline.
const TOOL_BTN_SX = { color: 'inherit', borderColor: 'divider', borderRadius: 1.5, minHeight: 36, fontWeight: 600, '&:hover': { borderColor: 'text.secondary', bgcolor: 'action.hover' } };
const FIELD_SX = { '& .MuiOutlinedInput-root': { borderRadius: '10px' } };

/** Copies text with the async clipboard API; reports whether it worked (it can be blocked by the browser). */
export async function copyText(text) {
  try {
    await navigator.clipboard.writeText(text);
    return true;
  } catch {
    return false;
  }
}

export default function EditorPanel({ languages, language, onLanguageChange, code, onCodeChange, fontSize, onFontSizeChange, onReset, resetLabel = 'Reset code', height = '420px' }) {
  const { mode } = useColorMode();
  const [copied, setCopied] = useState('');
  const selected = languages.find((l) => l.key === language) ?? null;

  const copy = async () => {
    setCopied((await copyText(code)) ? 'Copied' : 'Copy failed');
    setTimeout(() => setCopied(''), 2000);
  };

  return (
    <Stack spacing={1.5}>
      <Stack direction="row" spacing={1.5} useFlexGap sx={{ flexWrap: 'wrap', alignItems: 'center' }}>
        {/* Searchable: type to filter the language list; keyboard and screen-reader friendly (combobox). */}
        <Autocomplete
          size="small"
          sx={{ ...FIELD_SX, minWidth: 200, flex: { xs: '1 1 100%', sm: '0 1 240px' } }}
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
        <FormControl size="small" sx={{ ...FIELD_SX, minWidth: 110 }}>
          <InputLabel id="font-select-label">Font size</InputLabel>
          <Select labelId="font-select-label" label="Font size" value={fontSize} onChange={(e) => onFontSizeChange(e.target.value)}>
            {FONT_SIZES.map((s) => <MenuItem key={s} value={s}>{s}px</MenuItem>)}
          </Select>
        </FormControl>
        <Button startIcon={<ContentCopyIcon />} onClick={copy} variant="outlined" size="small" sx={TOOL_BTN_SX}>Copy code</Button>
        <Button startIcon={<RestartAltIcon />} onClick={onReset} variant="outlined" size="small" sx={TOOL_BTN_SX}>{resetLabel}</Button>
        <Box role="status" aria-live="polite" sx={{ fontSize: 13, color: 'text.secondary', minWidth: 70 }}>{copied}</Box>
      </Stack>
      <Box sx={{ border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper', overflow: 'hidden' }}>
        <Editor
          height={height}
          path={`solution.${language}`}
          language={monacoLanguage(language)}
          value={code}
          theme={mode === 'dark' ? 'vs-dark' : 'light'}
          onChange={(v) => onCodeChange(v ?? '')}
          options={{ fontSize, automaticLayout: true, minimap: { enabled: false }, scrollBeyondLastLine: false, tabSize: 4, ariaLabel: 'Code editor' }}
          loading="Loading editor…"
        />
      </Box>
    </Stack>
  );
}
