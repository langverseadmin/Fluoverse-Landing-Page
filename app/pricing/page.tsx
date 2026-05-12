import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import PricingContent from "./PricingContent";
import { LEARNERS_ONLY_SITE } from "@/lib/config";

export const metadata: Metadata = {
  title: "Pricing",
  description: LEARNERS_ONLY_SITE
    ? "Fluoverse pricing for learners integrating abroad — start free or go Premium for unlimited scenarios and Fluency Rooms that sharpen the speaking you use with locals daily."
    : "Flexible Fluoverse pricing for learners, tutors, and businesses — speaking practice scenarios, dashboards, and team options.",
  alternates: { canonical: "https://fluoverse.com/pricing" },
  openGraph: {
    url: "https://fluoverse.com/pricing",
    title: "Pricing | Fluoverse",
    description: LEARNERS_ONLY_SITE
      ? "Free and Premium for unlimited scenarios and Fluency Rooms—confidence for coffees with neighbours and coworkers."
      : "Plans for learners, tutors, and organizations.",
  },
  keywords: [
    "Fluoverse Premium",
    "language learning abroad subscription",
    "speaking locals confidence pricing",
  ],
};

export default function PricingPage() {
  return (
    <main className="min-h-screen">
      <Navigation />
      <div className="pt-24 pb-16 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto">
          <div className="text-center mb-12">
            <h1 className="text-4xl sm:text-5xl font-bold text-white mb-4">
              Simple, <span className="text-purple-400">Transparent</span> Pricing
            </h1>
            <p className="text-white/70 text-lg">
              Choose the plan that works best for you
            </p>
          </div>
          <PricingContent />
        </div>
      </div>
      <Footer />
    </main>
  );
}

