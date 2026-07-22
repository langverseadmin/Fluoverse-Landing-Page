/**
 * Public event ticket check-in for fluoverse.com/checkin/<token>
 */

export const API_BASE_URL =
  process.env.NEXT_PUBLIC_API_BASE_URL ||
  process.env.API_BASE_URL ||
  'https://fluoverse.onrender.com'

export type CheckinEvent = {
  id?: string
  title: string
  spot?: string
  city?: string
  address?: string
  starts_at?: string
  when_label?: string
  place_line?: string
}

export type CheckinResult =
  | {
      valid: true
      status: string
      ticket_token: string
      display_code: string
      event: CheckinEvent
    }
  | {
      valid: false
      error?: string
    }

export async function fetchCheckinTicket(token: string): Promise<CheckinResult> {
  const clean = (token || '').trim()
  if (!clean || clean.length < 8) {
    return { valid: false, error: 'invalid_token' }
  }

  try {
    const res = await fetch(
      `${API_BASE_URL.replace(/\/$/, '')}/community/checkin/${encodeURIComponent(clean)}`,
      {
        method: 'GET',
        headers: { Accept: 'application/json' },
        // Ticket status can change; don't cache a false "valid" forever.
        cache: 'no-store',
      },
    )

    const data = (await res.json().catch(() => ({}))) as Record<string, unknown>

    if (!res.ok || data.valid !== true) {
      return {
        valid: false,
        error: typeof data.error === 'string' ? data.error : 'not_found',
      }
    }

    const eventRaw = (data.event && typeof data.event === 'object'
      ? data.event
      : {}) as Record<string, unknown>

    return {
      valid: true,
      status: String(data.status || 'confirmed'),
      ticket_token: String(data.ticket_token || clean),
      display_code: String(data.display_code || `FLV-${clean.slice(0, 8).toUpperCase()}`),
      event: {
        id: eventRaw.id ? String(eventRaw.id) : undefined,
        title: String(eventRaw.title || 'Fluoverse event'),
        spot: eventRaw.spot ? String(eventRaw.spot) : undefined,
        city: eventRaw.city ? String(eventRaw.city) : undefined,
        address: eventRaw.address ? String(eventRaw.address) : undefined,
        starts_at: eventRaw.starts_at ? String(eventRaw.starts_at) : undefined,
        when_label: eventRaw.when_label ? String(eventRaw.when_label) : undefined,
        place_line: eventRaw.place_line ? String(eventRaw.place_line) : undefined,
      },
    }
  } catch {
    return { valid: false, error: 'network' }
  }
}
