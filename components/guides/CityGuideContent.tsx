"use client";
import Link from "next/link";
import type { CityGuideData } from "@/lib/guides/types";
import {
  CITY_IMAGES,
  FLUOVERSE_SCENARIO_IMAGES,
  listingImageAlt,
} from "@/lib/guides/listing-images";
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
  StepCard,
  AppRankCard,
  ImageFrame,
  PhoneMockup,
  SplitFeature,
} from "./GuideUI";
type CityGuideContentProps = {
  data: CityGuideData;
  placement: "guide_madrid" | "guide_valencia";
};
export default function CityGuideContent({
  data,
  placement,
}: CityGuideContentProps) {
  const images = CITY_IMAGES.madrid;
  return (
    <article className="relative mx-auto max-w-5xl px-4 pb-24 pt-28 sm:px-6 lg:px-8">
      {" "}
      <GuideBackground />{" "}
      <GuideHero
        eyebrow={data.heroEyebrow ?? `${data.city} · 2026 guide`}
        title={data.heroTitle}
        accent={data.heroAccent}
        lead={data.empathyOpener}
        meta={[
          "Updated for 2026",
          "Built by people who moved abroad",
          `${data.city}, Spain`,
        ]}
        image={{ src: images.hero.src, alt: images.hero.alt }}
      />{" "}
      <Reveal>
        {" "}
        <section
          aria-labelledby="quick-answer-heading"
          className="mb-20 overflow-hidden rounded-3xl border border-purple-300/40 bg-gradient-to-br from-purple-600/20 via-fuchsia-600/10 to-transparent p-6 sm:p-8"
        >
          {" "}
          <h2
            id="quick-answer-heading"
            className="mb-5 text-xl font-bold text-white sm:text-2xl"
          >
            {" "}
            Quick answer: how to make friends in {data.city} after moving
            abroad{" "}
          </h2>{" "}
          <ol className="grid gap-3 sm:grid-cols-2">
            {" "}
            {data.quickAnswerSteps.map((step, i) => (
              <li key={step} className="flex gap-3 text-white/85">
                {" "}
                <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-purple-400/25 text-xs font-bold text-purple-100">
                  {" "}
                  {i + 1}{" "}
                </span>{" "}
                <span className="leading-relaxed">{step}</span>{" "}
              </li>
            ))}{" "}
          </ol>{" "}
        </section>{" "}
      </Reveal>{" "}
      {/* Guide empathy , step 3 illustration matches "connect with locals" copy */}{" "}
      <section className="mb-20">
        {" "}
        <SplitFeature
          imageSide="right"
          image={
            <ImageFrame
              src={images.empathy.src}
              alt={images.empathy.alt}
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
      <section aria-labelledby="struggle-heading" className="mb-20">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="struggle-heading"
            label="Why it feels so hard"
            title={`You're not bad at this , ${data.city} is just built this way`}
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
      <section aria-labelledby="first-30-days-heading" className="mb-20">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="first-30-days-heading"
            label="The plan"
            title={`Your first 30 days in ${data.city}`}
            subtitle="One small, repeatable step at a time."
          />{" "}
        </Reveal>{" "}
        <div className="grid gap-4 sm:grid-cols-2">
          {" "}
          {data.first30Days.map((week, i) => (
            <Reveal key={week.week} delay={i * 0.05}>
              {" "}
              <StepCard
                number={String(i + 1)}
                title={`${week.week} , ${week.title}`}
              >
                {" "}
                <ul className="list-disc space-y-1 pl-5 marker:text-purple-400">
                  {" "}
                  {week.actions.map((action) => (
                    <li key={action}>{action}</li>
                  ))}{" "}
                </ul>{" "}
              </StepCard>{" "}
            </Reveal>
          ))}{" "}
        </div>{" "}
      </section>{" "}
      <Reveal>
        {" "}
        <section
          aria-labelledby="what-works-heading"
          className="mb-20 rounded-3xl border border-emerald-400/20 bg-emerald-500/[0.06] p-6 sm:p-8"
        >
          {" "}
          <h2
            id="what-works-heading"
            className="text-xl font-bold text-white sm:text-2xl"
          >
            {" "}
            What actually works , from people who moved abroad who cracked
            it{" "}
          </h2>{" "}
          <ul className="mt-5 grid gap-3 sm:grid-cols-2">
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
      {data.socialCalendar.length > 0 && (
        <section aria-labelledby="social-calendar-heading" className="mb-20">
          {" "}
          <Reveal>
            {" "}
            <SectionHeading
              id="social-calendar-heading"
              label="This week"
              title={`Weekly social calendar , ${data.city}`}
              subtitle="Photos and links go to the live listings, confirm times before you go."
            />{" "}
          </Reveal>{" "}
          <div className="space-y-4">
            {" "}
            {data.socialCalendar.map((event, i) => (
              <Reveal key={`${event.day}-${event.title}`} delay={i * 0.04}>
                {" "}
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
                      className="inline-flex rounded-full border border-purple-300/40 bg-purple-500/10 px-4 py-2 text-sm font-medium text-purple-100 hover:bg-purple-500/20"
                    >
                      {" "}
                      View on {event.source} →{" "}
                    </SocialLink>
                  }
                >
                  {" "}
                  <p className="text-sm font-medium text-purple-200">
                    {" "}
                    {event.day} · {event.time}{" "}
                  </p>{" "}
                  <h3 className="mt-1 text-lg font-semibold text-white">
                    {event.title}
                  </h3>{" "}
                  <p className="mt-1 text-sm text-white/60">
                    {" "}
                    {event.venue} · {event.neighborhood}{" "}
                  </p>{" "}
                </EventListingCard>{" "}
              </Reveal>
            ))}{" "}
          </div>{" "}
        </section>
      )}{" "}
      <section aria-labelledby="language-exchange-heading" className="mb-20">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="language-exchange-heading"
            label="Where people meet"
            title={
              <>
                {" "}
                Language exchanges in {data.city}{" "}
                <span className="text-white/40">/</span> Language exchanges en{" "}
                {data.citySpanish}{" "}
              </>
            }
          />{" "}
        </Reveal>{" "}
        <div className="space-y-4">
          {" "}
          {data.socialLinks.map((link, i) => (
            <Reveal key={link.label} delay={i * 0.04}>
              {" "}
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
                    className="inline-flex text-sm font-medium text-purple-300 hover:text-purple-200"
                  >
                    {" "}
                    Open listing on {link.source} →{" "}
                  </SocialLink>
                }
              >
                {" "}
                <h3 className="text-lg font-semibold text-white">
                  {link.label}
                </h3>{" "}
                {link.neighborhood && (
                  <p className="mt-1 text-sm text-purple-200/80">
                    {link.neighborhood}
                  </p>
                )}{" "}
                <p className="mt-2 text-sm leading-relaxed text-white/70">
                  {link.description}
                </p>{" "}
              </EventListingCard>{" "}
            </Reveal>
          ))}{" "}
        </div>{" "}
      </section>{" "}
      <section aria-labelledby="shy-venues-heading" className="mb-20">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="shy-venues-heading"
            label="For shy newcomers"
            title="Best first places when big events feel like too much"
          />{" "}
        </Reveal>{" "}
        <div className="grid gap-4 sm:grid-cols-2">
          {" "}
          {data.shyVenues.map((venue, i) => (
            <Reveal key={venue.name} delay={i * 0.05}>
              {" "}
              <GlassCard className="h-full p-5">
                {" "}
                <h3 className="font-semibold text-white">{venue.name}</h3>{" "}
                <p className="mt-1 text-sm text-purple-200">
                  {venue.neighborhood}
                </p>{" "}
                <p className="mt-2 text-sm text-white/75">{venue.why}</p>{" "}
                <p className="mt-3 rounded-lg bg-white/[0.04] px-3 py-2 text-sm text-white/60">
                  {" "}
                  <strong className="text-white/80">Tip:</strong>{" "}
                  {venue.tip}{" "}
                </p>{" "}
              </GlassCard>{" "}
            </Reveal>
          ))}{" "}
        </div>{" "}
      </section>{" "}
      <section aria-labelledby="apps-heading" className="mb-20">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="apps-heading"
            label="The toolkit, ranked"
            title="Apps that work in Madrid"
            subtitle="Fluoverse first for the full journey home, then the platforms that fill your calendar."
          />{" "}
        </Reveal>{" "}
        <div className="space-y-4">
          {" "}
          {data.appReviews.map((app, i) => (
            <Reveal key={app.name} delay={i * 0.04}>
              {" "}
              <AppRankCard
                rank={i + 1}
                appId={app.appId}
                name={app.name}
                pros={app.pros}
                cons={app.cons}
                bestFor={app.bestFor}
                highlight={app.highlight}
              />{" "}
            </Reveal>
          ))}{" "}
        </div>{" "}
        <p className="mt-5 text-sm text-white/55">
          {" "}
          See our full{" "}
          <Link
            href="/guides/social-apps-expats-spain-2026"
            className="text-purple-300 hover:underline"
          >
            {" "}
            social apps if you moved abroad in Spain (2026){" "}
          </Link>{" "}
          guide.{" "}
        </p>{" "}
      </section>{" "}
      {/* Fluoverse app mockup , only beside practice scripts */}{" "}
      <section aria-labelledby="scripts-heading" className="mb-20">
        {" "}
        <Reveal>
          {" "}
          <SectionHeading
            id="scripts-heading"
            label="Language & culture"
            title="Spanish phrases for your first conversations"
            subtitle="Practice these in Fluoverse so your language exchange feels familiar and you can keep the conversation going."
          />{" "}
        </Reveal>{" "}
        <div className="grid gap-8 lg:grid-cols-[260px_1fr] lg:items-start">
          {" "}
          <Reveal className="hidden lg:block lg:sticky lg:top-28">
            {" "}
            <PhoneMockup
              src={FLUOVERSE_SCENARIO_IMAGES.restaurant.src}
              alt={FLUOVERSE_SCENARIO_IMAGES.restaurant.alt}
              caption="Fluoverse scenario: café small talk"
            />{" "}
          </Reveal>{" "}
          <div className="space-y-3">
            {" "}
            {data.conversationScripts.map((script, i) => (
              <Reveal key={script.situation} delay={i * 0.04}>
                {" "}
                <GlassCard className="p-5">
                  {" "}
                  <p className="text-xs font-semibold uppercase tracking-wider text-purple-300">
                    {" "}
                    {script.situation}{" "}
                  </p>{" "}
                  <p className="mt-2 text-lg font-medium text-white">
                    {" "}
                    &ldquo;{script.spanish}&rdquo;{" "}
                  </p>{" "}
                  <p className="mt-1 text-sm text-white/55">
                    {script.english}
                  </p>{" "}
                </GlassCard>{" "}
              </Reveal>
            ))}{" "}
          </div>{" "}
        </div>{" "}
      </section>{" "}
      <Reveal>
        {" "}
        <section className="mb-12">
          {" "}
          <SectionHeading
            label="Hear from someone who moved abroad"
            title="A real Fluoverse story"
            subtitle="Marc went from practicing with Fluoverse to a night out with new friends."
          />{" "}
          <UserVideo />{" "}
        </section>{" "}
      </Reveal>{" "}
      <Reveal>
        {" "}
        <section
          aria-labelledby="nuance-heading"
          className="mb-20 rounded-3xl border border-white/10 bg-white/[0.04] p-6 sm:p-8"
        >
          {" "}
          <h2
            id="nuance-heading"
            className="text-xl font-bold text-white sm:text-2xl"
          >
            {" "}
            How social life really works in {data.city}{" "}
          </h2>{" "}
          <ul className="mt-5 grid gap-2.5 sm:grid-cols-2">
            {" "}
            {data.localNuances.map((nuance) => (
              <li key={nuance} className="flex gap-3 text-white/75">
                {" "}
                <span
                  className="mt-1 h-1.5 w-1.5 shrink-0 rounded-full bg-purple-400"
                  aria-hidden
                />{" "}
                <span className="leading-relaxed">{nuance}</span>{" "}
              </li>
            ))}{" "}
          </ul>{" "}
        </section>{" "}
      </Reveal>{" "}
      <section className="mb-12">
        {" "}
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
          {" "}
          <p className="text-xs font-semibold uppercase tracking-[0.2em] text-fuchsia-300">
            {" "}
            The other side{" "}
          </p>{" "}
          <h2 className="mt-3 text-2xl font-bold leading-tight text-white sm:text-3xl">
            {" "}
            Live fully in your new community{" "}
          </h2>{" "}
          <p className="mt-5 text-pretty text-lg leading-relaxed text-white/85">
            {" "}
            {data.successVision}{" "}
          </p>{" "}
        </SplitFeature>{" "}
      </section>{" "}
      <Reveal>
        {" "}
        <GuideSoftCta
          heading={data.languageBridge.heading}
          body={data.languageBridge.body}
          placement={placement}
        />{" "}
      </Reveal>{" "}
      <Reveal>
        {" "}
        <section aria-labelledby="related-heading" className="mt-14">
          {" "}
          <h2
            id="related-heading"
            className="mb-4 text-lg font-bold text-white"
          >
            {" "}
            Related guides{" "}
          </h2>{" "}
          <div className="grid gap-3 sm:grid-cols-3">
            {" "}
            {data.relatedLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className="group rounded-2xl border border-white/10 bg-white/[0.04] p-4 transition-colors hover:border-purple-300/40"
              >
                {" "}
                <p className="font-medium text-purple-300 group-hover:text-purple-200">
                  {" "}
                  {link.label} →{" "}
                </p>{" "}
                <p className="mt-1 text-sm text-white/55">
                  {link.description}
                </p>{" "}
              </Link>
            ))}{" "}
          </div>{" "}
        </section>{" "}
      </Reveal>{" "}
      <GuideFAQ faqs={data.faqs} />{" "}
    </article>
  );
}
