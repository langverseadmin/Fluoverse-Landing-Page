# Hero download baseline (step 2)

Record **7–14 days** of numbers **before** changing the hero. Do not ship hero experiments until this window ends.

Property: **G-BYX3GMDNEL** (see `components/GoogleAnalytics.tsx`).

## What to log each week

Copy this table into a spreadsheet or Notion:

| Week ending | Active users (homepage `/`) | `download_intent` (placement = hero) | Hero rate (clicks ÷ users) | Mobile hero clicks | Desktop hero clicks | Notes |
|-------------|------------------------------|--------------------------------------|----------------------------|--------------------|---------------------|-------|
| YYYY-MM-DD  |                              |                                      |                            |                    |                     |       |

**Hero rate** = hero `download_intent` event count ÷ active users on `/` (same date range).  
Use **event count** if user-level rate is not set up yet; prefer **unique users** once explorations support it.

## How to pull numbers in GA4

### Active users (homepage)

1. **Explore** → Free form  
2. **Dimensions:** Page path and screen class → `/`  
3. **Metrics:** Active users  
4. Date range: your baseline week  

### Hero download clicks

1. **Explore** → Free form  
2. **Dimensions:** Event name, `placement` (custom dimension — register first)  
3. **Metrics:** Event count (or Conversions if `download_intent` is marked)  
4. **Filter:** Event name = `download_intent`, `placement` = `hero`  
5. Optional breakdown: **Device category** (mobile / desktop)

### Sanity check (real-time)

1. Open [fluoverse.com](https://fluoverse.com) (or local with GA loaded)  
2. Click hero App Store or Play badge  
3. **Reports → Realtime** → should show `download_intent`, `download_app_store_click`, or `download_google_play_click`

## Baseline start / end

- **Start date:** _______________  
- **End date:** _______________ (≥ 7 days after start)  
- **Only after end date:** ship hero layout/copy tests and compare the next 7–14 days to this table.
