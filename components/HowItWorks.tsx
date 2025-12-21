"use client";

import { motion } from "framer-motion";
import { UserPlus, BookOpen, MessageCircle, Trophy } from "lucide-react";

const steps = [
  {
    number: "01",
    icon: UserPlus,
    title: "Sign Up & Set Goals",
    description: "Create your account and tell us your learning goals. Whether it's travel, work, or fluency, we'll customize your path.",
  },
  {
    number: "02",
    icon: BookOpen,
    title: "Start Learning",
    description: "Begin with personalized lessons that adapt to your level. Learn vocabulary, grammar, and phrases through interactive content.",
  },
  {
    number: "03",
    icon: MessageCircle,
    title: "Practice with AI Coach",
    description: "Have real conversations with your AI coach. Get instant feedback and improve your pronunciation and fluency.",
  },
  {
    number: "04",
    icon: Trophy,
    title: "Achieve Fluency",
    description: "Track your progress and celebrate milestones. Join fluency rooms and practice with confidence in real-world scenarios.",
  },
];

export default function HowItWorks() {
  return (
    <section id="how-it-works" className="py-24 bg-[#1a0b2e]">
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
            How It <span className="gradient-text">Works</span>
          </h2>
          <p className="text-xl text-white/80 max-w-3xl mx-auto">
            Your journey to Spanish fluency in four simple steps
          </p>
        </motion.div>

        {/* Steps */}
        <div className="relative">
          {/* Connection Line (Desktop) */}
          <div className="hidden lg:block absolute top-24 left-0 right-0 h-0.5 bg-gradient-to-r from-primary-400/30 via-accent-400/30 to-primary-400/30" />

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {steps.map((step, index) => {
              const Icon = step.icon;
              return (
                <motion.div
                  key={index}
                  initial={{ opacity: 0, y: 30 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                  className="relative"
                >
                  {/* Step Number */}
                  <div className="absolute -top-4 left-1/2 transform -translate-x-1/2 lg:left-0 lg:transform-none">
                    <div className="w-12 h-12 bg-gradient-to-br from-primary-600 to-accent-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow-lg">
                      {step.number}
                    </div>
                  </div>

                  {/* Card */}
                  <div className="bg-[#1a0b2e] rounded-2xl p-8 pt-12 shadow-lg hover:shadow-2xl transition-shadow duration-300 border border-white/10">
                    {/* Icon */}
                    <div className="inline-flex p-4 rounded-xl bg-gradient-to-br from-primary-100 to-accent-100 mb-6">
                      <Icon className="w-6 h-6 text-primary-600" />
                    </div>

                    {/* Content */}
                    <h3 className="text-xl font-bold text-white mb-3">
                      {step.title}
                    </h3>
                    <p className="text-white/80 leading-relaxed">
                      {step.description}
                    </p>
                  </div>
                </motion.div>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
}

