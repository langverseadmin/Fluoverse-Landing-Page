"use client";

import Image from "next/image";
import { motion } from "framer-motion";
import { trackHeroDownloadAppStore, trackHeroDownloadGooglePlay } from "@/lib/analytics";
import { APP_STORE_WEB_URLS } from "@/lib/config";

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
                className="flex flex-col sm:flex-row items-center justify-center gap-5 w-full"
              >
              <a
                href={APP_STORE_WEB_URLS.ios}
                target="_blank"
                rel="noopener noreferrer"
                onClick={() => trackHeroDownloadAppStore()}
                aria-label="Download on the App Store"
                className="hero-store-badge-3d"
              >
                <div className="flex items-center justify-center pl-4 pr-2.5 shrink-0 self-center">
                  <svg className="w-7 h-7 text-white" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
                    <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.81-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
                  </svg>
                </div>
                <div className="flex flex-col justify-center border-l border-white/25 pl-3.5 pr-5 py-2.5 min-h-14">
                  <span className="text-[11px] font-normal leading-tight tracking-wide text-white">
                    Download on the
                  </span>
                  <span className="text-[17px] font-bold leading-tight tracking-tight text-white mt-0.5">
                    App Store
                  </span>
                </div>
              </a>

              <a
                href={APP_STORE_WEB_URLS.android}
                target="_blank"
                rel="noopener noreferrer"
                onClick={() => trackHeroDownloadGooglePlay()}
                aria-label="Get it on Google Play"
                className="hero-store-badge-3d"
              >
                <div className="flex items-center justify-center pl-4 pr-2.5 shrink-0 self-center">
                  <svg className="w-7 h-7 text-white" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
                    <path d="M3,20.5V3.5C3,2.91 3.34,2.39 3.84,2.15L13.69,12L3.84,21.85C3.34,21.6 3,21.09 3,20.5M16.81,15.12L6.05,21.34L14.54,12.85L16.81,15.12M20.16,10.81C20.5,11.08 20.75,11.5 20.75,12C20.75,12.5 20.5,12.92 20.16,13.19L17.19,14.5L14.54,11.85L17.19,9.5L20.16,10.81M6.05,2.66L16.81,8.88L14.54,11.15L6.05,2.66Z"/>
                  </svg>
                </div>
                <div className="flex flex-col justify-center border-l border-white/25 pl-3.5 pr-5 py-2.5 min-h-14">
                  <span className="text-[11px] font-normal leading-tight tracking-wide text-white">Get it on</span>
                  <span className="text-[17px] font-bold leading-tight tracking-tight text-white mt-0.5">
                    Google Play
                  </span>
                </div>
              </a>
            </motion.div>
            </div>
        </motion.div>
      </div>
    </section>
  );
}


