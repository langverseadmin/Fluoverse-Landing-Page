import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import PrivacyContent from "./PrivacyContent";

export const metadata: Metadata = {
  title: "Privacy Policy",
  description:
    "How Fluoverse collects, uses, and protects personal data across the Fluoverse speaking-practice apps and fluoverse.com.",
  robots: { index: true, follow: true },
  alternates: { canonical: "https://fluoverse.com/privacy" },
  openGraph: {
    url: "https://fluoverse.com/privacy",
    title: "Privacy Policy | Fluoverse",
    description: "Privacy practices for Fluoverse language-learning products.",
  },
};

export default function PrivacyPage() {
  return (
    <main className="min-h-screen">
      <Navigation />
      <div className="pt-24 pb-16 px-4 sm:px-6 lg:px-8">
        <div className="max-w-4xl mx-auto">
          <PrivacyContent />
        </div>
      </div>
      <Footer />
    </main>
  );
}
