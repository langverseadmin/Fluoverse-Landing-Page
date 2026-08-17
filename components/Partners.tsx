"use client";

import { useState } from "react";
import { motion } from "framer-motion";
import Image from "next/image";
import "flag-icons/css/flag-icons.min.css";
import PartnerInquiryModal from "@/components/PartnerInquiryModal";

const audiences = [
  {
    src: "/partners/venues.png",
    alt: "Purple miniature city with cafés, rooftops, and gathering spots",
    title: "Venues & event hosts",
    body: "Coworking spaces, coliving, cafés, and organisers. Get featured where 10,000+ members already look for places to meet.",
  },
  {
    src: "/partners/relocations.png",
    alt: "Purple isometric office with passports, keys, and relocation desks",
    title: "Relocation & mobility",
    body: "Agencies, corporate mobility, and visa consultants. We handle the first month of social integration for the people you move.",
  },
  {
    src: "/partners/schools.png",
    alt: "Purple campus plaza with a university hall, classrooms, and graduation cap",
    title: "Schools & communities",
    body: "Language schools and expat schools. Give your students real language practice, speaking confidence, and a place to socialize beyond the classroom.",
  },
];

const countries = [
  { name: "United States", code: "us" },
  { name: "United Kingdom", code: "gb" },
  { name: "Spain", code: "es" },
  { name: "Germany", code: "de" },
  { name: "France", code: "fr" },
  { name: "Greece", code: "gr" },
];

export default function Partners() {
  const [formOpen, setFormOpen] = useState(false);

  return (
    <section
      id="become-a-partner"
      className="py-14 sm:py-16 lg:py-20"
      aria-labelledby="become-a-partner-heading"
    >
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.55 }}
          className="text-center"
        >
          <h2
            id="become-a-partner-heading"
            className="text-balance text-3xl font-bold leading-tight text-white sm:text-4xl lg:text-5xl"
          >
            Become a <span className="text-purple-400">Partner</span>
          </h2>
          <p className="mx-auto mt-6 max-w-3xl text-pretty leading-relaxed text-white/85 sm:mt-7 sm:text-lg">
            Fluoverse already connects 10,000+ members across six countries. If you
            work with people who just moved, or host the places they gather, we
            want to partner with you.
          </p>
        </motion.div>

        <div className="mt-10 grid grid-cols-1 gap-5 sm:mt-12 sm:grid-cols-3 lg:mt-14 lg:gap-6">
          {audiences.map((item, index) => (
            <motion.article
              key={item.title}
              initial={{ opacity: 0, y: 24 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: index * 0.08 }}
              className="group relative overflow-hidden rounded-2xl border border-white/10 bg-[#2a0f42]"
            >
              <div className="relative aspect-square w-full sm:aspect-[4/5]">
                <Image
                  src={item.src}
                  alt={item.alt}
                  fill
                  className="object-cover object-center transition-transform duration-700 ease-out group-hover:scale-[1.03]"
                  sizes="(max-width: 639px) 100vw, 33vw"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-[#1a0628]/95 via-[#1a0628]/35 to-transparent" />
              </div>
              <div className="absolute inset-x-0 bottom-0 p-5 sm:p-6">
                <h3 className="text-lg font-bold text-white sm:text-xl">{item.title}</h3>
                <p className="mt-2 text-sm leading-relaxed text-white/80">{item.body}</p>
              </div>
            </motion.article>
          ))}
        </div>

        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.12 }}
          className="mt-10 sm:mt-12"
        >
          <p className="mb-4 text-center text-xs font-medium uppercase tracking-[0.2em] text-white/55">
            Active in
          </p>
          <ul className="flex flex-wrap items-center justify-center gap-3 sm:gap-5">
            {countries.map((country) => (
              <li
                key={country.code}
                className="flex items-center gap-2 text-sm font-medium text-white/80"
              >
                <span
                  className={`fi fi-${country.code} overflow-hidden rounded-[2px] text-base shadow-sm`}
                  aria-hidden
                />
                {country.name}
              </li>
            ))}
          </ul>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="mt-10 text-center sm:mt-12"
        >
          <button
            type="button"
            onClick={() => setFormOpen(true)}
            className="neon-cta-3d inline-flex px-7 py-3.5 text-sm font-semibold text-white sm:text-base"
          >
            Become a Partner
          </button>
          <p className="mx-auto mt-4 max-w-md text-sm text-white/55">
            One intro. Tell us who you are and where you operate. We&apos;ll take it from there.
          </p>
        </motion.div>
      </div>

      <PartnerInquiryModal open={formOpen} onClose={() => setFormOpen(false)} />
    </section>
  );
}
