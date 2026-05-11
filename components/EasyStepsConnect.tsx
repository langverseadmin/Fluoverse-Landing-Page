"use client";

import { useCallback, useLayoutEffect, useRef, useState } from "react";
import { motion } from "framer-motion";
import Image from "next/image";
import AppStoreBadgeLinks from "@/components/AppStoreBadgeLinks";
import {
  trackStoreBadgeAppStore,
  trackStoreBadgeGooglePlay,
} from "@/lib/analytics";

const steps = [
  {
    number: "01",
    image: "/step1.png",
    title: "Download the App",
    description: "Access local resources and conversation practice.",
    alt: "Illustration for downloading the Fluoverse app",
  },
  {
    number: "02",
    image: "/step2.png",
    title: "Practice Local Conversations",
    description: "Build your confidence with guided dialogues.",
    alt: "Illustration for practicing local conversations",
  },
  {
    number: "03",
    image: "/step3.png",
    title: "Connect with Locals",
    description: "Start meaningful interactions with nearby friends.",
    alt: "Illustration for connecting with locals",
  },
];

export default function EasyStepsConnect() {
  /** Real scroll viewport — must not be motion.* so refs + scroll fire reliably */
  const carouselRef = useRef<HTMLDivElement>(null);
  const slideRefs = useRef<(HTMLLIElement | null)[]>([]);
  const scrollRafRef = useRef(0);
  const [activeSlide, setActiveSlide] = useState(0);

  const updateActiveFromScroll = useCallback(() => {
    const root = carouselRef.current;
    const slides = slideRefs.current.filter(Boolean) as HTMLElement[];
    if (!root || slides.length === 0 || !window.matchMedia("(max-width: 767px)").matches) {
      return;
    }
    const r = root.getBoundingClientRect();
    const cx = r.left + r.width / 2;
    let bestI = 0;
    let bestD = Infinity;
    slides.forEach((el, i) => {
      const cr = el.getBoundingClientRect();
      const mx = cr.left + cr.width / 2;
      const d = Math.abs(mx - cx);
      if (d < bestD) {
        bestD = d;
        bestI = i;
      }
    });
    setActiveSlide(bestI);
  }, []);

  const scheduleScrollSync = useCallback(() => {
    cancelAnimationFrame(scrollRafRef.current);
    scrollRafRef.current = requestAnimationFrame(updateActiveFromScroll);
  }, [updateActiveFromScroll]);

  useLayoutEffect(() => {
    const root = carouselRef.current;
    if (!root) return;

    const mq = window.matchMedia("(max-width: 767px)");

    let ro: ResizeObserver | undefined;
    const teardown = () => {
      ro?.disconnect();
      ro = undefined;
    };

    const setup = () => {
      teardown();
      if (!mq.matches) {
        setActiveSlide(0);
        return;
      }
      ro = new ResizeObserver(() => scheduleScrollSync());
      ro.observe(root);
      slideRefs.current.forEach((s) => s && ro?.observe(s));
      requestAnimationFrame(() => requestAnimationFrame(() => scheduleScrollSync()));
    };

    const onMqChange = () => {
      if (mq.matches) setup();
      else teardown();
    };

    mq.addEventListener("change", onMqChange);
    setup();

    return () => {
      teardown();
      mq.removeEventListener("change", onMqChange);
    };
  }, [scheduleScrollSync]);

  const goToSlide = (index: number) => {
    const slide = slideRefs.current[index];
    slide?.scrollIntoView({ behavior: "smooth", inline: "center", block: "nearest" });
    setActiveSlide(index);
    requestAnimationFrame(() => scheduleScrollSync());
  };

  return (
    <section
      id="easy-steps"
      className="py-14 sm:py-16 lg:py-20"
      aria-labelledby="easy-steps-heading"
      aria-describedby="easy-steps-subtitle"
    >
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          viewport={{ once: true }}
          transition={{ duration: 0.55 }}
          className="text-center"
        >
          <h2
            id="easy-steps-heading"
            className="text-balance text-3xl font-bold leading-tight text-white sm:text-4xl lg:text-5xl"
          >
            3 Easy Steps to <span className="text-purple-400">Connect</span>
          </h2>
          <p
            id="easy-steps-subtitle"
            className="mx-auto mt-6 max-w-3xl text-pretty leading-relaxed text-white/85 sm:mt-7 sm:text-lg"
          >
            Integrate into your new community quickly and effortlessly.
          </p>
        </motion.div>

        <div className="mt-12 sm:mt-14 lg:mt-16">
          <nav
            className="mb-5 flex justify-center gap-2.5 md:hidden"
            aria-label="Swipe between steps — step indicators"
          >
            {steps.map((step, index) => {
              const selected = activeSlide === index;
              return (
                <button
                  key={step.number}
                  type="button"
                  aria-label={`Step ${step.number}: ${step.title}`}
                  aria-current={selected ? true : undefined}
                  onClick={() => goToSlide(index)}
                  className={[
                    "h-2 rounded-full transition-[width,background-color,opacity] duration-300 ease-out",
                    selected ? "w-7 bg-purple-400 opacity-100" : "w-2 bg-white/35 opacity-80 hover:bg-white/50",
                  ].join(" ")}
                />
              );
            })}
          </nav>

          <div
            ref={carouselRef}
            onScroll={scheduleScrollSync}
            role="region"
            aria-label="Three easy steps"
            aria-roledescription="carousel"
            className={[
              "-mx-4 px-4 sm:-mx-6 sm:px-6 md:mx-0 lg:px-0",
              "snap-x snap-mandatory overflow-x-auto overflow-y-visible pb-3",
              "scroll-smooth [-ms-overflow-style:none] [scrollbar-width:none] [&::-webkit-scrollbar]:hidden",
              "[-webkit-overflow-scrolling:touch]",
              "md:overflow-x-visible md:snap-none md:pb-0 md:[scrollbar-width:auto]",
            ].join(" ")}
          >
            <ul className="m-0 flex w-max list-none flex-nowrap gap-6 md:grid md:w-full md:max-w-none md:grid-cols-3 md:flex-none md:gap-6 lg:gap-8">
              {steps.map((step, index) => (
                <li
                  key={step.number}
                  ref={(node) => {
                    slideRefs.current[index] = node;
                  }}
                  className={[
                    "flex shrink-0 snap-center flex-col rounded-[1.75rem]",
                    "w-[min(22rem,calc(100vw-2.75rem))] max-w-none md:w-auto md:max-w-none",
                    "md:snap-none md:min-w-0",
                    "border border-zinc-200/90 bg-white px-6 pb-9 pt-6 shadow-[0_18px_50px_-24px_rgba(0,0,0,0.35)] lg:rounded-[2rem] lg:px-7 lg:pb-10",
                  ].join(" ")}
                >
                  <div className="relative mb-7 aspect-[9/16] w-full shrink-0 overflow-hidden rounded-2xl bg-zinc-50/90 ring-1 ring-zinc-200/70 lg:mb-8">
                    <span
                      className="absolute left-3 top-3 z-10 flex h-11 w-11 items-center justify-center rounded-full bg-[#7c3aed] text-[0.6875rem] font-semibold tracking-tight text-white shadow-md sm:left-4 sm:top-4 sm:h-12 sm:w-12 sm:text-xs"
                      aria-hidden
                    >
                      {step.number}
                    </span>
                    <Image
                      src={step.image}
                      alt={step.alt}
                      fill
                      className="object-cover object-[center_10%]"
                      sizes="(max-width: 767px) 90vw, 28vw"
                    />
                  </div>
                  <h3 className="text-center text-xl font-bold leading-snug text-zinc-900 sm:text-[1.35rem]">
                    {step.title}
                  </h3>
                  <p className="mt-2 text-center text-sm font-normal leading-relaxed text-zinc-600 sm:text-[0.9375rem]">
                    {step.description}
                  </p>
                </li>
              ))}
            </ul>
          </div>

          <div className="mx-auto mt-12 max-w-4xl sm:mt-14 lg:mt-16">
            <motion.div
              initial={{ opacity: 0 }}
              whileInView={{ opacity: 1 }}
              viewport={{ once: true }}
              transition={{ duration: 0.55, delay: 0.04 }}
              className="rounded-[1.75rem] border border-white/10 bg-white px-6 py-10 text-center shadow-[0_18px_50px_-24px_rgba(0,0,0,0.35)] sm:px-10 sm:py-12 lg:rounded-[2rem] lg:py-14"
              aria-labelledby="easy-steps-closing-heading"
            >
              <h2
                id="easy-steps-closing-heading"
                className="text-balance text-2xl font-bold leading-tight text-zinc-900 sm:text-3xl lg:text-4xl"
              >
                Feeling Isolated? You&apos;re Not Alone.
              </h2>
              <p className="mt-5 text-lg font-semibold text-zinc-800 sm:mt-6 sm:text-xl">
                We&apos;re here to support you.
              </p>
              <p className="mx-auto mt-6 max-w-prose text-pretty text-base leading-relaxed text-zinc-700 sm:mt-8 sm:text-lg">
                Moving to a new country can feel overwhelming and lonely. At Fluoverse, we understand that forming
                genuine friendships often comes with challenges like language barriers and cultural differences.
                Our app is designed to help you practice essential conversations, connect with locals, and make the
                integration process feel seamless. Imagine transforming your new life into a vibrant community
                filled with supportive relationships. Don&apos;t let the opportunity for new connections pass you
                by.
              </p>
              <div className="mx-auto mt-10 max-w-xl lg:mt-12">
                <AppStoreBadgeLinks
                  onAppStoreClick={() => trackStoreBadgeAppStore("easy_steps_isolation_cta")}
                  onGooglePlayClick={() => trackStoreBadgeGooglePlay("easy_steps_isolation_cta")}
                />
              </div>
            </motion.div>
          </div>
        </div>
      </div>
    </section>
  );
}
