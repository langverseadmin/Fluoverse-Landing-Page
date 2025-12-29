"use client";

import { motion, AnimatePresence } from "framer-motion";
import { useState, useEffect, useRef } from "react";
import { ArrowRight, Languages, MessageCircle, Clock, TrendingUp, Award, BookOpen, X } from "lucide-react";

// Types for user recap data
export interface RecapEmbeddedData {
  userName: string;
  totalMinutes: number;
  totalSessions: number;
  languagesLearned: string[];
  topLanguage: string;
  longestStreak: number;
  totalConversations: number;
  favoriteScenario: string;
  levelProgress: number;
  year: number;
}

interface RecapEmbeddedProps {
  data: RecapEmbeddedData;
  onClose?: () => void;
  onComplete?: () => void;
  autoPlay?: boolean;
  className?: string;
}

// Mobile-first slide component
const Slide = ({ children, index, currentSlide }: { children: React.ReactNode; index: number; currentSlide: number }) => {
  const isActive = index === currentSlide;
  
  return (
    <motion.div
      initial={{ opacity: 0, x: 100 }}
      animate={{ 
        opacity: isActive ? 1 : 0,
        x: isActive ? 0 : 100,
      }}
      exit={{ opacity: 0, x: -100 }}
      transition={{ duration: 0.4, ease: "easeInOut" }}
      className="absolute inset-0 flex items-center justify-center w-full"
      style={{ display: isActive ? 'flex' : 'none' }}
    >
      {children}
    </motion.div>
  );
};

const WelcomeSlide = ({ userName, year }: { userName: string; year: number }) => (
  <div className="text-center px-6 py-8 w-full max-w-md mx-auto">
    <motion.h1
      initial={{ opacity: 0, scale: 0.8 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ duration: 0.6, delay: 0.2 }}
      className="text-7xl font-black text-white mb-6"
      style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }}
    >
      {year}
    </motion.h1>
    <motion.p
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6, delay: 0.4 }}
      className="text-2xl text-white/90 mb-3 font-semibold"
    >
      Your Fluoverse Year
    </motion.p>
    <motion.p
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.6, delay: 0.6 }}
      className="text-xl text-white/70"
    >
      {userName}
    </motion.p>
  </div>
);

const StatSlide = ({ 
  icon: Icon, 
  value, 
  label, 
  subtext,
  gradient 
}: { 
  icon: React.ElementType; 
  value: string | number; 
  label: string; 
  subtext?: string;
  gradient: string;
}) => {
  const [displayValue, setDisplayValue] = useState(0);
  const [hasStarted, setHasStarted] = useState(false);
  const slideRef = useRef<HTMLDivElement>(null);
  
  useEffect(() => {
    if (!hasStarted && slideRef.current) {
      const observer = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting && !hasStarted) {
              setHasStarted(true);
              if (typeof value === 'number') {
                const duration = 2000;
                const steps = 60;
                const increment = value / steps;
                const stepDuration = duration / steps;
                let currentStep = 0;
                
                const timer = setInterval(() => {
                  currentStep++;
                  const nextValue = Math.min(Math.floor(increment * currentStep), value);
                  setDisplayValue(nextValue);
                  
                  if (nextValue >= value) {
                    clearInterval(timer);
                    setDisplayValue(value);
                  }
                }, stepDuration);
              } else {
                setDisplayValue(value as any);
              }
            }
          });
        },
        { threshold: 0.5 }
      );
      
      observer.observe(slideRef.current);
      return () => observer.disconnect();
    }
  }, [value, hasStarted]);

  return (
    <div ref={slideRef} className="text-center px-6 py-8 w-full max-w-md mx-auto">
      <motion.div
        initial={{ scale: 0, rotate: -180 }}
        animate={{ scale: 1, rotate: 0 }}
        transition={{ duration: 0.5, delay: 0.2, type: "spring" }}
        className={`w-20 h-20 mx-auto mb-6 rounded-full flex items-center justify-center ${gradient} shadow-xl`}
      >
        <Icon className="w-10 h-10 text-white" />
      </motion.div>
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.4 }}
        className="text-6xl font-black text-white mb-4"
      >
        {typeof value === 'number' ? displayValue.toLocaleString() : displayValue}
      </motion.div>
      <motion.p
        initial={{ opacity: 0, y: 15 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.6 }}
        className="text-xl text-white/90 mb-2 font-semibold"
      >
        {label}
      </motion.p>
      {subtext && (
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.6, delay: 0.8 }}
          className="text-base text-white/70"
        >
          {subtext}
        </motion.p>
      )}
    </div>
  );
};

const LanguagesSlide = ({ languages }: { languages: string[] }) => (
  <div className="text-center px-6 py-8 w-full max-w-md mx-auto">
    <motion.h2
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6, delay: 0.2 }}
      className="text-2xl font-bold text-white mb-8"
    >
      Your Languages
    </motion.h2>
    <div className="flex flex-wrap justify-center gap-4">
      {languages.map((lang, index) => (
        <motion.div
          key={lang}
          initial={{ opacity: 0, scale: 0, rotate: -180 }}
          animate={{ opacity: 1, scale: 1, rotate: 0 }}
          transition={{ 
            duration: 0.5, 
            delay: 0.4 + index * 0.15,
            type: "spring",
            stiffness: 200
          }}
          className="w-28 h-28 bg-gradient-to-br from-purple-500 to-pink-500 rounded-2xl flex items-center justify-center shadow-xl"
        >
          <span className="text-xl font-bold text-white">{lang}</span>
        </motion.div>
      ))}
    </div>
  </div>
);

const TopLanguageSlide = ({ language }: { language: string }) => (
  <div className="text-center px-6 py-8 w-full max-w-md mx-auto">
    <motion.p
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6, delay: 0.2 }}
      className="text-xl text-white/80 mb-6"
    >
      Your Top Language
    </motion.p>
    <motion.div
      initial={{ scale: 0, rotate: -360 }}
      animate={{ scale: 1, rotate: 0 }}
      transition={{ duration: 0.8, delay: 0.4, type: "spring", stiffness: 150 }}
      className="w-40 h-40 mx-auto mb-6 bg-gradient-to-br from-purple-500 via-pink-500 to-orange-500 rounded-full flex items-center justify-center shadow-xl"
    >
      <span className="text-4xl font-black text-white">{language}</span>
    </motion.div>
  </div>
);

const FavoriteScenarioSlide = ({ scenario }: { scenario: string }) => (
  <div className="text-center px-6 py-8 w-full max-w-md mx-auto">
    <motion.p
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6, delay: 0.2 }}
      className="text-xl text-white/80 mb-6"
    >
      Your Favorite Scenario
    </motion.p>
    <motion.div
      initial={{ opacity: 0, scale: 0.9 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ duration: 0.6, delay: 0.4 }}
      className="bg-white/10 backdrop-blur-md rounded-3xl p-6 border border-white/20 shadow-xl"
    >
      <MessageCircle className="w-12 h-12 text-white mx-auto mb-4" />
      <p className="text-2xl font-bold text-white">{scenario}</p>
    </motion.div>
  </div>
);

const LevelProgressSlide = ({ progress }: { progress: number }) => (
  <div className="text-center px-6 py-8 w-full max-w-md mx-auto">
    <motion.p
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6, delay: 0.2 }}
      className="text-xl text-white/80 mb-6"
    >
      Your Progress
    </motion.p>
    <motion.div
      initial={{ opacity: 0, scale: 0.9 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ duration: 0.6, delay: 0.4 }}
      className="bg-white/10 backdrop-blur-md rounded-3xl p-6 border border-white/20 shadow-xl"
    >
      <TrendingUp className="w-12 h-12 text-white mx-auto mb-4" />
      <div className="text-6xl font-black text-white mb-3">{progress}%</div>
      <p className="text-lg text-white/70">Level Complete</p>
    </motion.div>
  </div>
);

const ThankYouSlide = ({ userName }: { userName: string }) => (
  <div className="text-center px-6 py-8 w-full max-w-md mx-auto">
    <motion.div
      initial={{ scale: 0, rotate: -180 }}
      animate={{ scale: 1, rotate: 0 }}
      transition={{ duration: 0.8, delay: 0.2, type: "spring" }}
      className="w-24 h-24 mx-auto mb-6 bg-gradient-to-br from-purple-500 to-pink-500 rounded-full flex items-center justify-center shadow-xl"
    >
      <Award className="w-12 h-12 text-white" />
    </motion.div>
    <motion.h2
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6, delay: 0.4 }}
      className="text-3xl font-bold text-white mb-4"
    >
      Thanks for Learning with Us
    </motion.h2>
    <motion.p
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.6, delay: 0.6 }}
      className="text-lg text-white/80"
    >
      {userName}
    </motion.p>
  </div>
);

export default function RecapEmbedded({ 
  data, 
  onClose, 
  onComplete, 
  autoPlay = true,
  className = ""
}: RecapEmbeddedProps) {
  const [currentSlide, setCurrentSlide] = useState(0);
  const [isPlaying, setIsPlaying] = useState(autoPlay);
  const containerRef = useRef<HTMLDivElement>(null);

  const slides = [
    <WelcomeSlide key="welcome" userName={data.userName} year={data.year} />,
    <StatSlide 
      key="minutes" 
      icon={Clock} 
      value={data.totalMinutes} 
      label="Minutes Practiced"
      subtext="Keep up the great work!"
      gradient="bg-gradient-to-br from-blue-500 to-cyan-500"
    />,
    <StatSlide 
      key="sessions" 
      icon={BookOpen} 
      value={data.totalSessions} 
      label="Learning Sessions"
      gradient="bg-gradient-to-br from-purple-500 to-pink-500"
    />,
    <StatSlide 
      key="conversations" 
      icon={MessageCircle} 
      value={data.totalConversations} 
      label="Conversations"
      gradient="bg-gradient-to-br from-orange-500 to-red-500"
    />,
    <LanguagesSlide key="languages" languages={data.languagesLearned} />,
    <TopLanguageSlide key="top-language" language={data.topLanguage} />,
    <StatSlide 
      key="streak" 
      icon={TrendingUp} 
      value={data.longestStreak} 
      label="Day Streak"
      subtext="Your longest streak this year!"
      gradient="bg-gradient-to-br from-green-500 to-emerald-500"
    />,
    <FavoriteScenarioSlide key="scenario" scenario={data.favoriteScenario} />,
    <LevelProgressSlide key="progress" progress={data.levelProgress} />,
    <ThankYouSlide key="thanks" userName={data.userName} />,
  ];

  // Slide progression timing
  useEffect(() => {
    if (!isPlaying) return;
    
    const slideDuration = 4000; // 4 seconds per slide
    const totalSlides = slides.length;
    
    const timer = setInterval(() => {
      setCurrentSlide((prev) => {
        const next = prev + 1;
        if (next >= totalSlides) {
          setIsPlaying(false);
          onComplete?.();
          return prev;
        }
        return next;
      });
    }, slideDuration);

    return () => clearInterval(timer);
  }, [isPlaying, onComplete, slides.length]);

  // Touch/swipe handlers for mobile
  const touchStart = useRef<number | null>(null);
  const touchEnd = useRef<number | null>(null);

  const minSwipeDistance = 50;

  const onTouchStart = (e: React.TouchEvent) => {
    touchEnd.current = null;
    touchStart.current = e.targetTouches[0].clientX;
  };

  const onTouchMove = (e: React.TouchEvent) => {
    touchEnd.current = e.targetTouches[0].clientX;
  };

  const onTouchEnd = () => {
    if (!touchStart.current || !touchEnd.current) return;
    const distance = touchStart.current - touchEnd.current;
    const isLeftSwipe = distance > minSwipeDistance;
    const isRightSwipe = distance < -minSwipeDistance;

    if (isLeftSwipe && currentSlide < slides.length - 1) {
      setCurrentSlide(prev => prev + 1);
      setIsPlaying(false);
    }
    if (isRightSwipe && currentSlide > 0) {
      setCurrentSlide(prev => prev - 1);
      setIsPlaying(false);
    }
  };

  const handleNext = () => {
    if (currentSlide < slides.length - 1) {
      setCurrentSlide(prev => prev + 1);
      setIsPlaying(false);
    }
  };

  const handlePrevious = () => {
    if (currentSlide > 0) {
      setCurrentSlide(prev => prev - 1);
      setIsPlaying(false);
    }
  };

  return (
    <div 
      ref={containerRef}
      className={`relative w-full h-full overflow-hidden bg-gradient-to-br from-purple-900 via-pink-900 to-orange-900 ${className}`}
      onTouchStart={onTouchStart}
      onTouchMove={onTouchMove}
      onTouchEnd={onTouchEnd}
      style={{
        maxWidth: '428px',
        margin: '0 auto',
      }}
    >
      {/* Close button */}
      {onClose && (
        <button
          onClick={onClose}
          className="absolute top-4 right-4 z-50 w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center text-white hover:bg-white/30 transition-colors"
          aria-label="Close recap"
        >
          <X className="w-5 h-5" />
        </button>
      )}

      {/* Animated background gradient */}
      <motion.div
        className="absolute inset-0"
        animate={{
          background: [
            "radial-gradient(circle at 20% 50%, rgba(168, 85, 247, 0.4) 0%, transparent 50%)",
            "radial-gradient(circle at 80% 50%, rgba(236, 72, 153, 0.4) 0%, transparent 50%)",
            "radial-gradient(circle at 50% 80%, rgba(249, 115, 22, 0.4) 0%, transparent 50%)",
            "radial-gradient(circle at 20% 50%, rgba(168, 85, 247, 0.4) 0%, transparent 50%)",
          ],
        }}
        transition={{ duration: 10, repeat: Infinity, ease: "linear" }}
      />

      {/* Slides container */}
      <div className="relative w-full h-full flex items-center justify-center">
        <AnimatePresence mode="wait">
          {slides.map((slide, index) => (
            <Slide key={index} index={index} currentSlide={currentSlide}>
              {slide}
            </Slide>
          ))}
        </AnimatePresence>
      </div>

      {/* Navigation buttons */}
      {currentSlide > 0 && (
        <button
          onClick={handlePrevious}
          className="absolute left-4 top-1/2 -translate-y-1/2 z-50 w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center text-white hover:bg-white/30 transition-colors"
          aria-label="Previous slide"
        >
          <ArrowRight className="w-5 h-5 rotate-180" />
        </button>
      )}

      {currentSlide < slides.length - 1 && (
        <button
          onClick={handleNext}
          className="absolute right-4 top-1/2 -translate-y-1/2 z-50 w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center text-white hover:bg-white/30 transition-colors"
          aria-label="Next slide"
        >
          <ArrowRight className="w-5 h-5" />
        </button>
      )}

      {/* Progress indicator */}
      <div className="absolute bottom-6 left-1/2 transform -translate-x-1/2 flex gap-2 z-50">
        {slides.map((_, index) => (
          <motion.div
            key={index}
            className="h-1.5 rounded-full cursor-pointer"
            initial={{ width: 6, opacity: 0.5 }}
            animate={{
              width: currentSlide === index ? 24 : 6,
              opacity: currentSlide === index ? 1 : 0.5,
              backgroundColor: currentSlide === index ? "white" : "rgba(255, 255, 255, 0.5)",
            }}
            transition={{ duration: 0.3 }}
            onClick={() => {
              setCurrentSlide(index);
              setIsPlaying(false);
            }}
          />
        ))}
      </div>

      {/* Navigation hint */}
      {currentSlide < slides.length - 1 && isPlaying && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="absolute bottom-20 left-1/2 transform -translate-x-1/2 text-white/60 text-sm z-50"
        >
          Swipe or tap arrow to navigate
        </motion.div>
      )}
    </div>
  );
}


