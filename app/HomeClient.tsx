"use client";

import { useState } from "react";
import { motion } from "framer-motion";
import { trackStoreBadgeAppStore, trackStoreBadgeGooglePlay } from "@/lib/analytics";
import AppStoreBadgeLinks from "@/components/AppStoreBadgeLinks";
import Navigation from "@/components/Navigation";
import Hero from "@/components/Hero";
import IsolationShowcase from "@/components/IsolationShowcase";
import TrustedBy from "@/components/TrustedBy";
import EasyStepsConnect from "@/components/EasyStepsConnect";
import Benefits from "@/components/Benefits";
import UnderstandJourney from "@/components/UnderstandJourney";
import UserVideo from "@/components/UserVideo";
import Testimonials from "@/components/Testimonials";
import Partners from "@/components/Partners";
import Footer from "@/components/Footer";

type TabType = "learners" | "tutors";

export default function HomeClient() {
  const [activeTab, setActiveTab] = useState<TabType>("learners");

  return (
    <main className="min-h-screen">
      <Navigation />
      <Hero />
      <IsolationShowcase />
      <Benefits activeTab={activeTab} onTabChange={setActiveTab} />
      <TrustedBy />
      <UnderstandJourney />
      <UserVideo />
      <Testimonials activeTab={activeTab} />
      <section aria-label="Download Fluoverse" className="py-12 lg:py-14">
        <div className="mx-auto max-w-xl px-4 sm:px-6 lg:px-8">
          <motion.div
            initial={{ opacity: 0, y: 16 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.55, delay: 0.06 }}
          >
            <AppStoreBadgeLinks
              onAppStoreClick={() => trackStoreBadgeAppStore("after_testimonials")}
              onGooglePlayClick={() => trackStoreBadgeGooglePlay("after_testimonials")}
            />
          </motion.div>
        </div>
      </section>
      <EasyStepsConnect />
      <Partners />
      <Footer />
    </main>
  );
}
