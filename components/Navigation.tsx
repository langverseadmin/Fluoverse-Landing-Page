"use client";

import { useState, useEffect } from "react";
import { Menu, X } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { getFluoverseUrl, isMobileDevice, openFluoverseApp } from "@/lib/utils";
import Image from "next/image";
import { usePathname, useRouter } from "next/navigation";

export default function Navigation() {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const pathname = usePathname();
  const router = useRouter();

  // Track external link clicks in GA
  const trackLinkClick = (linkName: string, linkUrl: string) => {
    if (typeof window !== "undefined" && window.gtag) {
      window.gtag("event", "link_click", {
        event_category: "engagement",
        event_label: linkName,
        link_url: linkUrl,
        link_domain: new URL(linkUrl).hostname,
      });
    }
  };

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
          const offsetPosition = elementPosition - 80; // Account for navbar height
          
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
          const offsetPosition = elementPosition - 80; // Account for navbar height
          
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
    { name: "Community", href: "#community" },
    { name: "Testimonials", href: "#testimonials" },
    { name: "Pricing", href: "/pricing" },
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
                      handleHashLink(e, item.href, false);
                    } else if (item.external) {
                      trackLinkClick(item.name, item.href);
                    }
                  }}
                  className="group relative text-sm font-semibold tracking-tight text-white/70 transition-all duration-200 hover:text-white"
                >
                  {item.name}
                  <span className="absolute left-0 -bottom-2 h-px w-full scale-0 bg-gradient-to-r from-accent-200 via-white to-primary-200 opacity-0 transition-all duration-200 group-hover:scale-100 group-hover:opacity-100" />
                </a>
              );
            })}
            <div className="flex items-center space-x-3">
              <a
                href="https://calendly.com/panosmoschos7/30min"
                target="_blank"
                rel="noopener noreferrer"
                onClick={() => trackLinkClick("Book a call", "https://calendly.com/panosmoschos7/30min")}
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
            style={{ pointerEvents: 'auto' }}
          >
            <div className="px-4 pt-4 pb-6 space-y-3" style={{ touchAction: 'manipulation' }}>
              {navItems.map((item) => {
                const isHashLink = item.href.startsWith("#");
                const isPageLink = !item.external && !isHashLink;
                
                const handleClick = (e: React.MouseEvent<HTMLAnchorElement>) => {
                  e.preventDefault();
                  e.stopPropagation();
                  
                  if (item.external) {
                    trackLinkClick(item.name, item.href);
                    window.open(item.href, '_blank', 'noopener,noreferrer');
                    setIsMobileMenuOpen(false);
                  } else if (isHashLink) {
                    handleHashLink(e, item.href, true);
                  } else if (isPageLink) {
                    // Regular page link
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
                    className="block rounded-xl border border-white/5 bg-white/5 px-4 py-3 text-sm font-semibold text-white/85 transition-all duration-200 hover:border-white/15 hover:bg-white/10 active:bg-white/15"
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
                <a
                  href="https://calendly.com/panosmoschos7/30min"
                  target="_blank"
                  rel="noopener noreferrer"
                  onClick={(e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    trackLinkClick("Book a call", "https://calendly.com/panosmoschos7/30min");
                    window.open('https://calendly.com/panosmoschos7/30min', '_blank', 'noopener,noreferrer');
                    setIsMobileMenuOpen(false);
                  }}
                  className="block rounded-full border border-white/10 bg-white/5 px-5 py-3 text-center text-sm font-semibold text-white/90 transition-all duration-200 hover:border-white/25 hover:bg-white/10 active:bg-white/15"
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
                <a
                  href={isMobileDevice() ? "#" : getFluoverseUrl()}
                  target={isMobileDevice() ? undefined : "_blank"}
                  rel={isMobileDevice() ? undefined : "noopener noreferrer"}
                  onClick={(e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    if (isMobileDevice()) {
                      openFluoverseApp();
                    } else {
                      window.open(getFluoverseUrl(), '_blank', 'noopener,noreferrer');
                    }
                    setIsMobileMenuOpen(false);
                  }}
                  className="block rounded-full bg-[#a855f7] px-5 py-3 text-center text-sm font-semibold text-white shadow-[0_10px_40px_rgba(168,85,247,0.4)] transition-all duration-200 active:bg-[#9333ea]"
                  style={{ 
                    touchAction: 'manipulation', 
                    WebkitTapHighlightColor: 'transparent',
                    cursor: 'pointer',
                    userSelect: 'none',
                    WebkitTouchCallout: 'none'
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

