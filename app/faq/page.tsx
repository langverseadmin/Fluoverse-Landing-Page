import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import FAQ from "@/components/FAQ";

export const metadata: Metadata = {
  title: "FAQ",
  description:
    "Answers about Fluoverse — connecting abroad, bridging language gaps, scenarios and Fluency Rooms, Premium vs Free, privacy, tutors, and support.",
  keywords: [
    "Fluoverse FAQ",
    "making friends abroad",
    "locals integration Fluency Rooms",
    "cultural barrier language scenarios",
    "Fluoverse Premium",
    "expat friendships support",
  ],
  alternates: { canonical: "https://fluoverse.com/faq" },
  openGraph: {
    url: "https://fluoverse.com/faq",
    title: "FAQ | Fluoverse",
    description:
      "Common questions about befriending locals abroad, Fluency Rooms, downloads, subscriptions, classrooms, and support.",
  },
};

export default function FaqPage() {
  return (
    <main className="min-h-screen">
      <Navigation />
      <div className="pt-24">
        <FAQ />
      </div>
      <Footer />
    </main>
  );
}
