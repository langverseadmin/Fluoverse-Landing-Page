import type { GuideBreadcrumb, GuideFaqItem } from "./types";

const BASE_URL = "https://fluoverse.com";

export function buildBreadcrumbSchema(breadcrumbs: GuideBreadcrumb[]) {
  return {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: breadcrumbs.map((crumb, index) => ({
      "@type": "ListItem",
      position: index + 1,
      name: crumb.name,
      item: `${BASE_URL}${crumb.href}`,
    })),
  };
}

export function buildFaqSchema(faqs: GuideFaqItem[]) {
  return {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: faqs.map((faq) => ({
      "@type": "Question",
      name: faq.question,
      acceptedAnswer: {
        "@type": "Answer",
        text: faq.answer,
      },
    })),
  };
}

export function buildArticleSchema(options: {
  title: string;
  description: string;
  path: string;
}) {
  return {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: options.title,
    description: options.description,
    url: `${BASE_URL}${options.path}`,
    author: {
      "@type": "Organization",
      name: "Fluoverse",
    },
    publisher: {
      "@type": "Organization",
      name: "Fluoverse",
      logo: {
        "@type": "ImageObject",
        url: `${BASE_URL}/android-chrome-512x512.png`,
      },
    },
  };
}

export function buildGuideSchemas(options: {
  title: string;
  description: string;
  path: string;
  breadcrumbs: GuideBreadcrumb[];
  faqs: GuideFaqItem[];
}) {
  return [
    buildBreadcrumbSchema(options.breadcrumbs),
    buildFaqSchema(options.faqs),
    buildArticleSchema({
      title: options.title,
      description: options.description,
      path: options.path,
    }),
  ];
}
