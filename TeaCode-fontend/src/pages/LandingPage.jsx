import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import Hero from '../features/landing/Hero.jsx';
import Features from '../features/landing/Features.jsx';
import Languages from '../features/landing/Languages.jsx';
import HowItWorks from '../features/landing/HowItWorks.jsx';
import PopularProblems from '../features/landing/PopularProblems.jsx';
import Faq from '../features/landing/Faq.jsx';
import FinalCta from '../features/landing/FinalCta.jsx';
import { scrollToSection } from '../utils/scroll.js';

export default function LandingPage() {
  const { hash } = useLocation();

  // Opening /#faq from any route navigates here, then scrolls to the section.
  useEffect(() => {
    if (hash) scrollToSection(hash.slice(1));
  }, [hash]);

  return (
    <>
      <Hero />
      <Features />
      <Languages />
      <HowItWorks />
      <PopularProblems />
      <Faq />
      <FinalCta />
    </>
  );
}