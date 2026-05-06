/**
 * Centralized Google Analytics event tracking utility.
 * Store badge clicks use stable event names + `placement` so GA4 can compare locations.
 */

type GtagFn = (...args: unknown[]) => void;

function getGtag(): GtagFn | undefined {
  if (typeof window === "undefined") return undefined;
  return (window as typeof window & { gtag?: GtagFn }).gtag;
}

function track(eventName: string, params?: Record<string, string | number | boolean>) {
  const gtag = getGtag();
  if (gtag) {
    gtag("event", eventName, params ?? {});
  }
}

// ─── Navigation ──────────────────────────────────────────────────────────────

export const trackNavGetStarted = (location: "desktop" | "mobile") =>
  track("nav_cta_get_started", { location });

export const trackNavBookCall = (location: "desktop" | "mobile") =>
  track("nav_cta_book_call", { location });

export const trackNavLink = (name: string, location: "desktop" | "mobile") =>
  track("nav_link_click", { link_name: name, location });

export const trackNavMobileMenuToggle = (opened: boolean) =>
  track(opened ? "nav_mobile_menu_open" : "nav_mobile_menu_close");

// ─── Store badges (App Store / Google Play) ────────────────────────────────
/** Badge row location — register `placement` as a GA4 custom dimension for breakdowns */
export type StoreDownloadPlacement =
  | "hero"
  | "isolation_showcase"
  | "benefits"
  | "after_testimonials"
  | "easy_steps_isolation_cta";

export const trackStoreBadgeAppStore = (placement: StoreDownloadPlacement) =>
  track("download_app_store_click", { placement });

export const trackStoreBadgeGooglePlay = (placement: StoreDownloadPlacement) =>
  track("download_google_play_click", { placement });

// ─── Benefits ─────────────────────────────────────────────────────────────────

export const trackBenefitsTabSwitch = (tab: "learners" | "tutors") =>
  track(`benefits_tab_${tab}`);

export const trackBenefitsCtaTryFluoverse = () =>
  track("benefits_cta_try_fluoverse");

export const trackBenefitsCtaBookCall = () =>
  track("benefits_cta_book_call");

export const trackBenefitsScenarioOpenFluoverse = () =>
  track("benefits_scenario_open_fluoverse");

export const trackBenefitsVoiceTestPlay = (language: string) =>
  track("benefits_voice_test_play", { language });

export const trackBenefitsVoiceTestStop = (language: string) =>
  track("benefits_voice_test_stop", { language });

export const trackBenefitsVoiceLanguageSelect = (language: string) =>
  track("benefits_voice_language_select", { language });

// ─── Pricing ──────────────────────────────────────────────────────────────────

export const trackPricingTabSwitch = (tab: "learners" | "tutors" | "businesses") =>
  track(`pricing_tab_${tab}`);

export const trackPricingCtaClick = (plan: string) =>
  track("pricing_cta_click", { plan_name: plan });

// ─── CTA Section ──────────────────────────────────────────────────────────────

export const trackCtaStartLearningFree = () =>
  track("cta_start_learning_free");

// ─── FAQ ──────────────────────────────────────────────────────────────────────

export const trackFaqOpen = (question: string) =>
  track("faq_question_open", { question });

// ─── Footer ───────────────────────────────────────────────────────────────────

export const trackFooterSocialClick = (platform: string) =>
  track(`footer_social_${platform.toLowerCase()}`);
