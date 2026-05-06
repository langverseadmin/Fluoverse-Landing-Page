import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import FAQ from "@/components/FAQ";

export const metadata: Metadata = {
  title: "FAQ",
  description:
    "Answers to common questions about Fluoverse — scenarios, speaking practice, getting started, and support.",
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
