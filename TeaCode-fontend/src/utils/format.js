/** Date/number formatting shared by history pages. Instants are UTC on the wire and shown in the viewer's own timezone. */
export function formatDateTime(iso) {
  if (!iso) return '—';
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return '—';
  return new Intl.DateTimeFormat(undefined, { year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit', timeZoneName: 'short' }).format(d);
}

export function formatShortDate(iso) {
  if (!iso) return '—';
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return '—';
  return new Intl.DateTimeFormat(undefined, { year: 'numeric', month: 'short', day: 'numeric' }).format(d);
}

export function formatMemory(kb) {
  if (kb == null) return null;
  return kb >= 1024 ? { value: (kb / 1024).toFixed(2), unit: 'MB' } : { value: String(kb), unit: 'KB' };
}

/** Offset of the viewer's timezone from UTC in minutes (UTC+05:30 gives 330), the convention the API expects. */
export function utcOffsetMinutes(date = new Date()) {
  return -date.getTimezoneOffset();
}
