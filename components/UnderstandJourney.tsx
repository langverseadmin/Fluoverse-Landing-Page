"use client";

import { motion } from "framer-motion";

export default function UnderstandJourney() {
  return (
    <section
      id="understand-journey"
      className="py-14 sm:py-16 lg:py-20"
      aria-labelledby="understand-journey-heading"
      aria-describedby="understand-journey-subtitle"
    >
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.55 }}
          className="text-center"
        >
          <h2
            id="understand-journey-heading"
            className="text-balance text-3xl font-bold leading-tight text-white sm:text-4xl lg:text-5xl"
          >
            We Understand{" "}
            <span className="text-purple-400">Your Journey</span>
          </h2>
          <p
            id="understand-journey-subtitle"
            className="mx-auto mt-6 max-w-3xl text-pretty leading-relaxed text-white/85 sm:mt-7 sm:text-lg"
          >
            <span className="mb-2 block font-semibold text-white sm:text-xl md:mb-3">
              Built by Expats for Expats.
            </span>
            <span className="block text-base text-white/75 sm:text-lg">
              Our founders are fellow expats that know firsthand the challenges of relocation and it
              shows in our testimonials.
            </span>
          </p>
        </motion.div>
      </div>
    </section>
  );
}
