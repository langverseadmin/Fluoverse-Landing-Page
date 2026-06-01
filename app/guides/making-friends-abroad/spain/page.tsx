import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import GuideSchema from "@/components/guides/GuideSchema";
import GuideEngagementTracker from "@/components/guides/GuideEngagementTracker";
import SpainHubContent from "@/components/guides/SpainHubContent";
import { spainHubData } from "@/lib/guides/spain-expat-data";
import { buildGuideSchemas } from "@/lib/guides/schema";

const canonical = "https://fluoverse.com/guides/making-friends-abroad/spain";

export const metadata: Metadata = {
  title: spainHubData.title,
  description: spainHubData.description,
  keywords: spainHubData.keywords,
  alternates: { canonical },
  openGraph: {
    url: canonical,
    title: `${spainHubData.title} | Fluoverse`,
    description: spainHubData.description,
  },
};

export default function SpainHubPage() {
  const schemas = buildGuideSchemas({
    title: spainHubData.title,
    description: spainHubData.description,
    path: "/guides/making-friends-abroad/spain",
    breadcrumbs: spainHubData.breadcrumbs,
    faqs: spainHubData.faqs,
  });

  return (
    <main className="min-h-screen">
      <GuideSchema schemas={schemas} />
      <GuideEngagementTracker guideSlug="spain-hub" />
      <Navigation />
      <SpainHubContent data={spainHubData} />
      <Footer />
    </main>
  );
}
