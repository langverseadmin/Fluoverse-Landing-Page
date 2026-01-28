"use client";

import Link from "next/link";
import Image from "next/image";
import { CheckCircle2, Home } from "lucide-react";

export default function UnsubscribePage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-[#3b0764] via-purple-900 via-pink-900 to-purple-800 flex items-center justify-center px-4 relative overflow-hidden">
      {/* Animated background gradient */}
      <div className="absolute inset-0">
        <div className="absolute inset-0 bg-gradient-to-br from-purple-600/30 via-pink-600/25 via-purple-600/25 to-purple-700/30" />
        <div
          className="absolute inset-0 opacity-20"
          style={{
            backgroundImage: `radial-gradient(circle at 2px 2px, white 1px, transparent 0)`,
            backgroundSize: "40px 40px",
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

        {/* Icon */}
        <div className="mb-6 flex justify-center">
          <CheckCircle2 className="h-20 w-20 text-emerald-300" />
        </div>

        {/* Title */}
        <h1 className="text-4xl md:text-5xl font-bold text-white mb-4">
          You&apos;re unsubscribed
        </h1>

        {/* Description */}
        <p className="text-xl text-white/80 mb-10 max-w-lg mx-auto">
          You have successfully unsubscribed from our newsletter.
        </p>

        {/* Action */}
        <div className="flex justify-center">
          <Link
            href="/"
            className="inline-flex items-center gap-2 px-6 py-3 bg-[#a855f7] text-white font-semibold rounded-full shadow-[0_10px_40px_rgba(168,85,247,0.35)] transition-all duration-200 hover:shadow-[0_12px_50px_rgba(168,85,247,0.45)] hover:scale-105"
          >
            <Home className="w-5 h-5" />
            Go Home
          </Link>
        </div>
      </div>
    </div>
  );
}




