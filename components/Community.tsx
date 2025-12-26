"use client";

import { motion } from "framer-motion";
import UserMap from "./UserMap";

export default function Community() {
  return (
    <section id="community" className="py-24 relative overflow-hidden">
      {/* Background gradient */}
      <div className="absolute inset-0 bg-gradient-to-b from-transparent via-purple-500/5 to-transparent"></div>
      
      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Title */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="text-center mb-16"
        >
          <h3 className="peer text-sm uppercase tracking-[0.2em] text-white/60 font-medium mb-2 transition-all duration-300 hover:text-white/90 inline-block cursor-default select-none">
            Community
          </h3>
          <div className="h-px w-16 bg-gradient-to-r from-transparent via-white/40 to-transparent mx-auto transition-all duration-300 peer-hover:via-white/70 peer-hover:w-24 mb-4"></div>
          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-bold text-white mb-6">
            Join a <span className="text-purple-400">Global Community</span>
            <br />
            <span className="text-white/90">of Language Learners</span>
          </h2>
        </motion.div>

        {/* User Map */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, delay: 0.2 }}
        >
          <UserMap />
        </motion.div>
      </div>
    </section>
  );
}

