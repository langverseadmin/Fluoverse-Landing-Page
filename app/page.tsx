 "use client";

import { useState } from "react";
import Navigation from "@/components/Navigation";
import Hero from "@/components/Hero";
import TrustedBy from "@/components/TrustedBy";
import Features from "@/components/Features";
import Benefits from "@/components/Benefits";
import Community from "@/components/Community";
import UserVideo from "@/components/UserVideo";
import Testimonials from "@/components/Testimonials";
import FAQ from "@/components/FAQ";
import Footer from "@/components/Footer";

type TabType = "learners" | "tutors";

export default function Home() {
  const [activeTab, setActiveTab] = useState<TabType>("learners");

  return (
    <main className="min-h-screen">
      <Navigation />
      <Hero />
      <TrustedBy />
      <Features />
      <Benefits activeTab={activeTab} onTabChange={setActiveTab} />
      <Community />
      <UserVideo />
      <Testimonials activeTab={activeTab} />
      <FAQ />
      <Footer />
    </main>
  );
}

