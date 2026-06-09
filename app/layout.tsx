import type { Metadata } from "next";
import { Inter, Plus_Jakarta_Sans } from "next/font/google";
import "./globals.css";
import GoogleAnalytics from "@/components/GoogleAnalytics";
import VWO from "@/components/VWO";
import { APP_STORE_WEB_URLS, LEARNERS_ONLY_SITE } from "@/lib/config";
import {
  SITE_DESCRIPTION,
  SITE_KEYWORDS,
  SITE_NAME,
  SITE_OG,
  SITE_TAGLINE,
  SITE_TITLE,
  SITE_TWITTER,
} from "@/lib/site-metadata";

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
    default: SITE_TITLE,
    template: `%s | ${SITE_NAME}`,
  },
  description: SITE_DESCRIPTION,
  keywords: [...SITE_KEYWORDS],
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
    url: SITE_OG.url,
    siteName: SITE_OG.siteName,
    title: SITE_OG.title,
    description: SITE_OG.description,
    images: [
      {
        url: SITE_OG.image,
        width: 1200,
        height: 630,
        alt: SITE_OG.imageAlt,
        type: "image/png",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: SITE_TWITTER.title,
    description: SITE_TWITTER.description,
    images: [SITE_OG.image],
    creator: "@fluoverse",
  },
  category: "Social Networking",
  classification: "Social Integration Application",
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
    "description": SITE_DESCRIPTION,
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
    "applicationCategory": "SocialNetworkingApplication",
    "operatingSystem": ["iOS", "Android"],
    "offers": {
      "@type": "Offer",
      "price": "0",
      "priceCurrency": "USD",
    },
    "description":
      `${SITE_TAGLINE} Friend-making app for expats in Spain through shared activities, recurring meetups, and Spanish and culture coaching.`,
    "screenshot": "https://fluoverse.com/android-chrome-512x512.png",
    "featureList": (() => {
      const all = [
        "Real Spanish for everyday situations with locals",
        "Cultural coaching so you stop feeling like an outsider",
        "Interest-based matching with trustworthy people",
        "Recurring group meetups that build real friendships",
        "Conversation practice before you walk into social events",
        "Guided path from lonely newcomer to feeling at home",
        "Activities with locals and fellow expats in Spain",
        "Custom scenarios for your city and situation (Premium)",
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
    "description": SITE_DESCRIPTION,
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

