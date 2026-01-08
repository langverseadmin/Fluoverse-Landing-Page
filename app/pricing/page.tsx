import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import PricingContent from "./PricingContent";

export const metadata: Metadata = {
  title: "Pricing",
  description: "Choose the perfect plan for learners, tutors, or businesses. Flexible pricing options to suit your needs.",
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

