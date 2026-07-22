import type { Metadata } from 'next'
import CheckinPass from '@/components/CheckinPass'
import { fetchCheckinTicket } from '@/lib/checkin'

export const dynamic = 'force-dynamic'

type PageProps = {
  params: { token: string }
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const result = await fetchCheckinTicket(params.token)
  if (!result.valid) {
    return {
      title: 'Ticket',
      description: 'Fluoverse event ticket',
      robots: { index: false, follow: false },
    }
  }
  return {
    title: result.event.title,
    description: `Your Fluoverse ticket · ${result.display_code}`,
    robots: { index: false, follow: false },
  }
}

/**
 * Public scan target for event QR codes:
 * https://fluoverse.com/checkin/<ticket_token>
 */
export default async function CheckinPage({ params }: PageProps) {
  const result = await fetchCheckinTicket(params.token)

  return (
    <main className="relative flex min-h-[100dvh] w-full items-center justify-center px-5 py-10 sm:px-6 sm:py-14">
      {/* Soft focus glow — brand, not clutter */}
      <div
        aria-hidden
        className="pointer-events-none absolute inset-0 overflow-hidden"
      >
        <div className="absolute left-1/2 top-[18%] h-64 w-64 -translate-x-1/2 rounded-full bg-[#7b2cbd]/[0.18] blur-3xl" />
      </div>

      <div className="relative z-10 flex w-full justify-center">
        <CheckinPass result={result} />
      </div>
    </main>
  )
}
