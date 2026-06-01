import { APP_BRANDS, type AppBrandId } from "@/lib/guides/brands";
import AppLogo from "./AppLogo";
import { Reveal } from "./GuideUI";

type AppLogoStripProps = {
  appIds: AppBrandId[];
  caption?: string;
};

export default function AppLogoStrip({ appIds, caption }: AppLogoStripProps) {
  return (
    <Reveal>
      <div className="mb-16 rounded-3xl border border-white/10 bg-white/[0.04] p-6 sm:p-8">
        {caption && <p className="mb-5 text-sm text-white/65">{caption}</p>}
        <div className="flex flex-wrap items-center gap-4">
          {appIds.map((id) => (
            <div
              key={id}
              className="flex items-center gap-2.5 rounded-2xl border border-white/10 bg-white/[0.03] px-3 py-2"
            >
              <AppLogo brand={id} size={36} />
              <span className="text-sm font-medium text-white/85">
                {APP_BRANDS[id].name}
              </span>
            </div>
          ))}
        </div>
      </div>
    </Reveal>
  );
}
