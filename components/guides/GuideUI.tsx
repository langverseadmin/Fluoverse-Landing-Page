"use client";

import type { ReactNode } from "react";
import Image from "next/image";
import { motion } from "framer-motion";
import type { AppBrandId } from "@/lib/guides/brands";
import AppLogo from "./AppLogo";

/* ─── Decorative aurora background ──────────────────────────────────────── */

export function GuideBackground() {
  return (
    <div
      className="pointer-events-none absolute inset-0 -z-10 overflow-hidden"
      aria-hidden
    >
      <div className="absolute -left-32 -top-24 h-[28rem] w-[28rem] rounded-full bg-purple-600/25 blur-[120px]" />
      <div className="absolute right-[-10rem] top-40 h-[26rem] w-[26rem] rounded-full bg-fuchsia-500/20 blur-[120px]" />
      <div className="absolute bottom-0 left-1/3 h-[24rem] w-[24rem] rounded-full bg-sky-500/10 blur-[130px]" />
      <div
        className="absolute inset-0 opacity-[0.04]"
        style={{
          backgroundImage:
            "radial-gradient(circle at 1px 1px, white 1px, transparent 0)",
          backgroundSize: "32px 32px",
        }}
      />
    </div>
  );
}

/* ─── Motion reveal wrapper ─────────────────────────────────────────────── */

export function Reveal({
  children,
  delay = 0,
  className = "",
}: {
  children: ReactNode;
  delay?: number;
  className?: string;
}) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 24 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-60px" }}
      transition={{ duration: 0.55, delay, ease: [0.21, 0.47, 0.32, 0.98] }}
      className={className}
    >
      {children}
    </motion.div>
  );
}

/* ─── Eyebrow pill ──────────────────────────────────────────────────────── */

export function Eyebrow({ children }: { children: ReactNode }) {
  return (
    <span className="inline-flex items-center gap-2 rounded-full border border-purple-300/30 bg-purple-500/10 px-4 py-1.5 text-xs font-semibold uppercase tracking-[0.18em] text-purple-200 backdrop-blur-sm">
      <span className="h-1.5 w-1.5 rounded-full bg-purple-300 shadow-[0_0_8px_2px_rgba(216,180,254,0.6)]" />
      {children}
    </span>
  );
}

/* ─── Section heading with accent label + gradient rule ─────────────────── */

export function SectionHeading({
  label,
  title,
  subtitle,
  id,
}: {
  label: string;
  title: ReactNode;
  subtitle?: ReactNode;
  id?: string;
}) {
  return (
    <div className="mb-8">
      <p className="mb-3 text-xs font-semibold uppercase tracking-[0.2em] text-purple-300">
        {label}
      </p>
      <h2
        id={id}
        className="text-balance text-2xl font-bold leading-tight text-white sm:text-3xl lg:text-[2.5rem]"
      >
        {title}
      </h2>
      <div className="mt-4 h-px w-20 bg-gradient-to-r from-purple-400/80 via-fuchsia-400/40 to-transparent" />
      {subtitle && (
        <p className="mt-4 max-w-2xl text-pretty leading-relaxed text-white/65">
          {subtitle}
        </p>
      )}
    </div>
  );
}

/* ─── Glass card ────────────────────────────────────────────────────────── */

export function GlassCard({
  children,
  className = "",
  glow = false,
}: {
  children: ReactNode;
  className?: string;
  glow?: boolean;
}) {
  return (
    <div
      className={[
        "group relative overflow-hidden rounded-2xl border border-white/10 bg-white/[0.04] backdrop-blur-sm transition-all duration-300 hover:border-purple-300/40 hover:bg-white/[0.07]",
        glow ? "hover:shadow-[0_18px_60px_-20px_rgba(168,85,247,0.45)]" : "",
        className,
      ]
        .filter(Boolean)
        .join(" ")}
    >
      {children}
    </div>
  );
}

/* ─── User-voice quote card ─────────────────────────────────────────────── */

export function QuoteCard({ quote, tag }: { quote: string; tag: string }) {
  return (
    <figure className="relative h-full rounded-2xl border border-white/10 bg-gradient-to-br from-white/[0.06] to-white/[0.02] p-6">
      <span
        className="absolute right-4 top-2 select-none font-display text-5xl leading-none text-purple-400/25"
        aria-hidden
      >
        &rdquo;
      </span>
      <blockquote className="relative text-pretty leading-relaxed text-white/85">
        {quote}
      </blockquote>
      <figcaption className="mt-4 text-xs font-medium uppercase tracking-wider text-purple-300/80">
        {tag}
      </figcaption>
    </figure>
  );
}

/* ─── Numbered plan / step row ──────────────────────────────────────────── */

export function StepCard({
  number,
  title,
  children,
}: {
  number: string;
  title: string;
  children: ReactNode;
}) {
  return (
    <GlassCard className="p-5 sm:p-6" glow>
      <div className="flex items-start gap-4">
        <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-gradient-to-br from-purple-500 to-fuchsia-600 text-lg font-bold text-white shadow-lg shadow-purple-900/40">
          {number}
        </span>
        <div className="min-w-0">
          <h3 className="text-lg font-semibold text-white">{title}</h3>
          <div className="mt-2 text-sm leading-relaxed text-white/75">
            {children}
          </div>
        </div>
      </div>
    </GlassCard>
  );
}

/* ─── App countdown card (rank N → 1) ───────────────────────────────────── */

export function AppRankCard({
  rank,
  appId,
  name,
  pros,
  cons,
  bestFor,
  highlight = false,
  footer,
}: {
  rank: number;
  appId: AppBrandId;
  name: string;
  pros: string;
  cons: string;
  bestFor: string;
  highlight?: boolean;
  footer?: ReactNode;
}) {
  return (
    <div
      className={[
        "relative overflow-hidden rounded-2xl border p-6 transition-all duration-300",
        highlight
          ? "border-purple-300/60 bg-gradient-to-br from-purple-600/25 via-fuchsia-600/10 to-transparent shadow-[0_22px_70px_-24px_rgba(192,38,211,0.7)]"
          : "border-white/10 bg-white/[0.04] hover:border-purple-300/30 hover:bg-white/[0.07]",
      ].join(" ")}
    >
      {highlight && (
        <span className="absolute right-4 top-4 rounded-full bg-purple-400/20 px-3 py-1 text-[10px] font-bold uppercase tracking-widest text-purple-100 ring-1 ring-purple-300/40">
          Our pick
        </span>
      )}
      <div className="flex items-center gap-4">
        <AppLogo brand={appId} size={highlight ? 56 : 48} />
        <div className="min-w-0 flex-1">
          <div className="flex items-center gap-2">
            <span
              className={[
                "flex h-8 w-8 shrink-0 items-center justify-center rounded-lg text-sm font-extrabold",
                highlight
                  ? "bg-purple-400/25 text-purple-100"
                  : "bg-white/[0.06] text-white/45",
              ].join(" ")}
            >
              #{rank}
            </span>
            <h3
              className={[
                "text-xl font-bold",
                highlight ? "text-white" : "text-white/90",
              ].join(" ")}
            >
              {name}
            </h3>
          </div>
        </div>
      </div>
      <dl className="mt-4 space-y-1.5 text-sm">
        <div className="flex gap-2">
          <dt className="shrink-0 font-semibold text-emerald-300/90">Pros</dt>
          <dd className="text-white/75">{pros}</dd>
        </div>
        <div className="flex gap-2">
          <dt className="shrink-0 font-semibold text-amber-300/90">Cons</dt>
          <dd className="text-white/75">{cons}</dd>
        </div>
        <div className="flex gap-2">
          <dt className="shrink-0 font-semibold text-white/80">Best for</dt>
          <dd className="text-white/65">{bestFor}</dd>
        </div>
      </dl>
      {footer && <div className="mt-4">{footer}</div>}
    </div>
  );
}

/* ─── Image frame ───────────────────────────────────────────────────────── */

export function ImageFrame({
  src,
  alt,
  className = "",
  aspect = "aspect-[4/3]",
  priority = false,
}: {
  src: string;
  alt: string;
  className?: string;
  aspect?: string;
  priority?: boolean;
}) {
  return (
    <div
      className={[
        "relative overflow-hidden rounded-3xl border border-white/10 shadow-[0_24px_70px_-30px_rgba(0,0,0,0.7)]",
        aspect,
        className,
      ].join(" ")}
    >
      <Image
        src={src}
        alt={alt}
        fill
        className="object-cover"
        sizes="(max-width: 768px) 100vw, 50vw"
        priority={priority}
      />
      <div className="absolute inset-0 bg-gradient-to-t from-[#230a37]/70 via-transparent to-transparent" />
    </div>
  );
}

/* ─── Phone mockup (app scenario screen) ────────────────────────────────── */

export function PhoneMockup({
  src,
  alt,
  caption,
  className = "",
}: {
  src: string;
  alt: string;
  caption?: string;
  className?: string;
}) {
  return (
    <div
      className={["relative mx-auto w-full max-w-[260px]", className].join(" ")}
    >
      <div className="relative aspect-[9/19] overflow-hidden rounded-[2.5rem] border-[6px] border-zinc-800 bg-zinc-900 shadow-[0_30px_80px_-25px_rgba(147,51,234,0.55)]">
        <span
          className="absolute left-1/2 top-2 z-10 h-5 w-24 -translate-x-1/2 rounded-full bg-zinc-800"
          aria-hidden
        />
        <Image
          src={src}
          alt={alt}
          fill
          className="object-cover"
          sizes="260px"
        />
      </div>
      {caption && (
        <span className="mt-4 block text-center text-sm text-white/60">
          {caption}
        </span>
      )}
    </div>
  );
}

/* ─── Split feature (image + content, alternating) ──────────────────────── */

export function SplitFeature({
  image,
  imageSide = "right",
  children,
}: {
  image: ReactNode;
  imageSide?: "left" | "right";
  children: ReactNode;
}) {
  return (
    <div className="grid items-center gap-8 lg:grid-cols-2">
      <Reveal className={imageSide === "left" ? "lg:order-1" : "lg:order-2"}>
        {image}
      </Reveal>
      <Reveal
        delay={0.08}
        className={imageSide === "left" ? "lg:order-2" : "lg:order-1"}
      >
        {children}
      </Reveal>
    </div>
  );
}

/* ─── Hero (optional side image) ────────────────────────────────────────── */

export function GuideHero({
  eyebrow,
  title,
  accent,
  lead,
  meta,
  image,
}: {
  eyebrow: string;
  title: string;
  accent?: string;
  lead: string;
  meta?: string[];
  image?: { src: string; alt: string };
}) {
  return (
    <header className="relative mb-16">
      <div className={image ? "grid items-center gap-10 lg:grid-cols-2" : ""}>
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
        >
          <Eyebrow>{eyebrow}</Eyebrow>
          <h1 className="mt-5 text-balance text-4xl font-bold leading-[1.08] text-white sm:text-5xl lg:text-[3.5rem]">
            {title}{" "}
            {accent && (
              <span className="inline-block bg-gradient-to-r from-purple-300 via-fuchsia-300 to-purple-400 bg-clip-text pr-[0.12em] italic text-transparent">
                {accent}
              </span>
            )}
          </h1>
          <p className="mt-6 max-w-2xl text-lg leading-relaxed text-white/80">
            {lead}
          </p>
          {meta && meta.length > 0 && (
            <div className="mt-6 flex flex-wrap gap-2">
              {meta.map((m) => (
                <span
                  key={m}
                  className="rounded-full border border-white/15 bg-white/[0.05] px-3 py-1 text-xs font-medium text-white/70"
                >
                  {m}
                </span>
              ))}
            </div>
          )}
        </motion.div>
        {image && (
          <motion.div
            initial={{ opacity: 0, scale: 0.96 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 0.7, delay: 0.1 }}
          >
            <ImageFrame
              src={image.src}
              alt={image.alt}
              aspect="aspect-[4/5]"
              priority
            />
          </motion.div>
        )}
      </div>
    </header>
  );
}
