import type { AppBrandId } from "./brands";

export type SocialChannel = "whatsapp" | "telegram" | "meetup" | "event";

export type GuideCity = "spain" | "madrid" | "valencia";

export interface GuideBreadcrumb {
  name: string;
  href: string;
}

export interface GuideFaqItem {
  question: string;
  answer: string;
}

export interface SocialLinkItem {
  label: string;
  description: string;
  url: string;
  channel: SocialChannel;
  neighborhood?: string;
  /** Cover image from the listing (Meetup group photo, etc.) */
  imageUrl?: string;
  imageAlt?: string;
  source: string;
}

export interface ExchangeListing {
  name: string;
  schedule: string;
  neighborhood: string;
  vibe: string;
  url: string;
  channel: SocialChannel;
  imageUrl?: string;
  imageAlt?: string;
  source: string;
}

export interface CalendarEvent {
  day: string;
  title: string;
  time: string;
  venue: string;
  neighborhood: string;
  url: string;
  channel: SocialChannel;
  imageUrl?: string;
  imageAlt?: string;
  source: string;
}

export interface ShyNewcomerVenue {
  name: string;
  why: string;
  neighborhood: string;
  tip: string;
}

export interface AppReview {
  appId: AppBrandId;
  name: string;
  pros: string;
  cons: string;
  bestFor: string;
  highlight?: boolean;
}

export interface UserVoiceQuote {
  quote: string;
  tag: string;
}

export interface ConversationScript {
  situation: string;
  spanish: string;
  english: string;
}

export interface First30DayWeek {
  week: string;
  title: string;
  actions: string[];
}

export interface GuideHeroHeadline {
  heroTitle: string;
  heroAccent?: string;
  heroEyebrow?: string;
}

export interface CityGuideData {
  slug: GuideCity;
  city: string;
  citySpanish: string;
  path: string;
  title: string;
  description: string;
  keywords: string[];
  heroTitle: string;
  heroAccent?: string;
  heroEyebrow?: string;
  empathyOpener: string;
  /** StoryBrand stakes — what expats told us goes wrong (the villain) */
  struggleIntro: string;
  /** Shown above quote cards, e.g. "We interviewed 10 people in Madrid." */
  struggleInterviewIntro: string;
  struggleQuotes: UserVoiceQuote[];
  /** StoryBrand value/success — what life looks like once it clicks */
  successVision: string;
  /** What actually works, drawn from expats who cracked it */
  whatWorks: string[];
  /** StoryBrand guide — empathy + authority */
  guideEmpathy: string;
  quickAnswerSteps: string[];
  first30Days: First30DayWeek[];
  socialCalendar: CalendarEvent[];
  socialLinks: SocialLinkItem[];
  shyVenues: ShyNewcomerVenue[];
  appReviews: AppReview[];
  conversationScripts: ConversationScript[];
  localNuances: string[];
  languageBridge: {
    heading: string;
    body: string;
  };
  faqs: GuideFaqItem[];
  breadcrumbs: GuideBreadcrumb[];
  relatedLinks: { label: string; href: string; description: string }[];
}

export interface SpainHubData {
  title: string;
  description: string;
  keywords: string[];
  heroTitle: string;
  heroAccent?: string;
  heroEyebrow?: string;
  empathyIntro: string;
  struggleIntro: string;
  struggleInterviewIntro: string;
  struggleQuotes: UserVoiceQuote[];
  successVision: string;
  whatWorks: string[];
  guideEmpathy: string;
  monthTimeline: { period: string; feeling: string; action: string }[];
  cityCards: { city: string; href: string; blurb: string }[];
  faqs: GuideFaqItem[];
  breadcrumbs: GuideBreadcrumb[];
}
