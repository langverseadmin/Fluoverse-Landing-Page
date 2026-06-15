"use client";
import Link from "next/link";
import SocialLink from "./SocialLink";
import GuideFAQ from "./GuideFAQ";
import GuideSoftCta from "./GuideSoftCta";
import EventListingCard from "./EventListingCard";
import { intercambioMadridData } from "@/lib/guides/spain-expat-data";
import {
  CITY_HERO_IMAGES,
  FLUOVERSE_SCENARIO_IMAGES,
  listingImageAlt,
} from "@/lib/guides/listing-images";
import {
  GuideBackground,
  GuideHero,
  Reveal,
  SectionHeading,
  GlassCard,
  PhoneMockup,
} from "./GuideUI";
export default function IntercambioMadridContent() {
  const data = intercambioMadridData;
  return (
    <article className="relative mx-auto max-w-4xl px-4 pb-24 pt-28 sm:px-6 lg:px-8">
      {" "}
      <GuideBackground />{" "}
      <GuideHero
        eyebrow={data.heroEyebrow ?? "Language exchange · Madrid 2026"}
        title={data.heroTitle}
        accent={data.heroAccent}
        lead={data.intro}
        meta={["Weekly schedules", "Beginner-friendly", "Updated 2026"]}
        image={{
          src: CITY_HERO_IMAGES.madrid.src,
          alt: CITY_HERO_IMAGES.madrid.alt,
        }}
      />{" "}
      {/* Exchanges , listing photos from Meetup */}{" "}
      <section aria-labelledby="exchanges-heading" className="mb-16">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="exchanges-heading"
            label="Where to go"
            title={
              <>
                {" "}
                Best language exchanges in Madrid{" "}
                <span className="text-white/40">/</span> Mejores language
                exchanges{" "}
              </>
            }
            subtitle="Photos match the Meetup listings we link to, confirm times on Meetup before you go."
          />{" "}
        </Reveal>{" "}
        <div className="space-y-4">
          {" "}
          {data.exchanges.map((exchange, i) => (
            <Reveal key={exchange.name} delay={i * 0.05}>
              {" "}
              <EventListingCard
                imageUrl={exchange.imageUrl}
                imageAlt={listingImageAlt(exchange.imageAlt, exchange.name)}
                source={exchange.source}
                channel={exchange.channel}
                footer={
                  <SocialLink
                    href={exchange.url}
                    channel={exchange.channel}
                    city="madrid"
                    unstyled
                    className="inline-flex rounded-full border border-purple-300/40 bg-purple-500/10 px-4 py-2 text-sm font-medium text-purple-100 hover:bg-purple-500/20"
                  >
                    {" "}
                    View on {exchange.source} →{" "}
                  </SocialLink>
                }
              >
                {" "}
                <span className="inline-block rounded-full bg-purple-500/15 px-3 py-1 text-xs font-semibold text-purple-200">
                  {" "}
                  {exchange.schedule}{" "}
                </span>{" "}
                <h3 className="mt-3 text-lg font-semibold text-white">
                  {exchange.name}
                </h3>{" "}
                <p className="mt-1 text-sm text-purple-200/80">
                  {exchange.neighborhood}
                </p>{" "}
                <p className="mt-2 text-sm leading-relaxed text-white/70">
                  {exchange.vibe}
                </p>{" "}
              </EventListingCard>{" "}
            </Reveal>
          ))}{" "}
        </div>{" "}
      </section>{" "}
      {/* Tips */}{" "}
      <Reveal>
        {" "}
        <section
          aria-labelledby="tips-heading"
          className="mb-16 rounded-3xl border border-white/10 bg-white/[0.04] p-6 sm:p-8"
        >
          {" "}
          <h2
            id="tips-heading"
            className="text-xl font-bold text-white sm:text-2xl"
          >
            {" "}
            How to get the most from your first language exchange{" "}
          </h2>{" "}
          <div className="mt-3 h-px w-20 bg-gradient-to-r from-purple-400/80 to-transparent" />{" "}
          <ul className="mt-5 space-y-2.5">
            {" "}
            {data.tips.map((tip) => (
              <li key={tip} className="flex gap-3 text-white/80">
                {" "}
                <span
                  className="mt-1 h-1.5 w-1.5 shrink-0 rounded-full bg-purple-400"
                  aria-hidden
                />{" "}
                <span className="leading-relaxed">{tip}</span>{" "}
              </li>
            ))}{" "}
          </ul>{" "}
        </section>{" "}
      </Reveal>{" "}
      {/* Scripts */}{" "}
      <section aria-labelledby="scripts-heading" className="mb-16">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="scripts-heading"
            label="Language & culture"
            title="Phrases to use tonight"
            subtitle="Practice these in Fluoverse before you go. Language and cultural context help you stay in the conversation and follow up after the event."
          />{" "}
        </Reveal>{" "}
        <div className="grid gap-8 lg:grid-cols-[1fr_260px] lg:items-start">
          {" "}
          <div className="space-y-3">
            {" "}
            {data.scripts.map((script, i) => (
              <Reveal key={script.situation} delay={i * 0.04}>
                {" "}
                <GlassCard className="p-5">
                  {" "}
                  <p className="text-xs font-semibold uppercase tracking-wider text-purple-300">
                    {" "}
                    {script.situation}{" "}
                  </p>{" "}
                  <p className="mt-2 text-lg font-medium text-white">
                    &ldquo;{script.spanish}&rdquo;
                  </p>{" "}
                  <p className="mt-1 text-sm text-white/55">
                    {script.english}
                  </p>{" "}
                </GlassCard>{" "}
              </Reveal>
            ))}{" "}
          </div>{" "}
          <Reveal className="hidden lg:block lg:sticky lg:top-28">
            {" "}
            <PhoneMockup
              src={FLUOVERSE_SCENARIO_IMAGES.supermarket.src}
              alt={FLUOVERSE_SCENARIO_IMAGES.supermarket.alt}
              caption="Fluoverse: language, culture, and real-life practice"
            />{" "}
          </Reveal>{" "}
        </div>{" "}
      </section>{" "}
      <Reveal>
        {" "}
        <GuideSoftCta
          heading="Stop feeling alone. Start feeling at home"
          body="Fluoverse helps you practice intro and follow-up lines, join recurring meetups, and learn local cultural context so night one is the start of something, not a one-off."
          placement="guide_intercambio_madrid"
        />{" "}
      </Reveal>{" "}
      {/* Related */}{" "}
      <Reveal>
        {" "}
        <section aria-labelledby="related-heading" className="mt-14">
          {" "}
          <h2
            id="related-heading"
            className="mb-4 text-lg font-bold text-white"
          >
            {" "}
            Related{" "}
          </h2>{" "}
          <div className="grid gap-3 sm:grid-cols-2">
            {" "}
            {data.relatedLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className="rounded-2xl border border-white/10 bg-white/[0.04] p-4 font-medium text-purple-300 transition-colors hover:border-purple-300/40 hover:bg-white/[0.07] hover:text-purple-200"
              >
                {" "}
                {link.label} →{" "}
              </Link>
            ))}{" "}
          </div>{" "}
        </section>{" "}
      </Reveal>{" "}
      <GuideFAQ faqs={data.faqs} />{" "}
    </article>
  );
}
