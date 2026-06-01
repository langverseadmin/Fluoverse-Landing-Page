"use client";

import { useState } from "react";
import { Minus, Plus } from "lucide-react";
import type { GuideFaqItem } from "@/lib/guides/types";

type GuideFAQProps = {
  faqs: GuideFaqItem[];
  heading?: string;
};

export default function GuideFAQ({
  faqs,
  heading = "Frequently asked questions",
}: GuideFAQProps) {
  const [openIndex, setOpenIndex] = useState<number | null>(0);

  return (
    <section aria-labelledby="guide-faq-heading" className="mt-16">
      <h2
        id="guide-faq-heading"
        className="mb-8 text-2xl font-bold text-white sm:text-3xl"
      >
        {heading}
      </h2>
      <div className="space-y-3">
        {faqs.map((faq, index) => {
          const isOpen = openIndex === index;
          return (
            <div
              key={faq.question}
              className="overflow-hidden rounded-2xl border border-white/10 bg-white/5"
            >
              <button
                type="button"
                onClick={() => setOpenIndex(isOpen ? null : index)}
                className="flex w-full items-center justify-between gap-4 px-5 py-4 text-left"
                aria-expanded={isOpen}
              >
                <span className="font-semibold text-white">{faq.question}</span>
                {isOpen ? (
                  <Minus
                    className="h-4 w-4 shrink-0 text-purple-300"
                    aria-hidden
                  />
                ) : (
                  <Plus
                    className="h-4 w-4 shrink-0 text-purple-300"
                    aria-hidden
                  />
                )}
              </button>
              {isOpen && (
                <div className="border-t border-white/10 px-5 pb-4 pt-3">
                  <p className="leading-relaxed text-white/75">{faq.answer}</p>
                </div>
              )}
            </div>
          );
        })}
      </div>
    </section>
  );
}
