import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import GoogleAnalytics from "@/components/GoogleAnalytics";
import VWO from "@/components/VWO";

const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });

export const metadata: Metadata = {
  metadataBase: new URL("https://fluoverse.com"),
  title: {
    default: "Fluoverse - Empowering every voice to speak with confidence | Authentic Speaking Practice",
    template: "%s | Fluoverse",
  },
  description: "Master English, Spanish, and Greek through immersive, interactive speaking practice. Assign speaking exercises at home, practice with real people or the AI, and build fluency through authentic conversations. Join 200+ active learners speaking with confidence.",
  keywords: [
    "Fluoverse",
    "Spanish Learning",
    "English Learning",
    "Greek Learning",
    "Authentic Speaking Practice",
    "Language Learning App",
    "Conversational Spanish",
    "Speaking Practice",
    "Language Practice",
    "Real Conversations",
    "Language Immersion",
    "Spanish Speaking Practice",
    "Interactive Language Learning",
    "Voice-Based Language Learning",
    "Speak with Real People",
    "Fluency Practice",
    "Assign Speaking at Home",
    "Immersive Language Learning",
    "Interactive Speaking Practice",
    "Learn Spanish Online",
    "Learn English Online",
    "Learn Greek Online",
    "Language Learning Platform",
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
    title: "Fluoverse - Empowering every voice to speak with confidence | Authentic Speaking Practice",
    description: "Master English, Spanish, and Greek through immersive, interactive speaking practice. Assign speaking exercises at home and practice with real people or the AI. Build fluency through authentic conversations.",
    images: [
      {
        url: "https://fluoverse.com/android-chrome-512x512.png",
        width: 512,
        height: 512,
        alt: "Fluoverse - Authentic Speaking Practice Platform for English, Spanish, and Greek",
        type: "image/png",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Fluoverse - Empowering every voice to speak with confidence",
    description: "Master English, Spanish, and Greek through immersive, interactive speaking practice. Assign speaking at home and practice with real people or the AI to build fluency.",
    images: ["https://fluoverse.com/android-chrome-512x512.png"],
    creator: "@fluoverse",
  },
  alternates: {
    canonical: "https://fluoverse.com",
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
    "description": "Empowering every voice to speak with confidence. Experience authentic speaking practice in English, Spanish, and Greek through immersive, interactive conversations with real people or the AI.",
    "foundingDate": "2024",
    "sameAs": [
      "https://twitter.com/fluoverse",
      "https://facebook.com/fluoverse",
      "https://instagram.com/fluoverse"
    ],
    "contactPoint": {
      "@type": "ContactPoint",
      "contactType": "Customer Support",
      "availableLanguage": ["English", "Spanish", "Greek"]
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
      "priceCurrency": "USD"
    },
    "aggregateRating": {
      "@type": "AggregateRating",
      "ratingValue": "4.9",
      "ratingCount": "2000",
      "bestRating": "5",
      "worstRating": "1"
    },
    "description": "Master English, Spanish, and Greek through immersive, interactive speaking practice. Assign speaking exercises at home, practice with real people, and build fluency through authentic conversations.",
    "screenshot": "https://fluoverse.com/android-chrome-512x512.png",
    "featureList": [
      "Authentic Speaking Practice",
      "Assign Speaking at Home",
      "Interactive Voice Conversations",
      "Real-World Scenario Practice",
      "Speak with Real People",
      "Custom Scenario Creation",
      "Progress Tracking",
      "Multi-Language Support (English, Spanish, Greek)",
      "Tutor Analytics Dashboard",
      "Fluency Building Exercises"
    ],
    "inLanguage": ["en", "es", "el"],
    "downloadUrl": [
      "https://apps.apple.com/gr/app/fluoverse/id6755234538",
      "https://play.google.com/store/search?q=Fluoverse&c=apps&hl=en"
    ]
  };

  // WebSite Schema
  const websiteSchema = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    "name": "Fluoverse",
    "url": "https://fluoverse.com",
    "description": "Learn the language by living it. Immersive, interactive speaking practice platform for English, Spanish, and Greek. Assign speaking at home and practice with real people.",
    "potentialAction": {
      "@type": "SearchAction",
      "target": {
        "@type": "EntryPoint",
        "urlTemplate": "https://fluoverse.com/search?q={search_term_string}"
      },
      "query-input": "required name=search_term_string"
    }
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
    <html lang="en" className={inter.variable}>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5" />
        <meta name="theme-color" content="#7c3aed" />
        <meta name="format-detection" content="telephone=no" />
        <link rel="canonical" href="https://fluoverse.com" />
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

