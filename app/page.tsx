import type { Metadata } from "next";
import HomeClient from "./HomeClient";
import {
  SITE_DESCRIPTION,
  SITE_OG,
  SITE_TAGLINE,
  SITE_TWITTER,
} from "@/lib/site-metadata";

const canonical = "https://fluoverse.com";

export const metadata: Metadata = {
  title: SITE_TAGLINE,
  description: SITE_DESCRIPTION,
  alternates: { canonical },
  openGraph: {
    url: canonical,
    title: SITE_OG.title,
    description: SITE_OG.description,
    images: [{ url: SITE_OG.image, alt: SITE_OG.imageAlt }],
  },
  twitter: {
    title: SITE_TWITTER.title,
    description: SITE_TWITTER.description,
    images: [SITE_OG.image],
  },
};

export default function HomePage() {
  return <HomeClient />;
}
