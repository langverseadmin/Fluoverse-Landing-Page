"use client";

import { motion } from "framer-motion";
import { useState, useRef } from "react";
import { Play, Pause, Volume2, VolumeX } from "lucide-react";
import Image from "next/image";

interface UserVideoProps {
  videoUrl?: string;
  thumbnailUrl?: string;
  userName?: string;
  userRole?: string;
  userLocation?: string;
}

export default function UserVideo({
  videoUrl = "/testimonials/Marc.mp4",
  thumbnailUrl,
  userName = "Marc",
  userRole = "Language Learner",
  userLocation = "United States",
}: UserVideoProps) {
  const [isPlaying, setIsPlaying] = useState(false);
  const [isMuted, setIsMuted] = useState(false);
  const [showControls, setShowControls] = useState(false);
  const videoRef = useRef<HTMLVideoElement | null>(null);

  const togglePlay = () => {
    if (videoRef.current) {
      if (isPlaying) {
        videoRef.current.pause();
      } else {
        videoRef.current.play();
      }
      setIsPlaying(!isPlaying);
    }
  };

  const toggleMute = () => {
    if (videoRef.current) {
      videoRef.current.muted = !isMuted;
      setIsMuted(!isMuted);
    }
  };

  return (
    <section id="user-video" className="relative overflow-hidden py-16">
      <div className="relative mx-auto max-w-5xl px-4 sm:px-6 lg:px-8">
        {/* Video and Quote Container */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, ease: "easeOut" }}
          className="relative flex flex-col lg:flex-row items-center lg:items-stretch gap-8 lg:gap-12 justify-center"
        >
          {/* Video Container */}
          <div
            className="relative flex justify-center"
            onMouseEnter={() => setShowControls(true)}
            onMouseLeave={() => setShowControls(false)}
          >
            <div className="relative inline-block shadow-[0_20px_60px_-15px_rgba(147,51,234,0.3)] rounded-2xl overflow-hidden max-w-xs w-full">
            {/* Video Element */}
            <div className="relative bg-black rounded-2xl overflow-hidden">
              <video
                ref={videoRef}
                src={videoUrl}
                poster={thumbnailUrl}
                className="w-full h-full object-cover"
                loop
                muted={isMuted}
                playsInline
                onPlay={() => setIsPlaying(true)}
                onPause={() => setIsPlaying(false)}
              />

              {/* Play/Pause Overlay */}
              {!isPlaying && (
                <motion.div
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.3, ease: "easeOut" }}
                  className="absolute inset-0 flex items-center justify-center bg-black/30 backdrop-blur-sm"
                >
                  <motion.button
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    onClick={togglePlay}
                    className="w-16 h-16 rounded-full bg-white/10 backdrop-blur-md border border-white/20 flex items-center justify-center hover:bg-white/20 transition-all duration-300"
                  >
                    <Play className="w-8 h-8 text-white ml-0.5" fill="white" />
                  </motion.button>
                </motion.div>
              )}

              {/* Controls Bar */}
              {(showControls || !isPlaying) && (
                <motion.div
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0, y: 20 }}
                  className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/90 to-transparent p-4"
                >
                  <div className="flex items-center justify-end gap-4">
                    {/* Control Buttons */}
                    <motion.button
                      whileHover={{ scale: 1.1 }}
                      whileTap={{ scale: 0.9 }}
                      onClick={toggleMute}
                      className="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center text-white transition-all duration-300"
                    >
                      {isMuted ? (
                        <VolumeX className="w-5 h-5" />
                      ) : (
                        <Volume2 className="w-5 h-5" />
                      )}
                    </motion.button>
                    {isPlaying && (
                      <motion.button
                        whileHover={{ scale: 1.1 }}
                        whileTap={{ scale: 0.9 }}
                        onClick={togglePlay}
                        className="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center text-white transition-all duration-300"
                      >
                        <Pause className="w-5 h-5" />
                      </motion.button>
                    )}
                  </div>
                </motion.div>
              )}
              </div>
            </div>
          </div>

          {/* Quote Section - Book-like Design */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.6, delay: 0.2, ease: "easeOut" }}
            className="flex-1 max-w-md flex"
          >
            <div className="relative bg-gradient-to-br from-white/5 to-white/0 backdrop-blur-sm border border-white/10 rounded-2xl p-8 lg:p-10 shadow-xl w-full h-full flex flex-col justify-between overflow-hidden">
              {/* Decorative Quote Mark */}
              <div className="absolute top-6 left-6 text-purple-400/30 text-7xl font-serif leading-none">&quot;</div>
              
              {/* Quote Text */}
              <div className="relative z-10">
                <p className="text-white text-lg lg:text-xl leading-relaxed mb-6 font-light italic pl-6">
                  Out last night discovering a new favourite place to eat! La Tropical 🫶🏻 All of the food was amazing, and we were there courtesy of Marc winning one of @Fluoverse language sprints. If you haven&apos;t already, you need to check out this brand new app!
                </p>
                
                {/* Author */}
                <div className="relative pl-6">
                  <div className="flex items-center gap-4 mb-4">
                    <div className="relative w-12 h-12 rounded-full overflow-hidden flex-shrink-0">
                      <Image
                        src="/testimonials/Marc.jpg"
                        alt="Marc - 2nd Fluency Sprint Winner and Fluoverse language learner"
                        fill
                        className="object-cover"
                        unoptimized
                      />
                    </div>
                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-1">
                        <div className="text-white font-semibold text-base">Marc</div>
                      </div>
                      <div className="text-white/60 text-sm">2nd Fluency Sprint Winner</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </motion.div>
        </motion.div>
      </div>
    </section>
  );
}

