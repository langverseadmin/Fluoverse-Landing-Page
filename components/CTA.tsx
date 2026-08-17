"use client";

import { motion } from "framer-motion";
import { ArrowRight, Sparkles } from "lucide-react";
import { getFluoverseUrl, isMobileDevice, openFluoverseApp } from "@/lib/utils";
import { trackCtaStartLearningFree } from "@/lib/analytics";

export default function CTA() {
  return (
    <section id="get-started" className="py-24 bg-gradient-to-br from-primary-600 via-accent-600 to-primary-700 relative overflow-hidden">
      {/* Background Pattern */}
      <div className="absolute inset-0 opacity-10">
        <div className="absolute inset-0" style={{
          backgroundImage: `radial-gradient(circle at 2px 2px, white 1px, transparent 0)`,
          backgroundSize: '40px 40px'
        }} />
      </div>

      <div className="relative max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          {/* Icon */}
          <motion.div
            animate={{ rotate: [0, 10, -10, 0] }}
            transition={{ duration: 2, repeat: Infinity, repeatDelay: 3 }}
            className="inline-flex p-4 bg-white/20 rounded-2xl mb-6 backdrop-blur-sm"
          >
            <Sparkles className="w-8 h-8 text-white" />
          </motion.div>

          {/* Heading */}
          <h2 className="text-4xl sm:text-5xl lg:text-6xl font-bold text-white mb-6">
            Ready to Start Your
            <br />
            Language Journey?
          </h2>

          {/* Description */}
          <p className="text-xl text-white/90 mb-10 max-w-2xl mx-auto">
            Join 10,000+ learners who are mastering Spanish with Fluoverse. 
            Start your free trial today and experience the future of language learning.
          </p>

          {/* CTA Buttons */}
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
            <motion.a
              href={isMobileDevice() ? "#" : getFluoverseUrl()}
              target={isMobileDevice() ? undefined : "_blank"}
              rel={isMobileDevice() ? undefined : "noopener noreferrer"}
              onClick={(e) => {
                trackCtaStartLearningFree();
                if (isMobileDevice()) {
                  e.preventDefault();
                  openFluoverseApp();
                }
              }}
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              className="bg-white text-primary-600 px-8 py-4 rounded-full font-semibold text-lg hover:shadow-2xl transition-all duration-200 flex items-center space-x-2"
            >
              <span>Start Learning Free</span>
              <ArrowRight className="w-5 h-5" />
            </motion.a>
            <motion.a
              href="#"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              className="bg-white/10 backdrop-blur-sm text-white border-2 border-white/30 px-8 py-4 rounded-full font-semibold text-lg hover:bg-white/20 transition-all duration-200"
            >
              Learn More
            </motion.a>
          </div>

          {/* Trust Badge */}
          <p className="mt-8 text-white/80 text-sm">
            ✓ No credit card required • ✓ Free 7-day trial • ✓ Cancel anytime
          </p>
        </motion.div>
      </div>
    </section>
  );
}

