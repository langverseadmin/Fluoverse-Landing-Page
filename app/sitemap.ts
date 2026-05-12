import { MetadataRoute } from "next";

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = "https://fluoverse.com";
  const now = new Date();

  const pages: MetadataRoute.Sitemap = [
    {
      url: baseUrl,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 1,
    },
    {
      url: `${baseUrl}/pricing`,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.85,
    },
    {
      url: `${baseUrl}/contact`,
      lastModified: now,
      changeFrequency: "monthly",
      priority: 0.8,
    },
    {
      url: `${baseUrl}/faq`,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.65,
    },
    {
      url: `${baseUrl}/privacy`,
      lastModified: now,
      changeFrequency: "monthly",
      priority: 0.5,
    },
    {
      url: `${baseUrl}/terms`,
      lastModified: now,
      changeFrequency: "monthly",
      priority: 0.5,
    },
    {
      url: `${baseUrl}/recap`,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.7,
    },
    {
      url: `${baseUrl}/wrapped`,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.7,
    },
  ];

  // Anchors currently used on the marketing homepage for deep linking
  const hashSections = [
    "hero",
    "download",
    "isolation-gallery",
    "benefits",
    "understand-journey",
    "user-video",
    "testimonials",
    "easy-steps",
  ];

  const hashUrls: MetadataRoute.Sitemap = hashSections.map((section) => ({
    url: `${baseUrl}/#${section}`,
    lastModified: now,
    changeFrequency: "weekly",
    priority: 0.55,
  }));

  return [...pages, ...hashUrls];
}
