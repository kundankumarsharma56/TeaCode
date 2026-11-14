import { Accordion, AccordionDetails, AccordionSummary, Box, Container, Typography } from '@mui/material';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import SectionHeading from './SectionHeading.jsx';

const ITEMS = [
  { q: 'How does TeaCode work?', a: 'Pick a problem, write a solution in the editor, run it against sample cases, then submit it to be judged on the full set of test cases.' },
  { q: 'How does code execution work?', a: 'Your code is sent from our server to the JDoodle Compiler API, which compiles and runs it remotely. Your code never runs in your browser or inside our application server.' },
  { q: 'Which languages are supported?', a: 'The languages in the language list on this page. It shows only languages that are verified on the configured execution service.' },
  { q: 'How are submissions evaluated?', a: 'A submission runs against every test case, including hidden ones. Output is compared using the rules defined for each problem, and the verdict reflects the actual execution result.' },
  { q: 'How do accounts and privacy work?', a: 'You need an account to run and submit code. We store your account details and submissions to provide the service. See the Privacy Policy and Cookie Policy for details.' },
];

export default function Faq() {
  return (
    <Box id="faq" component="section" aria-labelledby="faq-title" sx={{ py: { xs: 8, md: 12 } }}>
      <Container maxWidth="lg">
        <SectionHeading id="faq-title" title="Frequently asked questions" lead="What learners ask" highlight="before they start." />
        <Box sx={{ border: 1, borderColor: 'divider', borderRadius: 3, bgcolor: 'background.paper', overflow: 'hidden' }}>
          {ITEMS.map((it, i) => (
            <Accordion
              key={it.q}
              disableGutters
              square
              elevation={0}
              sx={{ bgcolor: 'transparent', '&::before': { display: 'none' }, '&:not(:first-of-type)': { borderTop: 1, borderColor: 'divider' } }}
            >
              <AccordionSummary expandIcon={<ExpandMoreIcon />} aria-controls={`faq-${i}-content`} id={`faq-${i}-header`} sx={{ px: 3, py: 0.75, minHeight: 56, '&:hover': { bgcolor: 'action.hover' } }}>
                <Typography component="h3" sx={{ fontWeight: 600 }}>{it.q}</Typography>
              </AccordionSummary>
              <AccordionDetails id={`faq-${i}-content`} sx={{ px: 3, pb: 3, pt: 0 }}>
                <Typography color="text.secondary" sx={{ lineHeight: 1.7 }}>{it.a}</Typography>
              </AccordionDetails>
            </Accordion>
          ))}
        </Box>
      </Container>
    </Box>
  );
}