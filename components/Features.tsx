"use client";

import { motion } from "framer-motion";
import { Sparkles, Repeat, Mic, Users, Target, Zap } from "lucide-react";

const features = [
  {
    icon: Sparkles,
    title: "Personalized Learning",
    description: "Fluoverse adapts to your goals, interests, and style. Get a custom path and content that fits you perfectly.",
    gradient: "from-cyan-400 to-blue-500",
    tags: ["Personalization", "Custom Path", "Motivation"],
  },
  {
    icon: Repeat,
    title: "Speak-First Cycles",
    description: "Our lessons get you speaking in no time. Move from vocab to conversation fast, with cycles for vocab, reading, listening, and real scenarios.",
    gradient: "from-yellow-400 to-orange-500",
    tags: ["Vocabulary", "Reading", "Listening", "Speaking"],
  },
  {
    icon: Mic,
    title: "Fluoverse AI Coach",
    description: "Practice with the Fluoverse AI coach. Get instant feedback and support in live voice sessions that feel natural and engaging.",
    gradient: "from-purple-400 to-pink-500",
    tags: ["AI Coach", "Live Practice", "Supportive"],
  },
  {
    icon: Users,
    title: "Fluency Rooms",
    description: "Join immersive conversation rooms where you practice real-world scenarios with AI-powered native speakers.",
    gradient: "from-green-400 to-teal-500",
    tags: ["Immersive", "Real Scenarios", "Native Speakers"],
  },
  {
    icon: Target,
    title: "Goal-Oriented",
    description: "Set your learning goals and track your progress. Whether it's travel, work, or fluency, we adapt to your needs.",
    gradient: "from-red-400 to-rose-500",
    tags: ["Goals", "Progress", "Adaptive"],
  },
  {
    icon: Zap,
    title: "Fast & Effective",
    description: "Learn faster with our proven methodology. See results in weeks, not months, with our speak-first approach.",
    gradient: "from-indigo-400 to-purple-500",
    tags: ["Fast", "Effective", "Proven"],
  },
];

export default function Features() {
  return (
    <section id="features" className="py-24 bg-[#1a0b2e]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="text-center mb-16"
        >
          <h2 className="text-4xl sm:text-5xl font-bold text-white mb-4">
            Master Spanish with{" "}
            <span className="gradient-text">Fluoverse</span>
          </h2>
          <p className="text-xl text-white/80 max-w-3xl mx-auto">
            Experience a seamless blend of AI-driven lessons and cultural immersion 
            for rapid, lasting mastery.
          </p>
        </motion.div>

        {/* Features Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {features.map((feature, index) => {
            const Icon = feature.icon;
            return (
              <motion.div
                key={index}
                initial={{ opacity: 0, y: 30 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.5, delay: index * 0.1 }}
                className="group relative bg-[#1a0b2e] p-8 rounded-2xl border border-white/10 hover:border-white/20 hover:shadow-2xl transition-all duration-300"
              >
                {/* Gradient Background on Hover */}
                <div className={`absolute inset-0 bg-gradient-to-br ${feature.gradient} opacity-0 group-hover:opacity-5 rounded-2xl transition-opacity duration-300`} />
                
                {/* Icon */}
                <div className={`inline-flex p-4 rounded-xl bg-gradient-to-br ${feature.gradient} mb-6 group-hover:scale-110 transition-transform duration-300`}>
                  <Icon className="w-6 h-6 text-white" />
                </div>

                {/* Content */}
                <h3 className="text-2xl font-bold text-white mb-3">
                  {feature.title}
                </h3>
                <p className="text-white/80 mb-6 leading-relaxed">
                  {feature.description}
                </p>

                {/* Tags */}
                <div className="flex flex-wrap gap-2">
                  {feature.tags.map((tag, tagIndex) => (
                    <span
                      key={tagIndex}
                      className="px-3 py-1 bg-white/10 text-white/90 text-sm font-medium rounded-full border border-white/20"
                    >
                      {tag}
                    </span>
                  ))}
                </div>
              </motion.div>
            );
          })}
        </div>
      </div>
    </section>
  );
}

