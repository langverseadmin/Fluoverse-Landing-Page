import type { Metadata } from "next";
import HomeClient from "./HomeClient";

const canonical = "https://fluoverse.com";

export const metadata: Metadata = {
  title: "Stop Feeling Alone. Start Feeling at Home in Spain",
  description:
    "New in Spain and tired of having zero real friends? Fluoverse teaches real Spanish and culture and guides you through recurring meetups until someone becomes a real friend.",
  alternates: { canonical },
  openGraph: {
    url: canonical,
    title: "Fluoverse — Stop Feeling Alone. Start Feeling at Home in Spain",
    description:
      "Make real friends in Spain, starting today. Practical Spanish, cultural coaching, and guided meetups for expats who want to feel at home fast.",
  },
  twitter: {
    title: "Stop Feeling Alone. Start Feeling at Home in Spain",
    description:
      "The social integration app for expats in Spain. Real conversations, real culture, real friendships.",
  },
};

export default function HomePage() {
  return <HomeClient />;
}
