"use client";
import Link from "next/link";
import SocialLink from "./SocialLink";
import GuideFAQ from "./GuideFAQ";
import GuideSoftCta from "./GuideSoftCta";
import AppLogoStrip from "./AppLogoStrip";
import AppLogo from "./AppLogo";
import { socialAppsGuideData } from "@/lib/guides/spain-expat-data";
import { FLUOVERSE_SCENARIO_IMAGES } from "@/lib/guides/listing-images";
import {
  GuideBackground,
  GuideHero,
  Reveal,
  SectionHeading,
  AppRankCard,
  PhoneMockup,
  SplitFeature,
} from "./GuideUI";
const RANKED_APP_IDS = [
  "fluoverse",
  "meetup",
  "whatsapp",
  "playtomic",
  "facebook_groups",
  "telegram",
  "internations",
] as const;
export default function SocialAppsGuideContent() {
  const data = socialAppsGuideData;
  const ranked = data.apps.map((app, i) => ({ app, rank: i + 1 }));
  return (
    <article className="relative mx-auto max-w-4xl px-4 pb-24 pt-28 sm:px-6 lg:px-8">
      {" "}
      <GuideBackground />{" "}
      <GuideHero
        eyebrow={data.heroEyebrow ?? "Social apps · Spain 2026"}
        title={data.heroTitle}
        accent={data.heroAccent}
        lead={data.intro}
        meta={["Ranked best first", "Updated 2026", "Honest pros & cons"]}
      />{" "}
      <AppLogoStrip
        appIds={[...RANKED_APP_IDS]}
        caption="Apps we rank below, best first: Fluoverse, Meetup, WhatsApp, Playtomic, Facebook Groups, Telegram, and InterNations."
      />{" "}
      {/* WhatsApp = infrastructure */}{" "}
      <Reveal>
        {" "}
        <section
          aria-labelledby="whatsapp-heading"
          className="mb-16 overflow-hidden rounded-3xl border border-emerald-400/25 bg-gradient-to-br from-emerald-500/15 to-transparent p-6 sm:p-8"
        >
          {" "}
          <div className="flex items-start gap-4">
            {" "}
            <AppLogo brand="whatsapp" size={48} />{" "}
            <div>
              {" "}
              <h2
                id="whatsapp-heading"
                className="text-xl font-bold text-white sm:text-2xl"
              >
                {" "}
                {data.whatsAppSection.heading}{" "}
              </h2>{" "}
              <div className="mt-3 h-px w-20 bg-gradient-to-r from-emerald-400/80 to-transparent" />{" "}
              <ul className="mt-5 space-y-2.5">
                {" "}
                {data.whatsAppSection.points.map((point) => (
                  <li key={point} className="flex gap-3 text-white/80">
                    {" "}
                    <span
                      className="mt-1 h-1.5 w-1.5 shrink-0 rounded-full bg-emerald-300"
                      aria-hidden
                    />{" "}
                    <span className="leading-relaxed">{point}</span>{" "}
                  </li>
                ))}{" "}
              </ul>{" "}
            </div>{" "}
          </div>{" "}
        </section>{" "}
      </Reveal>{" "}
      {/* Ranked countdown */}{" "}
      <section aria-labelledby="apps-ranked-heading" className="mb-16">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="apps-ranked-heading"
            label="Ranked best first"
            title="Best social apps in Spain (ranked)"
            subtitle={data.rankingNote}
          />{" "}
        </Reveal>{" "}
        <div className="space-y-4">
          {" "}
          {ranked.map(({ app, rank }, i) => (
            <Reveal key={app.name} delay={i * 0.04}>
              {" "}
              <AppRankCard
                rank={rank}
                appId={app.appId}
                name={app.name}
                pros={app.pros}
                cons={app.cons}
                bestFor={app.bestFor}
                highlight={app.highlight}
                footer={
                  app.highlight ? (
                    <Link
                      href="/#download"
                      className="inline-flex items-center gap-2 rounded-full bg-white px-5 py-2.5 text-sm font-semibold text-purple-700 transition-transform hover:scale-[1.03]"
                    >
                      {" "}
                      Get Fluoverse free →{" "}
                    </Link>
                  ) : (
                    <SocialLink
                      href={app.url}
                      channel={app.channel}
                      city="spain"
                    >
                      {" "}
                      Open {app.name} →{" "}
                    </SocialLink>
                  )
                }
              />{" "}
            </Reveal>
          ))}{" "}
        </div>{" "}
      </section>{" "}
      {/* Fluoverse-only mockup , beside copy about rehearsing conversations */}{" "}
      <section className="mb-16">
        {" "}
        <SplitFeature
          imageSide="left"
          image={
            <PhoneMockup
              src={FLUOVERSE_SCENARIO_IMAGES.restaurant.src}
              alt={FLUOVERSE_SCENARIO_IMAGES.restaurant.alt}
              caption="Fluoverse scenario: language, culture, and real-life practice"
            />
          }
        >
          {" "}
          <p className="text-xs font-semibold uppercase tracking-[0.2em] text-purple-300">
            {" "}
            Why #1 is different{" "}
          </p>{" "}
          <h2 className="mt-3 text-2xl font-bold leading-tight text-white sm:text-3xl">
            {" "}
            Apps find the room. Stop feeling alone in Spain. Start feeling at home.{" "}
          </h2>{" "}
          <div className="mt-4 h-px w-20 bg-gradient-to-r from-purple-400/80 to-transparent" />{" "}
          <p className="mt-5 text-pretty leading-relaxed text-white/80">
            {" "}
            Every other app drops you into a room full of strangers and leaves
            the rest to luck. People who moved abroad told us friendships need
            shared interests, repetition, and real conversations that keep
            going. Fluoverse helps you go from just landed to feeling at home:
            find activities you care about, learn language and culture for real
            life, and stay in touch until one event becomes a real friend.{" "}
          </p>{" "}
        </SplitFeature>{" "}
      </section>{" "}
      {/* City links */}{" "}
      <Reveal>
        {" "}
        <section aria-labelledby="city-links-heading" className="mb-16">
          {" "}
          <SectionHeading
            id="city-links-heading"
            label="Local calendars"
            title="Find the rooms in your city"
          />{" "}
          <div className="flex flex-wrap gap-3">
            {" "}
            {data.cityLinks.map((link) => (
              <Link
                key={link.city}
                href={link.href}
                className="rounded-full border border-purple-300/40 bg-purple-500/10 px-5 py-2.5 text-sm font-medium text-purple-100 transition-colors hover:bg-purple-500/20"
              >
                {" "}
                {link.city} social calendar →{" "}
              </Link>
            ))}{" "}
          </div>{" "}
        </section>{" "}
      </Reveal>{" "}
      <Reveal>
        {" "}
        <GuideSoftCta
          heading="Stop feeling alone in Spain. Start feeling at home"
          body="Meetup gets you in the room. Fluoverse helps you stay there: recurring meetups, follow-ups that stick, and Spanish and culture coaching when you need it."
          placement="guide_social_apps"
        />{" "}
      </Reveal>{" "}
      <GuideFAQ faqs={data.faqs} />{" "}
    </article>
  );
}
