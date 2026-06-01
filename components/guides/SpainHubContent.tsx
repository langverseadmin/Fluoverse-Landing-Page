"use client";
import Link from "next/link";
import Image from "next/image";
import type { SpainHubData } from "@/lib/guides/types";
import { CITY_HERO_IMAGES, STORY_IMAGES } from "@/lib/guides/listing-images";
import GuideFAQ from "./GuideFAQ";
import GuideSoftCta from "./GuideSoftCta";
import UserVideo from "@/components/UserVideo";
import {
  GuideBackground,
  GuideHero,
  Reveal,
  SectionHeading,
  GlassCard,
  QuoteCard,
  ImageFrame,
  SplitFeature,
} from "./GuideUI";
type SpainHubContentProps = { data: SpainHubData };
const cityPhotos: Record<string, { src: string; alt: string }> = {
  Madrid: CITY_HERO_IMAGES.madrid,
  Valencia: CITY_HERO_IMAGES.valencia,
};
export default function SpainHubContent({ data }: SpainHubContentProps) {
  return (
    <article className="relative mx-auto max-w-5xl px-4 pb-24 pt-28 sm:px-6 lg:px-8">
      {" "}
      <GuideBackground />{" "}
      <GuideHero
        eyebrow={data.heroEyebrow ?? "Spain · 2026 guide"}
        title={data.heroTitle}
        accent={data.heroAccent}
        lead={data.empathyIntro}
        meta={[
          "City-by-city plans",
          "Built by people who moved abroad",
          "Updated 2026",
        ]}
        image={{
          src: CITY_HERO_IMAGES.spainHub.src,
          alt: CITY_HERO_IMAGES.spainHub.alt,
        }}
      />{" "}
      {/* STAKES */}{" "}
      <section aria-labelledby="struggle-heading" className="mb-20">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="struggle-heading"
            label="What people who moved abroad told us"
            title="The walls are real , and almost none are your fault"
            subtitle={`${data.struggleInterviewIntro}. ${data.struggleIntro}`}
          />{" "}
        </Reveal>{" "}
        <div className="grid gap-4 sm:grid-cols-2">
          {" "}
          {data.struggleQuotes.map((q, i) => (
            <Reveal key={q.tag} delay={i * 0.06}>
              {" "}
              <QuoteCard quote={q.quote} tag={q.tag} />{" "}
            </Reveal>
          ))}{" "}
        </div>{" "}
      </section>{" "}
      {/* GUIDE empathy , split with image */}{" "}
      <section className="mb-20">
        {" "}
        <SplitFeature
          imageSide="left"
          image={
            <ImageFrame
              src={STORY_IMAGES.connectWithLocals.src}
              alt={STORY_IMAGES.connectWithLocals.alt}
              aspect="aspect-[4/3]"
            />
          }
        >
          {" "}
          <p className="text-xs font-semibold uppercase tracking-[0.2em] text-purple-300">
            {" "}
            We understand your journey{" "}
          </p>{" "}
          <h2 className="mt-3 text-2xl font-bold leading-tight text-white sm:text-3xl">
            {" "}
            Built by people who moved abroad who felt exactly this{" "}
          </h2>{" "}
          <div className="mt-4 h-px w-20 bg-gradient-to-r from-purple-400/80 to-transparent" />{" "}
          <p className="mt-5 text-pretty leading-relaxed text-white/80">
            {data.guideEmpathy}
          </p>{" "}
        </SplitFeature>{" "}
      </section>{" "}
      {/* PLAN , month timeline */}{" "}
      <section aria-labelledby="timeline-heading" className="mb-20">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="timeline-heading"
            label="The plan"
            title="Month 1 vs month 3 , what changes"
            subtitle="Friendships abroad follow a rhythm. Here's what to expect, and what to do at each stage."
          />{" "}
        </Reveal>{" "}
        <div className="relative space-y-4 before:absolute before:left-[1.35rem] before:top-2 before:h-[calc(100%-1rem)] before:w-px before:bg-gradient-to-b before:from-purple-400/60 before:to-transparent">
          {" "}
          {data.monthTimeline.map((item, i) => (
            <Reveal key={item.period} delay={i * 0.06}>
              {" "}
              <div className="relative flex gap-4">
                {" "}
                <span className="z-10 flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-gradient-to-br from-purple-500 to-fuchsia-600 text-sm font-bold text-white shadow-lg shadow-purple-900/40">
                  {" "}
                  {i + 1}{" "}
                </span>{" "}
                <GlassCard className="flex-1 p-5">
                  {" "}
                  <p className="font-semibold text-purple-200">
                    {item.period}
                  </p>{" "}
                  <p className="mt-2 text-white/80">
                    {" "}
                    <strong className="text-white">Feeling:</strong>{" "}
                    {item.feeling}{" "}
                  </p>{" "}
                  <p className="mt-1 text-white/70">
                    {" "}
                    <strong className="text-white">Do this:</strong>{" "}
                    {item.action}{" "}
                  </p>{" "}
                </GlassCard>{" "}
              </div>{" "}
            </Reveal>
          ))}{" "}
        </div>{" "}
      </section>{" "}
      {/* What works , text only; no decorative stock imagery */}{" "}
      <Reveal>
        {" "}
        <section
          aria-labelledby="what-works-heading"
          className="mb-20 rounded-3xl border border-emerald-400/20 bg-emerald-500/[0.06] p-6 sm:p-8"
        >
          {" "}
          <p className="text-xs font-semibold uppercase tracking-[0.2em] text-emerald-300">
            {" "}
            What actually works{" "}
          </p>{" "}
          <h2
            id="what-works-heading"
            className="mt-3 text-2xl font-bold leading-tight text-white sm:text-3xl"
          >
            {" "}
            Lessons from people who moved abroad who cracked it{" "}
          </h2>{" "}
          <ul className="mt-5 space-y-3">
            {" "}
            {data.whatWorks.map((item) => (
              <li key={item} className="flex gap-3 text-white/80">
                {" "}
                <span className="mt-1 text-emerald-300" aria-hidden>
                  {" "}
                  ✓{" "}
                </span>{" "}
                <span className="leading-relaxed">{item}</span>{" "}
              </li>
            ))}{" "}
          </ul>{" "}
        </section>{" "}
      </Reveal>{" "}
      {/* City cards with photos */}{" "}
      <section aria-labelledby="cities-heading" className="mb-20">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="cities-heading"
            label="Start here"
            title="City social calendars"
            subtitle="Local pages are more useful than a general Spain guide. Pick your city for weekly events, language exchanges, and a first-30-days plan."
          />{" "}
        </Reveal>{" "}
        <div className="grid gap-5 sm:grid-cols-2">
          {" "}
          {data.cityCards.map((card, i) => {
            const photo = cityPhotos[card.city];
            return (
              <Reveal key={card.city} delay={i * 0.06}>
                {" "}
                <Link href={card.href} className="group block h-full">
                  {" "}
                  <div className="h-full overflow-hidden rounded-3xl border border-white/10 bg-white/[0.04] transition-all duration-300 hover:border-purple-300/40 hover:shadow-[0_24px_70px_-30px_rgba(168,85,247,0.5)]">
                    {" "}
                    {photo && (
                      <div className="relative aspect-[16/9] overflow-hidden">
                        {" "}
                        <Image
                          src={photo.src}
                          alt={photo.alt}
                          fill
                          className="object-cover transition-transform duration-500 group-hover:scale-105"
                          sizes="(max-width: 640px) 100vw, 50vw"
                        />{" "}
                        <div className="absolute inset-0 bg-gradient-to-t from-[#230a37] via-[#230a37]/30 to-transparent" />{" "}
                        <h3 className="absolute bottom-4 left-5 text-2xl font-bold text-white">
                          {" "}
                          {card.city}{" "}
                        </h3>{" "}
                      </div>
                    )}{" "}
                    <div className="p-5">
                      {" "}
                      <p className="text-sm leading-relaxed text-white/70">
                        {card.blurb}
                      </p>{" "}
                      <p className="mt-3 text-sm font-medium text-purple-300 group-hover:text-purple-200">
                        {" "}
                        Open the {card.city} guide →{" "}
                      </p>{" "}
                    </div>{" "}
                  </div>{" "}
                </Link>{" "}
              </Reveal>
            );
          })}{" "}
        </div>{" "}
      </section>{" "}
      {/* Real user video */}{" "}
      <Reveal>
        {" "}
        <section className="mb-20">
          {" "}
          <SectionHeading
            label="Hear from someone who moved abroad"
            title="A real Fluoverse story"
            subtitle="Marc went from practicing with Fluoverse to a night out at a new favourite spot."
          />{" "}
          <UserVideo />{" "}
        </section>{" "}
      </Reveal>{" "}
      {/* More resources */}{" "}
      <Reveal>
        {" "}
        <section aria-labelledby="resources-heading" className="mb-20">
          {" "}
          <SectionHeading
            id="resources-heading"
            label="Go deeper"
            title="More resources"
          />{" "}
          <div className="grid gap-3 sm:grid-cols-2">
            {" "}
            <Link
              href="/guides/social-apps-expats-spain-2026"
              className="block h-full"
            >
              {" "}
              <GlassCard className="h-full p-5" glow>
                {" "}
                <p className="font-semibold text-purple-300">
                  {" "}
                  Essential social apps if you moved abroad in Spain (2026)
                  →{" "}
                </p>{" "}
                <p className="mt-2 text-sm text-white/60">
                  {" "}
                  WhatsApp, Meetup, Telegram, and what actually leads to plans,
                  counted down to our #1.{" "}
                </p>{" "}
              </GlassCard>{" "}
            </Link>{" "}
            <Link
              href="/guides/intercambio-idiomas-madrid"
              className="block h-full"
            >
              {" "}
              <GlassCard className="h-full p-5" glow>
                {" "}
                <p className="font-semibold text-purple-300">
                  {" "}
                  Best language exchanges in Madrid →{" "}
                </p>{" "}
                <p className="mt-2 text-sm text-white/60">
                  {" "}
                  The #1 social search term if you moved abroad in Spain, with
                  weekly schedules.{" "}
                </p>{" "}
              </GlassCard>{" "}
            </Link>{" "}
          </div>{" "}
        </section>{" "}
      </Reveal>{" "}
      {/* SUCCESS , split with after image */}{" "}
      <section className="mb-12">
        {" "}
        <SplitFeature
          imageSide="right"
          image={
            <ImageFrame
              src={STORY_IMAGES.afterFluoverse.src}
              alt={STORY_IMAGES.afterFluoverse.alt}
              aspect="aspect-[4/3]"
            />
          }
        >
          {" "}
          <p className="text-xs font-semibold uppercase tracking-[0.2em] text-fuchsia-300">
            {" "}
            The other side{" "}
          </p>{" "}
          <h2 className="mt-3 text-2xl font-bold leading-tight text-white sm:text-3xl">
            {" "}
            Live fully in your new community{" "}
          </h2>{" "}
          <div className="mt-4 h-px w-20 bg-gradient-to-r from-fuchsia-400/80 to-transparent" />{" "}
          <p className="mt-5 text-pretty text-lg leading-relaxed text-white/85">
            {" "}
            {data.successVision}{" "}
          </p>{" "}
        </SplitFeature>{" "}
      </section>{" "}
      <Reveal>
        {" "}
        <GuideSoftCta
          heading="Ready to feel at home, not just arrived?"
          body="Our founders relocated abroad and know how isolating the first months can feel. Fluoverse helps you find activities with people who share your interests, learn language and culture for real conversations, and keep interacting until friendships stick."
          placement="guide_spain_hub"
        />{" "}
      </Reveal>{" "}
      <GuideFAQ faqs={data.faqs} />{" "}
    </article>
  );
}
