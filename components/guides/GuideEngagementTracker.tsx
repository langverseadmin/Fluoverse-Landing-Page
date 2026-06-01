"use client";

import { useEffect, useRef } from "react";
import { trackGuideEngagement } from "@/lib/analytics";

type GuideEngagementTrackerProps = {
  guideSlug: string;
};

export default function GuideEngagementTracker({
  guideSlug,
}: GuideEngagementTrackerProps) {
  const firedRef = useRef<Set<number>>(new Set());

  useEffect(() => {
    const thresholds = [25, 50, 75, 90];

    const handleScroll = () => {
      const doc = document.documentElement;
      const scrollTop = doc.scrollTop || document.body.scrollTop;
      const scrollHeight = doc.scrollHeight - doc.clientHeight;
      if (scrollHeight <= 0) return;

      const percent = Math.round((scrollTop / scrollHeight) * 100);

      for (const threshold of thresholds) {
        if (percent >= threshold && !firedRef.current.has(threshold)) {
          firedRef.current.add(threshold);
          trackGuideEngagement(guideSlug, threshold);
        }
      }
    };

    window.addEventListener("scroll", handleScroll, { passive: true });
    handleScroll();

    return () => window.removeEventListener("scroll", handleScroll);
  }, [guideSlug]);

  return null;
}
