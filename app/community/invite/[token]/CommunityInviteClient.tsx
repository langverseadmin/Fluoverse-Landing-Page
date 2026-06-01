'use client'

import { buildCommunityInviteOneLink } from '@/lib/invite-onelink'
import { useEffect, useMemo } from 'react'

function isIOS(): boolean {
  if (typeof navigator === 'undefined') return false
  return /iphone|ipad|ipod/i.test(navigator.userAgent)
}

function isAndroid(): boolean {
  if (typeof navigator === 'undefined') return false
  return /android/i.test(navigator.userAgent)
}

type Props = {
  token: string
  refCode?: string
}

/**
 * Try the native app first. Only send people to OneLink / the store when the
 * app is not installed — OneLink cannot detect an existing install server-side.
 */
export default function CommunityInviteClient({ token, refCode }: Props) {
  const path = `/community/invite/${token}`

  const universalUrl = useMemo(() => {
    const query = refCode
      ? `?${new URLSearchParams({ ref: refCode }).toString()}`
      : ''
    return `https://fluoverse.com${path}${query}`
  }, [path, refCode])

  const onelinkUrl = useMemo(
    () => buildCommunityInviteOneLink(token, refCode),
    [token, refCode],
  )

  useEffect(() => {
    let cancelled = false

    const goToStoreFlow = () => {
      if (cancelled || document.visibilityState !== 'visible') return
      window.location.replace(onelinkUrl)
    }

    if (isAndroid()) {
      // com.fluoverse.app://launch is registered in every current Android build.
      // If the app is installed it opens; if not, Android follows
      // browser_fallback_url → OneLink → Play Store + deferred deep link.
      const params = new URLSearchParams({
        deep_link_value: path,
        community_invite_token: token,
      })
      if (refCode) params.set('ref', refCode)

      const intentUrl =
        `intent://launch?${params.toString()}` +
        '#Intent;scheme=com.fluoverse.app;package=com.fluoverse.app;' +
        `S.browser_fallback_url=${encodeURIComponent(onelinkUrl)};end`

      window.location.href = intentUrl

      const backup = window.setTimeout(goToStoreFlow, 2500)
      return () => {
        cancelled = true
        window.clearTimeout(backup)
      }
    }

    if (isIOS()) {
      // Re-hit the universal link so iOS can hand off to the installed app.
      window.location.href = universalUrl

      const backup = window.setTimeout(goToStoreFlow, 2500)
      return () => {
        cancelled = true
        window.clearTimeout(backup)
      }
    }

    // Desktop: no native app — go straight to OneLink / store fallback.
    goToStoreFlow()
  }, [onelinkUrl, path, refCode, token, universalUrl])

  return (
    <main className="mx-auto flex min-h-[70vh] w-full max-w-2xl items-center justify-center px-6 py-16">
      <p className="text-center text-black/70">Opening Fluoverse…</p>
    </main>
  )
}
