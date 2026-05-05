"use client";

import { motion } from "framer-motion";
import Image from "next/image";
import { useState, useRef, useMemo, useCallback, useEffect } from "react";
import { LEARNERS_ONLY_SITE } from "@/lib/config";

type TestimonialsTab = "learners" | "tutors";

const baseTestimonials = [
  {
    name: "Hassan El Sayed",
    role: "Language Learner",
    image: "/testimonials/hassan.jpg", // Replace with actual image path
    quote: "I love the concept behind Fluoverse. The Fluency Rooms are amazing for real conversation practice.",
  },
  {
    name: "Alicia Seivers",
    role: "B2 Spanish Speaker",
    image: "/testimonials/Alicia.jpg",
    quote: "As a B2 level Spanish speaker, I really enjoyed the unique experience using Fluoverse to increase my conversation skills.",
  },
  {
    name: "Eleni Salapasidi",
    role: "Language Learner",
    image: "/testimonials/eleni.jpg", // Replace with actual image path
    quote: "I've tried every app, but Fluoverse is the first that actually gets me talking.",
  },
  {
    name: "Aurora Tzouma",
    role: "Language Learner",
    image: "/testimonials/aurora.jpg", // Replace with actual image path
    quote: "Fluoverse completely changed the way I practice speaking. For the first time, I actually feel confident using the language in real conversations.",
  },
];

const tutorTestimonial = {
  name: "Konstantinos Krouskas",
  role: "Greek Language Teacher",
  image: "/testimonials/Konstantinos_Krouskas.jpg",
  quote: "Fluoverse has been an excellent discovery. I have recommended Fluoverse to many of my students, and the feedback has been overwhelmingly positive.",

};

const statsAll = [
  {
    value: "1000+",
    label: "Language Learners",
  },
  {
    value: "40+",
    label: "Tutors",
  },
  {
    value: "5,000+",
    label: "Conversations Started",
  },
  {
    value: "10,000+",
    label: "Minutes Spoken",
  },
];

const stats =
  LEARNERS_ONLY_SITE
    ? statsAll.map((s) =>
        s.label === "Tutors" ? { value: "50+", label: "Speaking topics" } : s
      )
    : statsAll;

export default function Testimonials({ activeTab = "learners" }: { activeTab?: TestimonialsTab }) {
  const showTutorVariant = !LEARNERS_ONLY_SITE && activeTab === "tutors";
  const testimonials = showTutorVariant ? [tutorTestimonial, ...baseTestimonials.slice(1)] : baseTestimonials;

  return (
    <section id="testimonials" className="py-24">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* 4 Column Grid - Interchanging pattern */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {testimonials.map((testimonial, index) => {
            // Alternate order: even columns start with testimonial, odd columns start with stat
            const startWithStat = index % 2 === 1;
            
            return (
              <TestimonialCard
                key={index}
                testimonial={testimonial}
                stat={stats[index]}
                index={index}
                startWithStat={startWithStat}
              />
            );
          })}
        </div>
      </div>
    </section>
  );
}

function StatCard({ stat, index }: { stat: { value: string; label: string }; index: number }) {
  const [mousePosition, setMousePosition] = useState({ x: 50, y: 50 });
  const [count, setCount] = useState(0);
  const [hasAnimated, setHasAnimated] = useState(false);
  const [showShine, setShowShine] = useState(false);
  const cardRef = useRef<HTMLDivElement>(null);
  const textRef = useRef<HTMLDivElement>(null);
  const rafRef = useRef<number | null>(null);

  // Extract numeric value from stat.value (e.g., "5,000+" -> 5000)
  const targetValue = useMemo(() => {
    const numStr = stat.value.replace(/[^0-9]/g, '');
    return parseInt(numStr, 10);
  }, [stat.value]);

  // Intersection Observer for count-up animation
  useEffect(() => {
    if (!cardRef.current || hasAnimated) return;

    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting && !hasAnimated) {
            setHasAnimated(true);
            setShowShine(true);
            observer.disconnect();
            
            const duration = 2000; // 2 seconds
            const steps = 60;
            const increment = targetValue / steps;
            const stepDuration = duration / steps;
            let currentStep = 0;

            const timer = setInterval(() => {
              currentStep++;
              const nextValue = Math.min(Math.floor(increment * currentStep), targetValue);
              setCount(nextValue);

              if (nextValue >= targetValue) {
                clearInterval(timer);
                setCount(targetValue);
              }
            }, stepDuration);
          }
        });
      },
      { threshold: 0.3 }
    );

    observer.observe(cardRef.current);

    return () => observer.disconnect();
  }, [targetValue, hasAnimated]);

  // Format number with commas and plus sign (preserve percentage if present)
  const formattedValue = useMemo(() => {
    const hasPercent = stat.value.includes('%');
    return count.toLocaleString() + (hasPercent ? '%+' : '+');
  }, [count, stat.value]);

  const handleMouseMove = useCallback((e: React.MouseEvent<HTMLDivElement>) => {
    if (!cardRef.current) return;
    
    if (rafRef.current) {
      cancelAnimationFrame(rafRef.current);
    }
    
    rafRef.current = requestAnimationFrame(() => {
      if (!cardRef.current) return;
      const rect = cardRef.current.getBoundingClientRect();
      const x = ((e.clientX - rect.left) / rect.width) * 100;
      const y = ((e.clientY - rect.top) / rect.height) * 100;
      setMousePosition({ x, y });
    });
  }, []);

  const handleMouseLeave = useCallback(() => {
    if (rafRef.current) {
      cancelAnimationFrame(rafRef.current);
    }
    setMousePosition({ x: 50, y: 50 });
  }, []);

  // Calculate shadow offset based on light position
  const shadowData = useMemo(() => {
    const textCenterX = 50;
    const textCenterY = 30;
    const dx = mousePosition.x - textCenterX;
    const dy = mousePosition.y - textCenterY;
    const distance = Math.sqrt(dx * dx + dy * dy);
    const maxDistance = 50;
    const shadowIntensity = Math.min(distance / maxDistance, 1);
    
    const angle = Math.atan2(dy, dx);
    const shadowOffsetX = Math.cos(angle + Math.PI) * shadowIntensity * 25;
    const shadowOffsetY = Math.sin(angle + Math.PI) * shadowIntensity * 25;

    if (shadowIntensity <= 0.05) {
      return { shadow: 'none', spotlight: `radial-gradient(circle at ${mousePosition.x}% ${mousePosition.y}%, rgba(255, 255, 255, 0.25) 0%, transparent 40%)` };
    }

    const shadow = Array.from({ length: 10 }, (_, i) => {
      const progress = i / 9;
      const offsetX = shadowOffsetX * progress;
      const offsetY = shadowOffsetY * progress;
      const blur = 1 + progress * 2;
      const opacity = Math.max(shadowIntensity * (1 - progress * 0.7), 0.1);
      return `${offsetX}px ${offsetY}px ${blur}px rgba(0, 0, 0, ${opacity})`;
    }).join(', ');

    return {
      shadow,
      spotlight: `radial-gradient(circle at ${mousePosition.x}% ${mousePosition.y}%, rgba(255, 255, 255, 0.25) 0%, transparent 40%)`
    };
  }, [mousePosition.x, mousePosition.y]);

  return (
    <motion.div
      ref={cardRef}
      initial={{ opacity: 0, y: 30 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.5, delay: index * 0.1 }}
      className="group relative bg-white/5 backdrop-blur-sm rounded-2xl p-10 lg:p-12 border border-white/10 overflow-hidden h-full"
      style={{ boxShadow: 'none' }}
      onMouseMove={handleMouseMove}
      onMouseLeave={handleMouseLeave}
    >
      {/* More prominent bottom purple glow to match hero */}
      <div className="absolute inset-0 rounded-2xl pointer-events-none bg-gradient-to-b from-transparent via-purple-500/25 to-purple-400/40 blur-md"></div>

      {/* Border hints */}
      <div className="absolute inset-0 rounded-2xl border border-white/5 pointer-events-none"></div>
      <div className="absolute top-0 left-0 right-0 h-px bg-gradient-to-r from-transparent via-white/20 to-transparent"></div>
      <div className="absolute bottom-0 left-0 right-0 h-px bg-gradient-to-r from-transparent via-white/20 to-transparent"></div>
      
      {/* Shiny effect when card appears */}
      {showShine && (
        <div 
          className="absolute inset-0 rounded-2xl bg-gradient-to-r from-transparent via-white/20 to-transparent pointer-events-none"
          style={{
            animation: `shimmer 1.5s ease-in-out forwards`
          }}
        ></div>
      )}
      
      {/* Spotlight effect that follows mouse */}
      <div 
        className="absolute inset-0 rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none will-change-[background]"
        style={{
          background: shadowData.spotlight
        }}
      ></div>
      
      <div className="relative text-center md:text-left h-full flex flex-col justify-center" ref={textRef}>
        <div 
          className="text-2xl sm:text-3xl lg:text-4xl font-bold text-white mb-3 tracking-tight will-change-[text-shadow]"
          style={{
            textShadow: shadowData.shadow
          }}
        >
          {formattedValue}
        </div>
        <div className="text-xs sm:text-sm text-white/70 font-medium uppercase tracking-wider">
          {stat.label}
        </div>
      </div>
    </motion.div>
  );
}

function TestimonialCard({ testimonial, stat, index, startWithStat }: { testimonial: typeof baseTestimonials[0], stat: typeof stats[0], index: number, startWithStat: boolean }) {
  const [imageError, setImageError] = useState(false);
  
  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.5, delay: index * 0.1 }}
      className="flex flex-col gap-6 h-full"
    >
      {/* Testimonial Card Component - Full Portrait with Bottom Overlay */}
      <div className={`flex-[3] relative aspect-[2/3] rounded-2xl overflow-hidden ${startWithStat ? 'order-2' : 'order-1'}`}>
        {/* Full Portrait Image */}
        <div className="relative w-full h-full">
          {!imageError && (
            <Image
              src={testimonial.image}
              alt={`${testimonial.name}, ${testimonial.role} - Fluoverse language learning testimonial`}
              fill
              className="object-cover"
              unoptimized
              onError={() => setImageError(true)}
            />
          )}
          {/* Fallback gradient */}
          {imageError && (
            <div className="absolute inset-0 bg-gradient-to-br from-purple-400 to-indigo-400 flex items-center justify-center text-6xl font-bold text-white">
              {testimonial.name.charAt(0)}
            </div>
          )}
        </div>
        
        {/* Bottom Text Overlay with Gradient - Only bottom half */}
        <div className="absolute inset-x-0 bottom-0 h-1/2 bg-gradient-to-t from-black/90 via-black/70 to-transparent pb-6 px-6 flex flex-col justify-end">
          {/* Quote */}
          <p className="text-white text-sm font-medium leading-relaxed mb-2">
            &quot;{testimonial.quote}&quot;
          </p>
          
          {/* Author Name */}
          <div className="text-white font-semibold text-xs">
            {testimonial.name.toUpperCase()}
          </div>
          {testimonial.role && (
            <div className="text-white/70 text-[10px] mt-0.5">
              {testimonial.role}
            </div>
          )}
        </div>
      </div>

      {/* Stat Card Component */}
      <div className={`flex-1 ${startWithStat ? 'order-1' : 'order-2'}`}>
        <StatCard stat={stat} index={index} />
      </div>
    </motion.div>
  );
}

