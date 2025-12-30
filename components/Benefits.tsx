"use client";

import { motion, AnimatePresence } from "framer-motion";
import { useMemo, useState, useEffect, useRef } from "react";
import { GraduationCap, Users, Globe, Sparkles, Mic, BarChart3, TrendingUp, Target, Zap, Coffee, ShoppingCart, Snowflake, UtensilsCrossed, Apple, Gift, Volume2, Lightbulb, X, Send, ArrowLeft, Phone, Play, Flame, Clock, Blocks, CheckCircle2, Rocket, MessageCircle, Bolt, Star } from "lucide-react";
import Image from "next/image";
import "flag-icons/css/flag-icons.min.css";
import { getFluoverseUrl } from "@/lib/utils";

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

  const handlePlay = () => {
    if (!audioRef.current) return;

    audioRef.current.src = languageConfig[selectedLanguage].audioFile;
    audioRef.current.play();
    setIsPlaying(true);
    animateAudioBars();

    audioRef.current.addEventListener("ended", () => {
      setIsPlaying(false);
      setAudioBars(Array(12).fill(8));
      if (intervalRef.current) clearInterval(intervalRef.current);
    });

    audioRef.current.addEventListener("error", () => {
      setIsPlaying(false);
      setAudioBars(Array(12).fill(8));
      if (intervalRef.current) clearInterval(intervalRef.current);
    });
  };

  const handleStop = () => {
    if (audioRef.current) {
      audioRef.current.pause();
      audioRef.current.currentTime = 0;
    }
    setIsPlaying(false);
    setAudioBars(Array(12).fill(8));
    if (intervalRef.current) clearInterval(intervalRef.current);
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
              className="expanding-button"
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
                  <button className="scenario-success-button">
                    Open Fluoverse
                  </button>
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

export default function Benefits() {
  const [activeTab, setActiveTab] = useState<"learners" | "tutors">("learners");
  const benefits = activeTab === "learners" ? learnerBenefits : tutorBenefits;

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
          
          {/* Tab Switcher */}
          <div className="inline-flex items-center p-1.5 bg-white/5 backdrop-blur-sm rounded-full border border-white/10 mt-2">
            <button
              onClick={() => setActiveTab("learners")}
              className={`relative flex items-center gap-2 px-6 py-3 rounded-full font-medium transition-all duration-300 ${
                activeTab === "learners"
                  ? "text-white"
                  : "text-white/60 hover:text-white/80"
              }`}
            >
              {activeTab === "learners" && (
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
              onClick={() => setActiveTab("tutors")}
              className={`relative flex items-center gap-2 px-6 py-3 rounded-full font-medium transition-all duration-300 ${
                activeTab === "tutors"
                  ? "text-white"
                  : "text-white/60 hover:text-white/80"
              }`}
            >
              {activeTab === "tutors" && (
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
        </motion.div>

        {/* Benefits List */}
        <AnimatePresence mode="wait">
          <motion.div
            key={activeTab}
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
                        activeTab === "learners"
                          ? "bg-gradient-to-br from-purple-500/20 to-indigo-500/20 border border-purple-500/30"
                          : "bg-gradient-to-br from-blue-500/20 to-blue-400/20 border border-blue-500/30"
                      }`}>
                        <Icon className={`w-6 h-6 ${
                          activeTab === "learners" ? "text-purple-400" : "text-blue-400"
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

        {/* CTA Button */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, delay: 0.3 }}
          className="flex justify-center mt-16 lg:mt-20"
        >
          {activeTab === "learners" ? (
            <a
              href={getFluoverseUrl()}
              target="_blank"
              rel="noopener noreferrer"
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
    </section>
  );
}

