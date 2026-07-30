import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import CommunityGuidelinesContent from "./CommunityGuidelinesContent";

export const metadata: Metadata = {
  title: "Community Guidelines",
  description:
    "How to show up well in Fluoverse community events, chats, and language meetups — respect, safety, and what to do if plans change.",
  robots: { index: true, follow: true },
  alternates: { canonical: "https://fluoverse.com/community-guidelines" },
  openGraph: {
    url: "https://fluoverse.com/community-guidelines",
    title: "Community Guidelines | Fluoverse",
    description:
      "Guidelines for Fluoverse community events, chats, and meetups.",
  },
};

export default function CommunityGuidelinesPage() {
  return (
    <main className="min-h-screen">
      <Navigation />
      <div className="pt-24 pb-16 px-4 sm:px-6 lg:px-8">
        <div className="max-w-4xl mx-auto">
          <CommunityGuidelinesContent />
        </div>
      </div>
      <Footer />
    </main>
  );
}
