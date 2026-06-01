import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import GuideSchema from "@/components/guides/GuideSchema";
import GuideEngagementTracker from "@/components/guides/GuideEngagementTracker";
import ValenciaGuideContent from "@/components/guides/ValenciaGuideContent";
import { valenciaGuideData } from "@/lib/guides/spain-expat-data";
import { buildGuideSchemas } from "@/lib/guides/schema";

const canonical = "https://fluoverse.com/guides/making-friends-abroad/spain/valencia";

export const metadata: Metadata = {
  title: valenciaGuideData.title,
  description: valenciaGuideData.description,
  keywords: valenciaGuideData.keywords,
  alternates: { canonical },
  openGraph: {
    url: canonical,
    title: `${valenciaGuideData.title} | Fluoverse`,
    description: valenciaGuideData.description,
  },
};

export default function ValenciaGuidePage() {
  const schemas = buildGuideSchemas({
    title: valenciaGuideData.title,
    description: valenciaGuideData.description,
    path: valenciaGuideData.path,
    breadcrumbs: valenciaGuideData.breadcrumbs,
    faqs: valenciaGuideData.faqs,
  });

  return (
    <main className="min-h-screen">
      <GuideSchema schemas={schemas} />
      <GuideEngagementTracker guideSlug="valencia" />
      <Navigation />
      <ValenciaGuideContent data={valenciaGuideData} placement="guide_valencia" />
      <Footer />
    </main>
  );
}
