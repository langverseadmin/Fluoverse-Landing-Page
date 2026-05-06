"use client";

import { APP_STORE_WEB_URLS } from "@/lib/config";

type AppStoreBadgeLinksProps = {
  onAppStoreClick?: () => void;
  onGooglePlayClick?: () => void;
  className?: string;
};

/**
 * App Store + Google Play badges (same markup as Hero) — wrap with motion in the parent if needed.
 */
export default function AppStoreBadgeLinks({
  onAppStoreClick,
  onGooglePlayClick,
  className = "",
}: AppStoreBadgeLinksProps) {
  return (
    <div
      className={[
        "flex w-full flex-col items-center justify-center gap-5 sm:flex-row",
        className,
      ]
        .filter(Boolean)
        .join(" ")}
    >
      <a
        href={APP_STORE_WEB_URLS.ios}
        target="_blank"
        rel="noopener noreferrer"
        onClick={onAppStoreClick}
        aria-label="Download on the App Store"
        className="hero-store-badge-3d"
      >
        <div className="flex items-center justify-center pl-4 pr-2.5 shrink-0 self-center">
          <svg
            className="w-7 h-7 text-white"
            viewBox="0 0 24 24"
            fill="currentColor"
            aria-hidden
          >
            <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.81-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
          </svg>
        </div>
        <div className="flex flex-col justify-center border-l border-white/25 pl-3.5 pr-5 py-2.5 min-h-14">
          <span className="text-[11px] font-normal leading-tight tracking-wide text-white">
            Download on the
          </span>
          <span className="text-[17px] font-bold leading-tight tracking-tight text-white mt-0.5">
            App Store
          </span>
        </div>
      </a>

      <a
        href={APP_STORE_WEB_URLS.android}
        target="_blank"
        rel="noopener noreferrer"
        onClick={onGooglePlayClick}
        aria-label="Get it on Google Play"
        className="hero-store-badge-3d"
      >
        <div className="flex items-center justify-center pl-4 pr-2.5 shrink-0 self-center">
          <svg
            className="w-7 h-7 text-white"
            viewBox="0 0 24 24"
            fill="currentColor"
            aria-hidden
          >
            <path d="M3,20.5V3.5C3,2.91 3.34,2.39 3.84,2.15L13.69,12L3.84,21.85C3.34,21.6 3,21.09 3,20.5M16.81,15.12L6.05,21.34L14.54,12.85L16.81,15.12M20.16,10.81C20.5,11.08 20.75,11.5 20.75,12C20.75,12.5 20.5,12.92 20.16,13.19L17.19,14.5L14.54,11.85L17.19,9.5L20.16,10.81M6.05,2.66L16.81,8.88L14.54,11.15L6.05,2.66Z" />
          </svg>
        </div>
        <div className="flex flex-col justify-center border-l border-white/25 pl-3.5 pr-5 py-2.5 min-h-14">
          <span className="text-[11px] font-normal leading-tight tracking-wide text-white">
            Get it on
          </span>
          <span className="text-[17px] font-bold leading-tight tracking-tight text-white mt-0.5">
            Google Play
          </span>
        </div>
      </a>
    </div>
  );
}
