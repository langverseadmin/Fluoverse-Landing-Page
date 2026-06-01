import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import GuideSchema from "@/components/guides/GuideSchema";
import GuideEngagementTracker from "@/components/guides/GuideEngagementTracker";
import CityGuideContent from "@/components/guides/CityGuideContent";
import { madridGuideData } from "@/lib/guides/spain-expat-data";
import { buildGuideSchemas } from "@/lib/guides/schema";

const canonical = "https://fluoverse.com/guides/making-friends-abroad/spain/madrid";

export const metadata: Metadata = {
  title: madridGuideData.title,
  description: madridGuideData.description,
  keywords: madridGuideData.keywords,
  alternates: { canonical },
  openGraph: {
    url: canonical,
    title: `${madridGuideData.title} | Fluoverse`,
    description: madridGuideData.description,
  },
};

export default function MadridGuidePage() {
  const schemas = buildGuideSchemas({
    title: madridGuideData.title,
    description: madridGuideData.description,
    path: madridGuideData.path,
    breadcrumbs: madridGuideData.breadcrumbs,
    faqs: madridGuideData.faqs,
  });

  return (
    <main className="min-h-screen">
      <GuideSchema schemas={schemas} />
      <GuideEngagementTracker guideSlug="madrid" />
      <Navigation />
      <CityGuideContent data={madridGuideData} placement="guide_madrid" />
      <Footer />
    </main>
  );
}
