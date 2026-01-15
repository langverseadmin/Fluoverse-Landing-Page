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
  const fallbackPath = useMemo(() => {
    // Our website deep links are under /r/..., but the Flutter web app typically routes without /r.
    // Example: /r/micro -> /micro
    if (path === '/r') return '/'
    if (path.startsWith('/r/')) return path.replace(/^\/r/, '')
    return path.startsWith('/') ? path : `/${path}`
  }, [path])

  const continueUrl = useMemo(() => {
    const base = getAppUrl()
    return `${base}${fallbackPath}`
  }, [fallbackPath])

  const onOpen = () => {
    const deepPath = path.startsWith('/') ? path : `/${path}`
    const search = typeof window !== 'undefined' ? window.location.search : ''
    const universalUrl = `https://fluoverse.com${deepPath}${search}`
    const continueUrlWithQuery = `${continueUrl}${search}`
    const deepPathWithQuery = `${deepPath}${search}`

    // Try to open the native app (best-effort). If it fails, we fall back.
    if (isAndroid()) {
      const intentUrl = `intent://fluoverse.com${deepPathWithQuery}#Intent;scheme=https;package=com.fluoverse.app;S.browser_fallback_url=${encodeURIComponent(
        continueUrlWithQuery,
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
    window.location.href = continueUrlWithQuery
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
        href={`${continueUrl}${typeof window !== 'undefined' ? window.location.search : ''}`}
        className="inline-flex items-center justify-center rounded-xl border border-black/15 bg-white px-5 py-3 text-black hover:bg-black/5"
      >
        Continue on web
      </a>
    </div>
  )
}


