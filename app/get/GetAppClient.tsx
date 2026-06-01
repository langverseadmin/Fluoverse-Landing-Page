'use client'

import { APP_STORE_WEB_URLS } from '@/lib/config'
import { useEffect } from 'react'

/**
 * Store-only redirect. Used as the AppsFlyer OneLink web fallback (af_web_dp)
 * so a tap NEVER lands on the Flutter web app — only the real app (handled by
 * the OS via universal/app links) or the App Store / Play Store.
 *
 * - iOS  -> App Store
 * - Android -> Play Store
 * - Desktop -> show both store links (can't open a mobile app on desktop)
 */
export default function GetAppClient() {
  useEffect(() => {
    const ua = typeof navigator !== 'undefined' ? navigator.userAgent : ''
    if (/android/i.test(ua)) {
      window.location.replace(APP_STORE_WEB_URLS.android)
    } else if (/iphone|ipad|ipod/i.test(ua)) {
      window.location.replace(APP_STORE_WEB_URLS.ios)
    }
  }, [])

  return (
    <div className="flex flex-col items-center gap-6 text-center">
      <h1 className="text-2xl font-bold text-black">Get Fluoverse</h1>
      <p className="max-w-md text-black/70">
        Open this on your phone to jump straight into the app, or grab it from
        your app store below.
      </p>
      <div className="flex flex-col gap-3 sm:flex-row">
        <a
          href={APP_STORE_WEB_URLS.ios}
          className="inline-flex items-center justify-center rounded-xl bg-black px-5 py-3 text-white hover:bg-black/90"
        >
          Download on the App Store
        </a>
        <a
          href={APP_STORE_WEB_URLS.android}
          className="inline-flex items-center justify-center rounded-xl border border-black/15 bg-white px-5 py-3 text-black hover:bg-black/5"
        >
          Get it on Google Play
        </a>
      </div>
    </div>
  )
}
