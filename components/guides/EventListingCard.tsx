import Image from "next/image";
import type { ReactNode } from "react";
import type { SocialChannel } from "@/lib/guides/types";
import { brandForChannel, brandForAppName } from "@/lib/guides/brands";
import AppLogo from "./AppLogo";
import { GlassCard } from "./GuideUI";

type EventListingCardProps = {
  imageUrl?: string;
  imageAlt: string;
  source: string;
  channel: SocialChannel;
  children: ReactNode;
  footer?: ReactNode;
};

export default function EventListingCard({
  imageUrl,
  imageAlt,
  source,
  channel,
  children,
  footer,
}: EventListingCardProps) {
  const platformBrand =
    brandForChannel(channel) ?? brandForAppName(source);

  return (
    <GlassCard className="overflow-hidden">
      <div className="flex flex-col sm:flex-row">
        <div className="relative aspect-[16/10] w-full shrink-0 sm:aspect-auto sm:w-44 sm:min-h-[140px] md:w-52">
          {imageUrl ? (
            <Image
              src={imageUrl}
              alt={imageAlt}
              fill
              className="object-cover"
              sizes="(max-width: 640px) 100vw, 208px"
            />
          ) : (
            <div
              className={[
                "flex h-full min-h-[140px] items-center justify-center",
                platformBrand?.id === "internations"
                  ? "bg-[#005EB8]/25"
                  : platformBrand?.id === "whatsapp"
                    ? "bg-emerald-500/15"
                    : "bg-white/[0.06]",
              ].join(" ")}
            >
              {platformBrand ? (
                <AppLogo brand={platformBrand} size={72} />
              ) : (
                <span className="text-xs uppercase tracking-wider text-white/40">
                  {source}
                </span>
              )}
            </div>
          )}
          <span className="absolute left-3 top-3 inline-flex items-center gap-1.5 rounded-full bg-black/55 px-2.5 py-1 text-[10px] font-semibold uppercase tracking-wider text-white backdrop-blur-sm">
            {platformBrand && (
              <AppLogo
                brand={platformBrand}
                size={16}
                className="rounded-md ring-0"
              />
            )}
            {source}
          </span>
        </div>
        <div className="flex flex-1 flex-col justify-between p-4 sm:p-5">
          <div>{children}</div>
          {footer && <div className="mt-4">{footer}</div>}
        </div>
      </div>
    </GlassCard>
  );
}
