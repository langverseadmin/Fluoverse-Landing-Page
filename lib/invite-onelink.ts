const ONELINK_BASE = 'https://sharefluoverse.onelink.me/4Qo2'
const STORE_FALLBACK_URL = 'https://fluoverse.com/get'

/** AppsFlyer OneLink used only when the native app is not installed. */
export function buildCommunityInviteOneLink(
  token: string,
  ref?: string,
): string {
  const deepLinkValue = `/community/invite/${token}`
  const afDp = `https://fluoverse.com/community/invite/${token}${
    ref ? `?${new URLSearchParams({ ref }).toString()}` : ''
  }`

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

  return `${ONELINK_BASE}?${query.toString()}`
}
