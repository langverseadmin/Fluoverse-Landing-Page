"use client";

import { motion } from "framer-motion";
import { Users, MapPin, Sparkles } from "lucide-react";

export default function Meetups() {
  return (
    <section
      id="meetups"
      aria-label="Meetups and Partners"
      className="py-16 lg:py-20 bg-gradient-to-b from-white to-violet-50"
    >
      <div className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.55 }}
          className="text-center mb-10"
        >
          <h2 className="text-3xl sm:text-4xl font-bold text-[#3b0764]">
            Host Meetups with Fluoverse
          </h2>
          <p className="mt-3 text-gray-600 max-w-xl mx-auto">
            We partner with cafés, co-working spaces, and local organizers to turn
            Fluoverse matches into real-life meetups — and bring new regulars
            through your door.
          </p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.55, delay: 0.1 }}
          className="grid grid-cols-1 sm:grid-cols-3 gap-6 mb-10"
        >
          <div className="rounded-2xl border border-violet-100 bg-white p-6 text-center shadow-sm">
            <Users className="mx-auto h-8 w-8 text-violet-700" />
            <h3 className="mt-3 font-semibold text-[#3b0764]">Built-in Community</h3>
            <p className="mt-1 text-sm text-gray-600">
              Get a steady flow of expats and locals actively looking for places to meet.
            </p>
          </div>
          <div className="rounded-2xl border border-violet-100 bg-white p-6 text-center shadow-sm">
            <MapPin className="mx-auto h-8 w-8 text-violet-700" />
            <h3 className="mt-3 font-semibold text-[#3b0764]">Local Visibility</h3>
            <p className="mt-1 text-sm text-gray-600">
              Featured as a recommended meetup spot right inside the Fluoverse app.
            </p>
          </div>
          <div className="rounded-2xl border border-violet-100 bg-white p-6 text-center shadow-sm">
            <Sparkles className="mx-auto h-8 w-8 text-violet-700" />
            <h3 className="mt-3 font-semibold text-[#3b0764]">Zero Setup</h3>
            <p className="mt-1 text-sm text-gray-600">
              We handle the matching and check-in flow — you just host.
            </p>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.55, delay: 0.15 }}
          className="text-center"
        >
          <a
            href="mailto:operations@fluoverse.com?subject=Meetup%20Partnership%20Inquiry"
            className="neon-cta-3d inline-flex px-6 py-3 text-sm font-semibold text-white"
          >
            Become a Meetup Partner
          </a>
        </motion.div>
      </div>
    </section>
  );
}