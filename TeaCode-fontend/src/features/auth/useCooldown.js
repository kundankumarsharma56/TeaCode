import { useCallback, useEffect, useState } from 'react';

/** Counts down in seconds. start(60) begins a new countdown; left === 0 means the action is allowed again. */
export function useCooldown() {
  const [left, setLeft] = useState(0);
  useEffect(() => {
    if (left <= 0) return undefined;
    const id = setTimeout(() => setLeft((n) => n - 1), 1000);
    return () => clearTimeout(id);
  }, [left]);
  const start = useCallback((seconds = 60) => setLeft(seconds), []);
  return [left, start];
}
