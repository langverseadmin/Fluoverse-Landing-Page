import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import FAQ from "@/components/FAQ";

export const metadata: Metadata = {
  title: "FAQ",
  description:
    "Answers about Fluoverse, the social integration app for expats in Spain: making real friends, learning real Spanish, cultural coaching, meetups, Premium vs Free, and support.",
  keywords: [
    "Fluoverse FAQ",
    "make friends in Spain",
    "feel at home Spain",
    "expat app Spain",
    "Fluoverse Premium",
    "social integration app",
    "lonely in Spain help",
  ],
  alternates: { canonical: "https://fluoverse.com/faq" },
  openGraph: {
    url: "https://fluoverse.com/faq",
    title: "FAQ | Fluoverse",
    description:
      "Common questions about making friends in Spain, Fluoverse meetups, downloads, subscriptions, and support.",
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
