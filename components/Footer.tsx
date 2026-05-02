"use client";

import Image from "next/image";
import { Mail, Youtube, Linkedin, Instagram } from "lucide-react";
import { motion } from "framer-motion";
import { trackFooterSocialClick } from "@/lib/analytics";

const socialLinks = [
  { icon: Linkedin, href: "https://www.linkedin.com/company/fluoverse", label: "LinkedIn", color: "#0077B5" },
  { icon: Youtube, href: "https://www.youtube.com/@fluoverse", label: "YouTube", color: "#FF0000" },
  { icon: Instagram, href: "https://www.instagram.com/fluoverse/", label: "Instagram", color: "#E4405F" },
  { 
    icon: () => (
      <svg className="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
        <path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-5.2 1.74 2.89 2.89 0 0 1 2.31-4.64 2.93 2.93 0 0 1 .88.13V9.4a6.84 6.84 0 0 0-1-.05A6.33 6.33 0 0 0 5 20.1a6.34 6.34 0 0 0 10.86-4.43v-7a8.16 8.16 0 0 0 4.77 1.52v-3.4a4.85 4.85 0 0 1-1-.1z"/>
      </svg>
    ), 
    href: "https://www.tiktok.com/@fluoverse", 
    label: "TikTok",
    color: "#000000",
    iconColor: "#FFFFFF"
  },
];

export default function Footer() {
  return (
    <footer className="relative bg-white/5 backdrop-blur-sm border-t border-white/10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {/* Logo */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="flex justify-center mb-8"
        >
          <a href="/" className="inline-block">
            <Image
              src="/logo.svg"
              alt="Fluoverse - Authentic Speaking Practice Platform"
              width={160}
              height={48}
              className="h-10 w-auto"
            />
          </a>
        </motion.div>

        {/* Email Badge */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, delay: 0.1 }}
          className="flex justify-center mb-8"
        >
          <div className="relative">
            <div className="absolute left-0 right-0 top-1/2 h-px bg-white/10"></div>
            <a
              href="mailto:operations@fluoverse.com"
              className="relative inline-flex items-center gap-3 px-6 py-3 bg-white/10 backdrop-blur-sm rounded-full border border-white/20 text-white hover:bg-white/15 hover:border-white/30 transition-all duration-300"
            >
              <Mail className="w-5 h-5" />
              <span className="text-sm font-medium">operations@fluoverse.com</span>
            </a>
          </div>
        </motion.div>

        {/* Navigation Links */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, delay: 0.2 }}
          className="flex flex-wrap justify-center gap-3 mb-8"
        >
          <a
            href="/contact"
            className="px-6 py-3 bg-white/10 backdrop-blur-sm rounded-full border border-white/20 text-white text-sm font-medium hover:bg-white/15 hover:border-white/30 transition-all duration-300"
          >
            Contact
          </a>
        </motion.div>

        {/* Divider */}
        <div className="h-px bg-white/10 mb-8"></div>

        {/* Bottom Section */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, delay: 0.3 }}
          className="flex flex-col md:flex-row items-center justify-between gap-6"
        >
          {/* Terms */}
          <a
            href="/terms"
            className="text-white/70 hover:text-white text-sm font-medium transition-colors"
          >
            Terms & Conditions
          </a>

          {/* Social Icons */}
          <div className="flex items-center gap-4">
            {socialLinks.map((social) => {
              const Icon = social.icon;
              const iconColor = (social as any).iconColor;
              const isTikTok = social.label === "TikTok";
              return (
                <a
                  key={social.label}
                  href={social.href}
                  target="_blank"
                  rel="noopener noreferrer"
                  aria-label={social.label}
                  onClick={() => trackFooterSocialClick(social.label)}
                  className={`social-icon relative w-11 h-11 rounded-full border border-white/20 flex items-center justify-center transition-colors duration-300 overflow-hidden ${
                    isTikTok ? "text-white" : "text-white/70"
                  }`}
                  style={{ 
                    '--social-color': social.color,
                    '--icon-color': iconColor || "#FFFFFF"
                  } as React.CSSProperties}
                >
                  <Icon className={`w-5 h-5 relative z-10 ${isTikTok ? "text-white" : ""}`} />
                </a>
              );
            })}
          </div>

          {/* Privacy Policy */}
          <a
            href="/privacy"
            className="text-white/70 hover:text-white text-sm font-medium transition-colors"
          >
            Privacy Policy
          </a>
        </motion.div>
      </div>
    </footer>
  );
}
