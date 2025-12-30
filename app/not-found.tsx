"use client";

import Link from 'next/link';
import Image from 'next/image';
import { Home, ArrowLeft } from 'lucide-react';

export default function NotFound() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-[#3b0764] via-purple-900 via-pink-900 to-purple-800 flex items-center justify-center px-4 relative overflow-hidden">
      {/* Animated background gradient */}
      <div className="absolute inset-0">
        <div className="absolute inset-0 bg-gradient-to-br from-purple-600/30 via-pink-600/25 via-purple-600/25 to-purple-700/30" />
        <div 
          className="absolute inset-0 opacity-20"
          style={{
            backgroundImage: `radial-gradient(circle at 2px 2px, white 1px, transparent 0)`,
            backgroundSize: '40px 40px'
          }}
        />
      </div>

      {/* Content */}
      <div className="relative z-10 max-w-2xl mx-auto text-center">
        {/* Logo */}
        <div className="mb-8 flex justify-center">
          <Link href="/" className="inline-block">
            <Image
              src="/logo.svg"
              alt="Fluoverse"
              width={200}
              height={70}
              className="h-16 w-auto rounded-lg"
              priority
            />
          </Link>
        </div>

        {/* 404 Number */}
        <div className="mb-6">
          <h1 className="text-9xl md:text-[12rem] font-black text-transparent bg-clip-text bg-gradient-to-r from-purple-300 via-pink-300 to-purple-300 leading-none">
            404
          </h1>
        </div>

        {/* Title */}
        <h2 className="text-4xl md:text-5xl font-bold text-white mb-4">
          Page Not Found
        </h2>

        {/* Description */}
        <p className="text-xl text-white/80 mb-10 max-w-lg mx-auto">
          Oops! The page you're looking for doesn't exist. It might have been moved, deleted, or you entered the wrong URL.
        </p>

        {/* Action Buttons */}
        <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
          <Link
            href="/"
            className="inline-flex items-center gap-2 px-6 py-3 bg-[#a855f7] text-white font-semibold rounded-full shadow-[0_10px_40px_rgba(168,85,247,0.35)] transition-all duration-200 hover:shadow-[0_12px_50px_rgba(168,85,247,0.45)] hover:scale-105"
          >
            <Home className="w-5 h-5" />
            Go Home
          </Link>
          
          <button
            onClick={() => window.history.back()}
            className="inline-flex items-center gap-2 px-6 py-3 bg-white/10 backdrop-blur-sm text-white font-semibold rounded-full border border-white/20 transition-all duration-200 hover:bg-white/20 hover:border-white/30"
          >
            <ArrowLeft className="w-5 h-5" />
            Go Back
          </button>
        </div>

        {/* Helpful Links */}
        <div className="mt-12 pt-8 border-t border-white/10">
          <p className="text-white/60 text-sm mb-4">You might be looking for:</p>
          <div className="flex flex-wrap justify-center gap-4 text-sm">
            <Link href="/" className="text-white/80 hover:text-white transition-colors">
              Home
            </Link>
            <Link href="/#features" className="text-white/80 hover:text-white transition-colors">
              Features
            </Link>
            <Link href="/#how-it-works" className="text-white/80 hover:text-white transition-colors">
              How It Works
            </Link>
            <Link href="/contact" className="text-white/80 hover:text-white transition-colors">
              Contact
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}

