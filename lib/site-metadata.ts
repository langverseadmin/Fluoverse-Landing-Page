/** Single source of truth for site-wide SEO, social previews, and brand messaging. */

export const SITE_NAME = "Fluoverse";

export const SITE_TAGLINE_LINE1 = "Stop feeling alone in Spain.";
export const SITE_TAGLINE_LINE2 = "Start feeling at home.";
export const SITE_TAGLINE = `${SITE_TAGLINE_LINE1} ${SITE_TAGLINE_LINE2}`;

export const SITE_TITLE = `${SITE_NAME} — ${SITE_TAGLINE}`;

export const SITE_DESCRIPTION =
  "Stop feeling alone in Spain. Start feeling at home. Fluoverse helps expats make real friends through shared activities and recurring meetups, with Spanish and culture coaching when you need it.";

export const SITE_OG_IMAGE = "https://fluoverse.com/Hero.png";

export const SITE_KEYWORDS = [
  "Fluoverse",
  "stop feeling alone Spain",
  "start feeling at home Spain",
  "make friends in Spain",
  "make real friends",
  "feel at home in Spain",
  "lonely in Spain",
  "new in Spain no friends",
  "expat friends Spain",
  "meet locals Spain",
  "recurring meetups Spain",
  "moved to Spain alone",
  "learn Spanish real life",
  "Spanish culture expats",
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
  "Fluoverse pairs you with people who share your interests, guides recurring meetups until friendships stick, and teaches Spanish and culture along the way.";
