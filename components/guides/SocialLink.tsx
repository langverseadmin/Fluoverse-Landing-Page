"use client";

import type { ReactNode } from "react";
import type { SocialChannel } from "@/lib/guides/types";
import { trackSocialLinkClick } from "@/lib/analytics";

type SocialLinkProps = {
  href: string;
  channel: SocialChannel;
  city: string;
  children: ReactNode;
  className?: string;
  /** When true, drop the default link styling so the caller controls appearance */
  unstyled?: boolean;
};

export default function SocialLink({
  href,
  channel,
  city,
  children,
  className = "",
  unstyled = false,
}: SocialLinkProps) {
  const base = unstyled
    ? "transition-colors"
    : "text-purple-300 underline decoration-purple-400/50 underline-offset-2 transition-colors hover:text-purple-200 hover:decoration-purple-300";
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      onClick={() => trackSocialLinkClick(city, channel)}
      className={[base, className].filter(Boolean).join(" ")}
    >
      {children}
    </a>
  );
}
