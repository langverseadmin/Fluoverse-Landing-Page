"use client";

import { motion, useScroll, useTransform, AnimatePresence } from "framer-motion";
import { useState, useEffect, useRef } from "react";
import { ArrowRight, Languages, MessageCircle, Clock, TrendingUp, Award, Users, BookOpen } from "lucide-react";

// Types for user recap data
export interface RecapData {
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

interface RecapProps {
  data: RecapData;
  onComplete?: () => void;
}

// Slide components for different stats
const Slide = ({ children, index, currentSlide }: { children: React.ReactNode; index: number; currentSlide: number }) => {
  const isActive = index === currentSlide;
  
  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.9 }}
      animate={{ 
        opacity: isActive ? 1 : 0.3,
        scale: isActive ? 1 : 0.95,
      }}
      exit={{ opacity: 0, scale: 0.9 }}
      transition={{ duration: 0.5, ease: "easeInOut" }}
      className="absolute inset-0 flex items-center justify-center"
    >
      {children}
    </motion.div>
  );
};

const WelcomeSlide = ({ userName, year }: { userName: string; year: number }) => (
  <div className="text-center px-8">
    <motion.h1
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, delay: 0.2 }}
      className="text-6xl md:text-8xl font-black text-white mb-6"
      style={{ fontFamily: 'system-ui, -apple-system, sans-serif' }}
    >
      {year}
    </motion.h1>
    <motion.p
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, delay: 0.4 }}
      className="text-2xl md:text-4xl text-white/90 mb-4"
    >
      Your Fluoverse Year
    </motion.p>
    <motion.p
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.8, delay: 0.6 }}
      className="text-xl md:text-2xl text-white/70"
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
  
  useEffect(() => {
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
      
      return () => clearInterval(timer);
    } else {
      setDisplayValue(value as any);
    }
  }, [value]);

  return (
    <div className="text-center px-8">
      <motion.div
        initial={{ scale: 0, rotate: -180 }}
        animate={{ scale: 1, rotate: 0 }}
        transition={{ duration: 0.6, delay: 0.2, type: "spring" }}
        className={`w-24 h-24 md:w-32 md:h-32 mx-auto mb-8 rounded-full flex items-center justify-center ${gradient} shadow-2xl`}
      >
        <Icon className="w-12 h-12 md:w-16 md:h-16 text-white" />
      </motion.div>
      <motion.div
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8, delay: 0.4 }}
        className="text-7xl md:text-9xl font-black text-white mb-4"
      >
        {typeof value === 'number' ? displayValue.toLocaleString() : displayValue}
      </motion.div>
      <motion.p
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8, delay: 0.6 }}
        className="text-2xl md:text-3xl text-white/90 mb-2"
      >
        {label}
      </motion.p>
      {subtext && (
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.8 }}
          className="text-lg md:text-xl text-white/70"
        >
          {subtext}
        </motion.p>
      )}
    </div>
  );
};

const LanguagesSlide = ({ languages }: { languages: string[] }) => (
  <div className="text-center px-8">
    <motion.h2
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, delay: 0.2 }}
      className="text-3xl md:text-5xl font-bold text-white mb-12"
    >
      Your Languages
    </motion.h2>
    <div className="flex flex-wrap justify-center gap-6 md:gap-8">
      {languages.map((lang, index) => (
        <motion.div
          key={lang}
          initial={{ opacity: 0, scale: 0, rotate: -180 }}
          animate={{ opacity: 1, scale: 1, rotate: 0 }}
          transition={{ 
            duration: 0.6, 
            delay: 0.4 + index * 0.2,
            type: "spring",
            stiffness: 200
          }}
          className="w-32 h-32 md:w-40 md:h-40 bg-gradient-to-br from-purple-500 to-pink-500 rounded-2xl flex items-center justify-center shadow-2xl"
        >
          <span className="text-2xl md:text-3xl font-bold text-white">{lang}</span>
        </motion.div>
      ))}
    </div>
  </div>
);

const TopLanguageSlide = ({ language }: { language: string }) => (
  <div className="text-center px-8">
    <motion.p
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, delay: 0.2 }}
      className="text-2xl md:text-3xl text-white/80 mb-8"
    >
      Your Top Language
    </motion.p>
    <motion.div
      initial={{ scale: 0, rotate: -360 }}
      animate={{ scale: 1, rotate: 0 }}
      transition={{ duration: 1, delay: 0.4, type: "spring", stiffness: 150 }}
      className="w-48 h-48 md:w-64 md:h-64 mx-auto mb-8 bg-gradient-to-br from-purple-500 via-pink-500 to-orange-500 rounded-full flex items-center justify-center shadow-2xl"
    >
      <span className="text-5xl md:text-7xl font-black text-white">{language}</span>
    </motion.div>
  </div>
);

const FavoriteScenarioSlide = ({ scenario }: { scenario: string }) => (
  <div className="text-center px-8">
    <motion.p
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, delay: 0.2 }}
      className="text-2xl md:text-3xl text-white/80 mb-8"
    >
      Your Favorite Scenario
    </motion.p>
    <motion.div
      initial={{ opacity: 0, scale: 0.8 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ duration: 0.8, delay: 0.4 }}
      className="bg-white/10 backdrop-blur-md rounded-3xl p-8 md:p-12 border border-white/20 shadow-2xl max-w-2xl mx-auto"
    >
      <MessageCircle className="w-16 h-16 md:w-20 md:h-20 text-white mx-auto mb-6" />
      <p className="text-3xl md:text-4xl font-bold text-white">{scenario}</p>
    </motion.div>
  </div>
);

const LevelProgressSlide = ({ progress }: { progress: number }) => (
  <div className="text-center px-8 max-w-2xl mx-auto">
    <motion.p
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, delay: 0.2 }}
      className="text-2xl md:text-3xl text-white/80 mb-8"
    >
      Your Progress
    </motion.p>
    <motion.div
      initial={{ opacity: 0, scale: 0.8 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ duration: 0.8, delay: 0.4 }}
      className="bg-white/10 backdrop-blur-md rounded-3xl p-8 md:p-12 border border-white/20 shadow-2xl"
    >
      <TrendingUp className="w-16 h-16 md:w-20 md:h-20 text-white mx-auto mb-6" />
      <div className="text-7xl md:text-9xl font-black text-white mb-4">{progress}%</div>
      <p className="text-xl md:text-2xl text-white/70">Level Complete</p>
    </motion.div>
  </div>
);

const ThankYouSlide = ({ userName }: { userName: string }) => (
  <div className="text-center px-8">
    <motion.div
      initial={{ scale: 0, rotate: -180 }}
      animate={{ scale: 1, rotate: 0 }}
      transition={{ duration: 1, delay: 0.2, type: "spring" }}
      className="w-32 h-32 md:w-40 md:h-40 mx-auto mb-8 bg-gradient-to-br from-purple-500 to-pink-500 rounded-full flex items-center justify-center shadow-2xl"
    >
      <Award className="w-16 h-16 md:w-20 md:h-20 text-white" />
    </motion.div>
    <motion.h2
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, delay: 0.4 }}
      className="text-4xl md:text-6xl font-bold text-white mb-6"
    >
      Thanks for Learning with Us
    </motion.h2>
    <motion.p
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.8, delay: 0.6 }}
      className="text-xl md:text-2xl text-white/80"
    >
      {userName}
    </motion.p>
  </div>
);

export default function Recap({ data, onComplete }: RecapProps) {
  const [currentSlide, setCurrentSlide] = useState(0);
  const [isPlaying, setIsPlaying] = useState(true);
  const [dimensions, setDimensions] = useState({ width: 1920, height: 1080 });
  const containerRef = useRef<HTMLDivElement>(null);
  const { scrollYProgress } = useScroll({
    container: containerRef,
  });

  useEffect(() => {
    const updateDimensions = () => {
      setDimensions({
        width: window.innerWidth,
        height: window.innerHeight,
      });
    };
    
    updateDimensions();
    window.addEventListener('resize', updateDimensions);
    return () => window.removeEventListener('resize', updateDimensions);
  }, []);

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
    
    const slideDuration = 3500; // 3.5 seconds per slide
    const totalSlides = slides.length; // Total number of slides
    
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

  return (
    <div 
      ref={containerRef}
      className="relative w-full h-screen overflow-hidden bg-gradient-to-br from-purple-900 via-pink-900 to-orange-900"
    >
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
      
      {/* Floating particles */}
      {Array.from({ length: 20 }).map((_, i) => {
        const initialX = Math.random() * dimensions.width;
        const initialY = Math.random() * dimensions.height;
        return (
          <motion.div
            key={i}
            className="absolute w-2 h-2 bg-white/20 rounded-full"
            initial={{
              x: initialX,
              y: initialY,
            }}
            animate={{
              y: [null, Math.random() * dimensions.height],
              x: [null, Math.random() * dimensions.width],
            }}
            transition={{
              duration: 10 + Math.random() * 10,
              repeat: Infinity,
              ease: "linear",
            }}
          />
        );
      })}

      {/* Slides container */}
      <AnimatePresence mode="wait">
        <div className="relative w-full h-full">
          {slides.map((slide, index) => (
            <Slide key={index} index={index} currentSlide={currentSlide}>
              {slide}
            </Slide>
          ))}
        </div>
      </AnimatePresence>

      {/* Progress indicator */}
      <div className="absolute bottom-8 left-1/2 transform -translate-x-1/2 flex gap-2">
        {slides.map((_, index) => (
          <motion.div
            key={index}
            className="h-2 rounded-full"
            initial={{ width: 8, opacity: 0.5 }}
            animate={{
              width: currentSlide === index ? 32 : 8,
              opacity: currentSlide === index ? 1 : 0.5,
              backgroundColor: currentSlide === index ? "white" : "rgba(255, 255, 255, 0.5)",
            }}
            transition={{ duration: 0.3 }}
          />
        ))}
      </div>

      {/* Skip/Next button */}
      {!isPlaying && (
        <motion.button
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          onClick={() => onComplete?.()}
          className="absolute bottom-8 right-8 bg-white text-purple-900 px-6 py-3 rounded-full font-semibold flex items-center gap-2 hover:bg-white/90 transition-colors shadow-lg"
        >
          Share Your Recap
          <ArrowRight className="w-5 h-5" />
        </motion.button>
      )}
    </div>
  );
}
