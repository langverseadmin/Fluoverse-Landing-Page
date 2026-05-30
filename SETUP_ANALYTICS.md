# Google Analytics — download conversion setup

Measurement ID in production: **G-BYX3GMDNEL** (`components/GoogleAnalytics.tsx`).

Events are defined in `lib/analytics.ts`. Store badge clicks send:

| Event | When |
|-------|------|
| `download_app_store_click` | App Store badge |
| `download_google_play_click` | Google Play badge |
| `download_intent` | Every store badge click (use as **main conversion**) |

All store events include **`placement`**: `hero`, `benefits`, `isolation_showcase`, etc.

---

## Step 1 — Verify events fire

1. Open the site (production or local with GA loaded).
2. DevTools → **Network** → filter `google-analytics` or `collect`.
3. Click an App Store / Play badge.
4. In GA4 **Reports → Realtime**, confirm `download_intent` (and store-specific events) appear within ~30s.

---

## Step 2 — Register custom dimensions (required for hero breakdowns)

In GA4 **Admin → Data display → Custom definitions → Create custom dimensions**:

| Dimension name | Event parameter | Scope |
|----------------|-----------------|-------|
| placement | placement | Event |
| store | store | Event |

Allow 24–48h after creating before explorations show data reliably.

---

## Step 3 — Mark conversions

**Admin → Data display → Events**

Mark as conversions:

- `download_intent` (primary — all store clicks, all sections)
- `download_app_store_click` (optional)
- `download_google_play_click` (optional)

---

## Step 4 — Hero baseline (7–14 days)

Before changing the hero, log weekly numbers using **[docs/HERO_CONVERSION_BASELINE.md](docs/HERO_CONVERSION_BASELINE.md)**.

Compare future hero changes against that table (same length of time, similar traffic).

---

## Quick hero conversion rate in Explore

1. **Explore → Free form**
2. Date range: baseline period
3. **Filter:** Page path = `/`
4. Metrics: Active users + Event count where event = `download_intent` and `placement` = `hero`
5. Rate ≈ hero download_intent count ÷ active users

Break down by **Device category** (mobile vs desktop).

---

## Troubleshooting

- No events: confirm `gtag` requests in Network; ad blockers block GA locally.
- No `placement` in reports: finish Step 2 and wait 24–48h.
- ID mismatch: `GoogleAnalytics.tsx` uses a hardcoded ID; keep it aligned with your GA4 property.

---

## Optional: env-based measurement ID

You can later move the ID to `NEXT_PUBLIC_GA_MEASUREMENT_ID` if you want different IDs per environment. Tracking code in `lib/analytics.ts` does not need to change.
