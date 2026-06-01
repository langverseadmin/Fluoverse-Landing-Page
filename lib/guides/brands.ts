export type AppBrandId =
  | "fluoverse"
  | "meetup"
  | "whatsapp"
  | "telegram"
  | "facebook_groups"
  | "playtomic"
  | "internations";

export type AppBrand = {
  id: AppBrandId;
  name: string;
  logo: string;
  logoAlt: string;
};

export const APP_BRANDS: Record<AppBrandId, AppBrand> = {
  fluoverse: {
    id: "fluoverse",
    name: "Fluoverse",
    logo: "/logo.svg",
    logoAlt: "Fluoverse app logo",
  },
  meetup: {
    id: "meetup",
    name: "Meetup",
    logo: "/guides/logos/meetup.png",
    logoAlt: "Meetup logo",
  },
  whatsapp: {
    id: "whatsapp",
    name: "WhatsApp",
    logo: "/guides/logos/whatsapp.png",
    logoAlt: "WhatsApp logo",
  },
  telegram: {
    id: "telegram",
    name: "Telegram",
    logo: "/guides/logos/telegram.png",
    logoAlt: "Telegram logo",
  },
  facebook_groups: {
    id: "facebook_groups",
    name: "Facebook Groups",
    logo: "/guides/logos/facebook-groups.svg",
    logoAlt: "Facebook Groups logo",
  },
  playtomic: {
    id: "playtomic",
    name: "Playtomic",
    logo: "/guides/logos/playtomic.png",
    logoAlt: "Playtomic logo",
  },
  internations: {
    id: "internations",
    name: "InterNations",
    logo: "/guides/logos/internations.png",
    logoAlt: "InterNations logo",
  },
};

export function brandForAppName(name: string): AppBrand | undefined {
  const key = name.toLowerCase();
  if (key.includes("fluoverse")) return APP_BRANDS.fluoverse;
  if (key.includes("meetup")) return APP_BRANDS.meetup;
  if (key.includes("whatsapp")) return APP_BRANDS.whatsapp;
  if (key.includes("telegram")) return APP_BRANDS.telegram;
  if (key.includes("facebook")) return APP_BRANDS.facebook_groups;
  if (key.includes("playtomic")) return APP_BRANDS.playtomic;
  if (key.includes("internations")) return APP_BRANDS.internations;
  return undefined;
}

export function brandForChannel(channel: string): AppBrand | undefined {
  if (channel === "meetup") return APP_BRANDS.meetup;
  if (channel === "whatsapp") return APP_BRANDS.whatsapp;
  if (channel === "telegram") return APP_BRANDS.telegram;
  return undefined;
}
