// Per-user, per-problem, per-language code drafts kept in localStorage so a refresh does not lose work.
// Storage can be missing, full or blocked (private windows); every access is guarded and the page works without it.
const key = (userId, slug, language) => `teacode.draft.v1:${userId ?? 'anon'}:${slug}:${language}`;

export function loadDraft(userId, slug, language) {
  if (!slug || !language) return null;
  try {
    const v = window.localStorage.getItem(key(userId, slug, language));
    return typeof v === 'string' ? v : null;
  } catch {
    return null;
  }
}

export function saveDraft(userId, slug, language, code) {
  if (!slug || !language) return;
  try {
    window.localStorage.setItem(key(userId, slug, language), code);
  } catch {
    /* quota exceeded or storage blocked: the in-memory copy still works */
  }
}

export function clearDraft(userId, slug, language) {
  try {
    window.localStorage.removeItem(key(userId, slug, language));
  } catch {
    /* ignore */
  }
}
