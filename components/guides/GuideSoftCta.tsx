"use client";

import AppStoreBadgeLinks from "@/components/AppStoreBadgeLinks";
import {
  trackStoreBadgeAppStore,
  trackStoreBadgeGooglePlay,
  type StoreDownloadPlacement,
} from "@/lib/analytics";

type GuideSoftCtaProps = {
  heading: string;
  body: string;
  placement: StoreDownloadPlacement;
};

export default function GuideSoftCta({
  heading,
  body,
  placement,
}: GuideSoftCtaProps) {
  return (
    <aside className="mt-12 rounded-2xl border border-purple-400/30 bg-purple-500/10 p-6 sm:p-8">
      <h2 className="mb-3 text-xl font-bold text-white sm:text-2xl">
        {heading}
      </h2>
      <p className="mb-6 leading-relaxed text-white/80">{body}</p>
      <AppStoreBadgeLinks
        onAppStoreClick={() => trackStoreBadgeAppStore(placement)}
        onGooglePlayClick={() => trackStoreBadgeGooglePlay(placement)}
      />
    </aside>
  );
}
