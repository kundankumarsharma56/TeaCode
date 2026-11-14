import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import TerminalPreview from '../features/landing/visuals/TerminalPreview.jsx';

describe('hero terminal preview', () => {
  it('is one labelled illustration made from markup, not an image file', () => {
    const { container } = render(<TerminalPreview />);
    expect(screen.getByRole('img', { name: /Illustration of the TeaCode online terminal/ })).toBeInTheDocument();
    expect(container.querySelector('img')).toBeNull();
  });

  it('shows the Java solution, the input 8 and its real output 13', () => {
    const { container } = render(<TerminalPreview />);
    const text = container.textContent;
    expect(text).toContain('Main.java');
    expect(text).toContain('public static void main');
    expect(text).toContain('javac Main.java && java Main');
    expect(text).toContain('Process finished with exit code 0');
    const output = [...container.querySelectorAll('div')].map((d) => d.textContent.trim());
    expect(output).toContain('8');
    expect(output).toContain('13');
  });

  it('shows the problem in a proper format: title, difficulty, topics, sections, constraints and both examples', () => {
    const { container } = render(<TerminalPreview />);
    const text = container.textContent;
    expect(text).toContain('Total Set Bits From 1 to N');
    for (const part of ['Hard', 'Bit Manipulation', 'Math', 'Input', 'Output', 'Constraints', 'Example 1', 'Example 2', 'Expected complexity']) {
      expect(text).toContain(part);
    }
    expect(text).toContain('1 <= N <= 1000000000000');
    expect(text).toContain('Input: 3');
    expect(text).toContain('Output: 4');
    expect(text).toContain('Input: 8');
    expect(text).toContain('Output: 13');
  });
});