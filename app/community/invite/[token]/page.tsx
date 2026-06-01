import CommunityInviteClient from './CommunityInviteClient'

export const dynamic = 'force-dynamic'

type PageProps = {
  params: { token: string }
  searchParams?: Record<string, string | string[] | undefined>
}

function firstParam(value: string | string[] | undefined): string | undefined {
  if (Array.isArray(value)) return value[0]
  return value
}

/**
 * Public invite link: https://fluoverse.com/community/invite/<token>
 *
 * Client-side routing tries the native app first, then OneLink / store only
 * when the app is not installed.
 */
export default function CommunityInvitePage({ params, searchParams }: PageProps) {
  return (
    <CommunityInviteClient
      token={params.token}
      refCode={firstParam(searchParams?.ref)}
    />
  )
}
