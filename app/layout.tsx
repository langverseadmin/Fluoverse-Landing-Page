import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });

export const metadata: Metadata = {
  title: "Fluoverse - Learn the Language by Living It",
  description: "Experience real-world Spanish conversations powered by AI. Master Spanish with personalized learning, speak-first cycles, and your AI coach.",
  keywords: "Fluoverse, Spanish Learning, AI Tutor, Language Learning, Real Conversations",
  authors: [{ name: "Fluoverse Team" }],
  icons: {
    icon: "/logo.svg",
    apple: "/logo.svg",
  },
  openGraph: {
    title: "Fluoverse - Learn the Language by Living It!",
    description: "Experience real-world Spanish conversations powered by AI.",
    url: "https://fluoverse.com",
    siteName: "Fluoverse",
    images: [
      {
        url: "https://fluoverse.com/logo.svg",
        width: 512,
        height: 512,
        alt: "Fluoverse Logo",
      },
    ],
    locale: "en_US",
    type: "website",
  },
  twitter: {
    card: "summary",
    title: "Fluoverse - Learn the Language by Living It!",
    description: "Experience real-world Spanish conversations powered by AI.",
    images: ["https://fluoverse.com/logo.svg"],
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "Fluoverse",
    "url": "https://fluoverse.com",
    "logo": "https://fluoverse.com/logo.svg",
    "description": "Learn the language by living it. Experience real-world Spanish conversations powered by AI.",
    "sameAs": [
      "https://twitter.com/fluoverse",
      "https://facebook.com/fluoverse",
      "https://instagram.com/fluoverse"
    ]
  };

  return (
    <html lang="en" className={inter.variable}>
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      </head>
      <body className="antialiased">{children}</body>
    </html>
  );
}

