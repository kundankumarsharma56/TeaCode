import { useContext } from 'react';
import { NotifyContext } from '../context/NotifyContext.jsx';

export function useNotify() {
  const notify = useContext(NotifyContext);
  if (!notify) throw new Error('useNotify must be used inside NotifyProvider');
  return notify;
}
