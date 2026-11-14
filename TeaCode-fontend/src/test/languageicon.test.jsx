import { describe, it, expect } from 'vitest';
import { render } from '@testing-library/react';
import LanguageIcon, { ICON_KEYS } from '../components/LanguageIcon.jsx';

describe('LanguageIcon', () => {
  it('has a logo file for each of the 16 languages the platform offers', () => {
    expect([...ICON_KEYS].sort()).toEqual(['c', 'cpp', 'csharp', 'dart', 'go', 'java', 'javascript', 'kotlin', 'php', 'python', 'r', 'ruby', 'rust', 'sql', 'swift', 'typescript']);
    for (const key of ICON_KEYS) {
      const { container, unmount } = render(<LanguageIcon language={key} />);
      const img = container.querySelector('img');
      expect(img, key).not.toBeNull();
      expect(img.getAttribute('src'), key).toBeTruthy();
      expect(img).toHaveAttribute('alt', '');
      unmount();
    }
  });

  it('is decorative and falls back to a neutral icon for an unknown language', () => {
    const { container } = render(<LanguageIcon language="cobol" />);
    expect(container.querySelector('img')).toBeNull();
    expect(container.firstChild).toHaveAttribute('aria-hidden', 'true');
  });
});