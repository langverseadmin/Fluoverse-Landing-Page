"use client";

import { motion } from "framer-motion";
import { trackStoreBadgeAppStore, trackStoreBadgeGooglePlay } from "@/lib/analytics";
import AppStoreBadgeLinks from "@/components/AppStoreBadgeLinks";

type Panel = {
  src: string;
  alt: string;
  label: string;
  objectPosition: string;
};

const panels: Panel[] = [
  {
    src: "/1.png",
    alt: "Person reaching out and connecting with people locally",
    label: "Struggling to connect with locals?",
    objectPosition: "center center",
  },
  {
    src: "/2.png",
    alt: "Group gathered together, leaning in and belonging",
    label: "Feeling disconnected from your community?",
    objectPosition: "center center",
  },
  {
    src: "/3.png",
    alt: "People from different backgrounds sharing a thoughtful moment outdoors",
    label: "Feeling lost in cultural misunderstandings?",
    objectPosition: "center center",
  },
  {
    src: "/4.png",
    alt: "Two people talking easily over coffee",
    label: "Overwhelmed by language barriers?",
    objectPosition: "center center",
  },
];

export default function IsolationShowcase() {
  return (
    <section
      id="isolation-gallery"
      className="relative overflow-hidden pb-16 pt-12 sm:pt-16 md:pb-24"
      aria-labelledby="isolation-gallery-heading"
    >
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0, y: 24 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.55 }}
          className="mb-10 text-center md:mb-14"
        >
          <h2
            id="isolation-gallery-heading"
            className="text-balance text-3xl font-bold leading-tight text-white sm:text-4xl lg:text-5xl"
          >
            Don&apos;t Face Isolation{" "}
            <span className="text-purple-400">Alone</span>
          </h2>
        </motion.div>
      </div>

      <div className="w-full">
        <div className="isolation-showcase__strip">
          {panels.map((panel, index) => (
            <div key={`${panel.src}-${index}`} className="isolation-showcase__box">
              <div className="isolation-showcase__image-wrap">
                <img
                  src={panel.src}
                  alt={panel.alt}
                  style={{ objectPosition: panel.objectPosition }}
                  loading="lazy"
                  draggable={false}
                />
              </div>
              <span>{panel.label}</span>
            </div>
          ))}
        </div>
      </div>

      <div className="mx-auto mt-10 max-w-xl px-4 sm:px-6 lg:px-8 sm:mt-12 md:mt-14">
        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.55, delay: 0.08 }}
        >
          <AppStoreBadgeLinks
            onAppStoreClick={() => trackStoreBadgeAppStore("isolation_showcase")}
            onGooglePlayClick={() => trackStoreBadgeGooglePlay("isolation_showcase")}
          />
        </motion.div>
      </div>
    </section>
  );
}
