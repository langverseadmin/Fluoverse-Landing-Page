import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import GuideSchema from "@/components/guides/GuideSchema";
import GuideEngagementTracker from "@/components/guides/GuideEngagementTracker";
import SocialAppsGuideContent from "@/components/guides/SocialAppsGuideContent";
import { socialAppsGuideData } from "@/lib/guides/spain-expat-data";
import { buildGuideSchemas } from "@/lib/guides/schema";

const canonical = "https://fluoverse.com/guides/social-apps-expats-spain-2026";

export const metadata: Metadata = {
  title: socialAppsGuideData.title,
  description: socialAppsGuideData.description,
  keywords: socialAppsGuideData.keywords,
  alternates: { canonical },
  openGraph: {
    url: canonical,
    title: `${socialAppsGuideData.title} | Fluoverse`,
    description: socialAppsGuideData.description,
  },
};

export default function SocialAppsGuidePage() {
  const schemas = buildGuideSchemas({
    title: socialAppsGuideData.title,
    description: socialAppsGuideData.description,
    path: socialAppsGuideData.path,
    breadcrumbs: socialAppsGuideData.breadcrumbs,
    faqs: socialAppsGuideData.faqs,
  });

  return (
    <main className="min-h-screen">
      <GuideSchema schemas={schemas} />
      <GuideEngagementTracker guideSlug="social-apps-spain" />
      <Navigation />
      <SocialAppsGuideContent />
      <Footer />
    </main>
  );
}
