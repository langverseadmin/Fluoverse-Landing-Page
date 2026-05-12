import type { Metadata } from "next";
import { Inter, Plus_Jakarta_Sans } from "next/font/google";
import "./globals.css";
import GoogleAnalytics from "@/components/GoogleAnalytics";
import VWO from "@/components/VWO";
import { APP_STORE_WEB_URLS, LEARNERS_ONLY_SITE } from "@/lib/config";

const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });

/** Display / marketing headings — pairs with Inter body copy */
const plusJakarta = Plus_Jakarta_Sans({
  subsets: ["latin"],
  variable: "--font-display",
  display: "swap",
  weight: ["600", "700", "800"],
});

export const metadata: Metadata = {
  metadataBase: new URL("https://fluoverse.com"),
  title: {
    default:
      "Fluoverse — Connect with locals, make friends & feel at home | Speak-first language confidence",
    template: "%s | Fluoverse",
  },
  description:
    "Break language and cultural barriers through speak-first practice for real chats—meetups, errands, coworkers, hobbies. Gain listening and speaking habits that feel natural abroad so chats can deepen into friendships. Scenarios, guided conversations, and Fluency Rooms for the language you're navigating—on iOS & Android.",
  keywords: [
    "Fluoverse",
    "make friends abroad",
    "connect with locals",
    "integrate abroad feeling at home",
    "cultural barrier language barrier",
    "genuine friendships expat",
    "speaking practice app",
    "voice-first language practice",
    "second language friendships",
    "local language anxiety confidence",
    "real-world scenarios",
    "Fluency Rooms",
    "expats social integration",
    "learn language abroad friendships",
    "relocating locals confidence",
  ],
  authors: [{ name: "Fluoverse Team" }],
  creator: "Fluoverse",
  publisher: "Fluoverse",
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
  openGraph: {
    type: "website",
    locale: "en_US",
    url: "https://fluoverse.com",
    siteName: "Fluoverse",
    title: "Fluoverse — Confidence for locals, friendships abroad",
    description:
      "Practice the conversations where language meets culture—listening, reacting, joking—so integrating feels warmer and friendships can spark. Scenario-first speaking and Fluency Rooms on mobile.",
    images: [
      {
        url: "https://fluoverse.com/android-chrome-512x512.png",
        width: 512,
        height: 512,
        alt: "Fluoverse — speak-first practice to soften language barriers so life abroad feels warmer with locals",
        type: "image/png",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Fluoverse — Connect with locals abroad",
    description:
      "Speak-first scenarios & Fluency Rooms to bridge vocabulary and cultural gaps—meet people, integrate, grow friendships in the language you're living.",
    images: ["https://fluoverse.com/android-chrome-512x512.png"],
    creator: "@fluoverse",
  },
  category: "Education",
  classification: "Language Learning Application",
  icons: {
    icon: [
      { url: "/favicon.ico", sizes: "any" },
      { url: "/favicon-16x16.png", sizes: "16x16", type: "image/png" },
      { url: "/favicon-32x32.png", sizes: "32x32", type: "image/png" },
      { url: "/logo.svg", type: "image/svg+xml" },
    ],
    apple: [
      { url: "/apple-touch-icon.png", sizes: "180x180", type: "image/png" },
    ],
    other: [
      { rel: "android-chrome", url: "/android-chrome-192x192.png", sizes: "192x192" },
      { rel: "android-chrome", url: "/android-chrome-512x512.png", sizes: "512x512" },
    ],
  },
  manifest: "/site.webmanifest",
  verification: {
    // Add your verification codes here when available
    // google: "your-google-verification-code",
    // yandex: "your-yandex-verification-code",
    // yahoo: "your-yahoo-verification-code",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  // Organization Schema
  const organizationSchema = {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "Fluoverse",
    "url": "https://fluoverse.com",
    "logo": "https://fluoverse.com/android-chrome-512x512.png",
    "description":
      "Fluoverse helps people integrate abroad and connect with locals by breaking language barriers—voice-first scenarios, guided conversations, and Fluency Rooms so everyday chats in the languages around them feel warmer and friendships form more easily.",
    "foundingDate": "2024",
    "sameAs": [
      "https://twitter.com/fluoverse",
      "https://facebook.com/fluoverse",
      "https://instagram.com/fluoverse"
    ],
    "contactPoint": {
      "@type": "ContactPoint",
      "contactType": "Customer Support"
    }
  };

  // SoftwareApplication Schema
  const softwareApplicationSchema = {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    "name": "Fluoverse",
    "applicationCategory": "EducationalApplication",
    "operatingSystem": ["iOS", "Android"],
    "offers": {
      "@type": "Offer",
      "price": "0",
      "priceCurrency": "USD",
    },
    "description":
      "Voice-first app for bridging language gaps and cultural friction—real-world scenarios and Fluency Rooms that strengthen listening and spontaneous speaking so friendships with locals grow more naturally abroad.",
    "screenshot": "https://fluoverse.com/android-chrome-512x512.png",
    "featureList": (() => {
      const all = [
        "Speak-first practice for everyday moments with locals",
        "Confidence that softens cultural and language barriers",
        "Scenario-based outings meetups errands and workplaces",
        "Fluency Rooms for paired conversational role-play",
        "Guided AI conversations grounded in culture and tone",
        "Pathways tuned to the language wherever you relocate",
        "Warmer introductions small talk jokes and goodwill",
        "Custom scenario creation (Premium)",
      ];
      const withTutor = [
        ...all,
        "Tutor dashboards and classroom insights",
      ];
      return LEARNERS_ONLY_SITE ? all : withTutor;
    })(),
    "downloadUrl": [APP_STORE_WEB_URLS.ios, APP_STORE_WEB_URLS.android],
  };

  // WebSite Schema
  const websiteSchema = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    "name": "Fluoverse",
    "url": "https://fluoverse.com",
    "description":
      "Practice the language you hear every day the way friendships start—scenario-first speaking, Fluency Rooms, and guided chats that help newcomers feel more at home with locals.",
  };

  // BreadcrumbList Schema
  const breadcrumbSchema = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
      {
        "@type": "ListItem",
        "position": 1,
        "name": "Home",
        "item": "https://fluoverse.com"
      }
    ]
  };

  return (
    <html lang="en" className={`${inter.variable} ${plusJakarta.variable}`}>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5" />
        <meta name="theme-color" content="#7c3aed" />
        <meta name="format-detection" content="telephone=no" />
        <link rel="icon" href="/favicon.ico" sizes="any" />
        <link rel="icon" href="/favicon-32x32.png" type="image/png" sizes="32x32" />
        <link rel="icon" href="/favicon-16x16.png" type="image/png" sizes="16x16" />
        <link rel="apple-touch-icon" href="/apple-touch-icon.png" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:700|Pacifico" />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(organizationSchema) }}
        />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(softwareApplicationSchema) }}
        />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(websiteSchema) }}
        />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbSchema) }}
        />
      </head>
      <body className="antialiased">
        <GoogleAnalytics />
        <VWO />
        {children}
      </body>
    </html>
  );
}

