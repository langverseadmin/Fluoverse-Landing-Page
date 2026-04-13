/**
 * Central configuration for Fluoverse app URLs and redirects
 * Update these values to change app URLs across the entire website
 */

// Base app domain - change this to switch between environments
// Production: 'https://fluoverseapp.netlify.app'
// Development: 'http://localhost:55857'
export const APP_BASE_URL = process.env.NEXT_PUBLIC_APP_URL || 'https://fluoverseapp.netlify.app';

/**
 * Get the full app URL
 */
export function getAppUrl(): string {
  return APP_BASE_URL.endsWith('/') ? APP_BASE_URL.slice(0, -1) : APP_BASE_URL;
}

/**
 * Get app URL with a specific path/route
 * @param path - The path to append (e.g., '/#/external-pricing-redirect')
 */
export function getAppUrlWithPath(path: string): string {
  const baseUrl = getAppUrl();
  const cleanPath = path.startsWith('/') ? path : `/${path}`;
  return `${baseUrl}${cleanPath}`;
}

/**
 * Get the pricing redirect URL
 * This is used for redirecting users to the app's pricing page
 */
export function getPricingRedirectUrl(): string {
  return getAppUrlWithPath('/#/external-pricing-redirect');
}

/**
 * Get the tutor license checkout URL
 * This is used for redirecting tutors to the app's tutor license checkout page
 */
export function getTutorCheckoutUrl(): string {
  return getAppUrlWithPath('/#/tutor-license-checkout');
}

/** AppsFlyer one-link used on mobile web (hero + deep links). */
export const APP_ONELINK_URL =
  'https://fluoverse.onelink.me/zcI3/9242fe8w' as const;

/**
 * App Store and Play Store URLs (mobile “open app” / one-link flows)
 */
export const APP_STORE_URLS = {
  ios: APP_ONELINK_URL,
  android: APP_ONELINK_URL,
} as const;

/**
 * Direct store listings for desktop browsers (hero store badges)
 */
export const APP_STORE_WEB_URLS = {
  ios: 'https://apps.apple.com/il/app/fluoverse/id6755234538',
  android:
    'https://play.google.com/store/apps/details?id=com.fluoverse.app&hl=en',
} as const;

