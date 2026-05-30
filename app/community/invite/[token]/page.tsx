import { redirect } from 'next/navigation'
import { getAppUrl } from '@/lib/config'

// Always run on the server so we issue a fresh redirect per request.
export const dynamic = 'force-dynamic'

// AppsFlyer OneLink template for community invites.
const ONELINK_BASE = 'https://sharefluoverse.onelink.me/4Qo2'

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
 *   install. The web fallback (af_web_dp) points at the real Flutter web app,
 *   never back at fluoverse.com, so there is no redirect loop.
 */
export default function CommunityInviteRedirect({ params, searchParams }: PageProps) {
  const token = params.token
  const ref = firstParam(searchParams?.ref)

  const deepLinkValue = `/community/invite/${token}`
  const webFallbackQuery = ref ? `?${new URLSearchParams({ ref }).toString()}` : ''
  const webFallback = `${getAppUrl()}/community/invite/${token}${webFallbackQuery}`

  const query = new URLSearchParams({
    deep_link_value: deepLinkValue,
    af_dp: deepLinkValue,
    community_invite_token: token,
    af_web_dp: webFallback,
    pid: 'user_invite',
    c: 'community_invite',
  })

  if (ref) {
    query.set('af_sub1', ref)
    query.set('ref', ref)
  }

  redirect(`${ONELINK_BASE}?${query.toString()}`)
}
