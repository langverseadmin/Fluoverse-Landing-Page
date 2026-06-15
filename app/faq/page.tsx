import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import FAQ from "@/components/FAQ";

export const metadata: Metadata = {
  title: "FAQ",
  description:
    "Stop feeling alone. Start feeling at home. Answers about Fluoverse: making real friends, meetups, language and culture coaching, Premium vs Free, and support.",
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
      "Stop feeling alone. Start feeling at home. Common questions about making friends abroad, meetups, downloads, and support.",
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
