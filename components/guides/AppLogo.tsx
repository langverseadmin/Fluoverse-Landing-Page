import Image from "next/image";
import type { AppBrand, AppBrandId } from "@/lib/guides/brands";
import { APP_BRANDS } from "@/lib/guides/brands";

type AppLogoProps = {
  brand: AppBrand | AppBrandId;
  size?: number;
  className?: string;
};

export default function AppLogo({
  brand,
  size = 40,
  className = "",
}: AppLogoProps) {
  const b = typeof brand === "string" ? APP_BRANDS[brand] : brand;

  // SVGs that already carry their own coloured background (all except Fluoverse)
  // should fill the container directly, no white wrapper.
  const hasBgColor = b.id !== "fluoverse";

  return (
    <span
      className={[
        "inline-flex shrink-0 items-center justify-center overflow-hidden",
        hasBgColor ? "rounded-xl" : "rounded-xl bg-white shadow-sm ring-1 ring-white/20",
        className,
      ]
        .filter(Boolean)
        .join(" ")}
      style={{ width: size, height: size }}
    >
      <Image
        src={b.logo}
        alt={b.logoAlt}
        width={size}
        height={size}
        className="h-full w-full object-contain"
      />
    </span>
  );
}
