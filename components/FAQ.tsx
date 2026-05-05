"use client";

import { motion, AnimatePresence } from "framer-motion";
import { useState, useMemo } from "react";
import { Minus, Plus } from "lucide-react";
import { trackFaqOpen } from "@/lib/analytics";
import { LEARNERS_ONLY_SITE } from "@/lib/config";

const faqsAll = [
  {
    question: "What is Fluoverse?",
    answer: "Fluoverse is a speak-first language learning app where you practice with real-world scenarios and guided conversations.",
  },
  {
    question: "What are 'Scenarios'?",
    answer: "Scenarios are short, realistic speaking activities designed to help you practice everyday situations with AI support.",
  },
  {
    question: "Do I need to talk out loud?",
    answer: "Yes! Fluoverse is fully voice-based. You speak, the AI understands, and responds naturally.",
  },
  {
    question: "How do I get started with Fluoverse?",
    answer: "Download the app, create an account, choose your language and you're in.",
  },
  {
    question: "Can teachers or schools use Fluoverse?",
    answer: "Yes. Teachers can track lesson participation, fluency, confidence, and get sent reports per class.",
  },
  {
    question: "What are Fluency Rooms?",
    answer: "Fluency Rooms let two learners role-play scenarios together.",
  },
  {
    question: "What should I do if I run into an issue?",
    answer: "You can contact support directly through the app or email us anytime at support@fluoverse.com.",
  },
];

export default function FAQ() {
  const faqs = useMemo(
    () =>
      LEARNERS_ONLY_SITE
        ? faqsAll.filter((f) => !f.question.includes("teachers or schools"))
        : faqsAll,
    []
  );
  const [openIndex, setOpenIndex] = useState<number | null>(0);

  const toggleFAQ = (index: number) => {
    const isOpening = openIndex !== index;
    setOpenIndex(isOpening ? index : null);
    if (isOpening) {
      trackFaqOpen(faqs[index].question);
    }
  };

  return (
    <section id="faq" className="py-24 relative overflow-hidden">
      {/* Background gradient */}
      <div className="absolute inset-0 bg-gradient-to-b from-transparent via-purple-500/5 to-transparent"></div>
      
      <div className="relative max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="text-center mb-16"
        >
          {/* Badge */}
          <h3 className="peer text-sm uppercase tracking-[0.2em] text-white/60 font-medium mb-2 transition-all duration-300 hover:text-white/90 inline-block cursor-default select-none">
            FAQ
          </h3>
          <div className="h-px w-16 bg-gradient-to-r from-transparent via-white/40 to-transparent mx-auto transition-all duration-300 peer-hover:via-white/70 peer-hover:w-24 mb-6"></div>

          {/* Heading */}
          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-bold text-white mb-6">
            Frequently Asked <span className="text-purple-400">Questions</span>
          </h2>
        </motion.div>

        {/* FAQ Items */}
        <div className="space-y-4">
          {faqs.map((faq, index) => {
            const isOpen = openIndex === index;
            
            return (
              <motion.div
                key={index}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true, margin: "-50px" }}
                transition={{ duration: 0.4, delay: index * 0.1 }}
                className="group relative bg-white/5 backdrop-blur-sm rounded-2xl border border-white/10 overflow-hidden hover:border-white/20 transition-all duration-300 hover:shadow-[0_8px_32px_rgba(168,85,247,0.1)]"
              >
                {/* Subtle glow on hover */}
                <div className="absolute inset-0 bg-gradient-to-r from-purple-500/0 via-purple-500/0 to-purple-500/0 group-hover:from-purple-500/5 group-hover:via-purple-500/5 group-hover:to-purple-500/5 transition-all duration-500 pointer-events-none"></div>
                
                {/* Question Button */}
                <button
                  onClick={() => toggleFAQ(index)}
                  className="relative w-full px-6 py-5 flex items-center justify-between text-left group/button"
                >
                  <span className="text-base sm:text-lg font-semibold text-white pr-4 group-hover/button:text-purple-300 transition-colors duration-300">
                    {faq.question}
                  </span>
                  <motion.div
                    animate={{ rotate: isOpen ? 0 : 0 }}
                    transition={{ duration: 0.3 }}
                    className="flex-shrink-0 w-8 h-8 rounded-full bg-white/10 flex items-center justify-center group-hover/button:bg-white/20 transition-all duration-300 group-hover/button:scale-110"
                  >
                    <AnimatePresence mode="wait">
                      {isOpen ? (
                        <motion.div
                          key="minus"
                          initial={{ opacity: 0, scale: 0.5, rotate: -90 }}
                          animate={{ opacity: 1, scale: 1, rotate: 0 }}
                          exit={{ opacity: 0, scale: 0.5, rotate: 90 }}
                          transition={{ duration: 0.2 }}
                        >
                          <Minus className="w-4 h-4 text-white" />
                        </motion.div>
                      ) : (
                        <motion.div
                          key="plus"
                          initial={{ opacity: 0, scale: 0.5, rotate: -90 }}
                          animate={{ opacity: 1, scale: 1, rotate: 0 }}
                          exit={{ opacity: 0, scale: 0.5, rotate: 90 }}
                          transition={{ duration: 0.2 }}
                        >
                          <Plus className="w-4 h-4 text-white" />
                        </motion.div>
                      )}
                    </AnimatePresence>
                  </motion.div>
                </button>

                {/* Answer */}
                <AnimatePresence>
                  {isOpen && (
                    <motion.div
                      initial={{ height: 0, opacity: 0 }}
                      animate={{ height: "auto", opacity: 1 }}
                      exit={{ height: 0, opacity: 0 }}
                      transition={{ duration: 0.3, ease: "easeInOut" }}
                      className="overflow-hidden"
                    >
                      <div className="px-6 pb-5 pt-0">
                        <div className="border-t border-white/10 pt-4">
                          <p className="text-white/70 text-sm sm:text-base leading-relaxed">
                            {faq.answer}
                          </p>
                        </div>
                      </div>
                    </motion.div>
                  )}
                </AnimatePresence>
              </motion.div>
            );
          })}
        </div>
      </div>
    </section>
  );
}

