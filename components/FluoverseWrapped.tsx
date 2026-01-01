"use client";

import { motion, AnimatePresence } from "framer-motion";
import { useState, useEffect, useRef, useCallback, useMemo } from "react";
import { Clock, Calendar, BookOpen, Target, Award, Sparkles } from "lucide-react";
import Image from "next/image";
import Clock3D from "./Clock3D";

// Spinning Clock Component with animated hands
const SpinningClock = ({ 
  duration = 43200, // 12 hours in seconds
  minuteDuration = 3600, // 60 minutes in seconds
  size = 16 
}: { 
  duration?: number; 
  minuteDuration?: number;
  size?: number;
}) => {
  return (
    <svg 
      viewBox="0 0 24 24" 
      fill="none" 
      stroke="white" 
      strokeWidth="1.5"
      className="w-16 h-16"
      style={{ opacity: 0.2 }}
    >
      {/* Clock circle */}
      <circle cx="12" cy="12" r="10" stroke="currentColor" fill="none" />
      
      {/* Hour markers */}
      <line x1="12" y1="2" x2="12" y2="4" stroke="currentColor" strokeWidth="2" />
      <line x1="22" y1="12" x2="20" y2="12" stroke="currentColor" strokeWidth="2" />
      <line x1="12" y1="22" x2="12" y2="20" stroke="currentColor" strokeWidth="2" />
      <line x1="2" y1="12" x2="4" y2="12" stroke="currentColor" strokeWidth="2" />
      
      {/* Hour hand - rotating around center (12,12) */}
      <motion.g
        style={{ transformOrigin: '12px 12px' }}
        animate={{ rotate: 360 }}
        transition={{ 
          duration: duration, 
          repeat: Infinity, 
          ease: "linear" 
        }}
      >
        <line 
          x1="12" 
          y1="12" 
          x2="12" 
          y2="7" 
          stroke="white" 
          strokeWidth="2.5" 
          strokeLinecap="round"
        />
      </motion.g>
      
      {/* Minute hand - rotating around center (12,12) */}
      <motion.g
        style={{ transformOrigin: '12px 12px' }}
        animate={{ rotate: 360 }}
        transition={{ 
          duration: minuteDuration, 
          repeat: Infinity, 
          ease: "linear" 
        }}
      >
        <line 
          x1="12" 
          y1="12" 
          x2="12" 
          y2="5" 
          stroke="white" 
          strokeWidth="2" 
          strokeLinecap="round"
        />
      </motion.g>
      
      {/* Center dot */}
      <circle cx="12" cy="12" r="1.5" fill="white" />
    </svg>
  );
};

// Data interface matching your database schema
export interface FluoverseWrappedData {
  userName: string;
  year: number;
  
  // 1. Total Minutes Learned
  totalMinutes: number;
  
  // 3. Learning Age (days since first lesson)
  learningAgeDays: number;
  
  // 4. Total Scenarios Completed
  totalScenariosCompleted: number;
  
  // 5 & 6. Top Scenarios for selection
  topScenarios: Array<{
    lessonId: string;
    lessonTitle: string;
    completionCount: number;
    averageScore: number;
    totalTimeSpent: number;
  }>;
  
  // 8. Unique Words Used (mastered)
  uniqueWordsMastered: number;
  
  // 12. Personalized Message
  personalizedMessage?: string;
  biggestAchievement?: string;
}

interface FluoverseWrappedProps {
  data: FluoverseWrappedData;
  onClose?: () => void;
  onComplete?: () => void;
  onScenarioSelect?: (lessonId: string) => void; // For interactive selection
  selectedScenarioId?: string; // Pre-selected scenario
  autoPlay?: boolean;
  /**
   * Capture mode disables real-time timers and allows Puppeteer to drive the slide index.
   * Puppeteer sets:
   * - window.__fluoverseDesiredSlide (0-based)
   * - window.__fluoverseDesiredScenarioId (string, optional)
   */
  captureMode?: boolean;
  /**
   * Hide UI controls (close button, navigation arrows, progress indicator)
   * Useful for video preview or embedding
   */
  hideControls?: boolean;
  className?: string;
}

// Mobile-first slide component
const Slide = ({ children, index, currentSlide, direction = 1 }: { 
  children: React.ReactNode; 
  index: number; 
  currentSlide: number;
  direction?: number;
}) => {
  const isActive = index === currentSlide;
  
  // Different animation styles for each slide - creates variety
  const getVariants = (slideIndex: number) => {
    const variantType = slideIndex % 6; // Cycle through 6 different styles
    
    switch (variantType) {
      case 0: // Fade with scale
        return {
          enter: (dir: number) => ({
            opacity: 0,
            scale: 0.8,
            y: 30,
            filter: 'blur(8px)',
          }),
          center: {
            opacity: 1,
            scale: 1,
            y: 0,
            filter: 'blur(0px)',
          },
          exit: (dir: number) => ({
            opacity: 0,
            scale: 1.1,
            y: -30,
            filter: 'blur(8px)',
          }),
        };
      case 1: // Slide horizontal with rotation
        return {
          enter: (dir: number) => ({
            opacity: 0,
            x: dir > 0 ? 150 : -150,
            rotateY: dir > 0 ? 45 : -45,
            scale: 0.9,
          }),
          center: {
            opacity: 1,
            x: 0,
            rotateY: 0,
            scale: 1,
          },
          exit: (dir: number) => ({
            opacity: 0,
            x: dir > 0 ? -150 : 150,
            rotateY: dir > 0 ? -45 : 45,
            scale: 0.9,
          }),
        };
      case 2: // Slide vertical with scale
        return {
          enter: (dir: number) => ({
            opacity: 0,
            y: dir > 0 ? 100 : -100,
            scale: 0.85,
            filter: 'blur(10px)',
          }),
          center: {
            opacity: 1,
            y: 0,
            scale: 1,
            filter: 'blur(0px)',
          },
          exit: (dir: number) => ({
            opacity: 0,
            y: dir > 0 ? -100 : 100,
            scale: 0.85,
            filter: 'blur(10px)',
          }),
        };
      case 3: // Zoom with fade
        return {
          enter: (dir: number) => ({
            opacity: 0,
            scale: 0.6,
            rotateZ: dir > 0 ? 10 : -10,
            filter: 'blur(12px)',
          }),
          center: {
            opacity: 1,
            scale: 1,
            rotateZ: 0,
            filter: 'blur(0px)',
          },
          exit: (dir: number) => ({
            opacity: 0,
            scale: 1.3,
            rotateZ: dir > 0 ? -10 : 10,
            filter: 'blur(12px)',
          }),
        };
      case 4: // Slide diagonal
        return {
          enter: (dir: number) => ({
            opacity: 0,
            x: dir > 0 ? 120 : -120,
            y: dir > 0 ? 80 : -80,
            scale: 0.9,
            rotateZ: dir > 0 ? -5 : 5,
          }),
          center: {
            opacity: 1,
            x: 0,
            y: 0,
            scale: 1,
            rotateZ: 0,
          },
          exit: (dir: number) => ({
            opacity: 0,
            x: dir > 0 ? -120 : 120,
            y: dir > 0 ? -80 : 80,
            scale: 0.9,
            rotateZ: dir > 0 ? 5 : -5,
          }),
        };
      case 5: // 3D flip
        return {
          enter: (dir: number) => ({
            opacity: 0,
            rotateX: dir > 0 ? 90 : -90,
            scale: 0.8,
            filter: 'blur(8px)',
          }),
          center: {
            opacity: 1,
            rotateX: 0,
            scale: 1,
            filter: 'blur(0px)',
          },
          exit: (dir: number) => ({
            opacity: 0,
            rotateX: dir > 0 ? -90 : 90,
            scale: 0.8,
            filter: 'blur(8px)',
          }),
        };
      default:
        return {
          enter: (dir: number) => ({ opacity: 0, x: dir > 0 ? 100 : -100 }),
          center: { opacity: 1, x: 0 },
          exit: (dir: number) => ({ opacity: 0, x: dir > 0 ? -100 : 100 }),
        };
    }
  };
  
  const variants = getVariants(index);
  
  // Different transition timings for variety
  const getTransition = (slideIndex: number) => {
    const transitionType = slideIndex % 3;
    switch (transitionType) {
      case 0:
        return {
          type: "spring",
          stiffness: 300,
          damping: 30,
          mass: 0.8,
        };
      case 1:
        return {
          type: "spring",
          stiffness: 400,
          damping: 25,
          mass: 0.7,
        };
      case 2:
        return {
          type: "spring",
          stiffness: 250,
          damping: 35,
          mass: 0.9,
        };
      default:
        return {
          type: "spring",
          stiffness: 300,
          damping: 30,
        };
    }
  };
  
  return (
    <motion.div
      key={`slide-${index}`}
      custom={direction}
      variants={variants}
      initial="enter"
      animate={isActive ? "center" : "exit"}
      exit="exit"
      transition={getTransition(index)}
      className="absolute inset-0 flex items-center justify-center w-full"
      style={{ 
        pointerEvents: isActive ? 'auto' : 'none',
        zIndex: isActive ? 10 : 0,
        perspective: '1000px',
        transformStyle: 'preserve-3d',
      }}
    >
      {children}
    </motion.div>
  );
};

// 1. Welcome Slide
const WelcomeSlide = ({ userName, year }: { userName: string; year: number }) => (
  <div className="text-center px-6 py-8 w-full relative overflow-hidden flex flex-col" style={{ height: '100%', minHeight: '100vh' }}>
    {/* Animated hexagon pattern background */}
    <div className="welcome-slide-hex-bg"></div>
    
    {/* Ripple effect on enter */}
    {Array.from({ length: 2 }).map((_, i) => (
      <motion.div
        key={`ripple-${i}`}
        initial={{ scale: 0, opacity: 0.4 }}
        animate={{ scale: 3, opacity: 0 }}
        transition={{ duration: 2, delay: i * 0.7, ease: "easeOut" }}
        className="absolute rounded-full border-2 border-white/20"
        style={{
          left: '50%',
          top: '50%',
          transform: 'translate(-50%, -50%)',
          width: '150px',
          height: '150px',
          zIndex: 1,
        }}
      />
    ))}
    
    {/* Content wrapper with z-index */}
    <div className="relative z-10 flex flex-col flex-1">
      {/* Logo at the top - stays in place */}
      <motion.div
        initial={{ opacity: 0, scale: 0.8 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.6, delay: 0.1, type: "spring", stiffness: 200 }}
        className="inline-flex items-center justify-center pt-12 pb-4"
      >
        <Image
          src="/logo.svg"
          alt="Fluoverse Logo"
          width={150}
          height={150}
          className="rounded-2xl"
          priority
        />
      </motion.div>
      
      {/* Centered content wrapper - everything else centered vertically */}
      <div className="flex-1 flex flex-col justify-center items-center text-center">
        {/* 3D Year text effect */}
        <motion.div
          initial={{ opacity: 0, scale: 0.8, y: 30 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.2, type: "spring", stiffness: 100 }}
          className="relative mb-8"
          style={{
            transformStyle: 'preserve-3d',
            perspective: '1000px',
          }}
        >
        <h1
          className="text-9xl md:text-[12rem] font-black relative"
          style={{ 
            fontFamily: 'system-ui, -apple-system, sans-serif',
            transform: 'perspective(1000px) rotateX(15deg) rotateY(-5deg)',
            transformStyle: 'preserve-3d',
            textShadow: 
              /* Multiple shadow layers for 3D depth */
              '2px 2px 0px rgba(236, 72, 153, 0.8), ' +
              '4px 4px 0px rgba(219, 39, 119, 0.6), ' +
              '6px 6px 0px rgba(192, 132, 252, 0.4), ' +
              '8px 8px 0px rgba(236, 72, 153, 0.3), ' +
              '10px 10px 0px rgba(219, 39, 119, 0.2), ' +
              '12px 12px 0px rgba(192, 132, 252, 0.1), ' +
              '14px 14px 10px rgba(0, 0, 0, 0.4), ' +
              '0 0 40px rgb(255, 0, 251), ' +
              '0 0 80px rgba(192, 132, 252, 0.7), ' +
              '0 0 120px rgba(219, 39, 119, 0.5)',
            background: 'linear-gradient(135deg, #fce7f3 0%, #f9a8d4 15%, #ec4899 30%, #d946ef 45%, #a855f7 60%, #9333ea 75%, #7c3aed 90%, #6d28d9 100%)',
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
            backgroundClip: 'text',
            filter: 'drop-shadow(0 0 20px rgba(236, 72, 153, 0.6))',
          }}
        >
          {year}
        </h1>
        
        {/* Additional 3D depth shadow layer */}
        <div
          className="text-9xl md:text-[12rem] font-black absolute inset-0"
          style={{
            fontFamily: 'system-ui, -apple-system, sans-serif',
            transform: 'perspective(1000px) rotateX(15deg) rotateY(-5deg) translateZ(-20px)',
            transformStyle: 'preserve-3d',
            textShadow: 
              '12px 12px 0px rgba(236, 72, 153, 0.2), ' +
              '14px 14px 0px rgba(219, 39, 119, 0.15), ' +
              '16px 16px 0px rgba(192, 132, 252, 0.1), ' +
              '18px 18px 20px rgba(0, 0, 0, 0.5)',
            background: 'linear-gradient(135deg, rgba(236, 72, 153, 0.5), rgba(192, 132, 252, 0.4), rgba(219, 39, 119, 0.3))',
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
            backgroundClip: 'text',
            filter: 'blur(2px)',
            zIndex: -1,
          }}
        >
          {year}
        </div>
      </motion.div>
      
      <motion.p
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.5 }}
        className="text-4xl md:text-5xl text-white mb-6 font-bold tracking-tight"
        style={{ textShadow: '0 2px 20px rgba(0, 0, 0, 0.3)' }}
      >
        {userName === 'Your Class' ? "Vera's Class Fluoverse Year" : 'Your Fluoverse Year'}
      </motion.p>
      
      {/* Premium glassmorphic badge with shimmer */}
      <motion.div
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.6, delay: 0.7 }}
        className="inline-block bg-white/10 backdrop-blur-md rounded-2xl px-8 py-4 border border-white/20 shadow-xl relative overflow-hidden"
        style={{
          boxShadow: '0 8px 32px rgba(168, 85, 247, 0.4), inset 0 1px 0 rgba(255, 255, 255, 0.1)',
        }}
      >
        {/* Shimmer effect */}
        <motion.div
          initial={{ x: '-100%' }}
          animate={{ x: '200%' }}
          transition={{ duration: 2, repeat: Infinity, repeatDelay: 2 }}
          className="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent"
          style={{ transform: 'skewX(-15deg)' }}
        />
        <p className="text-2xl md:text-3xl text-white/90 font-semibold relative z-10">
          {userName}
        </p>
      </motion.div>
      </div>
    </div>
  </div>
);

// 1. Total Minutes Learned
const TotalMinutesSlide = ({ totalMinutes, userName }: { totalMinutes: number; userName?: string }) => {
  const [displayValue, setDisplayValue] = useState(0);
  const [hasStarted, setHasStarted] = useState(false);
  const slideRef = useRef<HTMLDivElement>(null);
  
  // Calculate top percentage based on minutes
  // Using a realistic distribution: more minutes = higher percentile (lower % = better)
  const calculateTopPercentage = (minutes: number): number => {
    if (minutes >= 3000) return 5;
    if (minutes >= 1800) return 10;
    if (minutes >= 1200) return 15;
    if (minutes >= 720) return 20;
    if (minutes >= 480) return 25;
    if (minutes >= 300) return 30;
    if (minutes >= 180) return 40;
    if (minutes >= 120) return 50;
    if (minutes >= 60) return 60;
    if (minutes >= 30) return 70;
    if (minutes >= 15) return 80;
    return 85;
  };
  
  const topPercentage = calculateTopPercentage(totalMinutes);
  
  useEffect(() => {
    if (!hasStarted && slideRef.current) {
      const observer = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting && !hasStarted) {
              setHasStarted(true);
              const duration = 2000;
              const steps = 60;
              const increment = totalMinutes / steps;
              const stepDuration = duration / steps;
              let currentStep = 0;
              
              const timer = setInterval(() => {
                currentStep++;
                const nextValue = Math.min(Math.floor(increment * currentStep), totalMinutes);
                setDisplayValue(nextValue);
                
                if (nextValue >= totalMinutes) {
                  clearInterval(timer);
                  setDisplayValue(totalMinutes);
                }
              }, stepDuration);
            }
          });
        },
        { threshold: 0.5 }
      );
      
      observer.observe(slideRef.current);
      return () => observer.disconnect();
    }
  }, [totalMinutes, hasStarted]);

  return (
    <div ref={slideRef} className="text-center px-6 py-8 w-full relative overflow-hidden">
      {/* Spinning clocks at random positions */}
      <div className="absolute inset-0 pointer-events-none z-0">
        {/* Clock 1 - Random position */}
        <div className="absolute top-8 left-12 opacity-20">
          <SpinningClock duration={7200} minuteDuration={3600} size={16} />
        </div>
        
        {/* Clock 2 - Random position */}
        <div className="absolute top-12 right-16 opacity-20">
          <SpinningClock duration={5400} minuteDuration={2700} size={16} />
        </div>
        
        {/* Clock 3 - Random position */}
        <div className="absolute bottom-14 left-8 opacity-20">
          <SpinningClock duration={9600} minuteDuration={4800} size={16} />
        </div>
        
        {/* Clock 4 - Random position */}
        <div className="absolute bottom-10 right-14 opacity-20">
          <SpinningClock duration={6600} minuteDuration={3300} size={16} />
        </div>
      </div>
      
      {/* Ripple effect on slide enter */}
      <motion.div
        initial={{ scale: 0, opacity: 0.6 }}
        animate={{ scale: 2, opacity: 0 }}
        transition={{ duration: 1.5, ease: "easeOut" }}
        className="absolute inset-0 rounded-full border-2 border-purple-400/30"
        style={{
          left: '50%',
          top: '50%',
          transform: 'translate(-50%, -50%)',
          width: '200px',
          height: '200px',
        }}
      />
      
      {/* Content */}
      <div className="relative z-10">
        <motion.div
          initial={{ scale: 0, rotate: -180 }}
          animate={{ scale: 1, rotate: 0 }}
          transition={{ duration: 0.6, delay: 0.3, type: "spring", stiffness: 150 }}
          className="w-32 h-32 mx-auto mb-8 rounded-2xl flex items-center justify-center bg-gradient-to-br from-blue-500 to-cyan-500 shadow-2xl relative overflow-hidden"
          style={{
            boxShadow: '0 0 30px rgba(59, 130, 246, 0.5), 0 0 60px rgba(147, 51, 234, 0.3)',
          }}
        >
          {/* Shimmer effect */}
          <motion.div
            animate={{ x: ['-100%', '200%'] }}
            transition={{ duration: 2, repeat: Infinity, repeatDelay: 3 }}
            className="absolute inset-0 bg-gradient-to-r from-transparent via-white/40 to-transparent"
            style={{
              animation: 'shimmer 1.5s ease-in-out infinite',
            }}
          />
          
          {/* Ripple effect around icon */}
          <motion.div
            animate={{ scale: [1, 1.3, 1.3], opacity: [0.6, 0, 0] }}
            transition={{ duration: 2, repeat: Infinity, ease: "easeOut" }}
            className="absolute inset-0 rounded-2xl border-2 border-white/40"
          />
          <Clock className="w-16 h-16 text-white relative z-10" style={{ filter: 'drop-shadow(0 0 8px rgba(255, 255, 255, 0.6))' }} />
        </motion.div>
        
        <motion.div
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.8, delay: 0.5, type: "spring", stiffness: 200 }}
          className="mb-6 flex items-center justify-center h-32 w-full"
        >
          <div className="flex items-center justify-center w-full relative">
            {/* Glow effect around clock */}
            <motion.div
              animate={{ 
                opacity: [0.3, 0.6, 0.3],
                scale: [1, 1.05, 1],
              }}
              transition={{ duration: 2, repeat: Infinity }}
              className="absolute inset-0 bg-gradient-to-r from-purple-400/20 via-pink-400/20 to-purple-400/20 blur-2xl rounded-full"
            />
            <Clock3D value={displayValue} />
          </div>
        </motion.div>
        
        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.7 }}
          className="text-3xl md:text-4xl text-white mb-4 font-bold tracking-tight"
        >
          {totalMinutes === 0 ? 'Your Journey Starts Here!' : 'Minutes Learned'}
        </motion.p>
        
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.6, delay: 0.9 }}
          className="text-xl md:text-2xl text-white/80 font-medium"
          style={{ textShadow: '0 1px 10px rgba(0, 0, 0, 0.3)' }}
        >
          {totalMinutes === 0 
            ? `2026 is your year to shine! 🌟 Start practicing on Fluoverse and watch your minutes add up. Every expert was once a beginner!`
            : userName === 'Your Class' 
              ? `Your class is in the top ${topPercentage}% of learners on Fluoverse!`
              : `You were in the top ${topPercentage}% of learners on Fluoverse!`}
        </motion.p>
      </div>
    </div>
  );
};

// Calendar Leaf-through Animation Component with Realistic Calendar Design
const CalendarLeafThrough = ({ days, onComplete }: { days: number; onComplete: () => void }) => {
  const [currentPage, setCurrentPage] = useState(0);
  const [isAnimating, setIsAnimating] = useState(true);
  const [isFading, setIsFading] = useState(false);
  // Flip through a reasonable number of pages (not all days, just enough to show the effect)
  const pagesToFlip = Math.min(days, 8); // Flip through 8 pages max, then fade

  useEffect(() => {
    if (!isAnimating) return;

    let currentIndex = 0;
    // Slower, more visible flip speed
    const flipSpeed = 200; // 200ms per flip - slower and more visible
    
    const flipNextPage = () => {
      if (currentIndex >= pagesToFlip - 1) {
        // After flipping some pages, start fading
        setIsFading(true);
        setTimeout(() => {
          setIsAnimating(false);
          onComplete();
        }, 800); // Fade duration
        return;
      }
      
      currentIndex++;
      setCurrentPage(currentIndex);
      
      // Continue flipping
      setTimeout(flipNextPage, flipSpeed);
    };

    // Start immediately - no delay
    const timeoutId = setTimeout(flipNextPage, 0);

    return () => clearTimeout(timeoutId);
  }, [isAnimating, pagesToFlip, onComplete]);

  if (!isAnimating && currentPage >= pagesToFlip - 1) {
    return null;
  }

  // Format day number with leading zero if needed
  const formatDayNumber = (num: number) => {
    return num.toString().padStart(2, '0');
  };

  // Get month abbreviation for display
  const getMonthName = () => {
    const months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return months[currentPage % 12];
  };

  return (
    <motion.div 
      className="fixed inset-0 flex items-center justify-center z-50 pointer-events-none bg-gradient-to-br from-purple-900/98 via-purple-800/98 to-pink-900/98 backdrop-blur-md"
      initial={{ opacity: 1 }}
      animate={{ opacity: isFading ? 0 : (isAnimating ? 1 : 0) }}
      transition={{ duration: 0.8, ease: "easeOut" }}
    >
      {/* Calendar pages with realistic flip animation */}
      <div className="relative" style={{ width: '18em', height: '18em' }}>
        {/* Only render visible pages for performance - current, next, and a few past */}
        {Array.from({ length: pagesToFlip }).map((_, index) => {
          const isActive = index === currentPage;
          const isPast = index < currentPage;
          const isNext = index === currentPage + 1;
          // Only render current page, next page, and up to 3 past pages for stacking effect
          const isVisible = (index >= currentPage - 3 && index <= currentPage + 1) || isActive;
          
          if (!isVisible) return null;

          return (
            <div
              key={index}
              className={`calendar-flip-container absolute inset-0 ${isActive ? 'flip' : ''}`}
              style={{
                zIndex: isActive ? pagesToFlip + 1 : pagesToFlip - index,
                opacity: isPast ? 0 : 1,
              }}
            >
              <div className="calendar-flipper w-full h-full">
                {/* Front of calendar page */}
                <div className="calendar-front w-full h-full">
                  <div className="calendar-page">
                    <div className="calendar-inner">
                      <h3>{getMonthName()}</h3>
                      <h1>{formatDayNumber(index + 1)}</h1>
                    </div>
                    <div className="calendar-pin calendar-left-pin"></div>
                    <div className="calendar-pin calendar-right-pin"></div>
                  </div>
                </div>

                {/* Back of calendar page */}
                <div className="calendar-back w-full h-full">
                  <div className="calendar-page calendar-page-back">
                    <div className="calendar-inner-back"></div>
                    <div className="calendar-pin calendar-left-pin"></div>
                    <div className="calendar-pin calendar-right-pin"></div>
                  </div>
                </div>
              </div>
            </div>
          );
        })}
      </div>
    </motion.div>
  );
};

// 3. Learning Age (Days since first lesson)
const LearningAgeSlide = ({ days }: { days: number }) => {
  const [displayValue, setDisplayValue] = useState(0);
  const [hasStarted, setHasStarted] = useState(false);
  const [showCalendarFlip, setShowCalendarFlip] = useState(true);
  const slideRef = useRef<HTMLDivElement>(null);
  
  useEffect(() => {
    if (!hasStarted && slideRef.current) {
      const observer = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting && !hasStarted) {
              setHasStarted(true);
              const duration = 2000;
              const steps = 60;
              const increment = days / steps;
              const stepDuration = duration / steps;
              let currentStep = 0;
              
              const timer = setInterval(() => {
                currentStep++;
                const nextValue = Math.min(Math.floor(increment * currentStep), days);
                setDisplayValue(nextValue);
                
                if (nextValue >= days) {
                  clearInterval(timer);
                  setDisplayValue(days);
                }
              }, stepDuration);
            }
          });
        },
        { threshold: 0.5 }
      );
      
      observer.observe(slideRef.current);
      return () => observer.disconnect();
    }
  }, [days, hasStarted]);

  return (
    <div ref={slideRef} className="text-center px-6 py-8 w-full relative overflow-hidden">
      {/* Calendar leaf-through animation - covers full screen */}
      {showCalendarFlip && (
        <CalendarLeafThrough 
          days={days} 
          onComplete={() => setShowCalendarFlip(false)}
        />
      )}

      {/* Content - only visible after calendar animation */}
      <motion.div 
        className="relative z-10"
        initial={{ opacity: 0 }}
        animate={{ opacity: showCalendarFlip ? 0 : 1 }}
        transition={{ duration: 0.5, delay: 0.3 }}
      >
        {/* Calendar display showing the days */}
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.6, delay: 0.5 }}
          className="flex justify-center mb-8"
        >
          <div className="relative mx-auto">
            <div className="calendar-page">
              <div className="calendar-inner">
                <h1>{days === 0 ? '✨' : displayValue.toString()}</h1>
              </div>
              <div className="calendar-pin calendar-left-pin"></div>
              <div className="calendar-pin calendar-right-pin"></div>
            </div>
          </div>
        </motion.div>
        
        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.7 }}
          className="text-3xl md:text-4xl text-white mb-4 font-bold tracking-tight"
        >
          {days === 0 ? 'Your First Day Awaits!' : <>Days Learning on <span className="text-purple-300">Fluoverse</span></>}
        </motion.p>
        
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.6, delay: 0.9 }}
          className="text-xl md:text-2xl text-white/80 font-medium"
          style={{ textShadow: '0 1px 10px rgba(0, 0, 0, 0.3)' }}
        >
          {days === 0 
            ? `Today is the perfect day to start! 🚀 Join Fluoverse and begin your language learning adventure. Your future self will thank you!`
            : `Every day counts. Keep pushing forward!`}
        </motion.p>
      </motion.div>
    </div>
  );
};

// 4. Total Scenarios Completed
// Helper function to get scenario image path based on title
const getScenarioImage = (title: string): string => {
  const lowerTitle = title.toLowerCase();
  if (lowerTitle.includes('restaurant') || lowerTitle.includes('cafe') || lowerTitle.includes('food')) {
    return '/benefits/Restaurant.png';
  }
  if (lowerTitle.includes('supermarket') || lowerTitle.includes('grocery') || lowerTitle.includes('store') || lowerTitle.includes('market') || lowerTitle.includes('laiki')) {
    return '/benefits/Supermarket.png';
  }
  if (lowerTitle.includes('christmas') || lowerTitle.includes('holiday')) {
    return '/benefits/Christmas.png';
  }
  if (lowerTitle.includes('english') || lowerTitle.includes('london')) {
    return '/benefits/English_City.jpg';
  }
  if (lowerTitle.includes('greek') || lowerTitle.includes('athens')) {
    return '/benefits/Greek_City.jpg';
  }
  if (lowerTitle.includes('spanish') || lowerTitle.includes('madrid') || lowerTitle.includes('barcelona')) {
    return '/benefits/Spanish_City.jpg';
  }
  // Default to restaurant if no match
  return '/benefits/Restaurant.png';
};

// Helper function to get scenario type for "master" text
const getScenarioType = (title: string): string => {
  const lowerTitle = title.toLowerCase();
  if (lowerTitle.includes('restaurant') || lowerTitle.includes('cafe') || lowerTitle.includes('food')) {
    return 'Restaurant';
  }
  if (lowerTitle.includes('supermarket') || lowerTitle.includes('grocery') || lowerTitle.includes('store') || lowerTitle.includes('market') || lowerTitle.includes('laiki')) {
    return 'Supermarket';
  }
  if (lowerTitle.includes('christmas') || lowerTitle.includes('holiday')) {
    return 'Christmas';
  }
  if (lowerTitle.includes('english') || lowerTitle.includes('london')) {
    return 'English';
  }
  if (lowerTitle.includes('greek') || lowerTitle.includes('athens')) {
    return 'Greek';
  }
  if (lowerTitle.includes('spanish') || lowerTitle.includes('madrid') || lowerTitle.includes('barcelona')) {
    return 'Spanish';
  }
  // Default to Restaurant if no match
  return 'Restaurant';
};

// Fire Effect Component - Full width at bottom of screen
// Using useMemo to prevent re-renders when parent component updates
const FireEffect = () => {
  const particles = useMemo(() => {
    return Array.from({ length: 50 }, (_, i) => ({
      id: i,
      delay: Math.random(),
      left: i / 50,
    }));
  }, []); // Empty deps array ensures this only runs once
  
  return (
    <div 
      className="fire" 
      style={{ 
        fontSize: '24px', 
        filter: 'blur(0.02em)', 
        position: 'fixed', 
        bottom: 0, 
        left: 0, 
        right: 0,
        width: '100%', 
        height: '12em', 
        pointerEvents: 'none', 
        zIndex: 1,
        margin: 0,
      }}
    >
      {particles.map((particle) => (
        <div
          key={particle.id}
          className="particle"
          style={{
            animationDelay: `${particle.delay}s`,
            left: `calc((100% - 5em) * ${particle.left})`,
          }}
        />
      ))}
    </div>
  );
};

const TotalScenariosSlide = ({ count, userName }: { count: number; userName?: string }) => {
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
              const duration = 2000;
              const steps = 60;
              const increment = count / steps;
              const stepDuration = duration / steps;
              let currentStep = 0;
              
              const timer = setInterval(() => {
                currentStep++;
                const nextValue = Math.min(Math.floor(increment * currentStep), count);
                setDisplayValue(nextValue);
                
                if (nextValue >= count) {
                  clearInterval(timer);
                  setDisplayValue(count);
                }
              }, stepDuration);
            }
          });
        },
        { threshold: 0.5 }
      );
      
      observer.observe(slideRef.current);
      return () => observer.disconnect();
    }
  }, [count, hasStarted]);

  return (
    <>
      {/* Full screen background */}
      <div
        className="fixed inset-0"
        style={{
          backgroundColor: '#e5e5f7',
          opacity: 0.8,
          backgroundImage: 'radial-gradient(circle at center center, #bd00ff, #e5e5f7), repeating-radial-gradient(circle at center center, #bd00ff, #bd00ff, 10px, transparent 20px, transparent 10px)',
          backgroundBlendMode: 'multiply',
          zIndex: 0,
        }}
      />
      
      <div 
        ref={slideRef} 
        className="text-center px-6 py-8 w-full relative z-10"
      >
        {/* Content */}
        <div className="relative z-10">
        <motion.div
          initial={{ scale: 0, rotate: -180 }}
          animate={{ scale: 1, rotate: 0 }}
          transition={{ duration: 0.6, delay: 0.3, type: "spring", stiffness: 150 }}
          className="w-32 h-32 mx-auto mb-8 rounded-2xl flex items-center justify-center bg-gradient-to-br from-purple-500 to-pink-500 shadow-2xl relative overflow-hidden"
          style={{
            boxShadow: '0 0 30px rgba(192, 132, 252, 0.5), 0 0 60px rgba(236, 72, 153, 0.3), inset 0 0.5px rgba(255, 255, 255, 0.5)',
          }}
        >
          {/* Ripple effect */}
          <motion.div
            animate={{ scale: [1, 1.4, 1.4], opacity: [0.5, 0, 0] }}
            transition={{ duration: 2, repeat: Infinity, ease: "easeOut", delay: 0.5 }}
            className="absolute inset-0 rounded-2xl border-2 border-white/40"
          />
          
          {/* Shimmer effect */}
          <motion.div
            animate={{ x: ['-100%', '200%'] }}
            transition={{ duration: 2, repeat: Infinity, repeatDelay: 3 }}
            className="absolute inset-0 bg-gradient-to-r from-transparent via-white/40 to-transparent"
            style={{
              animation: 'shimmer 1.5s ease-in-out infinite',
            }}
          />
          <BookOpen className="w-16 h-16 text-white relative z-10" style={{ filter: 'drop-shadow(0 0 8px rgba(255, 255, 255, 0.6))' }} />
        </motion.div>
        
        <motion.div
          initial={{ opacity: 0, y: 20, scale: 0.9 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          transition={{ duration: 0.6, delay: 0.5, type: "spring", stiffness: 200 }}
          className="text-8xl md:text-9xl font-black mb-6 relative"
          style={{
            perspective: '1000px',
            transformStyle: 'preserve-3d',
          }}
        >
          {/* 3D depth shadow layers */}
          <div 
            className="absolute inset-0"
            style={{
              transform: 'translateZ(-50px)',
              textShadow: `
                2px 2px 0px rgba(217, 70, 239, 0.3),
                4px 4px 0px rgba(217, 70, 239, 0.25),
                6px 6px 0px rgba(217, 70, 239, 0.2),
                8px 8px 0px rgba(244, 114, 182, 0.15),
                10px 10px 0px rgba(244, 114, 182, 0.1),
                12px 12px 20px rgba(0, 0, 0, 0.4)
              `,
              color: 'transparent',
              WebkitTextStroke: '1px rgba(217, 70, 239, 0.2)',
            }}
          >
            {displayValue.toLocaleString()}
          </div>
          
          {/* Main 3D text with gradient and glow */}
          <div
            style={{
              transform: 'translateZ(20px)',
              textShadow: `
                0 1px 0 rgba(255, 255, 255, 0.8),
                0 2px 0 rgba(255, 255, 255, 0.6),
                0 3px 5px rgba(217, 70, 239, 0.5),
                0 4px 10px rgba(244, 114, 182, 0.4),
                0 5px 15px rgba(192, 132, 252, 0.3),
                0 0 30px rgba(217, 70, 239, 0.6),
                0 0 60px rgba(244, 114, 182, 0.4),
                0 0 90px rgba(192, 132, 252, 0.3)
              `,
              background: 'linear-gradient(to bottom, #ffffff, #fae8ff, #fce7f3, #ec4899)',
              WebkitBackgroundClip: 'text',
              WebkitTextFillColor: 'transparent',
              backgroundClip: 'text',
              position: 'relative',
              zIndex: 1,
            }}
          >
            {count === 0 ? '∞' : displayValue.toLocaleString()}
          </div>
        </motion.div>
        
        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.7 }}
          className="text-3xl md:text-4xl text-white mb-4 font-bold tracking-tight"
          style={{ textShadow: '0 2px 15px rgba(0, 0, 0, 0.4)' }}
        >
          {count === 0 ? 'Unlimited Potential!' : 'Sessions Completed'}
        </motion.p>
        
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.6, delay: 0.9 }}
          className="text-xl md:text-2xl text-white/80 font-medium"
        >
          {count === 0
            ? `Your first session is waiting for you! 🎯 Start practicing on Fluoverse and unlock your language learning potential. The journey of a thousand miles begins with a single step!`
            : userName === 'Your Class'
              ? `Your class completed ${count} ${count === 1 ? 'session' : 'sessions'}. They were on fire!`
              : `You completed ${count} ${count === 1 ? 'session' : 'sessions'}. You were on fire!`}
        </motion.p>
        </div>
      </div>
      
      {/* Fire effect at bottom of screen */}
      <FireEffect />
    </>
  );
};

// 5. Interactive: Select Your #1 Scenario
const SelectScenarioSlide = ({ 
  scenarios, 
  onSelect,
  selectedId,
  userName
}: { 
  scenarios: FluoverseWrappedData['topScenarios'];
  onSelect: (lessonId: string) => void;
  selectedId?: string;
  userName?: string;
}) => {
  const [selected, setSelected] = useState<string | null>(selectedId || null);

  const handleSelect = (lessonId: string) => {
    setSelected(lessonId);
    onSelect(lessonId);
  };

  // Check if all scenarios have zero completions
  const allZeros = scenarios.length > 0 && scenarios.every(s => s.completionCount === 0 && s.totalTimeSpent === 0);
  
  if (allZeros || scenarios.length === 0) {
    return (
      <div className="text-center px-6 py-8 w-full relative">
        <motion.div
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.8, delay: 0.3 }}
          className="w-32 h-32 mx-auto mb-8 rounded-full flex items-center justify-center bg-gradient-to-br from-yellow-400 to-orange-500 shadow-2xl"
        >
          <Sparkles className="w-16 h-16 text-white" />
        </motion.div>
        
        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.5 }}
          className="text-4xl md:text-5xl text-white mb-6 font-bold tracking-tight"
          style={{ textShadow: '0 2px 20px rgba(0, 0, 0, 0.3)' }}
        >
          Your First Scenario Awaits! 🎯
        </motion.p>
        
        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.7 }}
          className="text-xl md:text-2xl text-white/90 font-medium max-w-2xl mx-auto"
          style={{ textShadow: '0 2px 10px rgba(0, 0, 0, 0.3)' }}
        >
          Start your language learning journey on Fluoverse! Your first scenario is waiting for you. Every expert was once a beginner - your journey to fluency starts now! 🚀
        </motion.p>
      </div>
    );
  }
  
  return (
    <div className="text-center px-6 py-8 w-full relative">
      <motion.p
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.2 }}
        className="text-4xl md:text-5xl text-white mb-10 font-bold tracking-tight"
        style={{ textShadow: '0 2px 20px rgba(0, 0, 0, 0.3)' }}
      >
        {userName === 'Your Class' ? "Select Your Class's and Your Students' #1 Scenario" : "Select Your #1 Scenario"}
      </motion.p>
      <div className="space-y-4 max-h-[400px] overflow-y-auto pr-2">
        {scenarios.slice(0, 5).map((scenario, index) => (
          <motion.button
            key={scenario.lessonId}
            initial={{ opacity: 0, x: -50 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.5, delay: 0.3 + index * 0.1, type: "spring" }}
            onClick={() => handleSelect(scenario.lessonId)}
            className={`w-full text-left p-6 rounded-2xl border-2 transition-all relative overflow-hidden ${
              selected === scenario.lessonId
                ? 'bg-white/20 backdrop-blur-md border-white shadow-2xl scale-[1.02]'
                : 'bg-white/10 backdrop-blur-sm border-white/30 hover:bg-white/15 hover:border-white/40'
            }`}
          >
            {/* Glow effect for selected */}
            {selected === scenario.lessonId && (
              <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                className="absolute inset-0 bg-gradient-to-r from-purple-500/20 via-pink-500/20 to-transparent blur-xl -z-10"
              />
            )}
            
            {/* Shine effect */}
            <motion.div
              animate={{ x: selected === scenario.lessonId ? ['-100%', '200%'] : '-100%' }}
              transition={{ duration: 1.5, repeat: selected === scenario.lessonId ? Infinity : 0, repeatDelay: 2 }}
              className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent -z-10"
            />
            
            <div className="flex items-center justify-between relative z-10">
              <div className="flex-1">
                <div className="text-white font-bold text-xl md:text-2xl mb-2">{scenario.lessonTitle}</div>
                <div className="text-white/70 text-sm">
                  {scenario.completionCount} {scenario.completionCount === 1 ? 'completion' : 'completions'}
                </div>
              </div>
              {selected === scenario.lessonId && (
                <motion.div
                  initial={{ scale: 0, rotate: -180 }}
                  animate={{ scale: 1, rotate: 0 }}
                  transition={{ type: "spring", stiffness: 200 }}
                  className="w-10 h-10 rounded-full bg-gradient-to-br from-purple-500 to-pink-500 flex items-center justify-center shadow-lg"
                >
                  <Target className="w-6 h-6 text-white" />
                </motion.div>
              )}
            </div>
          </motion.button>
        ))}
      </div>
    </div>
  );
};

// 5b. Static version for video capture (non-interactive)
const TopLessonPreviewSlide = ({ 
  scenario,
  userName
}: { 
  scenario: FluoverseWrappedData['topScenarios'][0] | undefined;
  userName?: string;
}) => {
  // If no scenario or all zeros, show encouraging message
  if (!scenario || (scenario.completionCount === 0 && scenario.totalTimeSpent === 0)) {
    return (
      <div className="relative w-full h-full min-h-screen flex flex-col items-center justify-center px-6 py-8 overflow-hidden">
        {/* Gradient background */}
        <div className="absolute inset-0 bg-gradient-to-br from-purple-600 via-pink-600 to-orange-600" />
        
        {/* Content */}
        <div className="relative z-10 w-full text-center">
          <motion.div
            initial={{ opacity: 0, scale: 0.8 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 0.8, delay: 0.3 }}
            className="w-32 h-32 mx-auto mb-8 rounded-full flex items-center justify-center bg-gradient-to-br from-yellow-400 to-orange-500 shadow-2xl"
          >
            <Sparkles className="w-16 h-16 text-white" />
          </motion.div>
          
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.7, delay: 0.5 }}
            className="text-4xl md:text-5xl text-white mb-6 font-black tracking-tight"
            style={{ textShadow: '0 2px 20px rgba(0, 0, 0, 0.3)' }}
          >
            Your First Scenario Awaits! 🎯
          </motion.p>
          
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.7, delay: 0.7 }}
            className="text-xl md:text-2xl text-white/90 font-medium max-w-2xl mx-auto"
            style={{ textShadow: '0 2px 10px rgba(0, 0, 0, 0.3)' }}
          >
            Start your language learning journey on Fluoverse! Your first scenario is waiting for you. Every expert was once a beginner - your journey to fluency starts now! 🚀
          </motion.p>
        </div>
      </div>
    );
  }

  return (
    <div className="relative w-full h-full min-h-screen flex flex-col items-center justify-center px-6 py-8 overflow-hidden">
      {/* Full background image with transition animation */}
      <motion.div 
        className="absolute inset-0 z-0"
        initial={{ opacity: 0, scale: 1.1 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 1, ease: "easeOut" }}
      >
        <Image
          src={getScenarioImage(scenario.lessonTitle)}
          alt={scenario.lessonTitle}
          fill
          className="object-cover"
          sizes="100vw"
          priority
        />
      </motion.div>
      
      {/* Content */}
      <div className="relative z-10 w-full text-center">
        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.7, delay: 0.3 }}
          className="text-4xl md:text-5xl text-white mb-10 font-black tracking-tight"
          style={{ 
            textShadow: '0 2px 8px rgba(0, 0, 0, 0.5)',
          }}
        >
          {userName === 'Your Class' ? "Your Class's #1 Scenario" : "Your #1 Scenario"}
        </motion.p>
        
        <motion.div
          initial={{ opacity: 0, y: 30, scale: 0.95 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          transition={{ duration: 0.8, delay: 0.5, type: "spring", stiffness: 100 }}
          className="relative bg-white/20 backdrop-blur-xl rounded-3xl p-8 border-2 border-white/30 shadow-2xl overflow-hidden"
        >
          {/* Glass effect shine */}
          <motion.div
            animate={{ x: ['-100%', '200%'] }}
            transition={{ duration: 3, repeat: Infinity, repeatDelay: 2 }}
            className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent -z-10"
          />
          
          <div className="relative z-10">
            <div 
              className="text-white font-black text-3xl md:text-4xl mb-4"
              style={{ 
                textShadow: '0 2px 8px rgba(0, 0, 0, 0.5)',
              }}
            >
              {scenario.lessonTitle}
            </div>
            <div 
              className="text-white font-bold text-xl md:text-2xl"
              style={{ 
                textShadow: '0 2px 6px rgba(0, 0, 0, 0.5)',
              }}
            >
              {userName === 'Your Class'
                ? `Your students are ${getScenarioType(scenario.lessonTitle)} masters`
                : `You are a ${getScenarioType(scenario.lessonTitle)} master`}
            </div>
          </div>
        </motion.div>
      </div>
    </div>
  );
};

// 5c. Scenarios to Start With - For users with zero stats (encouragement mode)
const ScenariosToStartSlide = ({ scenarios, userName }: { scenarios: FluoverseWrappedData['topScenarios']; userName?: string }) => {
  // Show first 3 scenarios
  const displayScenarios = scenarios.slice(0, 3);
  
  return (
    <div className="text-center px-4 py-4 w-full relative min-h-screen flex flex-col items-center justify-center">
      <motion.p
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.2 }}
        className="text-2xl md:text-3xl text-white mb-4 font-bold tracking-tight"
        style={{ textShadow: '0 2px 20px rgba(0, 0, 0, 0.3)' }}
      >
        Scenarios You Can Start With! 🎯
      </motion.p>
      
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3 w-full max-w-3xl mb-4">
        {displayScenarios.map((scenario, index) => (
          <motion.div
            key={scenario.lessonId}
            initial={{ opacity: 0, y: 30, scale: 0.9 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            transition={{ duration: 0.6, delay: 0.4 + index * 0.2, type: "spring" }}
            className="relative bg-white/10 backdrop-blur-md rounded-xl overflow-hidden border-2 border-white/20 shadow-xl"
          >
            {/* Scenario Image */}
            <div className="relative h-48 w-full">
              <Image
                src={getScenarioImage(scenario.lessonTitle)}
                alt={scenario.lessonTitle}
                fill
                className="object-cover"
                sizes="(max-width: 768px) 100vw, 300px"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent" />
            </div>
            
            {/* Scenario Title */}
            <div className="p-2">
              <p className="text-sm font-bold text-white" style={{ textShadow: '0 2px 10px rgba(0, 0, 0, 0.5)' }}>
                {scenario.lessonTitle}
              </p>
            </div>
          </motion.div>
        ))}
      </div>
      
      <motion.p
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 1.0 }}
        className="text-base md:text-lg text-white/90 font-medium max-w-2xl"
        style={{ textShadow: '0 2px 10px rgba(0, 0, 0, 0.3)' }}
      >
        Start practicing these scenarios on Fluoverse today! 🚀
      </motion.p>
    </div>
  );
};

// 6. #1 Scenario + Completion Stats
const TopScenarioSlide = ({ scenario, userName }: { scenario: FluoverseWrappedData['topScenarios'][0]; userName?: string }) => {
  // If scenario has no completions, show encouraging message
  if (scenario.completionCount === 0 && scenario.totalTimeSpent === 0) {
    return (
      <div className="text-center px-6 py-8 w-full max-w-md mx-auto relative">
        <motion.div
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.8, delay: 0.3 }}
          className="w-32 h-32 mx-auto mb-8 rounded-full flex items-center justify-center bg-gradient-to-br from-yellow-400 to-orange-500 shadow-2xl"
        >
          <Sparkles className="w-16 h-16 text-white" />
        </motion.div>
        
        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.5 }}
          className="text-4xl md:text-5xl text-white mb-6 font-bold tracking-tight"
          style={{ textShadow: '0 2px 20px rgba(0, 0, 0, 0.3)' }}
        >
          Your First Scenario Awaits! 🎯
        </motion.p>
        
        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.7 }}
          className="text-xl md:text-2xl text-white/90 font-medium mb-6"
          style={{ textShadow: '0 2px 10px rgba(0, 0, 0, 0.3)' }}
        >
          Start your language learning journey on Fluoverse! Your first scenario is waiting for you. Every expert was once a beginner - your journey to fluency starts now! 🚀
        </motion.p>
        
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.9 }}
          className="bg-white/15 backdrop-blur-xl rounded-3xl p-8 border-2 border-white/20 shadow-2xl"
        >
          <p className="text-2xl md:text-3xl font-bold text-white mb-4">
            {scenario.lessonTitle}
          </p>
          <p className="text-lg text-white/80">
            Ready to start? This could be your first completed scenario! 🌟
          </p>
        </motion.div>
      </div>
    );
  }
  
  return (
    <div className="text-center px-6 py-8 w-full max-w-md mx-auto relative">
      <motion.p
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.2 }}
        className="text-4xl md:text-5xl text-white mb-10 font-bold tracking-tight"
        style={{ textShadow: '0 2px 20px rgba(0, 0, 0, 0.3)' }}
      >
        {userName === 'Your Class' ? "Your Class's #1 Scenario" : "Your #1 Scenario"}
      </motion.p>
    <motion.div
      initial={{ opacity: 0, scale: 0.95, y: 20 }}
      animate={{ opacity: 1, scale: 1, y: 0 }}
      transition={{ duration: 0.7, delay: 0.4, type: "spring" }}
      className="bg-white/15 backdrop-blur-xl rounded-3xl p-10 border-2 border-white/20 shadow-2xl relative overflow-hidden"
    >
      {/* Glow effect */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 1, delay: 0.6 }}
        className="absolute inset-0 bg-gradient-to-br from-purple-400/45 via-pink-400/40 to-purple-300/35 blur-2xl -z-10"
      />
      
      {/* Shine effect */}
      <motion.div
        animate={{ x: ['-100%', '200%'] }}
        transition={{ duration: 2.5, repeat: Infinity, repeatDelay: 3 }}
        className="absolute inset-0 bg-gradient-to-r from-transparent via-white/15 to-transparent -z-10"
      />
      
      <div className="relative z-10">
        {/* Scenario Image */}
        <motion.div
          initial={{ opacity: 0, scale: 0.8, rotateY: -15 }}
          animate={{ opacity: 1, scale: 1, rotateY: 0 }}
          transition={{ duration: 0.8, delay: 0.5, type: "spring", stiffness: 100 }}
          className="relative mb-8 rounded-2xl overflow-hidden"
          style={{ height: '300px', perspective: '1000px' }}
        >
          <Image
            src={getScenarioImage(scenario.lessonTitle)}
            alt={scenario.lessonTitle}
            fill
            className="object-cover"
            sizes="(max-width: 768px) 100vw, 400px"
          />
          {/* Overlay gradient for better text readability */}
          <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent" />
          {/* Subtle border glow */}
          <div className="absolute inset-0 border-2 border-white/20 rounded-2xl pointer-events-none" />
        </motion.div>
        
        <p className="text-3xl md:text-4xl font-bold text-white mb-8" style={{ textShadow: '0 2px 15px rgba(0, 0, 0, 0.4)' }}>
          {scenario.lessonTitle}
        </p>
        
        <div className="space-y-5 text-left bg-white/5 rounded-2xl p-6 backdrop-blur-sm border border-white/10">
          <div className="flex justify-between items-center">
            <span className="text-white/80 font-medium text-xl">Completions:</span>
            <span className="text-white font-bold text-xl">{scenario.completionCount}</span>
          </div>
          <div className="flex justify-between items-center">
            <span className="text-white/80 font-medium text-xl">Average Score:</span>
            <span className="text-white font-bold text-xl">{scenario.averageScore}%</span>
          </div>
          <div className="flex justify-between items-center">
            <span className="text-white/80 font-medium text-xl">Time Spent:</span>
            <span className="text-white font-bold text-xl">{Math.floor(scenario.totalTimeSpent / 60)} min</span>
          </div>
        </div>
      </div>
    </motion.div>
  </div>
  );
};

// Popping Words Component
const PoppingWords = ({ count }: { count: number }) => {
  // Common language learning words (Spanish/English mix for example)
  const commonWords = [
    'hola', 'gracias', 'por favor', 'adiós', 'sí', 'no', 'buenos días', 'buenas noches',
    'agua', 'comida', 'casa', 'amigo', 'familia', 'trabajo', 'tiempo', 'día', 'noche',
    'restaurante', 'menú', 'mesa', 'servicio', 'propina', 'cuenta', 'café', 'vino',
    'supermercado', 'comprar', 'precio', 'dinero', 'tarjeta', 'efectivo', 'bolsa',
    'ciudad', 'calle', 'hotel', 'taxi', 'aeropuerto', 'tren', 'autobús', 'mapa',
    'hablar', 'entender', 'aprender', 'practicar', 'estudiar', 'leer', 'escribir',
    'pregunta', 'respuesta', 'conversación', 'idioma', 'palabra', 'frase', 'oración'
  ];
  
  const words = useMemo(() => {
    // Show exactly 5 words
    const numWords = 5;
    const selectedWords: Array<{ word: string; left: number; top: number; delay: number }> = [];
    
    // Define safe zones to avoid content area
    // Content is roughly: icon (5-12%), number (18-30%), title (35-42%), description (45-52%)
    // Safe zones: top corners, sides, bottom
    const safeZones = [
      { left: 5, top: 5, width: 25, height: 12 },      // Top-left
      { left: 70, top: 5, width: 25, height: 12 },    // Top-right
      { left: 5, top: 55, width: 20, height: 20 },     // Bottom-left
      { left: 75, top: 55, width: 20, height: 20 },    // Bottom-right
      { left: 0, top: 15, width: 12, height: 40 },     // Left edge
      { left: 88, top: 15, width: 12, height: 40 },    // Right edge
    ];
    
    const usedPositions: Array<{ left: number; top: number }> = [];
    const minDistance = 15; // Minimum distance between words (in %)
    
    for (let i = 0; i < numWords; i++) {
      let attempts = 0;
      let position: { left: number; top: number } | null = null;
      
      // Try to find a non-overlapping position
      while (attempts < 50 && !position) {
        const zone = safeZones[Math.floor(Math.random() * safeZones.length)];
        const candidateLeft = zone.left + Math.random() * zone.width;
        const candidateTop = zone.top + Math.random() * zone.height;
        
        // Check if this position is far enough from other words
        const tooClose = usedPositions.some(used => {
          const distance = Math.sqrt(
            Math.pow(candidateLeft - used.left, 2) + Math.pow(candidateTop - used.top, 2)
          );
          return distance < minDistance;
        });
        
        if (!tooClose) {
          position = { left: candidateLeft, top: candidateTop };
          usedPositions.push(position);
        }
        
        attempts++;
      }
      
      // Fallback to a safe position if we couldn't find one
      if (!position) {
        const zone = safeZones[i % safeZones.length];
        position = {
          left: zone.left + (i * 5) % zone.width,
          top: zone.top + (i * 3) % zone.height,
        };
        usedPositions.push(position);
      }
      
      selectedWords.push({
        word: commonWords[Math.floor(Math.random() * commonWords.length)],
        left: position.left,
        top: position.top,
        delay: i * 0.4, // Staggered delay - one by one (0s, 0.4s, 0.8s, 1.2s, 1.6s)
      });
    }
    
    return selectedWords;
  }, [count]);
  
  return (
    <div className="absolute inset-0 overflow-hidden pointer-events-none z-0">
      {words.map((wordData, index) => (
        <motion.div
          key={index}
          className="absolute text-white/70 text-sm md:text-base font-medium"
          style={{
            left: `${wordData.left}%`,
            top: `${wordData.top}%`,
          }}
          initial={{ scale: 0, opacity: 0 }}
          animate={{ 
            scale: 1,
            opacity: 0.7,
          }}
          transition={{
            duration: 0.6,
            delay: wordData.delay,
            type: "spring",
            stiffness: 200,
          }}
        >
          {wordData.word}
        </motion.div>
      ))}
    </div>
  );
};

// 8. Unique Words Used (Mastered)
const UniqueWordsSlide = ({ count, userName }: { count: number; userName?: string }) => {
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
              const duration = 2000;
              const steps = 60;
              const increment = count / steps;
              const stepDuration = duration / steps;
              let currentStep = 0;
              
              const timer = setInterval(() => {
                currentStep++;
                const nextValue = Math.min(Math.floor(increment * currentStep), count);
                setDisplayValue(nextValue);
                
                if (nextValue >= count) {
                  clearInterval(timer);
                  setDisplayValue(count);
                }
              }, stepDuration);
            }
          });
        },
        { threshold: 0.5 }
      );
      
      observer.observe(slideRef.current);
      return () => observer.disconnect();
    }
  }, [count, hasStarted]);

  return (
    <div ref={slideRef} className="text-center px-6 py-8 w-full relative overflow-hidden">
      {/* Popping words in background */}
      {/* Content */}
      <div className="relative z-10">
        <motion.div
          initial={{ scale: 0, rotate: -180 }}
          animate={{ scale: 1, rotate: 0 }}
          transition={{ duration: 0.6, delay: 0.3, type: "spring", stiffness: 150 }}
          className="w-32 h-32 mx-auto mb-8 rounded-2xl flex items-center justify-center bg-gradient-to-br from-purple-500 to-pink-500 shadow-2xl relative overflow-hidden"
        >
          {/* Shine effect */}
          <motion.div
            animate={{ x: ['-100%', '200%'] }}
            transition={{ duration: 2, repeat: Infinity, repeatDelay: 3 }}
            className="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent"
          />
          <Sparkles className="w-16 h-16 text-white relative z-10" />
        </motion.div>
        
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.5 }}
          className="text-8xl md:text-9xl font-black mb-6 relative"
          style={{
            perspective: '1000px',
            transformStyle: 'preserve-3d',
          }}
        >
          {/* 3D depth shadow layers */}
          <div 
            className="absolute inset-0"
            style={{
              transform: 'translateZ(-50px)',
              textShadow: `
                2px 2px 0px rgba(217, 70, 239, 0.3),
                4px 4px 0px rgba(217, 70, 239, 0.25),
                6px 6px 0px rgba(217, 70, 239, 0.2),
                8px 8px 0px rgba(244, 114, 182, 0.15),
                10px 10px 0px rgba(244, 114, 182, 0.1),
                12px 12px 20px rgba(0, 0, 0, 0.4)
              `,
              color: 'transparent',
              WebkitTextStroke: '1px rgba(217, 70, 239, 0.2)',
            }}
          >
            {displayValue.toLocaleString()}
          </div>
          
          {/* Main 3D text with gradient and glow */}
          <div
            style={{
              transform: 'translateZ(20px)',
              textShadow: `
                0 1px 0 rgba(255, 255, 255, 0.8),
                0 2px 0 rgba(255, 255, 255, 0.6),
                0 3px 5px rgba(217, 70, 239, 0.5),
                0 4px 10px rgba(244, 114, 182, 0.4),
                0 5px 15px rgba(192, 132, 252, 0.3),
                0 0 30px rgba(217, 70, 239, 0.6),
                0 0 60px rgba(244, 114, 182, 0.4),
                0 0 90px rgba(192, 132, 252, 0.3)
              `,
              background: 'linear-gradient(to bottom, #ffffff, #fae8ff, #fce7f3, #ec4899)',
              WebkitBackgroundClip: 'text',
              WebkitTextFillColor: 'transparent',
              backgroundClip: 'text',
              position: 'relative',
              zIndex: 1,
            }}
          >
            {count === 0 ? '∞' : displayValue.toLocaleString()}
          </div>
        </motion.div>
        
        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.7 }}
          className="text-3xl md:text-4xl text-white mb-4 font-bold tracking-tight"
          style={{ textShadow: '0 2px 15px rgba(0, 0, 0, 0.4)' }}
        >
          {count === 0 ? 'Words Await You!' : 'Unique Words Used'}
        </motion.p>
        
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.6, delay: 0.9 }}
          className="text-xl md:text-2xl text-white/80 font-medium"
        >
          {count === 0
            ? `Start learning on Fluoverse and watch your vocabulary grow! 📚 Every word you learn opens new doors. Your journey to fluency begins with your first word!`
            : userName === 'Your Class'
              ? "Your students are on their way to becoming dictionaries!"
              : "You're on your way to becoming a dictionary!"}
        </motion.p>
      </div>
    </div>
  );
};

// Starry Background Component
const StarryBackground = () => {
  const generateBoxShadow = (count: number): string => {
    const shadows: string[] = [];
    for (let i = 0; i < count; i++) {
      const x = Math.floor(Math.random() * 2000);
      const y = Math.floor(Math.random() * 2000);
      shadows.push(`${x}px ${y}px #FFF`);
    }
    return shadows.join(', ');
  };

  const smallShadows = useMemo(() => generateBoxShadow(700), []);
  const mediumShadows = useMemo(() => generateBoxShadow(200), []);
  const bigShadows = useMemo(() => generateBoxShadow(100), []);

  return (
    <div className="starry-background" style={{ opacity: 1 }}>
      <div 
        className="stars-layer"
        style={{
          width: '1px',
          height: '1px',
          boxShadow: smallShadows,
        }}
      />
      <div 
        className="stars-layer-medium"
        style={{
          width: '2px',
          height: '2px',
          boxShadow: mediumShadows,
        }}
      />
      <div 
        className="stars-layer-big"
        style={{
          width: '3px',
          height: '3px',
          boxShadow: bigShadows,
        }}
      />
    </div>
  );
};

// Champagne Glass Component
const ChampagneGlass = ({ position }: { position: 'left' | 'right' }) => {
  return (
    <div className={`champagne-container ${position === 'left' ? 'left-glass' : 'right-glass'}`}>
      <div className="champagne-glass">
        <div className="champagne-liquid"></div>
        <div className="champagne-bubbles one"></div>
        <div className="champagne-bubbles two"></div>
        <div className="champagne-bubbles three"></div>
        <div className="champagne-bubbles four"></div>
        <div className="champagne-bubbles five"></div>
        <div className="champagne-bubbles six"></div>
      </div>
      <div className="champagne-stand"></div>
    </div>
  );
};

// New Year Animation Component (2025 to 2026)
const NewYearAnimation = () => {
  return (
    <div className="new-year-container">
      <div className="feliz">Happy New Year!</div>
      <div className="ano_novo">
        <span className="cinco">2025</span>
        <span className="seis">2026</span>
      </div>
      <div className="balao"></div>
      <div className="fogos">
        <div className="f1">
          <span><i></i></span>
          <span><i></i></span>
          <span><i></i></span>
        </div>
        <div className="f2">
          <span><i></i></span>
          <span><i></i></span>
          <span><i></i></span>
        </div>
        <div className="f3">
          <span><i></i></span>
          <span><i></i></span>
          <span><i></i></span>
        </div>
        <div className="f4">
          <span><i></i></span>
          <span><i></i></span>
          <span><i></i></span>
        </div>
      </div>
    </div>
  );
};

// 12. Personalized Message
const PersonalizedMessageSlide = ({ 
  userName, 
  message, 
  achievement,
  totalMinutes = 0,
  totalScenariosCompleted = 0
}: { 
  userName: string; 
  message?: string;
  achievement?: string;
  totalMinutes?: number;
  totalScenariosCompleted?: number;
}) => {
  // Check if user has zero stats (encouragement mode)
  const isEncouragementMode = totalMinutes === 0 && totalScenariosCompleted === 0;
  
  return (
    <div className="text-center px-6 py-8 w-full relative min-h-screen flex flex-col items-center justify-center">
      {/* Starry background - appears immediately */}
      <StarryBackground />
      
      {/* Content */}
      <div className="relative z-10 flex-1 flex flex-col items-center justify-center">
        {/* Logo at the top with champagne glasses */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.2 }}
          className="mb-8 flex justify-center items-center gap-6 relative"
        >
          <ChampagneGlass position="left" />
          <Image
            src="/logo.svg"
            alt="Fluoverse"
            width={243}
            height={84}
          className="h-20 w-auto rounded-lg relative z-10"
          style={{ transform: 'none' }}
        />
        <ChampagneGlass position="right" />
      </motion.div>
      
      <motion.h2
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.7, delay: 0.4 }}
        className="text-4xl md:text-5xl font-bold text-white mb-8"
        style={{ textShadow: '0 2px 20px rgba(0, 0, 0, 0.4)' }}
      >
        {isEncouragementMode 
          ? '2026 is Your Year to Shine! 🌟'
          : userName === 'Your Class' 
            ? 'Thanks for teaching with Fluoverse' 
            : 'Thanks for learning with Fluoverse'}
      </motion.h2>
      
      <motion.div
        initial={{ opacity: 0, y: 15, scale: 0.95 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        transition={{ duration: 0.6, delay: 0.6 }}
        className="bg-white/10 backdrop-blur-md rounded-2xl p-7 border border-white/20 shadow-xl"
      >
        <p className="text-2xl md:text-3xl text-white/95 font-semibold leading-relaxed">
          {isEncouragementMode
            ? message || 'Start your language learning journey on Fluoverse today! 🚀'
            : userName === 'Your Class' 
              ? 'Your students are making great progress and we are proud to support their learning journey'
              : message || 'Your skills are improving day by day and we are improving with you'}
        </p>
        {isEncouragementMode && achievement && (
          <p className="text-xl md:text-2xl text-white/85 font-medium mt-4 leading-relaxed">
            {achievement}
          </p>
        )}
      </motion.div>
    </div>
    
    {/* New Year Animation at bottom - moved higher with cutoff for balloon */}
    <div className="relative z-10 w-full" style={{ marginTop: '-40px' }}>
      <NewYearAnimation />
    </div>
  </div>
  );
};

export default function FluoverseWrapped({ 
  data, 
  onClose, 
  onComplete, 
  onScenarioSelect,
  selectedScenarioId,
  autoPlay = true,
  captureMode = false,
  hideControls = false,
  className = ""
}: FluoverseWrappedProps) {
  const [currentSlide, setCurrentSlide] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false); // Start as false, will be set to true after mount
  const [selectedScenario, setSelectedScenario] = useState<string | null>(selectedScenarioId || null);
  const [slideDirection, setSlideDirection] = useState(1); // 1 for forward, -1 for backward
  
  // Auto-select first scenario when hideControls is true (for video preview)
  useEffect(() => {
    if (hideControls && !selectedScenario && data.topScenarios[0]?.lessonId) {
      setSelectedScenario(data.topScenarios[0].lessonId);
      onScenarioSelect?.(data.topScenarios[0].lessonId);
    }
  }, [hideControls, selectedScenario, data.topScenarios, onScenarioSelect]);
  const containerRef = useRef<HTMLDivElement>(null);
  const timerRef = useRef<NodeJS.Timeout | null>(null);
  const totalSlidesRef = useRef(8); // Fixed number of slides - use ref to prevent timer reset
  const timerStartedRef = useRef(false); // Track if timer has been started to prevent multiple timers
  const lastTimerCreationRef = useRef<number>(0); // Track when timer was last created to prevent rapid recreation
  const isProcessingRef = useRef(false); // Track if timer callback is currently processing to prevent double-fires

  // Log slide changes and expose to window for video generation
  useEffect(() => {
    console.log('[FluoverseWrapped] Slide changed to:', currentSlide, 'isPlaying:', isPlaying);
    // Expose current slide to window for Puppeteer to read
    if (typeof window !== 'undefined') {
      (window as any).__fluoverseCurrentSlide = currentSlide;
    }
  }, [currentSlide, isPlaying]);

  // Check if user has zero stats (encouragement mode)
  const isEncouragementMode = data.totalMinutes === 0 && data.totalScenariosCompleted === 0;
  
  // Find selected scenario for slide 6
  const selectedScenarioData = data.topScenarios.find(s => s.lessonId === selectedScenario) || data.topScenarios[0];

  const handleScenarioSelect = useCallback((lessonId: string) => {
    console.log('[FluoverseWrapped] handleScenarioSelect called with:', lessonId, 'autoPlay:', autoPlay);
    setSelectedScenario(lessonId);
    onScenarioSelect?.(lessonId);

    // In capture mode, Puppeteer controls slide progression. Do NOT auto-advance here.
    if (captureMode) return;

    // Auto-advance to next slide after selection
    setTimeout(() => {
      setCurrentSlide(prev => {
        const next = prev + 1;
        console.log('[FluoverseWrapped] Scenario selected, advancing from slide', prev, 'to', next);
        // Only stop playing if not in auto-play mode
        if (!autoPlay) {
          console.log('[FluoverseWrapped] Stopping playback (not auto-play mode)');
          setIsPlaying(false);
        } else {
          console.log('[FluoverseWrapped] Continuing playback (auto-play mode)');
        }
        return next;
      });
    }, 1000);
  }, [onScenarioSelect, autoPlay, captureMode]);

  const slides = useMemo(() => {
    // For encouragement mode (zero stats), show single scenario showcase slide
    if (isEncouragementMode) {
      return [
        <WelcomeSlide key="welcome" userName={data.userName} year={data.year} />,
        <TotalMinutesSlide key="minutes" totalMinutes={data.totalMinutes} userName={data.userName} />,
        <LearningAgeSlide key="age" days={data.learningAgeDays} />,
        <TotalScenariosSlide key="scenarios" count={data.totalScenariosCompleted} userName={data.userName} />,
        <ScenariosToStartSlide key="scenarios-start" scenarios={data.topScenarios} userName={data.userName} />,
        <UniqueWordsSlide key="words" count={data.uniqueWordsMastered} userName={data.userName} />,
        <PersonalizedMessageSlide 
          key="thanks" 
          userName={data.userName}
          message={data.personalizedMessage}
          achievement={data.biggestAchievement}
          totalMinutes={data.totalMinutes}
          totalScenariosCompleted={data.totalScenariosCompleted}
        />,
      ];
    }
    
    // Normal mode - show selection and detailed scenario slides
    return [
      <WelcomeSlide key="welcome" userName={data.userName} year={data.year} />,
      <TotalMinutesSlide key="minutes" totalMinutes={data.totalMinutes} userName={data.userName} />,
      <LearningAgeSlide key="age" days={data.learningAgeDays} />,
      <TotalScenariosSlide key="scenarios" count={data.totalScenariosCompleted} userName={data.userName} />,
      // Use static preview slide in capture mode or when controls are hidden, interactive slide otherwise
      (captureMode || hideControls) ? (
        <TopLessonPreviewSlide 
          key="top-preview" 
          scenario={data.topScenarios[0]}
          userName={data.userName}
        />
      ) : (
        <SelectScenarioSlide 
          key="select" 
          scenarios={data.topScenarios}
          onSelect={handleScenarioSelect}
          selectedId={selectedScenario || undefined}
          userName={data.userName}
        />
      ),
      <TopScenarioSlide key="top-scenario" scenario={selectedScenarioData} userName={data.userName} />,
      <UniqueWordsSlide key="words" count={data.uniqueWordsMastered} userName={data.userName} />,
      <PersonalizedMessageSlide 
        key="thanks" 
        userName={data.userName}
        message={data.personalizedMessage}
        achievement={data.biggestAchievement}
        totalMinutes={data.totalMinutes}
        totalScenariosCompleted={data.totalScenariosCompleted}
      />,
    ];
  }, [data, selectedScenario, selectedScenarioData, handleScenarioSelect, captureMode, hideControls, isEncouragementMode]);

  // Auto-select scenario when reaching selection slide in auto-play mode
  // Skip this if we're using the static preview slide (hideControls or captureMode)
  useEffect(() => {
    console.log('[FluoverseWrapped] Auto-select check - isPlaying:', isPlaying, 'autoPlay:', autoPlay, 'currentSlide:', currentSlide, 'selectedScenario:', selectedScenario);
    if (captureMode || hideControls) return; // Skip if using static preview slide
    if (isPlaying && autoPlay && currentSlide === 4 && !selectedScenario) {
      console.log('[FluoverseWrapped] Scheduling auto-select for slide 4');
      // Auto-select first scenario after showing the slide for 3 seconds (half of 6 second slide duration)
      const timer = setTimeout(() => {
        const firstScenarioId = data.topScenarios[0]?.lessonId;
        console.log('[FluoverseWrapped] Auto-selecting scenario:', firstScenarioId);
        if (firstScenarioId) {
          handleScenarioSelect(firstScenarioId);
        }
      }, 3000); // Show selection slide for 3 seconds before auto-selecting (half of 6 second duration)
      return () => {
        console.log('[FluoverseWrapped] Clearing auto-select timer');
        clearTimeout(timer);
      };
    }
  }, [isPlaying, autoPlay, currentSlide, selectedScenario, data.topScenarios, handleScenarioSelect, captureMode, hideControls]);

  // Start auto-play after component mounts (for smooth modal animation)
  useEffect(() => {
    console.log('[FluoverseWrapped] Mount/Update - autoPlay:', autoPlay);
    if (captureMode) return;
    if (autoPlay) {
      // Small delay to ensure modal animation completes
      const startTimer = setTimeout(() => {
        console.log('[FluoverseWrapped] Starting auto-play');
        setIsPlaying(true);
      }, 600); // Wait for modal spring animation (500ms) + small buffer
      return () => clearTimeout(startTimer);
    } else {
      console.log('[FluoverseWrapped] Auto-play disabled');
      setIsPlaying(false);
    }
  }, [autoPlay, captureMode]);

  // Slide progression timing - use recursive setTimeout for more predictable timing
  totalSlidesRef.current = slides.length; // Keep it updated

  useEffect(() => {
    console.log('[FluoverseWrapped] Timer effect - isPlaying:', isPlaying, 'currentSlide:', currentSlide);
    if (captureMode) return;
    
    if (!isPlaying) {
      // Clear any existing timer and reset flag
      if (timerRef.current) {
        console.log('[FluoverseWrapped] Clearing timer (not playing)');
        clearInterval(timerRef.current);
        timerRef.current = null;
      }
      timerStartedRef.current = false;
      return;
    }
    
    // Prevent creating multiple timers
    const now = Date.now();
    const timeSinceLastCreation = now - lastTimerCreationRef.current;
    
    if (timerRef.current && timerStartedRef.current) {
      console.log('[FluoverseWrapped] Timer already running, skipping creation');
      return;
    }
    
    // Prevent rapid timer recreation (guard against StrictMode double-render or effect re-runs)
    if (timeSinceLastCreation < 1000 && timerRef.current) {
      console.log('[FluoverseWrapped] Timer created too recently (', timeSinceLastCreation, 'ms ago), skipping to prevent duplicate');
      return;
    }
    
    // Clear any existing timer first (safety check)
    if (timerRef.current) {
      console.log('[FluoverseWrapped] Clearing existing timer before creating new one');
      clearInterval(timerRef.current);
      timerRef.current = null;
    }
    
    lastTimerCreationRef.current = now;
    
    const slideDuration = 6000; // 6 seconds per slide (6000ms)
    const totalSlides = totalSlidesRef.current;
    
    console.log('[FluoverseWrapped] Starting slide progression timer - slideDuration:', slideDuration, 'ms (', slideDuration / 1000, 'seconds)', 'totalSlides:', totalSlides);
    timerStartedRef.current = true;
    
    // Store the interval ID to verify it's the same timer
    const intervalId = setInterval(() => {
      // Prevent double-firing (React StrictMode causes effects to run twice)
      if (isProcessingRef.current) {
        console.log('[FluoverseWrapped] Timer callback already processing, skipping duplicate');
        return;
      }
      
      // Verify this is still the active timer
      if (timerRef.current !== intervalId) {
        console.log('[FluoverseWrapped] Timer callback fired but timer ID mismatch, ignoring');
        return;
      }
      
      isProcessingRef.current = true;
      
      setCurrentSlide((prev) => {
        const total = totalSlidesRef.current;
        const now = new Date().toISOString();
        console.log('[FluoverseWrapped] Timer fired - current slide:', prev, 'total:', total, 'time:', now);
        
            // Skip auto-advance on selection slide (index 4) only if it's the interactive version
            // When hideControls is true, we use the static preview slide which should auto-advance normally
            if (prev === 4 && !hideControls) {
              console.log('[FluoverseWrapped] Skipping auto-advance on selection slide (index 4) - auto-select will handle it');
              // Reset flag after state update completes
              setTimeout(() => { isProcessingRef.current = false; }, 50);
              return prev;
            }
        
        const next = prev + 1;
        console.log('[FluoverseWrapped] Advancing to slide:', next, 'of', total);
        
        if (next >= total) {
          console.log('[FluoverseWrapped] All slides complete, stopping');
          setIsPlaying(false);
          // Clear the interval
          if (timerRef.current) {
            clearInterval(timerRef.current);
            timerRef.current = null;
          }
          timerStartedRef.current = false;
          isProcessingRef.current = false;
          // Call onComplete after clearing timer
          setTimeout(() => onComplete?.(), 0);
          return prev;
        }
        
        // Reset processing flag after state update (React batches state updates)
        setTimeout(() => {
          isProcessingRef.current = false;
        }, 50);
        
        return next;
      });
    }, slideDuration);
    
    timerRef.current = intervalId;
    console.log('[FluoverseWrapped] Timer created with ID:', intervalId, 'interval:', slideDuration, 'ms');

    return () => {
      console.log('[FluoverseWrapped] Timer cleanup');
      if (timerRef.current) {
        clearInterval(timerRef.current);
        timerRef.current = null;
      }
      timerStartedRef.current = false;
    };
  }, [isPlaying, captureMode, hideControls]); // Only depend on isPlaying; captureMode disables timers

  // Capture mode: follow external desired slide/scenario set by Puppeteer.
  useEffect(() => {
    if (!captureMode) return;

    // Ensure no real-time playback is running
    setIsPlaying(false);

    const id = setInterval(() => {
      try {
        const w = window as any;
        const desiredSlide = w.__fluoverseDesiredSlide;
        const desiredScenarioId = w.__fluoverseDesiredScenarioId;

        if (typeof desiredScenarioId === 'string' && desiredScenarioId && desiredScenarioId !== selectedScenario) {
          setSelectedScenario(desiredScenarioId);
          onScenarioSelect?.(desiredScenarioId);
        }

        if (typeof desiredSlide === 'number' && Number.isFinite(desiredSlide)) {
          const clamped = Math.max(0, Math.min(slides.length - 1, Math.floor(desiredSlide)));
          setCurrentSlide((prev) => {
            if (prev !== clamped) {
              setSlideDirection(clamped > prev ? 1 : -1);
              return clamped;
            }
            return prev;
          });
        }
      } catch {
        // no-op
      }
    }, 100);

    return () => clearInterval(id);
  }, [captureMode, slides.length, selectedScenario, onScenarioSelect]);

  // Touch/swipe handlers
  const touchStart = useRef<number | null>(null);
  const touchEnd = useRef<number | null>(null);
  const minSwipeDistance = 50;

  const onTouchStart = (e: React.TouchEvent) => {
    if (captureMode) return; // Disable touch in capture mode
    touchEnd.current = null;
    touchStart.current = e.targetTouches[0].clientX;
  };

  const onTouchMove = (e: React.TouchEvent) => {
    if (captureMode) return; // Disable touch in capture mode
    touchEnd.current = e.targetTouches[0].clientX;
  };

  const onTouchEnd = () => {
    if (captureMode) return; // Disable touch in capture mode
    if (!touchStart.current || !touchEnd.current) return;
    const distance = touchStart.current - touchEnd.current;
    const isLeftSwipe = distance > minSwipeDistance;
    const isRightSwipe = distance < -minSwipeDistance;

    // Don't allow swipe on selection slide (slide 4, index 4)
    if (currentSlide === 4) return;

    if (isLeftSwipe && currentSlide < slides.length - 1) {
      setSlideDirection(1);
      setCurrentSlide(prev => prev + 1);
      setIsPlaying(false);
    }
    if (isRightSwipe && currentSlide > 0) {
      setSlideDirection(-1);
      setCurrentSlide(prev => prev - 1);
      setIsPlaying(false);
    }
  };

  const handleNext = () => {
    if (captureMode) return; // Disable manual navigation in capture mode
    if (currentSlide < slides.length - 1 && currentSlide !== 4) {
      setSlideDirection(1);
      setCurrentSlide(prev => prev + 1);
      setIsPlaying(false);
    }
  };

  const handlePrevious = () => {
    if (captureMode) return; // Disable manual navigation in capture mode
    if (currentSlide > 0) {
      setSlideDirection(-1);
      setCurrentSlide(prev => prev - 1);
      setIsPlaying(false);
    }
  };

  return (
    <div 
      ref={containerRef}
      className={`relative w-full h-full overflow-hidden bg-gradient-to-br from-purple-800 via-pink-700 via-purple-700 to-purple-800 ${className}`}
      data-fluoverse-wrapped-root="true"
      data-current-slide={currentSlide}
      onTouchStart={onTouchStart}
      onTouchMove={onTouchMove}
      onTouchEnd={onTouchEnd}
    >
      {/* Close button - hidden in capture mode or when controls are hidden */}
      {onClose && !captureMode && !hideControls && (
        <button
          onClick={onClose}
          className="absolute top-4 right-4 z-50 w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center text-white hover:bg-white/30 transition-colors"
          aria-label="Close recap"
        >
          <span className="text-2xl">×</span>
        </button>
      )}

      {/* Animated background gradient - brighter purples and pinks */}
      <motion.div
        className="absolute inset-0"
        animate={{
          background: [
            "radial-gradient(circle at 20% 50%, rgba(192, 132, 252, 0.7) 0%, transparent 50%)",
            "radial-gradient(circle at 80% 50%, rgba(236, 72, 153, 0.6) 0%, transparent 50%)",
            "radial-gradient(circle at 50% 80%, rgba(217, 70, 239, 0.6) 0%, transparent 50%)",
            "radial-gradient(circle at 30% 70%, rgba(192, 132, 252, 0.7) 0%, transparent 50%)",
            "radial-gradient(circle at 70% 30%, rgba(244, 114, 182, 0.6) 0%, transparent 50%)",
            "radial-gradient(circle at 20% 50%, rgba(192, 132, 252, 0.7) 0%, transparent 50%)",
          ],
        }}
        transition={{ duration: 12, repeat: Infinity, ease: "linear" }}
      />
      
      {/* Additional bright purple/pink base gradient overlay */}
      <div className="absolute inset-0 bg-gradient-to-br from-purple-600/30 via-pink-600/25 via-purple-600/25 to-purple-700/30" />

      {/* Slides container */}
      <div className="relative w-full h-full flex items-center justify-center">
        <AnimatePresence mode="wait" custom={slideDirection}>
          {slides.map((slide, index) => (
            index === currentSlide && (
              <Slide 
                key={`slide-${index}`} 
                index={index} 
                currentSlide={currentSlide}
                direction={slideDirection}
              >
                {slide}
              </Slide>
            )
          ))}
        </AnimatePresence>
      </div>

      {/* Navigation buttons - hidden in capture mode, when controls are hidden, and on selection slide */}
      {!captureMode && !hideControls && currentSlide > 0 && currentSlide !== 4 && (
        <button
          onClick={handlePrevious}
          className="absolute left-4 top-1/2 -translate-y-1/2 z-50 w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center text-white hover:bg-white/30 transition-colors"
          aria-label="Previous slide"
        >
          ←
        </button>
      )}

      {!captureMode && !hideControls && currentSlide < slides.length - 1 && currentSlide !== 4 && (
        <button
          onClick={handleNext}
          className="absolute right-4 top-1/2 -translate-y-1/2 z-50 w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center text-white hover:bg-white/30 transition-colors"
          aria-label="Next slide"
        >
          →
        </button>
      )}

      {/* Progress indicator - hidden in capture mode or when controls are hidden */}
      {!captureMode && !hideControls && (
        <div className="absolute bottom-6 left-1/2 transform -translate-x-1/2 flex gap-2 z-50">
          {slides.map((_, index) => (
            <motion.div
              key={index}
              className="h-1.5 rounded-full cursor-pointer"
              initial={{ width: 6, opacity: 0.5 }}
              animate={{
                width: currentSlide === index ? 24 : 6,
                opacity: currentSlide === index ? 1 : 0.5,
              }}
              style={{
                backgroundColor: currentSlide === index ? "rgba(255, 255, 255, 1)" : "rgba(255, 255, 255, 0.5)",
              }}
              transition={{ duration: 0.3 }}
              onClick={() => {
                if (index !== 4) { // Can't skip to selection slide
                  setSlideDirection(index > currentSlide ? 1 : -1);
                  setCurrentSlide(index);
                  setIsPlaying(false);
                }
              }}
            />
          ))}
        </div>
      )}
    </div>
  );
}

