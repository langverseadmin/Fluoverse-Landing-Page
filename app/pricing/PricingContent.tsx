"use client";

import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Check, Mail } from "lucide-react";
import Link from "next/link";
import { getAppUrl, getPricingRedirectUrl, getTutorCheckoutUrl, LEARNERS_ONLY_SITE } from "@/lib/config";
import { trackPricingTabSwitch, trackPricingCtaClick } from "@/lib/analytics";

const learnerPlans = [
  {
    name: "Free",
    price: "€0",
    period: "forever",
    description: "Perfect for getting started",
    features: [
      "Access to basic speaking practice",
      "Limited conversations per month",
      "Community scenarios",
    ],
    cta: "Get Started",
    ctaLink: getAppUrl(),
    popular: false,
  },
  {
    name: "Premium",
    price: "€15",
    period: "per month",
    description: "For serious learners",
    features: [
      "Unlimited conversations",
      "Advanced speaking practice",
      "Create custom scenarios",
      "Access to Fluency Rooms for real speaking practice",
      "Priority support",
      "Ability to shape the product",
    ],
    cta: "Experience Real Fluency",
    ctaLink: getPricingRedirectUrl(),
    popular: true,
  },
];

const tutorPlan = {
  name: "Tutor Plan",
  price: "€10",
  period: "per student",
  description: "Perfect for language tutors and educators",
  features: [
    "Assign speaking practice to your studentsbusiness write Unmatched Value ",
    "Access to all premium features",
    "Seamless dashboard analytics",
    "Know what each student lacks",
    "Save time with automated insights",
    "Custom scenarios for the whole class",
    "Priority support",
  ],
  cta: "Empower your students",
  ctaLink: getTutorCheckoutUrl(),
  badgeText: "Real Fluency",
};

const businessPlan = {
  name: "Business",
  price: "Custom",
  period: "pricing",
  description: "Tailored solutions for your organization",
  features: [
    "Access to all premium features",
    "Seamless dashboard analytics",
    "Unmatched pricing",
    "Custom integrations with your tools",
    "Priority custom scenario creation",
    "Custom demos for your team",
    "The full Fluoverse experience",
    "Lightning fast support",
    "Exclusive perks and features",
  ],
  cta: "Contact Us",
  ctaLink: "/contact",
  isContact: true,
  badgeText: "Unmatched Value",
};

type TabType = "learners" | "tutors" | "businesses";

const getThemeColors = (tab: TabType) => {
  switch (tab) {
    case "learners":
      return {
        primary: "#a855f7", // metallic purple
        primaryLight: "#c084fc",
        primaryDark: "#9333ea",
        metallicGradient: "linear-gradient(135deg, #c084fc 0%, #a855f7 25%, #9333ea 50%, #7c3aed 75%, #a855f7 100%)",
        metallicGlow: "0 0 8px rgba(168,85,247,0.5), 0 0 12px rgba(168,85,247,0.3)",
        gradient: "from-purple-500/10 via-purple-500/10 to-purple-400/20",
        border: "border-purple-400/50",
        borderGlow: "0 0 4px rgba(168,85,247,0.4)",
        shadow: "rgba(168,85,247,0.2)",
        buttonShadow: "rgba(168,85,247,0.35)",
        buttonHoverShadow: "rgba(168,85,247,0.45)",
        checkColor: "text-purple-400",
        accent: "text-purple-400",
        tabBg: "bg-[#a855f7]",
        tabMetallic: "linear-gradient(135deg, #c084fc 0%, #a855f7 50%, #9333ea 100%)",
      };
    case "tutors":
      return {
        primary: "#3b82f6", // metallic blue/steel
        primaryLight: "#60a5fa",
        primaryDark: "#2563eb",
        metallicGradient: "linear-gradient(135deg, #60a5fa 0%, #3b82f6 25%, #2563eb 50%, #1d4ed8 75%, #3b82f6 100%)",
        metallicGlow: "0 0 8px rgba(59,130,246,0.5), 0 0 12px rgba(59,130,246,0.3)",
        gradient: "from-blue-500/10 via-blue-500/10 to-blue-400/20",
        border: "border-blue-400/50",
        borderGlow: "0 0 4px rgba(59,130,246,0.4)",
        shadow: "rgba(59,130,246,0.2)",
        buttonShadow: "rgba(59,130,246,0.35)",
        buttonHoverShadow: "rgba(59,130,246,0.45)",
        checkColor: "text-blue-400",
        accent: "text-blue-400",
        tabBg: "bg-[#3b82f6]",
        tabMetallic: "linear-gradient(135deg, #60a5fa 0%, #3b82f6 50%, #2563eb 100%)",
      };
    case "businesses":
      return {
        primary: "#fbbf24", // metallic gold
        primaryLight: "#fcd34d",
        primaryDark: "#f59e0b",
        metallicGradient: "linear-gradient(135deg, #fcd34d 0%, #fbbf24 25%, #f59e0b 50%, #d97706 75%, #fbbf24 100%)",
        metallicGlow: "0 0 8px rgba(251,191,36,0.5), 0 0 12px rgba(251,191,36,0.3)",
        gradient: "from-amber-500/10 via-amber-500/10 to-amber-400/20",
        border: "border-amber-400/50",
        borderGlow: "0 0 4px rgba(251,191,36,0.4)",
        shadow: "rgba(251,191,36,0.2)",
        buttonShadow: "rgba(251,191,36,0.35)",
        buttonHoverShadow: "rgba(251,191,36,0.45)",
        checkColor: "text-amber-400",
        accent: "text-amber-400",
        tabBg: "bg-[#fbbf24]",
        tabMetallic: "linear-gradient(135deg, #fcd34d 0%, #fbbf24 50%, #f59e0b 100%)",
      };
  }
};

export default function PricingContent() {
  const [activeTab, setActiveTab] = useState<TabType>("learners");

  const allTabs = [
    { id: "learners" as TabType, label: "For Learners" },
    { id: "tutors" as TabType, label: "For Tutors" },
    { id: "businesses" as TabType, label: "For Businesses" },
  ];

  const tabs = LEARNERS_ONLY_SITE ? allTabs.filter((t) => t.id === "learners") : allTabs;

  return (
    <div>
      {/* Tabs */}
      {tabs.length > 1 && (
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        transition={{ duration: 0.6 }}
        className="flex justify-center mb-12"
      >
        <div className="inline-flex bg-white/5 backdrop-blur-sm rounded-full p-1.5 border border-white/10">
          {tabs.map((tab) => (
            <button
              key={tab.id}
              onClick={() => { setActiveTab(tab.id); trackPricingTabSwitch(tab.id); }}
              className={`relative px-6 py-2.5 rounded-full text-sm font-semibold transition-all duration-200 ${
                activeTab === tab.id
                  ? "text-white"
                  : "text-white/60 hover:text-white/80"
              }`}
            >
              {activeTab === tab.id && (
                <motion.div
                  layoutId="activeTab"
                  className="absolute inset-0 rounded-full"
                  style={{
                    background: getThemeColors(tab.id).tabMetallic,
                    boxShadow: getThemeColors(tab.id).metallicGlow,
                  }}
                  transition={{ type: "spring", bounce: 0.2, duration: 0.6 }}
                />
              )}
              <span className="relative z-10">{tab.label}</span>
            </button>
          ))}
        </div>
      </motion.div>
      )}

      {/* Tab Content */}
      <AnimatePresence mode="wait">
        {activeTab === "learners" && (
          <motion.div
            key="learners"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
            transition={{ duration: 0.3 }}
          >
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-5xl mx-auto">
              {learnerPlans.map((plan, index) => (
                <PricingCard key={plan.name} plan={plan} index={index} theme="learners" />
              ))}
            </div>
          </motion.div>
        )}

        {activeTab === "tutors" && (
          <motion.div
            key="tutors"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
            transition={{ duration: 0.3 }}
          >
            <div className="text-center mb-12">
              <h2 className="text-3xl sm:text-4xl font-bold text-white mb-3">
                For <span 
                  className="text-blue-400"
                  style={{
                    background: getThemeColors("tutors").metallicGradient,
                    WebkitBackgroundClip: "text",
                    WebkitTextFillColor: "transparent",
                    backgroundClip: "text",
                    filter: `drop-shadow(${getThemeColors("tutors").borderGlow})`,
                    textShadow: getThemeColors("tutors").metallicGlow,
                  }}
                >Tutors</span>
              </h2>
              <p className="text-white/70 text-lg">
                Empower your students with better speaking practice
              </p>
            </div>
            <div className="max-w-md mx-auto">
              <PricingCard plan={tutorPlan} index={0} theme="tutors" />
            </div>
          </motion.div>
        )}

        {activeTab === "businesses" && (
          <motion.div
            key="businesses"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
            transition={{ duration: 0.3 }}
          >
            <div className="text-center mb-12">
              <h2 className="text-3xl sm:text-4xl font-bold text-white mb-3">
                For <span 
                  className="text-amber-400"
                  style={{
                    background: getThemeColors("businesses").metallicGradient,
                    WebkitBackgroundClip: "text",
                    WebkitTextFillColor: "transparent",
                    backgroundClip: "text",
                    filter: `drop-shadow(${getThemeColors("businesses").borderGlow})`,
                    textShadow: getThemeColors("businesses").metallicGlow,
                  }}
                >Businesses</span>
              </h2>
              <p className="text-white/70 text-lg">
                Enterprise solutions for your team
              </p>
            </div>
            <div className="max-w-md mx-auto">
              <PricingCard plan={businessPlan} index={0} theme="businesses" />
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

interface Plan {
  name: string;
  price: string;
  period: string;
  description: string;
  features: string[];
  cta: string;
  ctaLink: string;
  popular?: boolean;
  isContact?: boolean;
  badgeText?: string;
}

function PricingCard({ plan, index, theme = "learners" }: { plan: Plan; index: number; theme?: TabType }) {
  const themeColors = getThemeColors(theme);
  
  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.5, delay: index * 0.1 }}
      className={`relative bg-white/5 backdrop-blur-sm rounded-2xl p-8 border ${
        plan.popular ? themeColors.border : "border-white/10"
      } overflow-hidden flex flex-col`}
      style={
        plan.popular
          ? {
              boxShadow: `0 20px 80px ${themeColors.shadow}, ${themeColors.borderGlow}`,
              borderColor: themeColors.primary,
            }
          : undefined
      }
    >
      {/* Popular Badge */}
      {plan.popular && (
        <div
          className="absolute top-0 right-0 text-white text-xs font-semibold px-4 py-1 rounded-bl-2xl rounded-tr-2xl"
          style={{
            background: themeColors.metallicGradient,
            boxShadow: themeColors.metallicGlow,
            textShadow: "0 0 10px rgba(0,0,0,0.5)",
          }}
        >
          Most Popular
        </div>
      )}
      {/* Custom Badge (e.g., Real Fluency for tutors) */}
      {plan.badgeText && !plan.popular && (
        <div
          className="absolute top-0 right-0 text-white text-xs font-semibold px-4 py-1 rounded-bl-2xl rounded-tr-2xl"
          style={{
            background: themeColors.metallicGradient,
            boxShadow: themeColors.metallicGlow,
            textShadow: "0 0 10px rgba(0,0,0,0.5)",
          }}
        >
          {plan.badgeText}
        </div>
      )}

      {/* Background Gradient */}
      <div className={`absolute inset-0 rounded-2xl pointer-events-none bg-gradient-to-b from-transparent ${themeColors.gradient} blur-md`}></div>

      {/* Metallic Shine Overlay */}
      {plan.popular && (
        <div 
          className="absolute inset-0 rounded-2xl pointer-events-none opacity-30"
          style={{
            background: `linear-gradient(135deg, transparent 0%, ${themeColors.primaryLight}20 30%, transparent 60%, ${themeColors.primaryDark}20 100%)`,
            mixBlendMode: "overlay",
          }}
        />
      )}

      {/* Border hints */}
      <div 
        className="absolute inset-0 rounded-2xl pointer-events-none"
        style={{
          border: `1px solid ${plan.popular ? themeColors.primary : 'rgba(255,255,255,0.1)'}`,
          boxShadow: plan.popular ? `inset 0 0 20px ${themeColors.primary}20` : undefined,
        }}
      ></div>
      <div className="absolute top-0 left-0 right-0 h-px bg-gradient-to-r from-transparent via-white/20 to-transparent"></div>

      <div className="relative flex flex-col h-full">
        {/* Header */}
        <div className="mb-6">
          <h3 className="text-2xl font-bold text-white mb-2">{plan.name}</h3>
          <p className="text-white/70 text-sm">{plan.description}</p>
        </div>

        {/* Price */}
        <div className="mb-6">
          <div className="flex items-baseline gap-2">
            <span className="text-4xl sm:text-5xl font-bold text-white">
              {plan.price}
            </span>
            {plan.price !== "Custom" && (
              <span className="text-white/60 text-lg">/{plan.period}</span>
            )}
          </div>
          {plan.price !== "Custom" && (
            <p className="text-white/40 text-xs mt-2">
              * Price does not include VAT
            </p>
          )}
        </div>

        {/* Features */}
        <ul className="space-y-4 mb-8 flex-grow">
          {plan.features.map((feature, idx) => (
            <li key={idx} className="flex items-start gap-3">
              <Check 
                className={`w-5 h-5 ${themeColors.checkColor} flex-shrink-0 mt-0.5`}
                style={{
                  filter: `drop-shadow(${themeColors.borderGlow})`,
                }}
              />
              <span className="text-white/80 text-sm">{feature}</span>
            </li>
          ))}
        </ul>

        {/* CTA Button */}
        <Link
          href={plan.ctaLink}
          target={plan.ctaLink.startsWith("http") ? "_blank" : undefined}
          rel={plan.ctaLink.startsWith("http") ? "noopener noreferrer" : undefined}
          onClick={() => trackPricingCtaClick(plan.name)}
          className={`block w-full text-center rounded-full px-6 py-3 text-sm font-semibold transition-all duration-200 ${
            plan.popular || plan.isContact || plan.badgeText
              ? "text-white relative overflow-hidden"
              : "border border-white/15 bg-white/5 text-white/80 hover:border-white/30 hover:text-white hover:shadow-[0_10px_40px_rgba(255,255,255,0.08)]"
          }`}
          style={
            plan.popular || plan.isContact || plan.badgeText
              ? {
                  background: themeColors.metallicGradient,
                  boxShadow: `${themeColors.metallicGlow}, 0 10px 40px ${themeColors.buttonShadow}`,
                  position: "relative",
                }
              : undefined
          }
          onMouseEnter={(e) => {
            if (plan.popular || plan.isContact || plan.badgeText) {
              e.currentTarget.style.boxShadow = `${themeColors.metallicGlow}, 0 12px 50px ${themeColors.buttonHoverShadow}`;
            }
          }}
          onMouseLeave={(e) => {
            if (plan.popular || plan.isContact || plan.badgeText) {
              e.currentTarget.style.boxShadow = `${themeColors.metallicGlow}, 0 10px 40px ${themeColors.buttonShadow}`;
            }
          }}
        >
          {plan.isContact ? (
            <span className="flex items-center justify-center gap-2">
              <Mail className="w-4 h-4" />
              {plan.cta}
            </span>
          ) : (
            plan.cta
          )}
        </Link>
      </div>
    </motion.div>
  );
}

