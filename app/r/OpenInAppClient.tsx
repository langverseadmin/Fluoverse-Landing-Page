'use client'

import { APP_STORE_URLS, getAppUrl } from '@/lib/config'
import { useMemo } from 'react'

function isIOS(): boolean {
  if (typeof window === 'undefined') return false
  return /iphone|ipad|ipod/i.test(window.navigator.userAgent)
}

function isAndroid(): boolean {
  if (typeof window === 'undefined') return false
  return /android/i.test(window.navigator.userAgent)
}

export default function OpenInAppClient({ path }: { path: string }) {
  const continueUrl = useMemo(() => {
    const base = getAppUrl()
    const cleanPath = path.startsWith('/') ? path : `/${path}`
    return `${base}${cleanPath}`
  }, [path])

  const onOpen = () => {
    const deepPath = path.startsWith('/') ? path : `/${path}`

    // Try to open the native app (best-effort). If it fails, we fall back.
    if (isAndroid()) {
      const intentUrl = `intent://fluoverse.com${deepPath}#Intent;scheme=https;package=com.fluoverse.app;S.browser_fallback_url=${encodeURIComponent(
        continueUrl,
      )};end`
      window.location.href = intentUrl
      return
    }

    if (isIOS()) {
      // iOS Universal Links should open automatically in Safari if configured.
      // This is a best-effort explicit deep link attempt (requires the app to register the scheme).
      const schemeUrl = `fluoverse://${deepPath.replace(/^\//, '')}`
      window.location.href = schemeUrl
      window.setTimeout(() => {
        window.location.href = APP_STORE_URLS.ios
      }, 1200)
      return
    }

    // Desktop/other: go to the web experience.
    window.location.href = continueUrl
  }

  return (
    <div className="mt-6 flex flex-col gap-3 sm:flex-row">
      <button
        type="button"
        onClick={onOpen}
        className="inline-flex items-center justify-center rounded-xl bg-black px-5 py-3 text-white hover:bg-black/90"
      >
        Open Fluoverse
      </button>
      <a
        href={continueUrl}
        className="inline-flex items-center justify-center rounded-xl border border-black/15 bg-white px-5 py-3 text-black hover:bg-black/5"
      >
        Continue on web
      </a>
      <a
        href={isIOS() ? APP_STORE_URLS.ios : APP_STORE_URLS.android}
        className="inline-flex items-center justify-center rounded-xl border border-black/15 bg-white px-5 py-3 text-black hover:bg-black/5"
      >
        Get the app
      </a>
    </div>
  )
}


