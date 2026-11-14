/**
 * Below the `sm` breakpoint a data table becomes a stack of cards: the header row is visually hidden
 * (kept for assistive tech) and each cell shows its column name from its `data-label` attribute.
 * From `sm` up it is an ordinary table.
 */
export const stackedTableSx = {
  '& td, & th': { overflowWrap: 'break-word' },
  '& tbody td:first-of-type': { minWidth: 180, overflowWrap: 'anywhere' },
  '@media (max-width:599.95px)': {
    '&, & tbody, & tr, & td': { display: 'block', width: '100%' },
    position: 'relative',
    '& thead': { display: 'block', position: 'absolute', width: 1, height: 1, overflow: 'hidden', clip: 'rect(0 0 0 0)', whiteSpace: 'nowrap' },
    '& thead tr': { width: 'auto' },
    '& tbody tr': { px: 2, py: 1.5, borderBottom: '1px solid', borderColor: 'divider', '&:last-child': { borderBottom: 0 } },
    '& tbody td': {
      display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 2, border: 0, px: 0, py: 0.5, textAlign: 'right',
      '&::before': { content: 'attr(data-label)', flexShrink: 0, color: 'text.secondary', fontSize: '0.75rem', fontWeight: 700, letterSpacing: '0.04em', textTransform: 'uppercase', textAlign: 'left' },
      '&:not([data-label])::before': { content: 'none' },
      '&:not([data-label])': { minWidth: 0, justifyContent: 'flex-start', textAlign: 'left', fontSize: '1rem' },
      '&[data-empty="true"]': { display: 'none' },
    },
  },
};
