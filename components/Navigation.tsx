"use client";

import { useState, useEffect } from "react";
import { Menu, X } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import Image from "next/image";
import { usePathname, useRouter } from "next/navigation";
import {
  trackNavBookCall,
  trackNavLink,
  trackNavMobileMenuToggle,
} from "@/lib/analytics";
import { LEARNERS_ONLY_SITE } from "@/lib/config";

export default function Navigation() {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const pathname = usePathname();
  const router = useRouter();

  /** Top inset + bar height for hash scroll (floating glass nav) */
  const navClearance = 100;

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 20);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  // Handle hash scrolling when page loads with a hash
  useEffect(() => {
    if (pathname === "/" && window.location.hash) {
      const hash = window.location.hash;
      const scrollToElement = () => {
        const element = document.querySelector(hash);
        if (element) {
          // Get element position accounting for fixed navbar
          const elementPosition = element.getBoundingClientRect().top + window.pageYOffset;
          const offsetPosition = elementPosition - navClearance;
          
          // Use window.scrollTo for better mobile compatibility
          window.scrollTo({
            top: offsetPosition,
            behavior: "smooth"
          });
        }
      };
      
      // Wait for page to fully render
      setTimeout(scrollToElement, 100);
    }
  }, [pathname]);

  const handleHashLink = (e: React.MouseEvent<HTMLAnchorElement>, hash: string, closeMenu: boolean = false) => {
    e.preventDefault();
    e.stopPropagation();
    
    // Close menu first if needed
    if (closeMenu) {
      setIsMobileMenuOpen(false);
    }
    
    // If we're not on the home page, navigate to home page with hash
    if (pathname !== "/") {
      // Use window.location to navigate with hash (ensures hash is preserved and page scrolls)
      window.location.href = `/${hash}`;
    } else {
      // If we're on the home page, scroll to the section
      const scrollToElement = () => {
        const element = document.querySelector(hash);
        if (element) {
          // Update URL hash first
          window.history.pushState(null, '', hash);
          
          // Get element position accounting for fixed navbar
          const elementPosition = element.getBoundingClientRect().top + window.pageYOffset;
          const offsetPosition = elementPosition - navClearance;
          
          // Use window.scrollTo for better mobile compatibility
          window.scrollTo({
            top: offsetPosition,
            behavior: "smooth"
          });
        }
      };
      
      // Use setTimeout to ensure menu is closed and DOM is ready
      if (closeMenu) {
        // Wait for menu animation to complete
        setTimeout(scrollToElement, 200);
      } else {
        // Immediate scroll for desktop
        scrollToElement();
      }
    }
  };

  const navItems = [
  { name: "Benefits", href: "#benefits" },
  { name: "Testimonials", href: "#understand-journey" },
  { name: "Meetups", href: "#meetups" },
  { name: "Blog", href: "https://blog.fluoverse.com", external: true },
];

  return (
    <div className="fixed top-0 left-0 right-0 z-50 px-3 pt-3 pb-0 sm:px-5 sm:pt-4 md:px-8 md:pt-5 pointer-events-none">
      <div className="pointer-events-auto mx-auto max-w-7xl">
        <nav
          className={`relative overflow-hidden rounded-2xl sm:rounded-3xl border border-white/25 shadow-[0_4px_24px_rgba(0,0,0,0.06),0_18px_48px_-8px_rgba(59,7,100,0.35),inset_0_1px_0_rgba(255,255,255,0.45),inset_0_0_0_1px_rgba(255,255,255,0.06)] transition-all duration-500 ease-out ${
            isScrolled
              ? "bg-[#3b0764]/55 backdrop-blur-[28px] backdrop-saturate-[1.35] shadow-[0_8px_32px_rgba(0,0,0,0.12),0_22px_56px_-10px_rgba(59,7,100,0.45),inset_0_1px_0_rgba(255,255,255,0.5)]"
              : "bg-[#3b0764]/40 backdrop-blur-xl backdrop-saturate-125"
          }`}
        >
          {/* Glass sheen + purple depth */}
          <div
            className="pointer-events-none absolute inset-0 rounded-2xl sm:rounded-3xl bg-gradient-to-b from-white/[0.12] via-white/[0.02] to-transparent"
            aria-hidden
          />
          <div
            className="pointer-events-none absolute inset-0 rounded-2xl sm:rounded-3xl bg-gradient-to-br from-fuchsia-500/[0.07] via-transparent to-violet-950/[0.12]"
            aria-hidden
          />
          <div
            className="pointer-events-none absolute inset-x-5 top-0 h-px bg-gradient-to-r from-transparent via-white/45 to-transparent"
            aria-hidden
          />

          <div className="relative px-4 sm:px-6 lg:px-8">
            <div className="relative flex h-[4.25rem] items-center justify-between sm:h-20">
              {/* Logo */}
              <div className="relative z-10 flex shrink-0 items-center gap-3">
                <a href="/" className="flex items-center space-x-2">
                  <Image
                    src="/logo.svg"
                    alt="Fluoverse — speak-first practice to connect with locals and soften language gaps"
                    width={160}
                    height={48}
                    className="h-12 w-auto rounded-lg"
                    priority
                  />
                </a>
              </div>

              {/* Desktop: links + secondary CTAs centered in the bar (not Download) */}
              <nav
                className="pointer-events-none absolute inset-0 z-0 hidden items-center justify-center md:flex"
                aria-label="Main"
              >
                <div className="flex items-center space-x-6 lg:space-x-7 pointer-events-auto">
                  {navItems.map((item) => {
                    const isHashLink = item.href.startsWith("#");
                    const isPageLink = !item.external && !isHashLink;

                    return (
                      <a
                        key={item.name}
                        href={item.href}
                        target={item.external ? "_blank" : undefined}
                        rel={item.external ? "noopener noreferrer" : undefined}
                        onClick={(e) => {
                          if (isHashLink) {
                            trackNavLink(item.name, "desktop");
                            handleHashLink(e, item.href, false);
                          } else if (item.external) {
                            trackNavLink(item.name, "desktop");
                          } else {
                            trackNavLink(item.name, "desktop");
                          }
                        }}
                        className="relative rounded-full px-3 py-2 text-sm font-semibold tracking-tight text-white/75 outline-none transition-colors duration-200 hover:bg-white/[0.12] hover:text-white focus-visible:ring-2 focus-visible:ring-white/30 focus-visible:ring-offset-2 focus-visible:ring-offset-transparent"
                      >
                        {item.name}
                      </a>
                    );
                  })}
                  {!LEARNERS_ONLY_SITE && (
                    <a
                      href="https://calendly.com/panosmoschos7/30min"
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={() => trackNavBookCall("desktop")}
                      className="rounded-full border border-white/15 bg-white/5 px-4 py-2 text-sm font-semibold text-white/80 transition-all duration-200 hover:border-white/30 hover:text-white hover:shadow-[0_10px_40px_rgba(255,255,255,0.08)]"
                    >
                      Book a call
                    </a>
                  )}
                </div>
              </nav>

              {/* Download + mobile menu */}
              <div className="relative z-10 ml-auto flex items-center gap-3">
                <a
                  href="#download"
                  onClick={(e) => {
                    trackNavLink("Download now", "desktop");
                    handleHashLink(e, "#download", false);
                  }}
                  className="neon-cta-3d hidden px-5 py-2.5 text-sm font-semibold text-white md:inline-flex"
                >
                  Download now
                </a>
                <button
                  type="button"
                  className="p-2 text-white md:hidden"
                  onClick={() => {
                    const next = !isMobileMenuOpen;
                    setIsMobileMenuOpen(next);
                    trackNavMobileMenuToggle(next);
                  }}
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

            {/* Mobile Menu — extends same glass pill */}
            <AnimatePresence>
              {isMobileMenuOpen && (
                <motion.div
                  initial={{ opacity: 0, height: 0 }}
                  animate={{ opacity: 1, height: "auto" }}
                  exit={{ opacity: 0, height: 0 }}
                  className="md:hidden border-t border-white/15 bg-black/[0.12] backdrop-blur-md"
                  style={{ pointerEvents: "auto" }}
                >
                  <div className="px-4 pt-4 pb-6 space-y-3" style={{ touchAction: "manipulation" }}>
              {navItems.map((item) => {
                const isHashLink = item.href.startsWith("#");
                const isPageLink = !item.external && !isHashLink;
                
                const handleClick = (e: React.MouseEvent<HTMLAnchorElement>) => {
                  e.preventDefault();
                  e.stopPropagation();
                  trackNavLink(item.name, "mobile");
                  
                  if (item.external) {
                    window.open(item.href, '_blank', 'noopener,noreferrer');
                    setIsMobileMenuOpen(false);
                  } else if (isHashLink) {
                    handleHashLink(e, item.href, true);
                  } else if (isPageLink) {
                    router.push(item.href);
                    setIsMobileMenuOpen(false);
                  }
                };

                return (
                  <a
                    key={item.name}
                    href={item.href}
                    target={item.external ? "_blank" : undefined}
                    rel={item.external ? "noopener noreferrer" : undefined}
                    onClick={handleClick}
                    className="block rounded-xl border border-white/10 bg-white/[0.06] px-4 py-3 text-sm font-semibold text-white/90 transition-all duration-200 hover:border-white/20 hover:bg-white/10 active:bg-white/15"
                    style={{ 
                      touchAction: 'manipulation', 
                      WebkitTapHighlightColor: 'transparent',
                      cursor: 'pointer',
                      userSelect: 'none',
                      WebkitUserSelect: 'none',
                      minHeight: '44px',
                      display: 'flex',
                      alignItems: 'center',
                      WebkitTouchCallout: 'none'
                    }}
                  >
                    {item.name}
                  </a>
                );
              })}
              <div className="grid grid-cols-1 gap-3 pt-1">
                {!LEARNERS_ONLY_SITE && (
                <a
                  href="https://calendly.com/panosmoschos7/30min"
                  target="_blank"
                  rel="noopener noreferrer"
                  onClick={(e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    trackNavBookCall("mobile");
                    window.open('https://calendly.com/panosmoschos7/30min', '_blank', 'noopener,noreferrer');
                    setIsMobileMenuOpen(false);
                  }}
                  className="block rounded-full border border-white/15 bg-white/[0.06] px-5 py-3 text-center text-sm font-semibold text-white/90 transition-all duration-200 hover:border-white/25 hover:bg-white/10 active:bg-white/15"
                  style={{ 
                    touchAction: 'manipulation', 
                    WebkitTapHighlightColor: 'transparent',
                    cursor: 'pointer',
                    userSelect: 'none',
                    WebkitTouchCallout: 'none'
                  }}
                >
                  Book a call
                </a>
                )}
                <a
                  href="#download"
                  onClick={(e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    trackNavLink("Download now", "mobile");
                    handleHashLink(e, "#download", true);
                  }}
                  className="neon-cta-3d flex w-full justify-center px-5 py-3 text-sm font-semibold text-white"
                  style={{ 
                    touchAction: 'manipulation', 
                    WebkitTapHighlightColor: 'transparent',
                    cursor: 'pointer',
                    userSelect: 'none',
                    WebkitTouchCallout: 'none'
                  }}
                >
                  Download now
                </a>
              </div>
                  </div>
                </motion.div>
              )}
            </AnimatePresence>
          </div>
        </nav>
      </div>
    </div>
  );
}
