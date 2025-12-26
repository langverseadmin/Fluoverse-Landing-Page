/**
 * Check if the device is mobile or tablet
 */
export function isMobileDevice(): boolean {
  if (typeof window === 'undefined') return false;
  
  const userAgent = window.navigator.userAgent.toLowerCase();
  const mobileRegex = /android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i;
  
  return mobileRegex.test(userAgent) || window.innerWidth < 768;
}

/**
 * Get the appropriate URL based on device type
 * For now, all devices redirect to web app
 * TODO: Add app deep linking for mobile devices
 */
export function getFluoverseUrl(): string {
  // For now, always use web URL
  // In the future, we can add:
  // - iOS: fluoverse:// or App Store link
  // - Android: intent:// or Play Store link
  return 'https://fluoverseapp.netlify.app/';
}
