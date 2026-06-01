import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import GuideSchema from "@/components/guides/GuideSchema";
import GuideEngagementTracker from "@/components/guides/GuideEngagementTracker";
import IntercambioMadridContent from "@/components/guides/IntercambioMadridContent";
import { intercambioMadridData } from "@/lib/guides/spain-expat-data";
import { buildGuideSchemas } from "@/lib/guides/schema";

const canonical = "https://fluoverse.com/guides/intercambio-idiomas-madrid";

export const metadata: Metadata = {
  title: intercambioMadridData.title,
  description: intercambioMadridData.description,
  keywords: intercambioMadridData.keywords,
  alternates: { canonical },
  openGraph: {
    url: canonical,
    title: `${intercambioMadridData.title} | Fluoverse`,
    description: intercambioMadridData.description,
  },
};

export default function IntercambioMadridPage() {
  const schemas = buildGuideSchemas({
    title: intercambioMadridData.title,
    description: intercambioMadridData.description,
    path: intercambioMadridData.path,
    breadcrumbs: intercambioMadridData.breadcrumbs,
    faqs: intercambioMadridData.faqs,
  });

  return (
    <main className="min-h-screen">
      <GuideSchema schemas={schemas} />
      <GuideEngagementTracker guideSlug="intercambio-madrid" />
      <Navigation />
      <IntercambioMadridContent />
      <Footer />
    </main>
  );
}
