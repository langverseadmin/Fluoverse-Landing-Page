import type { CheckinResult } from '@/lib/checkin'

type Props = {
  result: CheckinResult
}

function MetaRow({ label, value }: { label: string; value: string }) {
  if (!value.trim()) return null
  return (
    <div className="flex flex-col gap-1 border-t border-white/[0.08] pt-4 first:border-t-0 first:pt-0">
      <span className="text-[11px] font-semibold uppercase tracking-[0.18em] text-white/45">
        {label}
      </span>
      <span className="text-[15px] font-medium leading-snug text-white/92 sm:text-base">
        {value}
      </span>
    </div>
  )
}

export default function CheckinPass({ result }: Props) {
  if (!result.valid) {
    const isNetwork = result.error === 'network'
    return (
      <section className="w-full max-w-[400px] animate-slide-up px-1">
        <div className="rounded-[28px] border border-white/10 bg-white/[0.04] px-6 py-10 text-center shadow-[0_24px_80px_rgba(0,0,0,0.35)] backdrop-blur-md sm:px-8">
          <div className="mx-auto mb-5 flex h-14 w-14 items-center justify-center rounded-full bg-white/[0.06] ring-1 ring-white/10">
            <span className="text-2xl text-white/70" aria-hidden>
              ✕
            </span>
          </div>
          <p className="text-[11px] font-semibold uppercase tracking-[0.2em] text-white/45">
            Fluoverse
          </p>
          <h1 className="mt-3 font-display text-[1.65rem] font-bold tracking-tight text-white">
            {isNetwork ? 'Can’t reach ticket' : 'Ticket not found'}
          </h1>
          <p className="mx-auto mt-3 max-w-[280px] text-[15px] leading-relaxed text-white/55">
            {isNetwork
              ? 'Check your connection and try again.'
              : 'This pass isn’t valid, or the link is incomplete.'}
          </p>
        </div>
      </section>
    )
  }

  const waitlisted = result.status === 'waitlist'
  const { event } = result
  const place =
    event.place_line ||
    [event.spot, event.city].filter(Boolean).join(' · ') ||
    'Venue TBA'

  return (
    <section className="w-full max-w-[400px] animate-slide-up px-1">
      <div className="overflow-hidden rounded-[28px] border border-white/10 bg-white/[0.04] shadow-[0_24px_80px_rgba(0,0,0,0.35)] backdrop-blur-md">
        {/* Status band */}
        <div
          className={
            waitlisted
              ? 'bg-gradient-to-br from-amber-400/90 to-amber-600 px-6 py-5'
              : 'bg-gradient-to-br from-[#9b4dff] to-[#5b1fa8] px-6 py-5'
          }
        >
          <p className="text-[11px] font-semibold uppercase tracking-[0.2em] text-white/75">
            Fluoverse pass
          </p>
          <div className="mt-3 flex items-center gap-2.5">
            <span
              className="flex h-7 w-7 items-center justify-center rounded-full bg-white/20 text-sm text-white"
              aria-hidden
            >
              {waitlisted ? '…' : '✓'}
            </span>
            <h1 className="font-display text-[1.35rem] font-bold tracking-tight text-white sm:text-[1.5rem]">
              {waitlisted ? 'On the waitlist' : 'You’re going'}
            </h1>
          </div>
        </div>

        {/* Body */}
        <div className="space-y-5 px-6 py-7 sm:px-8">
          <div>
            <p className="text-[11px] font-semibold uppercase tracking-[0.18em] text-white/45">
              Event
            </p>
            <h2 className="mt-2 font-display text-[1.25rem] font-bold leading-snug tracking-tight text-white sm:text-[1.35rem]">
              {event.title}
            </h2>
          </div>

          <div className="space-y-4">
            <MetaRow label="When" value={event.when_label || 'See app for time'} />
            <MetaRow label="Where" value={place} />
            {event.address ? <MetaRow label="Address" value={event.address} /> : null}
          </div>

          {/* Ticket code */}
          <div className="rounded-2xl border border-dashed border-white/15 bg-black/20 px-4 py-5 text-center">
            <p className="text-[11px] font-semibold uppercase tracking-[0.2em] text-white/45">
              Ticket code
            </p>
            <p className="mt-2 font-mono text-[1.35rem] font-semibold tracking-[0.18em] text-white">
              {result.display_code}
            </p>
            <p className="mt-3 text-[13px] text-white/45">Show this at the door</p>
          </div>
        </div>
      </div>

      <p className="mt-6 text-center text-[12px] tracking-wide text-white/35">
        Powered by Fluoverse
      </p>
    </section>
  )
}
