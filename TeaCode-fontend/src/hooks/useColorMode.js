import { useContext } from 'react';
import { ColorModeContext } from '../context/ColorModeContext.jsx';

export function useColorMode() {
  const ctx = useContext(ColorModeContext);
  if (!ctx) throw new Error('useColorMode must be used inside ColorModeProvider');
  return ctx;
}
