"use client";

import Link from "next/link";
import type { CityGuideData } from "@/lib/guides/types";
import { CITY_IMAGES, listingImageAlt } from "@/lib/guides/listing-images";
import SocialLink from "./SocialLink";
import GuideFAQ from "./GuideFAQ";
import GuideSoftCta from "./GuideSoftCta";
import UserVideo from "@/components/UserVideo";
import EventListingCard from "./EventListingCard";
import {
  GuideBackground,
  GuideHero,
  Reveal,
  SectionHeading,
  GlassCard,
  QuoteCard,
  AppRankCard,
  ImageFrame,
  SplitFeature,
} from "./GuideUI";

type ValenciaGuideContentProps = {
  data: CityGuideData;
  placement: "guide_valencia";
};

export default function ValenciaGuideContent({
  data,
  placement,
}: ValenciaGuideContentProps) {
  const images = CITY_IMAGES.valencia;

  return (
    <article className="relative mx-auto max-w-5xl px-4 pb-24 pt-28 sm:px-6 lg:px-8">
      <GuideBackground />

      <GuideHero
        eyebrow={data.heroEyebrow ?? "Valencia · 2026 guide"}
        title={data.heroTitle}
        accent={data.heroAccent}
        lead={data.empathyOpener}
        meta={[
          "Weekly calendar included",
          "Built by people who moved abroad",
          "Valencia, Spain",
        ]}
        image={{ src: images.hero.src, alt: images.hero.alt }}
      />

      {/* Calendar-first: Valencia's compact scene is easier to scan week-by-week */}
      {data.socialCalendar.length > 0 && (
        <section aria-labelledby="social-calendar-heading" className="mb-20">
          <Reveal>
            <SectionHeading
              id="social-calendar-heading"
              label="Start here"
              title="This week in Valencia"
              subtitle="Three recurring nights where newcomers actually show up. Photos link to the live Meetup listings."
            />
          </Reveal>
          <div className="space-y-4">
            {data.socialCalendar.map((event, i) => (
              <Reveal key={`${event.day}-${event.title}`} delay={i * 0.04}>
                <EventListingCard
                  imageUrl={event.imageUrl}
                  imageAlt={listingImageAlt(event.imageAlt, event.title)}
                  source={event.source}
                  channel={event.channel}
                  footer={
                    <SocialLink
                      href={event.url}
                      channel={event.channel}
                      city={data.slug}
                      unstyled
                      className="inline-flex rounded-full border border-emerald-300/40 bg-emerald-500/10 px-4 py-2 text-sm font-medium text-emerald-100 hover:bg-emerald-500/20"
                    >
                      View on {event.source} →
                    </SocialLink>
                  }
                >
                  <p className="text-sm font-medium text-emerald-200">
                    {event.day} · {event.time}
                  </p>
                  <h3 className="mt-1 text-lg font-semibold text-white">
                    {event.title}
                  </h3>
                  <p className="mt-1 text-sm text-white/60">
                    {event.venue} · {event.neighborhood}
                  </p>
                </EventListingCard>
              </Reveal>
            ))}
          </div>
        </section>
      )}

      <Reveal>
        <section
          aria-labelledby="quick-answer-heading"
          className="mb-20 overflow-hidden rounded-3xl border border-emerald-300/30 bg-gradient-to-br from-emerald-600/15 via-teal-600/10 to-transparent p-6 sm:p-8"
        >
          <h2
            id="quick-answer-heading"
            className="mb-5 text-xl font-bold text-white sm:text-2xl"
          >
            Quick answer: how to make friends in Valencia after moving abroad
          </h2>
          <ol className="space-y-3">
            {data.quickAnswerSteps.map((step, i) => (
              <li key={step} className="flex gap-3 text-white/85">
                <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-emerald-400/25 text-xs font-bold text-emerald-100">
                  {i + 1}
                </span>
                <span className="leading-relaxed">{step}</span>
              </li>
            ))}
          </ol>
        </section>
      </Reveal>

      <section aria-labelledby="language-exchange-heading" className="mb-20">
        <Reveal>
          <SectionHeading
            id="language-exchange-heading"
            label="Neighbourhoods"
            title="Where the international crowd meets"
            subtitle="Ruzafa, Benimaclet, and Blasco Ibañez host most recurring language exchanges."
          />
        </Reveal>
        <div className="grid gap-4 md:grid-cols-2">
          {data.socialLinks.map((link, i) => (
            <Reveal key={link.label} delay={i * 0.04}>
              <EventListingCard
                imageUrl={link.imageUrl}
                imageAlt={listingImageAlt(link.imageAlt, link.label)}
                source={link.source}
                channel={link.channel}
                footer={
                  <SocialLink
                    href={link.url}
                    channel={link.channel}
                    city={data.slug}
                    unstyled
                    className="inline-flex text-sm font-medium text-emerald-300 hover:text-emerald-200"
                  >
                    Open listing on {link.source} →
                  </SocialLink>
                }
              >
                <h3 className="text-lg font-semibold text-white">{link.label}</h3>
                {link.neighborhood && (
                  <p className="mt-1 text-sm text-emerald-200/80">
                    {link.neighborhood}
                  </p>
                )}
                <p className="mt-2 text-sm leading-relaxed text-white/70">
                  {link.description}
                </p>
              </EventListingCard>
            </Reveal>
          ))}
        </div>
      </section>

      <section className="mb-20">
        <SplitFeature
          imageSide="left"
          image={
            <ImageFrame
              src={images.empathy.src}
              alt={images.empathy.alt}
              aspect="aspect-[4/3]"
            />
          }
        >
          <p className="text-xs font-semibold uppercase tracking-[0.2em] text-emerald-300">
            Smaller city, faster circles
          </p>
          <h2 className="mt-3 text-2xl font-bold leading-tight text-white sm:text-3xl">
            Valencia rewards showing up twice, not trying everything once
          </h2>
          <div className="mt-4 h-px w-20 bg-gradient-to-r from-emerald-400/80 to-transparent" />
          <p className="mt-5 text-pretty leading-relaxed text-white/80">
            {data.guideEmpathy}
          </p>
        </SplitFeature>
      </section>

      <section aria-labelledby="struggle-heading" className="mb-20">
        <Reveal>
          <SectionHeading
            id="struggle-heading"
            label="Why it still feels hard"
            title="Even in a friendly city, the first month can sting"
            subtitle={`${data.struggleInterviewIntro}. ${data.struggleIntro}`}
          />
        </Reveal>
        <div className="mx-auto max-w-2xl space-y-4">
          {data.struggleQuotes.map((q, i) => (
            <Reveal key={q.tag} delay={i * 0.06}>
              <QuoteCard quote={q.quote} tag={q.tag} />
            </Reveal>
          ))}
        </div>
      </section>

      <section aria-labelledby="first-30-days-heading" className="mb-20">
        <Reveal>
          <SectionHeading
            id="first-30-days-heading"
            label="Your month"
            title="First 30 days in Valencia"
            subtitle="Outdoor culture and neighbourhood bars beat big one-off events here."
          />
        </Reveal>
        <div className="relative space-y-4 before:absolute before:left-[1.35rem] before:top-2 before:h-[calc(100%-1rem)] before:w-px before:bg-gradient-to-b before:from-emerald-400/60 before:to-transparent">
          {data.first30Days.map((week, i) => (
            <Reveal key={week.week} delay={i * 0.05}>
              <div className="relative flex gap-4">
                <span className="z-10 flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 text-sm font-bold text-white shadow-lg shadow-emerald-900/40">
                  {i + 1}
                </span>
                <GlassCard className="flex-1 p-5">
                  <p className="font-semibold text-emerald-200">{week.week}</p>
                  <h3 className="mt-1 text-lg font-semibold text-white">
                    {week.title}
                  </h3>
                  <ul className="mt-3 list-disc space-y-1 pl-5 text-sm leading-relaxed text-white/75 marker:text-emerald-400">
                    {week.actions.map((action) => (
                      <li key={action}>{action}</li>
                    ))}
                  </ul>
                </GlassCard>
              </div>
            </Reveal>
          ))}
        </div>
      </section>

      <Reveal>
        <section
          aria-labelledby="what-works-heading"
          className="mb-20 rounded-3xl border border-emerald-400/20 bg-emerald-500/[0.06] p-6 sm:p-8"
        >
          <h2
            id="what-works-heading"
            className="text-xl font-bold text-white sm:text-2xl"
          >
            What actually works in Valencia
          </h2>
          <ul className="mt-5 space-y-3">
            {data.whatWorks.map((item) => (
              <li key={item} className="flex gap-3 text-white/80">
                <span className="mt-1 text-emerald-300" aria-hidden>
                  ✓
                </span>
                <span className="leading-relaxed">{item}</span>
              </li>
            ))}
          </ul>
        </section>
      </Reveal>

      <section aria-labelledby="shy-venues-heading" className="mb-20">
        <Reveal>
          <SectionHeading
            id="shy-venues-heading"
            label="Low-pressure starts"
            title="Best first places when big crowds feel like too much"
          />
        </Reveal>
        <div className="flex gap-4 overflow-x-auto pb-2 snap-x snap-mandatory sm:grid sm:grid-cols-3 sm:overflow-visible">
          {data.shyVenues.map((venue, i) => (
            <Reveal key={venue.name} delay={i * 0.05}>
              <GlassCard className="min-w-[260px] snap-start p-5 sm:min-w-0">
                <p className="text-xs font-semibold uppercase tracking-wider text-emerald-300">
                  {venue.neighborhood}
                </p>
                <h3 className="mt-2 font-semibold text-white">{venue.name}</h3>
                <p className="mt-2 text-sm text-white/75">{venue.why}</p>
                <p className="mt-3 rounded-lg bg-white/[0.04] px-3 py-2 text-sm text-white/60">
                  <strong className="text-white/80">Tip:</strong> {venue.tip}
                </p>
              </GlassCard>
            </Reveal>
          ))}
        </div>
      </section>

      <section aria-labelledby="apps-heading" className="mb-20">
        <Reveal>
          <SectionHeading
            id="apps-heading"
            label="The toolkit"
            title="Apps that work in Valencia"
            subtitle="Fluoverse first for the full journey home, then the platforms that fill your calendar."
          />
        </Reveal>
        <div className="space-y-4">
          {data.appReviews.map((app, i) => (
            <Reveal key={app.name} delay={i * 0.04}>
              <AppRankCard
                rank={i + 1}
                appId={app.appId}
                name={app.name}
                pros={app.pros}
                cons={app.cons}
                bestFor={app.bestFor}
                highlight={app.highlight}
              />
            </Reveal>
          ))}
        </div>
        <p className="mt-5 text-sm text-white/55">
          See our full{" "}
          <Link
            href="/guides/social-apps-expats-spain-2026"
            className="text-emerald-300 hover:underline"
          >
            social apps guide for Spain (2026)
          </Link>
          .
        </p>
      </section>

      <section aria-labelledby="scripts-heading" className="mb-20">
        <Reveal>
          <SectionHeading
            id="scripts-heading"
            label="Language & culture"
            title="Spanish for beach plans and Ruzafa meetups"
            subtitle="Practice these in Fluoverse so you show up prepared and ready to follow up after the event."
          />
        </Reveal>
        <Reveal>
          <ImageFrame
            src={images.success.src}
            alt={images.success.alt}
            aspect="aspect-[21/9]"
            className="mb-8"
          />
        </Reveal>
        <div className="grid gap-3 sm:grid-cols-2">
          {data.conversationScripts.map((script, i) => (
            <Reveal key={script.situation} delay={i * 0.04}>
              <GlassCard className="h-full p-5">
                <p className="text-xs font-semibold uppercase tracking-wider text-emerald-300">
                  {script.situation}
                </p>
                <p className="mt-2 text-lg font-medium text-white">
                  &ldquo;{script.spanish}&rdquo;
                </p>
                <p className="mt-1 text-sm text-white/55">{script.english}</p>
              </GlassCard>
            </Reveal>
          ))}
        </div>
      </section>

      <Reveal>
        <section className="mb-12">
          <SectionHeading
            label="Hear from someone who moved abroad"
            title="A real Fluoverse story"
            subtitle="Marc went from practicing with Fluoverse to a night out with new friends."
          />
          <UserVideo />
        </section>
      </Reveal>

      <Reveal>
        <section
          aria-labelledby="nuance-heading"
          className="mb-20 rounded-3xl border border-white/10 bg-white/[0.04] p-6 sm:p-8"
        >
          <h2
            id="nuance-heading"
            className="text-xl font-bold text-white sm:text-2xl"
          >
            How social life really works in Valencia
          </h2>
          <div className="mt-5 grid gap-3 sm:grid-cols-2">
            {data.localNuances.map((nuance) => (
              <p
                key={nuance}
                className="rounded-xl border border-emerald-400/15 bg-emerald-500/[0.05] px-4 py-3 text-sm leading-relaxed text-white/75"
              >
                {nuance}
              </p>
            ))}
          </div>
        </section>
      </Reveal>

      <section className="mb-12">
        <SplitFeature
          imageSide="right"
          image={
            <ImageFrame
              src={images.success.src}
              alt={images.success.alt}
              aspect="aspect-[4/3]"
            />
          }
        >
          <p className="text-xs font-semibold uppercase tracking-[0.2em] text-teal-300">
            The other side
          </p>
          <h2 className="mt-3 text-2xl font-bold leading-tight text-white sm:text-3xl">
            Beach runs, Turia walks, and a circle that feels like home
          </h2>
          <p className="mt-5 text-pretty text-lg leading-relaxed text-white/85">
            {data.successVision}
          </p>
        </SplitFeature>
      </section>

      <Reveal>
        <GuideSoftCta
          heading={data.languageBridge.heading}
          body={data.languageBridge.body}
          placement={placement}
        />
      </Reveal>

      <Reveal>
        <section aria-labelledby="related-heading" className="mt-14">
          <h2 id="related-heading" className="mb-4 text-lg font-bold text-white">
            Related guides
          </h2>
          <div className="grid gap-3 sm:grid-cols-3">
            {data.relatedLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className="group rounded-2xl border border-white/10 bg-white/[0.04] p-4 transition-colors hover:border-emerald-300/40"
              >
                <p className="font-medium text-emerald-300 group-hover:text-emerald-200">
                  {link.label} →
                </p>
                <p className="mt-1 text-sm text-white/55">{link.description}</p>
              </Link>
            ))}
          </div>
        </section>
      </Reveal>

      <GuideFAQ faqs={data.faqs} />
    </article>
  );
}
