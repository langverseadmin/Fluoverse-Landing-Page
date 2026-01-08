"use client";

import { motion } from "framer-motion";
import { useState, useRef, useMemo, useCallback, useEffect } from "react";

const stats = [
  {
    value: "7,500+",
    label: "Minutes Spoken",
  },
  {
    value: "500+",
    label: "Active Learners",
  },
  {
    value: "2,500+",
    label: "Conversations Started",
  },
];

export default function Features() {
  return (
    <section id="features" className="py-24">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="text-center mb-20"
        >
            <h2 className="text-4xl sm:text-5xl font-bold text-white mb-4 leading-tight">
            Fluoverse is Already Helping Learners
            <br />
            <span className="text-white/90">Speak with <span className="text-purple-400">Confidence</span></span>
          </h2>
        </motion.div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 lg:gap-8">
          {stats.map((stat, index) => (
            <StatCard key={index} stat={stat} index={index} />
          ))}
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

  // Format number with commas and plus sign
  const formattedValue = useMemo(() => {
    return count.toLocaleString() + '+';
  }, [count]);

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
  // Text center is approximately at 50% x, 30% y of card
  const shadowData = useMemo(() => {
    const textCenterX = 50;
    const textCenterY = 30;
    const dx = mousePosition.x - textCenterX;
    const dy = mousePosition.y - textCenterY;
    const distance = Math.sqrt(dx * dx + dy * dy);
    const maxDistance = 50;
    const shadowIntensity = Math.min(distance / maxDistance, 1);
    
    // Calculate shadow direction (opposite to light direction)
    const angle = Math.atan2(dy, dx);
    // Much longer shadow offset for dramatic effect
    const shadowOffsetX = Math.cos(angle + Math.PI) * shadowIntensity * 25;
    const shadowOffsetY = Math.sin(angle + Math.PI) * shadowIntensity * 25;

    if (shadowIntensity <= 0.05) {
      return { shadow: 'none', spotlight: `radial-gradient(circle at ${mousePosition.x}% ${mousePosition.y}%, rgba(255, 255, 255, 0.25) 0%, transparent 40%)` };
    }

    // Reduced to 10 layers for better performance
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
      className="group relative bg-white/5 backdrop-blur-sm rounded-2xl p-10 lg:p-12 border border-white/10 overflow-hidden"
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
      
      <div className="relative text-center md:text-left" ref={textRef}>
        <div 
          className="text-4xl sm:text-5xl lg:text-6xl font-bold text-white mb-4 tracking-tight will-change-[text-shadow]"
          style={{
            textShadow: shadowData.shadow
          }}
        >
          {formattedValue}
        </div>
        <div className="text-base sm:text-lg text-white/70 font-medium uppercase tracking-wider">
          {stat.label}
        </div>
      </div>
    </motion.div>
  );
}

