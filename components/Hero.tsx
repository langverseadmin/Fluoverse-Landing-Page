"use client";

import { motion, AnimatePresence } from "framer-motion";
import { useState, useEffect, useRef } from "react";
import Image from "next/image";
import { Star, User, MessageCircle, BookOpen, CheckCircle2, BarChart3, Share2, Settings, MessageSquare, Users, Plane, ShoppingCart, UtensilsCrossed, Pill } from "lucide-react";
import { trackHeroDownloadAppStore, trackHeroDownloadGooglePlay } from "@/lib/analytics";

export default function Hero() {
  const [selectedLanguage, setSelectedLanguage] = useState<"en" | "es" | "el">("en");
  const cycleTimerRef = useRef<NodeJS.Timeout | null>(null);

  const languageConfig = {
    en: {
      name: "English",
      image: "/benefits/English_City.jpg",
      text: "Ready to speak English?",
    },
    es: {
      name: "Spanish",
      image: "/benefits/Spanish_City.jpg",
      text: "Ready to speak Spanish?",
    },
    el: {
      name: "Greek",
      image: "/benefits/Greek_City.jpg",
      text: "Ready to speak Greek?",
    },
  };

  const languages: ("en" | "es" | "el")[] = ["en", "es", "el"];

  // Auto-cycle through languages
  useEffect(() => {
    const cycleDuration = 3000; // Change language every 3 seconds

    const cycle = () => {
      setSelectedLanguage((prev) => {
        const currentIndex = languages.indexOf(prev);
        const nextIndex = (currentIndex + 1) % languages.length;
        return languages[nextIndex];
      });
      cycleTimerRef.current = setTimeout(cycle, cycleDuration);
    };

    cycleTimerRef.current = setTimeout(cycle, cycleDuration);

    return () => {
      if (cycleTimerRef.current) {
        clearTimeout(cycleTimerRef.current);
        cycleTimerRef.current = null;
      }
    };
  }, []);
  return (
    <section className="relative min-h-screen flex items-center justify-center pt-20 hero-texture">
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
            <motion.h1
              initial={{ opacity: 0, y: -20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.3 }}
              className="text-xl sm:text-2xl lg:text-3xl xl:text-4xl font-semibold mb-16 text-white/90 leading-tight"
            >
              Language Learning for the{" "}
              <br />
              <span className="text-purple-400">Real World</span>
            </motion.h1>

            {/* App Download Buttons */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.6 }}
              className="flex flex-col sm:flex-row items-center lg:items-start gap-4"
            >
              {/* App Store Button - Official Badge */}
              <a
                href="https://fluoverse.onelink.me/zcI3/9242fe8w"
                target="_blank"
                rel="noopener noreferrer"
                onClick={() => trackHeroDownloadAppStore()}
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
                href="https://fluoverse.onelink.me/zcI3/9242fe8w"
                target="_blank"
                rel="noopener noreferrer"
                onClick={() => trackHeroDownloadGooglePlay()}
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
                    <div className="device-screen overflow-hidden" style={{ backgroundColor: '#6b21a8' }}>
                      {/* App Content - Premium Fluoverse Design */}
                      <div className="min-h-full flex flex-col" style={{ backgroundColor: '#6b21a8' }}>
                        {/* Welcome Header with Language City Background */}
                        <div className="relative h-56 overflow-hidden">
                          {/* Language City Background Image - Cycling */}
                          <AnimatePresence mode="wait">
                            <motion.div
                              key={selectedLanguage}
                              initial={{ opacity: 0 }}
                              animate={{ opacity: 1 }}
                              exit={{ opacity: 0 }}
                              transition={{ duration: 0.5 }}
                              className="absolute inset-0"
                            >
                              <Image
                                src={languageConfig[selectedLanguage].image}
                                alt={`${languageConfig[selectedLanguage].name} cityscape background`}
                                fill
                                className="object-cover"
                                priority
                              />
                              {/* Purple/Pink Gradient Overlay */}
                              <div className="absolute inset-0 bg-gradient-to-r from-purple-900/70 via-pink-900/60 to-purple-800/70"></div>
                            </motion.div>
                          </AnimatePresence>
                          <div className="relative z-10 px-6 pt-12 pb-4 h-full flex flex-col justify-center items-center text-center">
                            <h2 className="text-white text-2xl font-bold mb-1">Welcome to</h2>
                            <h1 className="text-white text-3xl font-black mb-2">Fluoverse</h1>
                            <AnimatePresence mode="wait">
                              <motion.p
                                key={selectedLanguage}
                                initial={{ opacity: 0, y: 10 }}
                                animate={{ opacity: 1, y: 0 }}
                                exit={{ opacity: 0, y: -10 }}
                                transition={{ duration: 0.3 }}
                                className="text-white/90 text-sm"
                              >
                                {languageConfig[selectedLanguage].text}
                              </motion.p>
                            </AnimatePresence>
                          </div>
                        </div>

                        {/* Main Content - Fluency Bites Card */}
                        <div className="flex-1 px-4 py-4 overflow-y-auto flex items-center justify-center">
                          <div className="bg-white rounded-3xl p-5 mb-3 shadow-lg relative overflow-hidden w-full max-w-sm">
                            {/* Subtle background pattern */}
                            <div className="absolute inset-0 opacity-5">
                              <div className="absolute top-0 right-0 w-32 h-32 bg-purple-300 rounded-full blur-3xl"></div>
                              <div className="absolute bottom-0 left-0 w-24 h-24 bg-pink-300 rounded-full blur-2xl"></div>
                            </div>
                            
                            <div className="relative z-10">
                              {/* Header */}
                              <div className="flex items-center gap-3 mb-3">
                                <div className="w-12 h-12 bg-[#a855f7] rounded-xl flex items-center justify-center">
                                  <MessageSquare className="w-6 h-6 text-white" />
                                </div>
                                <div>
                                  <h3 className="text-lg font-bold text-gray-900">Fluency Bites</h3>
                                  <p className="text-xs text-[#a855f7]">Quick practice sessions</p>
                                </div>
                              </div>

                              {/* Description */}
                              <p className="text-sm text-gray-700 mb-4 leading-relaxed">
                                Practice real-world situations with 2-4 line conversations. Perfect for building confidence in specific scenarios.
                              </p>

                              {/* Scenarios */}
                              <div className="space-y-3 mb-4">
                                <div className="flex items-center gap-3">
                                  <div className="w-10 h-10 bg-[#a855f7] rounded-lg flex items-center justify-center flex-shrink-0">
                                    <MessageSquare className="w-5 h-5 text-white" />
                                  </div>
                                  <span className="text-sm font-medium text-gray-900">Restaurant & Cafe</span>
                                </div>
                                <div className="flex items-center gap-3">
                                  <div className="w-10 h-10 bg-[#a855f7] rounded-lg flex items-center justify-center flex-shrink-0">
                                    <Plane className="w-5 h-5 text-white" />
                                  </div>
                                  <span className="text-sm font-medium text-gray-900">Airports & Flights</span>
                                </div>
                                <div className="flex items-center gap-3">
                                  <div className="w-10 h-10 bg-[#a855f7] rounded-lg flex items-center justify-center flex-shrink-0">
                                    <ShoppingCart className="w-5 h-5 text-white" />
                                  </div>
                                  <span className="text-sm font-medium text-gray-900">Shopping & Services</span>
                                </div>
                              </div>

                              {/* Start Bites Button */}
                              <div className="w-full bg-[#a855f7] text-white font-semibold py-3 rounded-2xl shadow-lg transition-all text-center pointer-events-none">
                                Start Bites
                              </div>
                            </div>
                          </div>
                        </div>

                        {/* Bottom Navigation Bar */}
                        <div className="bg-[#3b0764] px-6 py-3 flex items-center justify-around border-t border-purple-700/50">
                          <div className="flex flex-col items-center gap-1">
                            <div className="w-10 h-10 bg-[#a855f7] rounded-xl flex items-center justify-center">
                              <BarChart3 className="w-5 h-5 text-white" />
                            </div>
                            <span className="text-xs text-white/80">Leaderboard</span>
                          </div>
                          <div className="flex flex-col items-center gap-1">
                            <div className="w-10 h-10 bg-[#a855f7] rounded-xl flex items-center justify-center">
                              <Share2 className="w-5 h-5 text-white" />
                            </div>
                            <span className="text-xs text-white/80">Share</span>
                          </div>
                          <div className="flex flex-col items-center gap-1">
                            <div className="w-10 h-10 bg-[#a855f7] rounded-xl flex items-center justify-center">
                              <Settings className="w-5 h-5 text-white" />
                            </div>
                            <span className="text-xs text-white/80">Settings</span>
                          </div>
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
              initial={{ opacity: 0, scale: 0.8, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.8, ease: "easeOut" }}
              className="absolute top-8 left-4 sm:left-8 z-20 hidden sm:block"
              style={{
                '--bg': '#ffffff',
                '--contrast': '#f8f9fa',
                '--grey': '#e9ecef',
                padding: '9px',
                backgroundColor: 'var(--bg)',
                borderRadius: '35px',
                boxShadow: 'rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset',
              } as React.CSSProperties}
            >
              <div 
                className="absolute inset-0 pointer-events-none"
                style={{
                  background: 'repeating-conic-gradient(var(--bg) 0.0000001%, var(--grey) 0.000104%) 60% 60%/600% 600%',
                  filter: 'opacity(10%) contrast(105%)',
                  borderRadius: '35px'
                }}
              />
              <div 
                className="relative flex items-center space-x-2 p-2 sm:p-3"
                style={{
                  backgroundColor: 'var(--contrast)',
                  borderRadius: '30px',
                  minWidth: 'fit-content'
                }}
              >
                <div className="w-8 h-8 bg-gradient-to-br from-[#a855f7] to-[#7c3aed] rounded-xl flex items-center justify-center" style={{ boxShadow: '0 4px 14px rgba(168, 85, 247, 0.4)' }}>
                  <Star className="w-4 h-4 fill-yellow-400 text-yellow-400" />
                </div>
                <div>
                  <div className="text-base font-black text-gray-900">5.0</div>
                  <div className="text-[10px] text-gray-500 font-medium">App Store & Play Store</div>
                </div>
              </div>
            </motion.div>

            {/* Fluency Rooms Card - Left Middle */}
            <motion.div
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.6, delay: 1, ease: "easeOut" }}
              className="absolute left-0 top-1/2 -translate-y-1/2 -translate-x-1/2 sm:-translate-x-1/4 z-20 w-[150px] hidden sm:block"
              style={{
                '--bg': '#ffffff',
                '--contrast': '#f8f9fa',
                '--grey': '#e9ecef',
                padding: '9px',
                backgroundColor: 'var(--bg)',
                borderRadius: '35px',
                boxShadow: 'rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset',
              } as React.CSSProperties}
            >
              <div 
                className="absolute inset-0 pointer-events-none"
                style={{
                  background: 'repeating-conic-gradient(var(--bg) 0.0000001%, var(--grey) 0.000104%) 60% 60%/600% 600%',
                  filter: 'opacity(10%) contrast(105%)',
                  borderRadius: '35px'
                }}
              />
              <div 
                className="relative p-3 sm:p-4"
                style={{
                  backgroundColor: 'var(--contrast)',
                  borderRadius: '30px',
                  display: 'flex',
                  flexDirection: 'column'
                }}
              >
                <div className="flex items-center space-x-2 mb-3">
                  <div className="w-9 h-9 bg-gradient-to-br from-[#a855f7] to-[#7c3aed] rounded-xl flex items-center justify-center" style={{ boxShadow: '0 4px 14px rgba(168, 85, 247, 0.4)' }}>
                    <Users className="w-4 h-4 text-white" />
                  </div>
                  <div className="flex-1">
                    <div className="text-xs font-bold text-gray-900">Fluency Rooms</div>
                    <div className="text-[9px] text-[#a855f7] font-medium">Live practice</div>
                  </div>
                </div>
                <div className="w-full bg-gradient-to-r from-[#a855f7] to-[#7c3aed] text-white text-[10px] font-bold py-2 rounded-xl text-center pointer-events-none" style={{ boxShadow: '0 4px 14px rgba(168, 85, 247, 0.35)' }}>
                  Join Now
                </div>
              </div>
            </motion.div>

            {/* Scenarios Card - Right Middle */}
            <motion.div
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.6, delay: 1.2, ease: "easeOut" }}
              className="absolute right-0 top-1/2 -translate-y-1/2 translate-x-1/2 sm:translate-x-1/4 z-20 w-[130px] hidden sm:block"
              style={{
                '--bg': '#ffffff',
                '--contrast': '#f8f9fa',
                '--grey': '#e9ecef',
                padding: '9px',
                backgroundColor: 'var(--bg)',
                borderRadius: '35px',
                boxShadow: 'rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset',
              } as React.CSSProperties}
            >
              <div 
                className="absolute inset-0 pointer-events-none"
                style={{
                  background: 'repeating-conic-gradient(var(--bg) 0.0000001%, var(--grey) 0.000104%) 60% 60%/600% 600%',
                  filter: 'opacity(10%) contrast(105%)',
                  borderRadius: '35px'
                }}
              />
              <div 
                className="relative p-3"
                style={{
                  backgroundColor: 'var(--contrast)',
                  borderRadius: '30px',
                  display: 'flex',
                  flexDirection: 'column'
                }}
              >
                <div className="text-[10px] font-bold text-gray-900 mb-2">Top Scenarios</div>
                <div className="space-y-2">
                  {[
                    { icon: UtensilsCrossed, label: "Taverna" },
                    { icon: ShoppingCart, label: "Market" },
                    { icon: Pill, label: "Pharmacist" }
                  ].map((item, i) => (
                    <motion.div
                      key={i}
                      initial={{ opacity: 0, x: 10 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ duration: 0.3, delay: 1.3 + i * 0.1 }}
                      className="flex items-center gap-2"
                    >
                      <div className="w-7 h-7 bg-gradient-to-br from-[#a855f7] to-[#7c3aed] rounded-lg flex items-center justify-center flex-shrink-0" style={{ boxShadow: '0 2px 8px rgba(168, 85, 247, 0.3)' }}>
                        <item.icon className="w-3.5 h-3.5 text-white" />
                      </div>
                      <span className="text-[10px] font-semibold text-gray-800">{item.label}</span>
                    </motion.div>
                  ))}
                </div>
              </div>
            </motion.div>

            {/* Confidence Card - Bottom Right */}
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 1.4, ease: "easeOut" }}
              className="absolute bottom-8 right-4 sm:right-8 z-20 hidden sm:block"
              style={{
                '--bg': '#ffffff',
                '--contrast': '#f8f9fa',
                '--grey': '#e9ecef',
                padding: '7px',
                backgroundColor: 'var(--bg)',
                borderRadius: '28px',
                boxShadow: 'rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset',
              } as React.CSSProperties}
            >
              <div 
                className="absolute inset-0 pointer-events-none"
                style={{
                  background: 'repeating-conic-gradient(var(--bg) 0.0000001%, var(--grey) 0.000104%) 60% 60%/600% 600%',
                  filter: 'opacity(10%) contrast(105%)',
                  borderRadius: '28px'
                }}
              />
              <div 
                className="relative p-2.5"
                style={{
                  backgroundColor: 'var(--contrast)',
                  borderRadius: '24px',
                  display: 'flex',
                  flexDirection: 'column'
                }}
              >
                <div className="flex items-center space-x-1.5 mb-1.5">
                  <div className="w-6 h-6 bg-gradient-to-br from-[#a855f7] to-[#7c3aed] rounded-lg flex items-center justify-center" style={{ boxShadow: '0 3px 10px rgba(168, 85, 247, 0.4)' }}>
                    <Star className="w-3 h-3 text-white fill-white" />
                  </div>
                  <span className="text-[10px] font-bold text-gray-900">Confidence</span>
                </div>
                <div className="text-lg font-black text-transparent bg-clip-text bg-gradient-to-r from-[#a855f7] to-[#7c3aed] mb-0.5">92%</div>
                <div className="text-[9px] text-gray-500 font-medium mb-1.5">Speaking</div>
                <div className="h-1.5 bg-gray-100 rounded-full overflow-hidden">
                  <motion.div 
                    initial={{ width: 0 }}
                    animate={{ width: '92%' }}
                    transition={{ duration: 1, delay: 1.6 }}
                    className="h-full bg-gradient-to-r from-[#a855f7] via-[#7c3aed] to-green-500 rounded-full"
                  />
                </div>
              </div>
            </motion.div>
          </motion.div>
        </div>
      </div>
    </section>
  );
}


