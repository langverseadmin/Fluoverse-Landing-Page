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
 * On mobile, uses app store links which will open the app if installed,
 * or redirect to the store if not installed
 */
export function getFluoverseUrl(): string {
  if (typeof window === 'undefined') {
    return 'https://fluoverseapp.netlify.app/';
  }

  const userAgent = window.navigator.userAgent.toLowerCase();
  const isIOS = /iphone|ipad|ipod/.test(userAgent);
  const isAndroid = /android/.test(userAgent);

  if (isIOS) {
    // iOS App Store link - will open app if installed, store if not
    return 'https://apps.apple.com/gr/app/fluoverse/id6755234538';
  } else if (isAndroid) {
    // Try direct Play Store link first (if package name is correct)
    // Falls back to search if package not found
    // Note: If app is installed and App Links are configured, this will open the app
    const packageName = 'com.fluoverse.app';
    return `https://play.google.com/store/apps/details?id=${packageName}`;
  }

  // Desktop or unknown - use web app
  return 'https://fluoverseapp.netlify.app/';
}

/**
 * Open the Fluoverse app using deep link, with fallback to store
 * This function tries to open the app first, then falls back to the store
 */
export function openFluoverseApp(): void {
  if (typeof window === 'undefined') return;

  const userAgent = window.navigator.userAgent.toLowerCase();
  const isIOS = /iphone|ipad|ipod/.test(userAgent);
  const isAndroid = /android/.test(userAgent);

  if (isIOS) {
    // Use App Store link directly
    // Note: Custom URL schemes (fluoverse://) require configuration in the iOS app's Info.plist
    // Since the scheme isn't registered, we use the App Store link
    // If the app is installed, the App Store page will show an "Open" button
    const appStoreUrl = 'https://apps.apple.com/gr/app/fluoverse/id6755234538';
    window.location.href = appStoreUrl;
  } else if (isAndroid) {
    // Use Android Intent URL which handles fallback automatically
    const packageName = 'com.fluoverse.app';
    const playStoreUrl = `https://play.google.com/store/apps/details?id=${packageName}`;
    
    // Intent URL tries app first, then falls back to Play Store
    const intentUrl = `intent://open#Intent;scheme=fluoverse;package=${packageName};S.browser_fallback_url=${encodeURIComponent(playStoreUrl)};end`;
    
    window.location.href = intentUrl;
  } else {
    // Desktop - just open web app
    window.open('https://fluoverseapp.netlify.app/', '_blank');
  }
}
