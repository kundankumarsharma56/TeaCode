import { afterEach, describe, expect, it, vi } from 'vitest';
import { clearDraft, loadDraft, saveDraft } from '../features/workspace/drafts.js';

afterEach(() => { window.localStorage.clear(); vi.restoreAllMocks(); });

describe('code drafts', () => {
  it('round-trips per user, problem and language', () => {
    saveDraft(1, 'two-sum', 'python', 'print(1)');
    saveDraft(1, 'two-sum', 'java', 'class A {}');
    expect(loadDraft(1, 'two-sum', 'python')).toBe('print(1)');
    expect(loadDraft(1, 'two-sum', 'java')).toBe('class A {}');
    expect(loadDraft(2, 'two-sum', 'python')).toBeNull();
    expect(loadDraft(1, 'other', 'python')).toBeNull();
  });
  it('clears a draft', () => {
    saveDraft(null, 's', 'c', 'x');
    clearDraft(null, 's', 'c');
    expect(loadDraft(null, 's', 'c')).toBeNull();
  });
  it('never throws when storage is blocked', () => {
    vi.spyOn(Storage.prototype, 'getItem').mockImplementation(() => { throw new Error('blocked'); });
    vi.spyOn(Storage.prototype, 'setItem').mockImplementation(() => { throw new Error('full'); });
    expect(loadDraft(1, 's', 'c')).toBeNull();
    expect(() => saveDraft(1, 's', 'c', 'x')).not.toThrow();
  });
});
