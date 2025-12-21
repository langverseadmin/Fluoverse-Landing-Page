"use client";

import { motion } from "framer-motion";
import { Star, User, MessageCircle, BookOpen, CheckCircle2 } from "lucide-react";

export default function Hero() {
  return (
    <section className="relative min-h-screen flex items-center justify-center bg-[#1a0b2e] pt-20 hero-texture">
      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 lg:py-20">
        <div className="grid lg:grid-cols-2 gap-12 items-center">
          {/* Left Side - Content */}
          <motion.div
            initial={{ opacity: 0, x: -30 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.6 }}
            className="text-center lg:text-left"
          >
            {/* Main Heading */}
            <div className="gold-text-wrapper mt-0 md:-mt-32 mb-12 mx-auto lg:mx-0 lg:ml-0 lg:mr-auto">
              <div className="gold-text-bg">
                {"FLUOVERSE".split("").map((letter, index) => (
                  <motion.span
                    key={`bg-${index}`}
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ 
                      duration: 0.5, 
                      delay: index * 0.1,
                      ease: "easeOut"
                    }}
                    style={{ display: "inline-block" }}
                  >
                    {letter === " " ? "\u00A0" : letter}
                  </motion.span>
                ))}
              </div>
              <div className="gold-text-fg">
                {"FLUOVERSE".split("").map((letter, index) => (
                  <motion.span
                    key={`fg-${index}`}
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ 
                      duration: 0.5, 
                      delay: index * 0.1,
                      ease: "easeOut"
                    }}
                    style={{ display: "inline-block" }}
                  >
                    {letter === " " ? "\u00A0" : letter}
                  </motion.span>
                ))}
              </div>
            </div>
            <motion.h2
              initial={{ opacity: 0, y: -20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.3 }}
              className="text-xl sm:text-2xl lg:text-3xl xl:text-4xl font-semibold mb-16 text-white/90 leading-tight"
            >
              Empowering Every Voice to{" "}
              <br />
              Speak with <span className="text-purple-400">Confidence</span>
            </motion.h2>

            {/* App Download Buttons */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.6 }}
              className="flex flex-col sm:flex-row items-center lg:items-start gap-4"
            >
              {/* App Store Button - Official Badge */}
              <a
                href="https://apps.apple.com/gr/app/fluoverse/id6755234538"
                target="_blank"
                rel="noopener noreferrer"
                className="group bg-black text-white rounded-xl font-semibold hover:bg-gray-800 transition-all duration-200 flex items-center shadow-lg hover:shadow-xl overflow-hidden h-14 px-4"
                style={{ boxShadow: '0 0 20px rgba(255, 255, 255, 0.2), 0 0 40px rgba(255, 255, 255, 0.1)' }}
              >
                {/* Apple Logo */}
                <div className="flex items-center justify-center w-8 h-8 mr-3">
                  <svg className="w-6 h-6" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.81-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
                  </svg>
                </div>
                {/* App Store Text */}
                <div className="text-left border-l border-white/20 pl-3">
                  <div className="text-[10px] leading-tight font-normal">Download on the</div>
                  <div className="text-base leading-tight font-semibold tracking-tight">App Store</div>
                </div>
              </a>

              {/* Google Play Button */}
              <a
                href="https://play.google.com/store/search?q=Fluoverse&c=apps&hl=en"
                target="_blank"
                rel="noopener noreferrer"
                className="group bg-black text-white rounded-xl font-semibold hover:bg-gray-800 transition-all duration-200 flex items-center shadow-lg hover:shadow-xl overflow-hidden h-14"
                style={{ boxShadow: '0 0 20px rgba(255, 255, 255, 0.2), 0 0 40px rgba(255, 255, 255, 0.1)' }}
              >
                {/* Google Play Logo */}
                <div className="px-3 flex items-center">
                  <svg className="w-7 h-7" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M3,20.5V3.5C3,2.91 3.34,2.39 3.84,2.15L13.69,12L3.84,21.85C3.34,21.6 3,21.09 3,20.5M16.81,15.12L6.05,21.34L14.54,12.85L16.81,15.12M20.16,10.81C20.5,11.08 20.75,11.5 20.75,12C20.75,12.5 20.5,12.92 20.16,13.19L17.19,14.5L14.54,11.85L17.19,9.5L20.16,10.81M6.05,2.66L16.81,8.88L14.54,11.15L6.05,2.66Z"/>
                  </svg>
                </div>
                <div className="text-left pr-4 border-l border-white/20 pl-3">
                  <div className="text-[10px] leading-tight">Get it on</div>
                  <div className="text-base leading-tight font-semibold tracking-tight">Google Play</div>
                </div>
              </a>
            </motion.div>
          </motion.div>

          {/* Right Side - Phone Mockup with Floating Elements */}
          <motion.div
            initial={{ opacity: 0, x: 30 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.6, delay: 0.3 }}
            className="relative flex items-center justify-center"
          >
            {/* Phone Mockup - iPhone 14 from devices.css */}
            <div className="relative z-10 flex items-center justify-center">
              <div style={{ transform: 'scale(0.75)', transformOrigin: 'center' }}>
                <div className="device device-iphone-14 device-silver">
                  <div className="device-frame">
                    <div className="device-screen bg-gradient-to-br from-primary-50 to-accent-50">
                      {/* App Content */}
                      <div className="px-4 py-3 min-h-full">
                        {/* Navigation */}
                        <div className="flex items-center justify-between mb-4 pt-2">
                          <div className="flex items-center space-x-2">
                            <div className="w-8 h-8 rounded-full bg-gradient-to-br from-primary-400 to-accent-400 flex items-center justify-center text-white text-xs font-bold">
                              F
                            </div>
                            <span className="text-sm font-semibold text-gray-900">Welcome John</span>
                          </div>
                          <MessageCircle className="w-5 h-5 text-gray-600" />
                        </div>

                        {/* Search Bar */}
                        <div className="bg-white rounded-xl px-4 py-2.5 mb-4 shadow-sm">
                          <div className="flex items-center space-x-2">
                            <div className="w-4 h-4 rounded-full bg-primary-200"></div>
                            <span className="text-xs text-gray-500">Your search</span>
                          </div>
                        </div>

                        {/* Categories */}
                        <div className="mb-4">
                          <div className="flex items-center justify-between mb-3">
                            <span className="text-sm font-bold text-gray-900">Category</span>
                            <span className="text-xs text-primary-600">See all</span>
                          </div>
                          <div className="flex space-x-3 overflow-x-auto pb-2">
                            {[1, 2, 3].map((i) => (
                              <div key={i} className="flex-shrink-0 w-20 bg-white rounded-xl p-2 shadow-sm">
                                <div className="w-12 h-12 bg-gradient-to-br from-primary-200 to-accent-200 rounded-lg mb-2 mx-auto"></div>
                                <div className="h-2 bg-gray-200 rounded w-12 mx-auto"></div>
                              </div>
                            ))}
                          </div>
                        </div>

                        {/* Lesson Card */}
                        <div className="bg-white rounded-xl p-4 shadow-sm mb-4">
                          <div className="flex items-center space-x-3 mb-2">
                            <BookOpen className="w-5 h-5 text-primary-600" />
                            <span className="text-sm font-semibold text-gray-900">Daily Lesson</span>
                          </div>
                          <div className="h-2 bg-gray-200 rounded-full mb-2">
                            <div className="h-full bg-gradient-to-r from-primary-500 to-accent-500 rounded-full w-3/4"></div>
                          </div>
                          <span className="text-xs text-gray-600">75% Complete</span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div className="device-stripe"></div>
                  <div className="device-header"></div>
                  <div className="device-sensors"></div>
                  <div className="device-btns"></div>
                  <div className="device-power"></div>
                </div>
              </div>
            </div>

            {/* Floating UI Elements */}
            {/* Rating Card - Top Left */}
            <motion.div
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ duration: 0.5, delay: 0.8 }}
              className="absolute top-8 left-4 sm:left-8 bg-white rounded-2xl p-4 shadow-xl border border-gray-100 z-20"
            >
              <div className="flex items-center space-x-2">
                <Star className="w-5 h-5 fill-yellow-400 text-yellow-400" />
                <div>
                  <div className="text-lg font-bold text-gray-900">4.9</div>
                  <div className="text-xs text-gray-600">Rating</div>
                </div>
              </div>
            </motion.div>

            {/* AI Coach Card - Left Middle */}
            <motion.div
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.5, delay: 1 }}
              className="absolute left-0 top-1/2 -translate-y-1/2 -translate-x-1/2 sm:-translate-x-1/4 bg-white rounded-2xl p-4 shadow-xl border-2 border-primary-200 z-20 w-[200px]"
            >
              <div className="flex items-center space-x-3 mb-2">
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-primary-400 to-accent-400 flex items-center justify-center text-white font-bold">
                  AI
                </div>
                <div className="flex-1">
                  <div className="text-sm font-semibold text-gray-900">AI Coach</div>
                  <div className="text-xs text-gray-600">Language Expert</div>
                </div>
              </div>
              <div className="flex items-center justify-between mb-2">
                <span className="text-xs text-gray-600">Session Ready</span>
                <span className="text-sm font-bold text-primary-600">Free</span>
              </div>
              <div className="flex items-center space-x-1 mb-2">
                <Star className="w-3 h-3 fill-yellow-400 text-yellow-400" />
                <span className="text-xs font-semibold text-gray-900">5.0</span>
                <span className="text-xs text-gray-600">(2k Reviews)</span>
              </div>
              <button className="w-full bg-gradient-to-r from-primary-500 to-accent-500 text-white text-xs font-semibold py-2 rounded-lg">
                Start Session
              </button>
            </motion.div>

            {/* Tutors Row - Right Middle */}
            <motion.div
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.5, delay: 1.2 }}
              className="absolute right-0 top-1/2 -translate-y-1/2 translate-x-1/2 sm:translate-x-1/4 bg-white rounded-2xl p-3 shadow-xl border border-gray-100 z-20"
            >
              <div className="text-xs font-semibold text-gray-900 mb-2">Top Tutors</div>
              <div className="flex -space-x-2">
                {["M", "A", "L", "L"].map((letter, i) => (
                  <motion.div
                    key={i}
                    initial={{ scale: 0 }}
                    animate={{ scale: 1 }}
                    transition={{ duration: 0.3, delay: 1.3 + i * 0.1 }}
                    className={`w-10 h-10 rounded-full bg-gradient-to-br ${
                      i === 1 ? "from-primary-400 to-accent-400 ring-4 ring-primary-200" : "from-gray-300 to-gray-400"
                    } flex items-center justify-center text-white text-xs font-bold border-2 border-white`}
                  >
                    {letter}
                  </motion.div>
                ))}
              </div>
            </motion.div>

            {/* Progress Card - Bottom Right */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5, delay: 1.4 }}
              className="absolute bottom-8 right-4 sm:right-8 bg-white rounded-2xl p-4 shadow-xl border border-gray-100 z-20"
            >
              <div className="flex items-center space-x-2 mb-2">
                <CheckCircle2 className="w-5 h-5 text-green-500" />
                <span className="text-sm font-semibold text-gray-900">Progress</span>
              </div>
              <div className="text-2xl font-bold gradient-text mb-1">85%</div>
              <div className="text-xs text-gray-600">Fluency Level</div>
            </motion.div>
          </motion.div>
        </div>
      </div>
    </section>
  );
}

