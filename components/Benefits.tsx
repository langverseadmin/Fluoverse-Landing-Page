"use client";

import { motion, AnimatePresence, useInView } from "framer-motion";
import { useMemo, useState, useEffect, useRef, useCallback } from "react";
import { GraduationCap, Users, Globe, Sparkles, Mic, BarChart3, TrendingUp, Target, Zap, Coffee, ShoppingCart, Snowflake, UtensilsCrossed, Apple, Gift, Volume2, Lightbulb, X, Send, ArrowLeft, Phone, Play, Flame, Clock, Blocks, CheckCircle2, Rocket, MessageCircle, Bolt, Star } from "lucide-react";
import Image from "next/image";
import "flag-icons/css/flag-icons.min.css";
import { getFluoverseUrl, isMobileDevice, openFluoverseApp } from "@/lib/utils";
import { LEARNERS_ONLY_SITE } from "@/lib/config";
import {
  trackBenefitsTabSwitch,
  trackBenefitsCtaTryFluoverse,
  trackBenefitsCtaBookCall,
  trackBenefitsScenarioOpenFluoverse,
  trackBenefitsVoiceTestPlay,
  trackBenefitsVoiceTestStop,
  trackBenefitsVoiceLanguageSelect,
} from "@/lib/analytics";

// User type for confidence cards
interface ConfidenceUser {
  src: string;
  name: string;
  boost: number;
  weeks: number;
}

// Carousel Card Component - Static display for infinite scroll (no gaps, no shadows)
function CarouselCard({ user }: { user: ConfidenceUser }) {
  return (
    <div className="flex-shrink-0 w-32 sm:w-36 md:w-40 relative">
      <div className="relative w-full aspect-square overflow-hidden">
        <Image 
          src={user.src} 
          alt={`${user.name} - Fluoverse user`}
          fill 
          className="object-cover"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-black/10" />
        
        {/* Confidence Boost Badge */}
        <div className="absolute top-2 right-2 z-10">
          <div className="bg-gradient-to-br from-green-400 via-green-500 to-emerald-600 text-white text-[10px] sm:text-[11px] font-black px-1.5 sm:px-2 py-0.5 sm:py-1 rounded-md">
            <span className="flex items-center gap-0.5">
              <svg className="w-2.5 h-2.5 sm:w-3 sm:h-3" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M12 7a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0V8.414l-4.293 4.293a1 1 0 01-1.414 0L8 10.414l-4.293 4.293a1 1 0 01-1.414-1.414l5-5a1 1 0 011.414 0L11 10.586 14.586 7H12z" clipRule="evenodd" />
              </svg>
              <span className="tabular-nums">{user.boost}%</span>
            </span>
          </div>
        </div>
        
        {/* User Info with Progress Bar */}
        <div className="absolute bottom-0 left-0 right-0 p-2">
          {/* Mini Stars */}
          <div className="flex items-center gap-px mb-0.5">
            {[...Array(5)].map((_, j) => (
              <svg key={j} className="w-2 h-2 sm:w-2.5 sm:h-2.5 text-yellow-400 fill-current" viewBox="0 0 20 20">
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
              </svg>
            ))}
          </div>
          <p className="text-white font-semibold text-[11px] sm:text-xs truncate">{user.name}</p>
          
          {/* Progress Bar */}
          <div className="mt-1 relative">
            <div className="h-1.5 sm:h-2 bg-black/40 rounded-full overflow-hidden">
              <div 
                className="h-full rounded-full"
                style={{ 
                  width: `${user.boost}%`,
                  background: 'linear-gradient(90deg, #22c55e 0%, #10b981 40%, #059669 100%)'
                }}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

// Confidence Card Component with smooth premium animations (for non-carousel use)

function ConfidenceCard({ user, index }: { user: ConfidenceUser; index: number }) {
  const cardRef = useRef<HTMLDivElement>(null);
  const isInView = useInView(cardRef, { once: true, margin: "-100px" });
  const [isAnimating, setIsAnimating] = useState(false);
  const [displayCount, setDisplayCount] = useState(0);

  // Stagger delay - longer gaps for premium feel
  const staggerDelay = index * 200; // 200ms between each card

  useEffect(() => {
    if (isInView && !isAnimating) {
      // Start animation after stagger delay
      const timer = setTimeout(() => {
        setIsAnimating(true);
        
        // Smooth counting animation using CSS-like timing
        const duration = 2500; // 2.5 seconds for smooth premium feel
        const startTime = performance.now();
        const targetValue = user.boost;
        
        const updateCount = (currentTime: number) => {
          const elapsed = currentTime - startTime;
          const progress = Math.min(elapsed / duration, 1);
          
          // Premium easing: ease-out-quart for smooth deceleration
          const eased = 1 - Math.pow(1 - progress, 4);
          
          setDisplayCount(Math.round(eased * targetValue));
          
          if (progress < 1) {
            requestAnimationFrame(updateCount);
          }
        };
        
        requestAnimationFrame(updateCount);
      }, staggerDelay);
      
      return () => clearTimeout(timer);
    }
  }, [isInView, isAnimating, staggerDelay, user.boost]);

  return (
    <motion.div
      ref={cardRef}
      initial={{ opacity: 0, y: 40, scale: 0.95 }}
      animate={isAnimating ? { opacity: 1, y: 0, scale: 1 } : { opacity: 0, y: 40, scale: 0.95 }}
      transition={{ 
        duration: 0.8, 
        ease: [0.25, 0.46, 0.45, 0.94] // Custom ease for premium feel
      }}
      className="relative group"
    >
      {/* Card Container */}
      <div className="relative w-full aspect-square rounded-xl overflow-visible shadow-lg group-hover:shadow-2xl transition-shadow duration-500">
        <div className="relative w-full h-full rounded-xl overflow-hidden">
          <Image 
            src={user.src} 
            alt={`${user.name} - Fluoverse user`}
            fill 
            className="object-cover"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-black/10" />
        </div>
        
        {/* Confidence Boost Badge */}
        <motion.div 
          className="absolute -top-2 -right-2 z-10"
          initial={{ scale: 0, opacity: 0 }}
          animate={isAnimating ? { scale: 1, opacity: 1 } : { scale: 0, opacity: 0 }}
          transition={{ 
            duration: 0.6, 
            delay: 0.3,
            ease: [0.34, 1.56, 0.64, 1] // Slight bounce
          }}
        >
          <div className="relative bg-gradient-to-br from-green-400 via-green-500 to-emerald-600 text-white text-[11px] font-black px-2 py-1 rounded-lg shadow-lg border border-green-300/30">
            <span className="flex items-center gap-1">
              <svg className="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M12 7a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0V8.414l-4.293 4.293a1 1 0 01-1.414 0L8 10.414l-4.293 4.293a1 1 0 01-1.414-1.414l5-5a1 1 0 011.414 0L11 10.586 14.586 7H12z" clipRule="evenodd" />
              </svg>
              <span className="tabular-nums min-w-[28px]">{displayCount}%</span>
            </span>
          </div>
        </motion.div>
        
        {/* User Info with Realistic Progress Bar */}
        <div className="absolute bottom-0 left-0 right-0 p-2 rounded-b-xl">
          {/* Mini Stars */}
          <div className="flex items-center gap-px mb-1">
            {[...Array(5)].map((_, j) => (
              <motion.svg 
                key={j} 
                className="w-2.5 h-2.5 text-yellow-400 fill-current drop-shadow-sm" 
                viewBox="0 0 20 20"
                initial={{ opacity: 0, scale: 0 }}
                animate={isAnimating ? { opacity: 1, scale: 1 } : { opacity: 0, scale: 0 }}
                transition={{ 
                  duration: 0.4, 
                  delay: 0.4 + j * 0.08,
                  ease: "easeOut"
                }}
              >
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
              </motion.svg>
            ))}
          </div>
          <p className="text-white font-semibold text-xs truncate">{user.name}</p>
          
          {/* Premium Confidence Progress Bar */}
          <div className="mt-1.5 relative">
            {/* Background track */}
            <div className="h-2 bg-black/30 rounded-full overflow-hidden backdrop-blur-sm border border-white/10">
              {/* Animated fill with CSS transition for smoothness */}
              <motion.div 
                className="h-full rounded-full relative overflow-hidden"
                initial={{ width: 0 }}
                animate={isAnimating ? { width: `${user.boost}%` } : { width: 0 }}
                transition={{ 
                  duration: 2.5, 
                  delay: 0.2,
                  ease: [0.25, 0.46, 0.45, 0.94] // Premium ease-out
                }}
                style={{ 
                  background: 'linear-gradient(90deg, #22c55e 0%, #10b981 40%, #059669 100%)'
                }}
              >
                {/* Shine sweep effect */}
                <motion.div 
                  className="absolute inset-0 bg-gradient-to-r from-transparent via-white/40 to-transparent"
                  initial={{ x: '-100%' }}
                  animate={isAnimating ? { x: '200%' } : { x: '-100%' }}
                  transition={{ 
                    duration: 1.5, 
                    delay: 1.2,
                    ease: "easeInOut"
                  }}
                />
                {/* Top highlight */}
                <div className="absolute inset-x-0 top-0 h-1/2 bg-gradient-to-b from-white/25 to-transparent rounded-t-full" />
              </motion.div>
            </div>
          </div>
        </div>
      </div>
    </motion.div>
  );
}

type TabType = "learners" | "tutors";

const learnerBenefits = [
  {
    icon: Globe,
    title: "Learn by Living the Language",
    description: "Instead of drills and memorization, learners practice language exactly as it's used in real life through guided conversations, scenarios, and spontaneous interaction. This builds confidence, fluency, and natural flow.",
    mockupType: "scenarios",
  },
  {
    icon: Target,
    title: "Create Custom Scenarios That Match Your Real Life",
    description: "You can instantly generate speaking scenarios tailored to your goals, like job interviews, travel, dating, exams, or everyday conversations. You practice exactly what you need, not generic phrases.",
    mockupType: "conversation",
  },
  {
    icon: Mic,
    title: "Full Immersion with the Most Realistic Voice Experience",
    description: "Fluoverse places you inside lifelike conversations powered by one of the most natural, human-sounding AI voices available. It feels like speaking with a real person, helping you think and react in the language naturally.",
    mockupType: "voice",
  },
];

const tutorBenefits = [
  {
    icon: Sparkles,
    title: "More Engaged, Better-Prepared Students",
    description: "For the first time, tutors can assign real speaking practice at home. Students arrive to sessions already warmed up, more confident, and actively using the language, making live lessons far more effective.",
    mockupType: "students",
  },
  {
    icon: BarChart3,
    title: "Intuitive Analytics That Highlight Exactly What to Teach",
    description: "Fluoverse provides a simple, easy-to-use dashboard that clearly surfaces each learner's weak points. Tutors spend less time on tracking and logistics, and more time doing what matters most: teaching!",
    mockupType: "analytics",
  },
  {
    icon: TrendingUp,
    title: "Higher Demand Through Technology That Works for You",
    description: "Tutors gain a competitive edge with immersive voice technology, fast scenario creation, and lightning-quick support. This keeps students motivated, satisfied, and coming back, while helping tutors grow their reputation and demand.",
    mockupType: "growth",
  },
];

function VoiceTester() {
  const [selectedLanguage, setSelectedLanguage] = useState<"en" | "es" | "el">("en");
  const [isPlaying, setIsPlaying] = useState(false);
  const [audioBars, setAudioBars] = useState<number[]>(Array(12).fill(8));
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const intervalRef = useRef<NodeJS.Timeout | null>(null);

  const languageConfig = {
    en: {
      name: "English",
      flagCode: "gb",
      image: "/benefits/English_City.jpg",
      audioFile: "/audio/voice-en.mp3",
    },
    es: {
      name: "Spanish",
      flagCode: "es",
      image: "/benefits/Spanish_City.jpg",
      audioFile: "/audio/voice-es.mp3",
    },
    el: {
      name: "Greek",
      flagCode: "gr",
      image: "/benefits/Greek_City.jpg",
      audioFile: "/audio/voice-el.mp3",
    },
  };

  useEffect(() => {
    // Create audio element
    audioRef.current = new Audio();
    audioRef.current.preload = "auto";

    return () => {
      if (intervalRef.current) clearInterval(intervalRef.current);
      if (audioRef.current) {
        audioRef.current.pause();
        audioRef.current = null;
      }
    };
  }, []);

  useEffect(() => {
    if (audioRef.current) {
      audioRef.current.src = languageConfig[selectedLanguage].audioFile;
      if (isPlaying) {
        audioRef.current.currentTime = 0;
        audioRef.current.play();
      }
    }
  }, [selectedLanguage]);

  const animateAudioBars = () => {
    if (intervalRef.current) clearInterval(intervalRef.current);
    intervalRef.current = setInterval(() => {
      setAudioBars(Array(12).fill(0).map(() => Math.random() * 40 + 15));
    }, 100);
  };

  const handlePlay = async () => {
    if (!audioRef.current) return;

    try {
      audioRef.current.src = languageConfig[selectedLanguage].audioFile;
      audioRef.current.load();
      await audioRef.current.play();
      setIsPlaying(true);
      animateAudioBars();
      trackBenefitsVoiceTestPlay(selectedLanguage);

      audioRef.current.addEventListener("ended", () => {
        setIsPlaying(false);
        setAudioBars(Array(12).fill(8));
        if (intervalRef.current) clearInterval(intervalRef.current);
      }, { once: true });

      audioRef.current.addEventListener("error", () => {
        setIsPlaying(false);
        setAudioBars(Array(12).fill(8));
        if (intervalRef.current) clearInterval(intervalRef.current);
      }, { once: true });
    } catch (error) {
      // Handle play() promise rejection (e.g., autoplay blocked)
      console.error("Audio play failed:", error);
      setIsPlaying(false);
      setAudioBars(Array(12).fill(8));
      if (intervalRef.current) clearInterval(intervalRef.current);
    }
  };

  const handleStop = () => {
    if (audioRef.current) {
      audioRef.current.pause();
      audioRef.current.currentTime = 0;
    }
    setIsPlaying(false);
    setAudioBars(Array(12).fill(8));
    if (intervalRef.current) clearInterval(intervalRef.current);
    trackBenefitsVoiceTestStop(selectedLanguage);
  };

  return (
    <div className="relative w-full max-w-xl mx-auto rounded-2xl overflow-hidden aspect-[4/3] sm:aspect-[4/3] border-0">
      {/* Background Image */}
      <div className="absolute inset-0 rounded-2xl overflow-hidden">
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
              alt={`${languageConfig[selectedLanguage].name} cityscape background for authentic speaking practice in Fluoverse language learning app`}
              fill
              className="object-cover"
              priority
              style={{ borderRadius: '1rem' }}
            />
          </motion.div>
        </AnimatePresence>
        {/* Dark Overlay for Readability */}
        <div className="absolute inset-0 bg-black/20 rounded-2xl"></div>
      </div>

      {/* Content */}
      <div className="relative z-10 text-center p-4 sm:p-6 lg:p-8 h-full flex flex-col">
        {/* Language Selector */}
        <div className="flex justify-center gap-2 sm:gap-3 mb-4 sm:mb-6 flex-wrap">
          {(["en", "es", "el"] as const).map((lang) => (
            <button
              key={lang}
              onClick={() => {
                if (isPlaying) handleStop();
                setSelectedLanguage(lang);
                trackBenefitsVoiceLanguageSelect(lang);
              }}
              className={`px-3 py-2 sm:px-4 sm:py-2.5 rounded-lg font-medium text-xs sm:text-sm transition-all duration-300 backdrop-blur-sm flex items-center gap-1.5 sm:gap-2 ${
                selectedLanguage === lang
                  ? "bg-purple-600 text-white shadow-lg"
                  : "bg-white/10 text-white/90 hover:bg-white/20 border border-white/20"
              }`}
            >
              <span className={`fi fi-${languageConfig[lang].flagCode} text-lg sm:text-xl`}></span>
              <span className="whitespace-nowrap">{languageConfig[lang].name}</span>
            </button>
          ))}
        </div>

        {/* Audio Visualizer and Button Container */}
        <div className="mt-auto space-y-4 sm:space-y-6">
          {/* Simple Audio Visualizer */}
          <div className="flex justify-center items-end gap-0.5 sm:gap-1 h-12 sm:h-16">
            {audioBars.map((height, i) => (
              <motion.div
                key={i}
                className="w-1 sm:w-1.5 rounded-full bg-purple-500"
                animate={{
                  height: `${height}px`,
                  opacity: isPlaying ? 1 : 0.4,
                }}
                transition={{
                  duration: 0.1,
                  ease: "easeOut",
                }}
              />
            ))}
          </div>

          {/* Play/Stop Button */}
          <div className="flex justify-center">
          <div className={`expanding-button-wrapper ${isPlaying ? 'is-playing' : ''}`}>
            <button
              onClick={isPlaying ? handleStop : handlePlay}
              onTouchStart={(e) => {
                // Prevent double-tap zoom on mobile
                e.currentTarget.style.touchAction = 'manipulation';
              }}
              className="expanding-button"
              type="button"
            >
              {isPlaying ? (
                <>
                  <div className="w-3 h-3 rounded-full bg-white"></div>
                </>
              ) : (
                <>
                  <span className="expanding-button-text">Test Voice</span>
                  <Volume2 className="expanding-button-icon text-white" />
                </>
              )}
            </button>
          </div>
          </div>
        </div>
      </div>
    </div>
  );
}

function BenefitMockup({ type, isReversed }: { type: string; isReversed: boolean }) {
  const [scenarioText, setScenarioText] = useState("");
  const [isSubmitted, setIsSubmitted] = useState(false);
  
  const scenarioTemplates = {
    "Job Interview": "Create me a job interview scenario where I practice introducing myself, discussing my experience, and answering common interview questions.",
    "Travel": "Create me a travel scenario where I practice booking hotels, asking for directions, ordering food at restaurants, and having conversations with locals.",
    "Dating": "Create me a dating scenario where I practice making small talk, asking questions, and having natural conversations on a first date."
  };

  const handleTagClick = (tag: string) => {
    setScenarioText(scenarioTemplates[tag as keyof typeof scenarioTemplates] || "");
  };

  const handleSubmit = () => {
    if (scenarioText.trim()) {
      setIsSubmitted(true);
    }
  };
  const scenarioImages = [
    "/benefits/Restaurant.png",
    "/benefits/Supermarket.png",
    "/benefits/Christmas.png",
  ];
  const scenarioLabels = ["Restaurant Scenario", "Supermarket Scenario", "Christmas Market Scenario"];
  const popupMeta = [
    {
      leftIcon: Coffee,
      leftTone: "from-amber-400 to-amber-500",
      rightIcon: UtensilsCrossed,
      rightTone: "from-amber-400 to-amber-500",
    },
    {
      leftIcon: Apple,
      leftTone: "from-emerald-400 to-emerald-500",
      rightIcon: ShoppingCart,
      rightTone: "from-emerald-400 to-emerald-500",
    },
    {
      leftIcon: Snowflake,
      leftTone: "from-rose-600 to-red-600",
      rightIcon: Gift,
      rightTone: "from-rose-600 to-red-600",
    },
  ];
  const popupLeft = [
    {
      badge: "Live Order",
      title: "“Café con leche”",
      subtitle: "+ Croissant • Ready in 2 min",
    },
    {
      badge: "Aisle 5",
      title: "Fresh Produce",
      subtitle: "Apples • Oranges • Avocados",
    },
    {
      badge: "Market Stall",
      title: "Hot Chocolate",
      subtitle: "+ Cinnamon Bun • Ready now",
    },
  ];

  const popupRight = [
    {
      badge: "Special",
      title: "Chef’s Pick",
      subtitle: "Tapas Tasting • Tonight only",
    },
    {
      badge: "Deal",
      title: "Daily Savings",
      subtitle: "Mix & Match • 2 for 1",
    },
    {
      badge: "Festive",
      title: "Mulled Wine",
      subtitle: "Spiced • Limited time",
    },
  ];
  // Clone first slide for seamless left-only swipe
  const slides = useMemo(() => [...scenarioImages, scenarioImages[0]], [scenarioImages]);
  const [index, setIndex] = useState(0);
  const [isReset, setIsReset] = useState(false);
  const timerRef = useRef<NodeJS.Timeout | null>(null);

  // Step through slides: dwell then quick swipe left
  useEffect(() => {
    if (type !== "scenarios") return;

    const dwell = 3000; // still time (ms)
    const swipe = 350;  // swipe duration (ms)

    const tick = () => {
      setIsReset(false);
      setIndex((prev) => {
        const next = prev + 1;
        return next >= slides.length ? slides.length - 1 : next;
      });
      timerRef.current = setTimeout(tick, dwell + swipe);
    };

    timerRef.current = setTimeout(tick, dwell);

    return () => {
      if (timerRef.current) clearTimeout(timerRef.current);
    };
  }, [slides.length, type]);

  // Snap back instantly after hitting the cloned slide
  useEffect(() => {
    if (type !== "scenarios") return;
    if (index === slides.length - 1) {
      setIsReset(true);
      const snap = setTimeout(() => setIndex(0), 10);
      return () => clearTimeout(snap);
    }
  }, [index, slides.length, type]);
  if (type === "scenarios") {
    return (
      <motion.div
        initial={{ opacity: 0, x: isReversed ? -50 : 50 }}
        whileInView={{ opacity: 1, x: 0 }}
        viewport={{ once: true, margin: "-100px" }}
        transition={{ duration: 0.7, ease: "easeOut" }}
        className="flex justify-center items-center"
      >
        <div
          className="device device-iphone-14 device-silver"
          style={{ transform: "scale(0.65)", transformOrigin: "center" }}
        >
          <div className="device-frame">
            <div className="device-screen relative overflow-hidden bg-[#230a37]">
              <div className="absolute inset-0 overflow-hidden">
                <motion.div
                  className="flex h-full will-change-transform"
                  style={{ width: `${slides.length * 100}%` }}
                  animate={{ x: `-${(index * 100) / slides.length}%` }}
                  transition={{
                    duration: isReset ? 0 : 0.35,
                    ease: [0.4, 0, 0.2, 1],
                  }}
                >
                  {slides.map((src: string, i) => (
                    <div
                      key={`${src}-${i}`}
                      className="relative h-full flex-shrink-0"
                      style={{ width: `${100 / slides.length}%` }}
                    >
                      <Image
                        src={src}
                        alt={`${scenarioLabels[index % scenarioImages.length]} - Interactive language learning scenario in Fluoverse app`}
                        fill
                        sizes="(max-width: 768px) 90vw, 400px"
                        className="object-cover"
                        priority
                      />
                    </div>
                  ))}
                </motion.div>
              </div>
              <div className="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-2 px-6 py-2.5 rounded-full bg-black/75 border border-white/30 text-base font-semibold text-white shadow-[0_12px_45px_rgba(0,0,0,0.6)] backdrop-blur-lg whitespace-nowrap">
                <span className="inline-flex h-2.5 w-2.5 rounded-full bg-white shadow-[0_0_12px_rgba(255,255,255,0.9)]" />
                <span className="tracking-tight">{scenarioLabels[index % scenarioImages.length]}</span>
              </div>
            </div>
          </div>
          {/* Floating popups (premium style) */}
          <motion.div
            initial={{ opacity: 0, x: -16, y: 3, scale: 0.99 }}
            animate={{ opacity: 1, x: 0, y: 0, scale: 1 }}
            transition={{ duration: 0.5, delay: 0.3, ease: [0.22, 1, 0.36, 1] }}
            className="hidden md:flex flex-col gap-2 absolute left-[-58px] top-10 z-20"
          >
            {(() => {
              const Icon = popupMeta[index % scenarioImages.length].leftIcon;
              const tone = popupMeta[index % scenarioImages.length].leftTone;
              return (
                <div className={`h-[72px] w-[72px] rounded-2xl bg-gradient-to-br ${tone} flex items-center justify-center shadow-[0_20px_52px_rgba(0,0,0,0.42)] border border-white/10`}>
                  <Icon className="h-9 w-9 text-[#1a1032]" />
                </div>
              );
            })()}
          </motion.div>

          <motion.div
            initial={{ opacity: 0, x: 16, y: 3, scale: 0.99 }}
            animate={{ opacity: 1, x: 0, y: 0, scale: 1 }}
            transition={{ duration: 0.5, delay: 0.4, ease: [0.22, 1, 0.36, 1] }}
            className="hidden md:flex flex-col gap-2 absolute right-[-58px] bottom-12 z-20 items-end"
          >
            {(() => {
              const Icon = popupMeta[index % scenarioImages.length].rightIcon;
              const tone = popupMeta[index % scenarioImages.length].rightTone;
              return (
                <div className={`h-[72px] w-[72px] rounded-2xl bg-gradient-to-br ${tone} flex items-center justify-center shadow-[0_22px_56px_rgba(0,0,0,0.45)] border border-white/15`}>
                  <Icon className="h-9 w-9 text-white drop-shadow-[0_0_14px_rgba(255,255,255,0.7)]" />
                </div>
              );
            })()}
          </motion.div>

          <div className="device-stripe"></div>
          <div className="device-header"></div>
          <div className="device-sensors"></div>
          <div className="device-btns"></div>
          <div className="device-power"></div>
        </div>
      </motion.div>
    );
  }

  return (
    <motion.div
      initial={{ opacity: 0, x: isReversed ? -50 : 50 }}
      whileInView={{ opacity: 1, x: 0 }}
      viewport={{ once: true, margin: "-100px" }}
      transition={{ duration: 0.7, ease: "easeOut" }}
      className="relative"
    >
      <div className={`relative rounded-2xl overflow-hidden ${type === "conversation" ? "p-0" : "bg-white/5 backdrop-blur-sm border border-white/10 p-6 lg:p-8"}`}>
        {type !== "conversation" && (
          <>
            {/* Glow effect */}
            <div className="absolute -inset-1 bg-gradient-to-r from-purple-500/20 via-transparent to-blue-500/20 rounded-2xl blur-xl opacity-50"></div>
          </>
        )}
        
        <div className="relative">
          {type === "conversation" && !isSubmitted && (
            <div className="relative w-full max-w-[400px] mx-auto">
              <div className="scenario-chat-container">
                <div className="scenario-chat-options">
                  <div className="scenario-chat">
                    <div className="scenario-chat-bot">
                      <textarea
                        placeholder="Describe your scenario..."
                        className="scenario-textarea"
                        value={scenarioText}
                        onChange={(e) => setScenarioText(e.target.value)}
                      />
                    </div>
                    <div className="scenario-options">
                      <button className="scenario-btn-submit" onClick={handleSubmit}>
                        <Send className="w-5 h-5" />
                      </button>
                    </div>
                  </div>
                </div>
                <div className="scenario-tags">
                  <span onClick={() => handleTagClick("Job Interview")}>Job Interview</span>
                  <span onClick={() => handleTagClick("Travel")}>Travel</span>
                  <span onClick={() => handleTagClick("Dating")}>Dating</span>
                </div>
              </div>
            </div>
          )}

          {type === "conversation" && isSubmitted && (
            <div className="relative w-full max-w-[400px] mx-auto">
              <div className="scenario-success-container">
                <div className="scenario-success-inner">
                  <button 
                    onClick={() => setIsSubmitted(false)}
                    className="scenario-back-button"
                  >
                    <ArrowLeft className="w-4 h-4" />
                  </button>
                  <div className="scenario-success-icon">
                    <Sparkles className="w-8 h-8" />
                  </div>
                  <h3 className="scenario-success-title">Awesome!</h3>
                  <p className="scenario-success-subtitle">Great scenario idea! Open Fluoverse and submit this scenario request through the app.</p>
                  <motion.a
                    href={isMobileDevice() ? "#" : getFluoverseUrl()}
                    target={isMobileDevice() ? undefined : "_blank"}
                    rel={isMobileDevice() ? undefined : "noopener noreferrer"}
                    onClick={(e) => {
                      trackBenefitsScenarioOpenFluoverse();
                      if (isMobileDevice()) {
                        e.preventDefault();
                        e.stopPropagation();
                        openFluoverseApp();
                      }
                    }}
                    whileHover={{ scale: 1.02 }}
                    whileTap={{ scale: 0.98 }}
                    className="scenario-success-button"
                    style={{ pointerEvents: 'auto' }}
                  >
                    Open Fluoverse
                  </motion.a>
                </div>
              </div>
            </div>
          )}

          {type === "voice" && <VoiceTester />}

          {type === "students" && (
            <div className="space-y-4">
              <div className="flex items-center justify-between mb-4">
                <p className="text-white/60 text-xs uppercase tracking-wider">Student Progress</p>
                <span className="text-green-400 text-xs font-medium">+24% this week</span>
              </div>
              {[
                { name: "Maria S.", progress: 85, sessions: 12 },
                { name: "Carlos R.", progress: 72, sessions: 8 },
                { name: "Ana L.", progress: 91, sessions: 15 },
              ].map((student, i) => (
                <div key={i} className="bg-white/5 rounded-xl p-3">
                  <div className="flex items-center justify-between mb-2">
                    <span className="text-white/90 font-medium text-sm">{student.name}</span>
                    <span className="text-white/60 text-xs">{student.sessions} sessions</span>
                  </div>
                  <div className="h-2 bg-white/10 rounded-full overflow-hidden">
                    <div 
                      className="h-full bg-gradient-to-r from-purple-500 to-blue-500 rounded-full transition-all duration-1000"
                      style={{ width: `${student.progress}%` }}
                    ></div>
                  </div>
                </div>
              ))}
            </div>
          )}

          {type === "analytics" && (
            <div className="space-y-5">
              {/* Statistics Cards */}
              <div className="grid grid-cols-2 gap-3 mb-4">
                {[
                  { icon: Flame, value: "24", label: "Micro scenarios completed", color: "text-purple-400" },
                  { icon: Clock, value: "47", label: "Minutes spent speaking", color: "text-purple-400" },
                  { icon: Blocks, value: "156", label: "Unique words used", color: "text-purple-400" },
                  { icon: BarChart3, value: "28%", label: "Progress", color: "text-purple-400" },
                ].map((stat, i) => {
                  const Icon = stat.icon;
                  return (
                    <div key={i} className="bg-white/5 rounded-xl p-3 border border-white/10">
                      <div className="flex items-center gap-2 mb-2">
                        <Icon className={`w-4 h-4 ${stat.color}`} />
                      </div>
                      <div className="text-xl font-bold text-white mb-0.5">{stat.value}</div>
                      <div className="text-white/60 text-xs leading-tight">{stat.label}</div>
                    </div>
                  );
                })}
              </div>

              {/* Progress Graph */}
              <div className="bg-white/5 rounded-xl p-4 border border-white/10">
                <div className="flex items-center justify-between mb-4">
                  <p className="text-white/80 font-medium text-sm">Student Progress</p>
                  <div className="flex items-center gap-3 text-xs">
                    <div className="flex items-center gap-1.5">
                      <div className="w-2 h-2 rounded-full bg-black"></div>
                      <span className="text-white/60">Class Average</span>
                    </div>
                    <div className="flex items-center gap-1.5">
                      <div className="w-2 h-2 rounded-full bg-orange-500"></div>
                      <span className="text-white/60">Selected Student</span>
                    </div>
                  </div>
                </div>
                {/* Simple Line Graph */}
                <div className="relative h-32">
                  {/* Y-axis labels */}
                  <div className="absolute left-0 top-0 h-full flex flex-col justify-between text-xs text-white/40 pr-2">
                    <span>5</span>
                    <span>4</span>
                    <span>3</span>
                    <span>2</span>
                    <span>1</span>
                    <span>0</span>
                  </div>
                  {/* Graph area */}
                  <div className="ml-8 h-full relative">
                    {/* Grid lines */}
                    <div className="absolute inset-0 flex flex-col justify-between">
                      {[0, 1, 2, 3, 4, 5].map((i) => (
                        <div key={i} className="h-px bg-white/10"></div>
                      ))}
                    </div>
                    {/* Graph lines */}
                    <svg className="absolute inset-0 w-full h-full" viewBox="0 0 200 120" preserveAspectRatio="none">
                      {/* Class Average line (black) - more varied */}
                      <polyline
                        points="0,110 28,105 60,100 85,95 115,88 142,75 180,65"
                        fill="none"
                        stroke="rgba(0,0,0,0.8)"
                        strokeWidth="2"
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      />
                      {/* Selected Student line (orange) - more active with peaks and valleys */}
                      <polyline
                        points="0,112 25,98 50,85 75,72 100,65 125,55 150,45 175,28 200,18"
                        fill="none"
                        stroke="rgb(249, 115, 22)"
                        strokeWidth="2.5"
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      />
                    </svg>
                    {/* X-axis labels */}
                    <div className="absolute -bottom-5 left-0 right-0 flex justify-between text-xs text-white/40">
                      <span>Wed</span>
                      <span>Thu</span>
                      <span>Fri</span>
                      <span>Sat</span>
                      <span>Sun</span>
                      <span>Mon</span>
                      <span>Tue</span>
                    </div>
                  </div>
                </div>
              </div>

              {/* Student Info */}
              <div className="bg-white/5 rounded-xl p-3 border border-white/10">
                <div className="flex items-center gap-3 mb-3">
                  <div className="w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center text-white font-semibold text-sm">
                    MS
                  </div>
                  <div className="flex-1">
                    <div className="text-white font-medium text-sm">Maria S.</div>
                    <div className="text-white/60 text-xs">maria.s@example.com</div>
                  </div>
                </div>
                <div className="text-white/60 text-xs bg-white/5 rounded-lg px-2 py-1.5 inline-block">
                  Language: Greek
                </div>
              </div>
            </div>
          )}

          {type === "growth" && (
            <div className="space-y-5">
              {/* Value Proposition Cards */}
              <div className="grid grid-cols-1 gap-4">
                {[
                  { 
                    icon: Volume2, 
                    title: "Immersive Voice Technology", 
                    description: "Cutting-edge AI voices that set you apart",
                    gradient: "from-purple-500/20 to-blue-500/20",
                    iconColor: "text-purple-400"
                  },
                  { 
                    icon: Zap, 
                    title: "Fast Scenario Creation", 
                    description: "Create custom practice scenarios in seconds",
                    gradient: "from-blue-500/20 to-purple-500/20",
                    iconColor: "text-blue-400"
                  },
                  { 
                    icon: MessageCircle, 
                    title: "Lightning-Quick Support", 
                    description: "Responsive support when you need it",
                    gradient: "from-purple-500/20 to-indigo-500/20",
                    iconColor: "text-purple-400"
                  },
                ].map((benefit, i) => {
                  const Icon = benefit.icon;
                  return (
                    <div key={i} className={`bg-gradient-to-br ${benefit.gradient} rounded-xl p-4 border border-white/10`}>
                      <div className="flex items-start gap-3">
                        <div className={`flex-shrink-0 w-10 h-10 rounded-lg bg-white/10 flex items-center justify-center`}>
                          <Icon className={`w-5 h-5 ${benefit.iconColor}`} />
                        </div>
                        <div className="flex-1 min-w-0">
                          <h4 className="text-white font-semibold text-sm mb-1">{benefit.title}</h4>
                          <p className="text-white/70 text-xs leading-relaxed">{benefit.description}</p>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>

              {/* Competitive Edge Highlight */}
              <div className="bg-gradient-to-r from-green-500/10 to-emerald-500/10 rounded-xl p-4 border border-green-500/20">
                <div className="flex items-center justify-center gap-2">
                  <Rocket className="w-5 h-5 text-green-400" />
                  <span className="text-green-400 font-medium text-sm">Gain a competitive edge</span>
                </div>
                <p className="text-white/70 text-xs text-center mt-2 leading-relaxed">
                  Keep students motivated and satisfied with technology that works for you
                </p>
              </div>
            </div>
          )}
        </div>
      </div>
    </motion.div>
  );
}

type BenefitsProps = {
  activeTab?: TabType;
  onTabChange?: (tab: TabType) => void;
};

export default function Benefits({ activeTab, onTabChange }: BenefitsProps) {
  const [internalTab, setInternalTab] = useState<TabType>("learners");
  const currentTab = activeTab ?? internalTab;
  const setTab = (tab: TabType) => {
    if (!activeTab) {
      setInternalTab(tab);
    }
    if (onTabChange) {
      onTabChange(tab);
    }
  };

  const effectiveTab: TabType = LEARNERS_ONLY_SITE ? "learners" : currentTab;

  const benefits = effectiveTab === "learners" ? learnerBenefits : tutorBenefits;

  return (
    <section id="benefits" className="py-24 overflow-hidden">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="text-center mb-16"
        >
          <h3 className="peer text-sm uppercase tracking-[0.2em] text-white/60 font-medium mb-2 transition-all duration-300 hover:text-white/90 inline-block cursor-default select-none">
            Benefits
          </h3>
          <div className="h-px w-16 bg-gradient-to-r from-transparent via-white/40 to-transparent mx-auto transition-all duration-300 peer-hover:via-white/70 peer-hover:w-24 mb-4"></div>
          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-bold text-white mb-6">
            Designed for <span className="text-purple-400">Real Results</span>
          </h2>
          
          {/* Tab Switcher — hidden in learners-only mode (tutor UX preserved in code) */}
          {!LEARNERS_ONLY_SITE && (
          <div className="inline-flex items-center p-1.5 bg-white/5 backdrop-blur-sm rounded-full border border-white/10 mt-2">
            <button
              onClick={() => { setTab("learners"); trackBenefitsTabSwitch("learners"); }}
              className={`relative flex items-center gap-2 px-6 py-3 rounded-full font-medium transition-all duration-300 ${
                currentTab === "learners"
                  ? "text-white"
                  : "text-white/60 hover:text-white/80"
              }`}
            >
              {currentTab === "learners" && (
                <motion.div
                  layoutId="activeTab"
                  className="absolute inset-0 bg-gradient-to-r from-purple-600 to-purple-500 rounded-full"
                  transition={{ type: "spring", bounce: 0.2, duration: 0.6 }}
                />
              )}
              <GraduationCap className="w-5 h-5 relative z-10" />
              <span className="relative z-10">For Learners</span>
            </button>
            <button
              onClick={() => { setTab("tutors"); trackBenefitsTabSwitch("tutors"); }}
              className={`relative flex items-center gap-2 px-6 py-3 rounded-full font-medium transition-all duration-300 ${
                currentTab === "tutors"
                  ? "text-white"
                  : "text-white/60 hover:text-white/80"
              }`}
            >
              {currentTab === "tutors" && (
                <motion.div
                  layoutId="activeTab"
                  className="absolute inset-0 bg-gradient-to-r from-blue-600 to-blue-500 rounded-full"
                  transition={{ type: "spring", bounce: 0.2, duration: 0.6 }}
                />
              )}
              <Users className="w-5 h-5 relative z-10" />
              <span className="relative z-10">For Tutors</span>
            </button>
          </div>
          )}
        </motion.div>

        {/* Benefits List */}
        <AnimatePresence mode="wait">
          <motion.div
            key={effectiveTab}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
            transition={{ duration: 0.4 }}
            className="space-y-14 lg:space-y-20"
          >
            {benefits.map((benefit, index) => {
              const Icon = benefit.icon;
              const isReversed = index % 2 === 1;
              
              return (
                <div
                  key={benefit.title}
                  className={`flex flex-col ${isReversed ? "lg:flex-row-reverse" : "lg:flex-row"} items-center gap-12 lg:gap-16 min-h-[540px] lg:min-h-[600px]`}
                >
                  {/* Content */}
                  <motion.div
                    initial={{ opacity: 0, x: isReversed ? 50 : -50 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    viewport={{ once: true, margin: "-100px" }}
                    transition={{ duration: 0.7, ease: "easeOut" }}
                    className="flex-1 text-center lg:text-left"
                  >
                    {/* Number badge */}
                    <div className="inline-flex items-center gap-3 mb-6">
                      <div className={`w-12 h-12 rounded-xl flex items-center justify-center ${
                        effectiveTab === "learners"
                          ? "bg-gradient-to-br from-purple-500/20 to-indigo-500/20 border border-purple-500/30"
                          : "bg-gradient-to-br from-blue-500/20 to-blue-400/20 border border-blue-500/30"
                      }`}>
                        <Icon className={`w-6 h-6 ${
                          effectiveTab === "learners" ? "text-purple-400" : "text-blue-400"
                        }`} />
                      </div>
                      <span className="text-white/40 text-sm font-medium">0{index + 1}</span>
                    </div>
                    
                    <h3 className="text-2xl sm:text-3xl lg:text-4xl font-bold text-white mb-4 leading-tight">
                      {benefit.title}
                    </h3>
                    <p className="text-white/70 text-lg leading-relaxed max-w-xl mx-auto lg:mx-0">
                      {benefit.description}
                    </p>
                  </motion.div>

                  {/* Mockup */}
                  <div className="flex-1 w-full max-w-md lg:max-w-none">
                    <BenefitMockup type={benefit.mockupType} isReversed={isReversed} />
                  </div>
                </div>
              );
            })}
          </motion.div>
        </AnimatePresence>

      </div>

      {/* Full-Width CTA Section - Carousel with Confidence Boost Cards */}
      <div className="w-full mt-20 lg:mt-28">
        {/* Top Border Line */}
        <div className="w-full h-px bg-gradient-to-r from-transparent via-white/20 to-transparent" />
        
        <motion.div
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8 }}
          className="relative w-full py-16 lg:py-24 overflow-hidden"
        >
          {/* Full Width Content */}
          <div className="relative z-10 w-full">
            
            {/* Top Carousel - Scrolls Left - Seamless Infinite */}
            <div className="relative mb-6 overflow-hidden">
              <div className="carousel-track animate-scroll-left gap-10">
                {/* Repeat cards multiple times to ensure full coverage - 7 unique names */}
                {[...Array(4)].map((_, setIndex) => (
                  [
                    { src: '/testimonials/Alicia.jpg', name: 'Alicia', boost: 87, weeks: 2 },
                    { src: '/testimonials/Hassan.jpg', name: 'Hassan', boost: 92, weeks: 3 },
                    { src: '/testimonials/Aurora.jpg', name: 'Aurora', boost: 78, weeks: 2 },
                    { src: '/testimonials/Marc.jpg', name: 'Marc', boost: 95, weeks: 4 },
                    { src: '/testimonials/Eleni.jpg', name: 'Eleni', boost: 84, weeks: 2 },
                    { src: '/testimonials/Dimitris.jpg', name: 'Dimitris', boost: 91, weeks: 3 },
                    { src: '/testimonials/Maria.jpg', name: 'Maria', boost: 88, weeks: 2 },
                  ].map((user, i) => (
                    <CarouselCard key={`top-${setIndex}-${i}`} user={user} />
                  ))
                ))}
              </div>
            </div>

            {/* Center Content */}
            <div className="max-w-4xl mx-auto text-center mb-12">
              {/* Main Headline */}
              <motion.h3
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.6, delay: 0.3 }}
                className="text-3xl sm:text-4xl lg:text-5xl xl:text-6xl font-bold text-white mb-6 leading-tight"
              >
                {effectiveTab === "learners" ? (
                  <>Join them and start speaking with <span className="text-purple-400">confidence</span></>
                ) : (
                  <>Give your students the tools to <span className="text-blue-400">succeed</span></>
                )}
              </motion.h3>

              {/* Testimonial Quote */}
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.6, delay: 0.4 }}
                className="mb-10"
              >
                <p className="text-white/70 text-lg sm:text-xl italic mb-2">
                  {effectiveTab === "learners" 
                    ? "\"I went from nervous to confident in just 2 weeks. The real conversations made all the difference!\"" 
                    : "\"My students are more engaged than ever. Their speaking confidence has skyrocketed.\""}
                </p>
                <p className="text-white/50 text-sm">
                  — {effectiveTab === "learners" ? "Maria, +88% confidence boost" : "Mateo, Spanish Teacher"}
                </p>
              </motion.div>

              {/* CTA Button */}
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.6, delay: 0.5 }}
                className="flex justify-center mb-8"
              >
                {effectiveTab === "learners" ? (
                  <a
                    href={isMobileDevice() ? "#" : getFluoverseUrl()}
                    target={isMobileDevice() ? undefined : "_blank"}
                    rel={isMobileDevice() ? undefined : "noopener noreferrer"}
                    onClick={(e) => {
                      trackBenefitsCtaTryFluoverse();
                      if (isMobileDevice()) {
                        e.preventDefault();
                        openFluoverseApp();
                      }
                    }}
                    className="premium-cta-button"
                  >
                    <div className="dots_border"></div>
                    <div className="sparkle premium-icon-wrapper">
                      <div className="icon-glow"></div>
                      <Play className="w-7 h-7 premium-icon" />
                    </div>
                    <span className="text_button">
                      Try Fluoverse
                    </span>
                  </a>
                ) : (
                  <a 
                    href="https://calendly.com/panosmoschos7/30min" 
                    target="_blank" 
                    rel="noopener noreferrer"
                    onClick={() => trackBenefitsCtaBookCall()}
                    className="premium-cta-button"
                  >
                    <div className="dots_border"></div>
                    <div className="sparkle premium-icon-wrapper">
                      <div className="icon-glow"></div>
                      <Phone className="w-7 h-7 premium-icon" />
                    </div>
                    <span className="text_button">
                      Book a Call
                    </span>
                  </a>
                )}
              </motion.div>

            </div>

            {/* Bottom Carousel - Scrolls Right - Seamless Infinite */}
            <div className="relative overflow-hidden">
              <div className="carousel-track animate-scroll-right gap-10">
                {/* Repeat cards multiple times to ensure full coverage - Same 7 unique names */}
                {[...Array(4)].map((_, setIndex) => (
                  [
                    { src: '/testimonials/Alicia.jpg', name: 'Alicia', boost: 87, weeks: 2 },
                    { src: '/testimonials/Hassan.jpg', name: 'Hassan', boost: 92, weeks: 3 },
                    { src: '/testimonials/Aurora.jpg', name: 'Aurora', boost: 78, weeks: 2 },
                    { src: '/testimonials/Marc.jpg', name: 'Marc', boost: 95, weeks: 4 },
                    { src: '/testimonials/Eleni.jpg', name: 'Eleni', boost: 84, weeks: 2 },
                    { src: '/testimonials/Dimitris.jpg', name: 'Dimitris', boost: 91, weeks: 3 },
                    { src: '/testimonials/Maria.jpg', name: 'Maria', boost: 88, weeks: 2 },
                  ].map((user, i) => (
                    <CarouselCard key={`bottom-${setIndex}-${i}`} user={user} />
                  ))
                ))}
              </div>
            </div>

          </div>
        </motion.div>

        {/* Bottom Border Line */}
        <div className="w-full h-px bg-gradient-to-r from-transparent via-white/20 to-transparent" />
      </div>
    </section>
  );
}

