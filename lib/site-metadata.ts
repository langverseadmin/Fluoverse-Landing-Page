/** Single source of truth for site-wide SEO, social previews, and brand messaging. */

export const SITE_NAME = "Fluoverse";

export const SITE_TAGLINE_LINE1 = "Stop feeling alone.";
export const SITE_TAGLINE_LINE2 = "Start feeling at home.";
export const SITE_TAGLINE = `${SITE_TAGLINE_LINE1} ${SITE_TAGLINE_LINE2}`;

export const SITE_TITLE = `${SITE_NAME} — ${SITE_TAGLINE}`;

export const SITE_DESCRIPTION =
  "Stop feeling alone. Start feeling at home. Fluoverse helps people who moved abroad make real friends through shared activities and recurring meetups, with language and culture coaching when you need it.";

export const SITE_OG_IMAGE = "https://fluoverse.com/Hero.png";

export const SITE_KEYWORDS = [
  "Fluoverse",
  "stop feeling alone abroad",
  "start feeling at home",
  "make friends abroad",
  "make real friends",
  "feel at home abroad",
  "lonely after moving abroad",
  "new country no friends",
  "expat friends",
  "meet locals",
  "recurring meetups",
  "moved abroad alone",
  "social integration app",
  "language and culture abroad",
] as const;

export const SITE_OG = {
  title: SITE_TITLE,
  description: SITE_DESCRIPTION,
  url: "https://fluoverse.com",
  siteName: SITE_NAME,
  image: SITE_OG_IMAGE,
  imageAlt: SITE_TAGLINE,
} as const;

export const SITE_TWITTER = {
  title: SITE_TITLE,
  description: SITE_DESCRIPTION,
} as const;

/** Hero / subheads: friends first, tagline-adjacent */
export const SITE_SUBHEAD =
  "Fluoverse pairs you with people who share your interests, guides recurring meetups until friendships stick, and teaches language and culture along the way.";
