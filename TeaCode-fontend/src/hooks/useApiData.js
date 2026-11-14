import { useEffect, useState } from 'react';
import { api } from '../services/api.js';

/** GET helper returning { status: 'idle' | 'loading' | 'success' | 'error', data, error }. Pass skip=true to not fetch (status 'idle'). */
export function useApiData(path, params, skip = false) {
  const [state, setState] = useState({ status: 'loading', data: null, error: null });
  const paramsKey = JSON.stringify(params ?? {});

  useEffect(() => {
    if (skip) {
      setState({ status: 'idle', data: null, error: null });
      return undefined;
    }
    let active = true;
    setState({ status: 'loading', data: null, error: null });
    api
      .get(path, { params: JSON.parse(paramsKey) })
      .then((res) => active && setState({ status: 'success', data: res.data, error: null }))
      .catch((error) => active && setState({ status: 'error', data: null, error }));
    return () => {
      active = false;
    };
  }, [path, paramsKey, skip]);

  return state;
}
