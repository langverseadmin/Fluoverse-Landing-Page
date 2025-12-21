"use client";

import { motion } from "framer-motion";
import { Star, Quote } from "lucide-react";

const testimonials = [
  {
    name: "Sarah Johnson",
    role: "Travel Enthusiast",
    image: "👩",
    content: "Fluoverse transformed how I learn Spanish. The AI coach feels so natural, and I'm speaking confidently after just 2 months!",
    rating: 5,
  },
  {
    name: "Michael Chen",
    role: "Business Professional",
    image: "👨",
    content: "The personalized learning path is incredible. It adapts to my schedule and goals perfectly. Best language app I've used.",
    rating: 5,
  },
  {
    name: "Emma Rodriguez",
    role: "Student",
    image: "👩‍🎓",
    content: "I love the fluency rooms! Practicing real scenarios with the AI makes me feel so much more confident. Highly recommend!",
    rating: 5,
  },
];

export default function Testimonials() {
  return (
    <section id="testimonials" className="py-24 bg-[#1a0b2e]">
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
            Loved by <span className="gradient-text">Thousands</span>
          </h2>
          <p className="text-xl text-white/80 max-w-3xl mx-auto">
            See what our learners are saying about their Fluoverse experience
          </p>
        </motion.div>

        {/* Testimonials Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {testimonials.map((testimonial, index) => (
            <motion.div
              key={index}
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: index * 0.1 }}
              className="bg-[#1a0b2e] rounded-2xl p-8 border border-white/10 hover:shadow-xl transition-shadow duration-300 relative"
            >
              {/* Quote Icon */}
              <Quote className="w-8 h-8 text-primary-300 mb-4" />

              {/* Rating */}
              <div className="flex items-center space-x-1 mb-4">
                {[...Array(testimonial.rating)].map((_, i) => (
                  <Star key={i} className="w-5 h-5 fill-yellow-400 text-yellow-400" />
                ))}
              </div>

              {/* Content */}
              <p className="text-white/90 mb-6 leading-relaxed italic">
                "{testimonial.content}"
              </p>

              {/* Author */}
              <div className="flex items-center space-x-4">
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-primary-400 to-accent-400 flex items-center justify-center text-2xl">
                  {testimonial.image}
                </div>
                <div>
                  <div className="font-semibold text-white">{testimonial.name}</div>
                  <div className="text-sm text-white/70">{testimonial.role}</div>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}

