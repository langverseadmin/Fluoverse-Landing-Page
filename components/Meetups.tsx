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
            Become a Fluoverse Host
          </h2>
          <p className="mt-3 text-gray-600 max-w-xl mx-auto">
            Fluoverse connects 6,000+ members across dozens of cities through
            shared-interest meetups. As a host, your space becomes part of
            where those connections happen.
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
            <h3 className="mt-3 font-semibold text-[#3b0764]">Active Community</h3>
            <p className="mt-1 text-sm text-gray-600">
              Meet expats and locals who are already looking for places to
              connect, again and again.
            </p>
          </div>
          <div className="rounded-2xl border border-violet-100 bg-white p-6 text-center shadow-sm">
            <MapPin className="mx-auto h-8 w-8 text-violet-700" />
            <h3 className="mt-3 font-semibold text-[#3b0764]">In-App Visibility</h3>
            <p className="mt-1 text-sm text-gray-600">
              Stay featured as a recommended meetup spot inside the Fluoverse
              app for as long as you host.
            </p>
          </div>
          <div className="rounded-2xl border border-violet-100 bg-white p-6 text-center shadow-sm">
            <Sparkles className="mx-auto h-8 w-8 text-violet-700" />
            <h3 className="mt-3 font-semibold text-[#3b0764]">We Handle the Logistics</h3>
            <p className="mt-1 text-sm text-gray-600">
              Matching and check-in are managed for you — you just host.
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
          
            href="mailto:operations@fluoverse.com?subject=Host%20Subscription%20Inquiry"
            className="neon-cta-3d inline-flex px-6 py-3 text-sm font-semibold text-white"
          >
            Become a Host
          </a>
        </motion.div>
      </div>
    </section>
  );
}
