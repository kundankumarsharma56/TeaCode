import '@testing-library/jest-dom/vitest';
import { afterEach, vi } from 'vitest';
import { cleanup, configure } from '@testing-library/react';

afterEach(() => cleanup());

// findBy*/waitFor wait up to 5 s instead of the 1 s default. The first render of each lazily loaded route
// transforms its module graph, which can exceed 1 s when many test files run in parallel on a busy machine.
configure({ asyncUtilTimeout: 5000 });
// jsdom lacks these browser APIs.
window.matchMedia = window.matchMedia || ((query) => ({
  // Simulate a desktop viewport: min-width breakpoints match; other features do not.
  matches: /min-width/.test(query), media: query, onchange: null,
  addListener: () => {}, removeListener: () => {},
  addEventListener: () => {}, removeEventListener: () => {}, dispatchEvent: () => false,
}));
window.HTMLElement.prototype.scrollIntoView = vi.fn();
window.scrollTo = vi.fn();
class IO { observe() {} unobserve() {} disconnect() {} }
window.IntersectionObserver = window.IntersectionObserver || IO;

// First lazy-route renders and axe scans can exceed Vitest's 5 s default under parallel load.
import { vi as viTimeout } from 'vitest';
viTimeout.setConfig({ testTimeout: 20000 });
