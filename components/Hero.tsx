"use client";

import Image from "next/image";
import { motion } from "framer-motion";
import { trackStoreBadgeAppStore, trackStoreBadgeGooglePlay } from "@/lib/analytics";
import AppStoreBadgeLinks from "@/components/AppStoreBadgeLinks";

export default function Hero() {
  return (
    <section
      id="hero"
      className="relative min-h-screen flex flex-col overflow-hidden rounded-b-[3rem] pt-24 sm:pt-28 pb-12 sm:pb-16"
    >
      {/* Full-bleed background art — Hero_Mobile below md, Hero from md up */}
      <div className="absolute inset-0 z-0 pointer-events-none" aria-hidden>
        <picture className="absolute inset-0 block h-full w-full">
          <source media="(max-width: 767px)" srcSet="/Hero_Mobile.png" type="image/png" />
          <Image
            src="/Hero.png"
            alt=""
            fill
            className="object-cover object-center"
            priority
            sizes="100vw"
          />
        </picture>
      </div>
      {/* Top: no overlay (image full opacity); mid/bottom: tint + fade to #9333ea */}
      <div
        className="absolute inset-0 z-[1] pointer-events-none"
        style={{
          background:
            "linear-gradient(to bottom, transparent 0%, transparent 25%, rgba(42, 11, 69, 0.38) 50%, rgba(42, 11, 69, 0.68) 65%, rgba(42, 11, 69, 0.78) 75%, rgba(59, 7, 100, 0.82) 85%, #9333ea 100%)",
        }}
        aria-hidden
      />

      <div className="relative z-10 flex flex-1 flex-col min-h-0 w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0, x: -30 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.6 }}
          className="flex flex-1 flex-col min-h-0 w-full max-w-5xl mx-auto"
        >
          {/* Headline: vertically centered; nudged higher on small phones only */}
          <div className="flex flex-1 flex-col justify-center items-center min-h-0 w-full py-6 sm:py-8 max-sm:-translate-y-24 sm:translate-y-0">
            <motion.h1
              initial={{ opacity: 0, y: -20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.1 }}
              className="hero-headline-pop w-full min-w-0 text-center text-3xl sm:text-5xl lg:text-6xl xl:text-7xl font-bold text-white leading-[1.1] sm:leading-[1.08]"
            >
              {/* Mobile / tablet: same two-line headline as before (< lg) */}
              <span className="flex flex-col items-center gap-3 sm:gap-4 lg:gap-5 lg:hidden">
                <span className="block max-w-full whitespace-nowrap">
                  Bridge the Gap to
                </span>
                <span className="block max-w-full whitespace-nowrap text-purple-400 italic font-black">
                  Genuine Friendships
                </span>
              </span>
              {/* lg+: Genuine sits on the first line */}
              <span className="hidden flex-col items-center gap-3 sm:gap-4 lg:gap-5 lg:flex">
                <span className="block">
                  Bridge the Gap to{" "}
                  <span className="text-purple-400 italic font-black">
                    Genuine
                  </span>
                </span>
                <span className="block text-purple-400 italic font-black">
                  Friendships
                </span>
              </span>
            </motion.h1>
          </div>

          {/* Subhead + store badges — pinned to bottom of hero content */}
          <div
            id="download"
            className="shrink-0 flex flex-col items-center gap-3 sm:gap-4 scroll-mt-24 w-full max-w-xl mx-auto pb-2"
          >
              <div className="-translate-y-6 sm:-translate-y-9">
                <motion.p
                  initial={{ opacity: 0, y: 12 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.6, delay: 0.22 }}
                  className="text-center text-base sm:text-lg lg:text-xl text-white/90 drop-shadow-[0_1px_10px_rgba(0,0,0,0.25)]"
                >
                  Are you struggling to connect with locals in your new home?
                </motion.p>
              </div>

              <motion.div
                initial={{ opacity: 0, y: 16 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.6, delay: 0.45 }}
              >
                <AppStoreBadgeLinks
                  onAppStoreClick={() => trackStoreBadgeAppStore("hero")}
                  onGooglePlayClick={() => trackStoreBadgeGooglePlay("hero")}
                />
              </motion.div>
            </div>
        </motion.div>
      </div>
    </section>
  );
}
