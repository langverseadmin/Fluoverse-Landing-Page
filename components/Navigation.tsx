"use client";

import { useState, useEffect } from "react";
import { Menu, X } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { getFluoverseUrl, isMobileDevice, openFluoverseApp } from "@/lib/utils";
import Image from "next/image";

export default function Navigation() {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 20);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  const navItems = [
    { name: "Benefits", href: "#benefits" },
    { name: "Community", href: "#community" },
    { name: "Testimonials", href: "#testimonials" },
    { name: "Blog", href: "https://blog.fluoverse.com", external: true },
  ];

  return (
    <nav
      className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
        isScrolled
          ? "bg-[#3b0764]/85 backdrop-blur-2xl border-b border-white/10 shadow-[0_20px_80px_rgba(0,0,0,0.35)]"
          : "bg-[#3b0764]/55 backdrop-blur-xl border-b border-white/5"
      }`}
    >
      <div className="absolute inset-0 bg-gradient-to-r from-white/5 via-transparent to-white/5 pointer-events-none" />

      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-20">
          {/* Logo */}
          <div className="flex items-center gap-3">
            <a href="/" className="flex items-center space-x-2">
              <Image
                src="/logo.svg"
                alt="Fluoverse - Authentic Speaking Practice Platform for English, Spanish, and Greek"
                width={160}
                height={48}
                className="h-12 w-auto rounded-lg"
                priority
              />
            </a>
          </div>

          {/* Desktop Navigation */}
          <div className="hidden md:flex items-center space-x-7">
            {navItems.map((item) => (
              <a
                key={item.name}
                href={item.href}
                target={item.external ? "_blank" : undefined}
                rel={item.external ? "noopener noreferrer" : undefined}
                className="group relative text-sm font-semibold tracking-tight text-white/70 transition-all duration-200 hover:text-white"
              >
                {item.name}
                <span className="absolute left-0 -bottom-2 h-px w-full scale-0 bg-gradient-to-r from-accent-200 via-white to-primary-200 opacity-0 transition-all duration-200 group-hover:scale-100 group-hover:opacity-100" />
              </a>
            ))}
            <div className="flex items-center space-x-3">
              <a
                href="https://calendly.com/panosmoschos7/30min"
                target="_blank"
                rel="noopener noreferrer"
                className="rounded-full border border-white/15 bg-white/5 px-4 py-2 text-sm font-semibold text-white/80 transition-all duration-200 hover:border-white/30 hover:text-white hover:shadow-[0_10px_40px_rgba(255,255,255,0.08)]"
              >
                Book a call
              </a>
              <a
                href={isMobileDevice() ? "#" : getFluoverseUrl()}
                target={isMobileDevice() ? undefined : "_blank"}
                rel={isMobileDevice() ? undefined : "noopener noreferrer"}
                onClick={(e) => {
                  if (isMobileDevice()) {
                    e.preventDefault();
                    openFluoverseApp();
                  }
                }}
                className="rounded-full bg-[#a855f7] px-5 py-2.5 text-sm font-semibold text-white shadow-[0_10px_40px_rgba(168,85,247,0.35)] transition-all duration-200 hover:shadow-[0_12px_50px_rgba(168,85,247,0.45)]"
              >
                Get started
              </a>
            </div>
          </div>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden p-2 text-white"
            onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
            aria-label="Toggle menu"
          >
            {isMobileMenuOpen ? (
              <X className="h-6 w-6" />
            ) : (
              <Menu className="h-6 w-6" />
            )}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      <AnimatePresence>
        {isMobileMenuOpen && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: "auto" }}
            exit={{ opacity: 0, height: 0 }}
            className="md:hidden bg-[#0f031d]/90 backdrop-blur-2xl border-t border-white/10"
          >
            <div className="px-4 pt-4 pb-6 space-y-3">
              {navItems.map((item) => (
                <a
                  key={item.name}
                  href={item.href}
                  target={item.external ? "_blank" : undefined}
                  rel={item.external ? "noopener noreferrer" : undefined}
                  className="block rounded-xl border border-white/5 bg-white/5 px-4 py-3 text-sm font-semibold text-white/85 transition-all duration-200 hover:border-white/15 hover:bg-white/10"
                  onClick={() => setIsMobileMenuOpen(false)}
                >
                  {item.name}
                </a>
              ))}
              <div className="grid grid-cols-1 gap-3 pt-1">
                <a
                  href="https://calendly.com/panosmoschos7/30min"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="block rounded-full border border-white/10 bg-white/5 px-5 py-3 text-center text-sm font-semibold text-white/90 transition-all duration-200 hover:border-white/25 hover:bg-white/10"
                  onClick={() => setIsMobileMenuOpen(false)}
                >
                  Book a call
                </a>
                <a
                  href={isMobileDevice() ? "#" : getFluoverseUrl()}
                  target={isMobileDevice() ? undefined : "_blank"}
                  rel={isMobileDevice() ? undefined : "noopener noreferrer"}
                  className="block rounded-full bg-[#a855f7] px-5 py-3 text-center text-sm font-semibold text-white shadow-[0_10px_40px_rgba(168,85,247,0.4)] transition-all duration-200"
                  onClick={(e) => {
                    if (isMobileDevice()) {
                      e.preventDefault();
                      openFluoverseApp();
                    }
                    setIsMobileMenuOpen(false);
                  }}
                >
                  Get started
                </a>
              </div>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </nav>
  );
}

