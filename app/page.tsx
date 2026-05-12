import type { Metadata } from "next";
import HomeClient from "./HomeClient";

const canonical = "https://fluoverse.com";

export const metadata: Metadata = {
  alternates: { canonical },
  openGraph: {
    url: canonical,
  },
};

export default function HomePage() {
  return <HomeClient />;
}
