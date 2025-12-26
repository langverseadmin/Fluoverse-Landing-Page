# Analytics & A/B Testing Setup Guide

This guide will help you set up Google Analytics and VWO for your Fluoverse landing page.

## Prerequisites

1. A Google Analytics 4 (GA4) account
2. A VWO account (free tier available)

## Step 1: Get Your Google Analytics Measurement ID

1. Go to [Google Analytics](https://analytics.google.com/)
2. Navigate to **Admin** (gear icon at bottom left)
3. Under **Property**, click **Data Streams**
4. Click on your web stream (or create one if you don't have one)
5. Copy your **Measurement ID** (format: `G-XXXXXXXXXX`)

## Step 2: Get Your VWO Account ID

1. Go to [VWO](https://app.vwo.com/) and log in
2. Navigate to **Settings** → **Installation**
3. Find your **Account ID** (it's a number, e.g., `123456`)
4. Copy the Account ID

## Step 3: Create Environment Variables

Create a `.env.local` file in the root of your project (if it doesn't exist) and add:

```env
# Google Analytics 4 Measurement ID
NEXT_PUBLIC_GA_MEASUREMENT_ID=G-XXXXXXXXXX

# VWO Account ID (just the number)
NEXT_PUBLIC_VWO_ACCOUNT_ID=123456
```

Replace the placeholder values with your actual IDs.

## Step 4: Restart Your Development Server

After adding the environment variables, restart your Next.js development server:

```bash
npm run dev
```

## Step 5: Verify Installation

### Google Analytics
1. Visit your website in a browser
2. Open the browser's Developer Tools (F12)
3. Go to the **Network** tab
4. Look for requests to `www.googletagmanager.com`
5. You can also check Google Analytics Real-Time reports to see if you appear as an active user

### VWO
1. Visit your website in a browser
2. Open the browser's Developer Tools (F12)
3. Go to the **Console** tab
4. Type `window._vwo_code` and press Enter
5. You should see an object (not `undefined`)

## Usage

### Google Analytics
- Track page views automatically
- View reports in Google Analytics dashboard
- Real-time visitor tracking is available

### VWO
- Create A/B tests in the VWO dashboard
- Use the visual editor to modify your pages
- Track conversions and analyze results

## Troubleshooting

### Analytics not tracking?
- Ensure your `.env.local` file is in the root directory
- Make sure you've restarted your development server after adding environment variables
- Check that the environment variable names are correct (they must start with `NEXT_PUBLIC_`)

### VWO not working?
- Verify your Account ID is a number (not a string)
- Check the browser console for any JavaScript errors
- Ensure the VWO script is loading (check Network tab)

## Production Deployment

When deploying to production (e.g., Vercel, Netlify), make sure to add the environment variables in your hosting platform's settings:

- **Vercel**: Project Settings → Environment Variables
- **Netlify**: Site Settings → Environment Variables

The environment variables should be:
- `NEXT_PUBLIC_GA_MEASUREMENT_ID`
- `NEXT_PUBLIC_VWO_ACCOUNT_ID`

## Notes

- Both scripts load using Next.js `Script` component with `afterInteractive` strategy for optimal performance
- The scripts won't load if the environment variables are not set (graceful degradation)
- All tracking respects user privacy settings and browser Do Not Track preferences

