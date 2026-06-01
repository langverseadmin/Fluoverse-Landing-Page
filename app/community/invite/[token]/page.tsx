import { redirect } from 'next/navigation'

// Always run on the server so we issue a fresh redirect per request.
export const dynamic = 'force-dynamic'

// AppsFlyer OneLink template for community invites.
const ONELINK_BASE = 'https://sharefluoverse.onelink.me/4Qo2'

// Web fallback for the OneLink. Points at a STORE-ONLY page so a tap never
// opens the Flutter web app — only the real app (via universal/app link) or
// the App Store / Play Store.
const STORE_FALLBACK_URL = 'https://fluoverse.com/get'

type PageProps = {
  params: { token: string }
  searchParams?: Record<string, string | string[] | undefined>
}

function firstParam(value: string | string[] | undefined): string | undefined {
  if (Array.isArray(value)) return value[0]
  return value
}

/**
 * Public, branded invite link: https://fluoverse.com/community/invite/<token>
 *
 * - Installed apps open this directly via the universal link / app link
 *   (this route never runs for them).
 * - Everyone else (desktop, or mobile without the app) lands here and is
 *   forwarded to the AppsFlyer OneLink, which sends them to the App Store /
 *   Play Store and delivers the invite token via deferred deep linking after
 *   install. The web fallback (af_web_dp) is a STORE-ONLY page — it never opens
 *   the Flutter web app, so a tap always ends on the real app or a store.
 */
export default function CommunityInviteRedirect({ params, searchParams }: PageProps) {
  const token = params.token
  const ref = firstParam(searchParams?.ref)

  const deepLinkValue = `/community/invite/${token}`
  // af_dp MUST be a full https URL. A bare path (/community/invite/…) makes
  // AppsFlyer's Android intent builder produce a broken intent:// URL that
  // flashes and closes immediately ("screen can't load").
  const afDp = `https://fluoverse.com/community/invite/${token}${ref ? `?${new URLSearchParams({ ref }).toString()}` : ''}`

  const query = new URLSearchParams({
    deep_link_value: deepLinkValue,
    af_dp: afDp,
    community_invite_token: token,
    af_web_dp: STORE_FALLBACK_URL,
    pid: 'user_invite',
    c: 'community_invite',
  })

  if (ref) {
    query.set('af_sub1', ref)
    query.set('ref', ref)
  }

  redirect(`${ONELINK_BASE}?${query.toString()}`)
}
