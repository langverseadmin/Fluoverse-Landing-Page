'use client'

import { getAppUrl } from '@/lib/config'
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
    const universalUrl = `https://fluoverse.com${deepPath}`

    // Try to open the native app (best-effort). If it fails, we fall back.
    if (isAndroid()) {
      const intentUrl = `intent://fluoverse.com${deepPath}#Intent;scheme=https;package=com.fluoverse.app;S.browser_fallback_url=${encodeURIComponent(
        continueUrl,
      )};end`
      window.location.href = intentUrl
      return
    }

    if (isIOS()) {
      // iOS: use the Universal Link itself (no custom scheme).
      // If we're already on it, reload to re-trigger OS handling in some contexts.
      if (window.location.href === universalUrl) {
        window.location.reload()
      } else {
        window.location.href = universalUrl
      }
      return
    }

    // Desktop/other: go to the web experience.
    window.location.href = continueUrl
  }

  return (
    <div className="flex flex-col gap-3 sm:flex-row">
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
    </div>
  )
}


