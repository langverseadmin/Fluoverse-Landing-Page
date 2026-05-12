import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import TermsContent from "./TermsContent";

export const metadata: Metadata = {
  title: "Terms & Conditions",
  description:
    "Terms of use for Fluoverse services: voice-first language scenarios, Fluency Rooms, subscriptions, and website use.",
  robots: { index: true, follow: true },
  alternates: { canonical: "https://fluoverse.com/terms" },
  openGraph: {
    url: "https://fluoverse.com/terms",
    title: "Terms & Conditions | Fluoverse",
    description: "Terms governing use of Fluoverse apps and services.",
  },
};

export default function TermsPage() {
  return (
    <main className="min-h-screen">
      <Navigation />
      <div className="pt-24 pb-16 px-4 sm:px-6 lg:px-8">
        <div className="max-w-4xl mx-auto">
          <TermsContent />
        </div>
      </div>
      <Footer />
    </main>
  );
}
