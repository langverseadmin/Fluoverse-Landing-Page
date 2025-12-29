# Fluoverse Wrapped Video Generation Guide

Generate MP4 videos from your recap data instead of interactive components.

## 🎯 Overview

Instead of interactive recaps, generate MP4 videos that can be:
- ✅ Sent via email as attachments
- ✅ Embedded in emails
- ✅ Shared on social media
- ✅ Saved and viewed offline
- ✅ No interactivity needed

## 🚀 Solution: Remotion

**Remotion** is a React library for creating videos programmatically. Perfect for generating personalized recap videos!

### Installation

```bash
npm install remotion @remotion/bundler @remotion/ffmpeg
```

## 📦 Implementation Options

### Option 1: Remotion (Recommended) ⭐

**Pros:**
- ✅ React-based (fits your stack)
- ✅ Programmatic video generation
- ✅ Full control over animations
- ✅ Can export high-quality MP4
- ✅ Server-side rendering

**Cons:**
- ⚠️ Learning curve
- ⚠️ Requires setup

### Option 2: Puppeteer/Playwright (Screen Recording)

**Pros:**
- ✅ Uses existing React components
- ✅ Easy to implement
- ✅ Can record any component

**Cons:**
- ⚠️ Requires browser instance
- ⚠️ More resource-intensive
- ⚠️ Less control over output

### Option 3: External API (HTML2Video)

**Pros:**
- ✅ No setup needed
- ✅ Managed service

**Cons:**
- ⚠️ Costs money
- ⚠️ External dependency
- ⚠️ Less control

## 🎬 Remotion Implementation

### Step 1: Install Remotion

```bash
npm install remotion @remotion/bundler @remotion/cli @remotion/ffmpeg
```

### Step 2: Create Video Composition

Create a Remotion composition that matches your recap slides:

```tsx
// src/video/RecapVideo.tsx
import { Composition } from 'remotion';
import { RecapSequence } from './RecapSequence';

export const RecapVideo = ({ data }: { data: RecapData }) => {
  return (
    <Composition
      id="recap"
      component={RecapSequence}
      durationInFrames={480} // 8 seconds at 60fps (8 slides × 1 second each)
      fps={60}
      width={428} // Mobile width
      height={926} // Mobile height
      defaultProps={data}
    />
  );
};
```

### Step 3: Create Video Sequence

```tsx
// src/video/RecapSequence.tsx
import { useCurrentFrame, interpolate, spring } from 'remotion';

export const RecapSequence: React.FC<RecapData> = (data) => {
  const frame = useCurrentFrame();
  const fps = 60;
  
  // Calculate which slide to show (each slide is 60 frames = 1 second)
  const slideIndex = Math.floor(frame / fps);
  
  return (
    <div style={{
      width: 428,
      height: 926,
      background: 'linear-gradient(135deg, #7c3aed 0%, #ec4899 50%, #f97316 100%)',
    }}>
      {slideIndex === 0 && <WelcomeSlide frame={frame} data={data} />}
      {slideIndex === 1 && <TotalMinutesSlide frame={frame} data={data} />}
      {slideIndex === 2 && <LearningAgeSlide frame={frame} data={data} />}
      {/* ... more slides */}
    </div>
  );
};
```

### Step 4: Generate Video

```typescript
// scripts/generateRecapVideo.ts
import { bundle } from '@remotion/bundler';
import { renderMedia } from '@remotion/renderer';
import path from 'path';

async function generateRecapVideo(userId: string, recapData: RecapData) {
  // Bundle Remotion project
  const bundleLocation = await bundle({
    entryPoint: path.resolve('./src/video/index.ts'),
    webpackOverride: (config) => config,
  });

  // Render video
  await renderMedia({
    composition: {
      id: 'recap',
      width: 428,
      height: 926,
      fps: 60,
      durationInFrames: 480,
    },
    serveUrl: bundleLocation,
    codec: 'h264',
    outputLocation: `./videos/recap-${userId}.mp4`,
    inputProps: recapData,
  });

  return `./videos/recap-${userId}.mp4`;
}
```

### Step 5: API Endpoint

```typescript
// app/api/recap/generate-video/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { generateRecapVideo } from '@/scripts/generateRecapVideo';

export async function POST(request: NextRequest) {
  const { userId } = await request.json();
  
  // Fetch recap data
  const recapData = await fetchRecapData(userId);
  
  // Generate video
  const videoPath = await generateRecapVideo(userId, recapData);
  
  // Read video file
  const videoBuffer = await fs.readFile(videoPath);
  
  return new NextResponse(videoBuffer, {
    headers: {
      'Content-Type': 'video/mp4',
      'Content-Disposition': `attachment; filename="fluoverse-wrapped-${userId}.mp4"`,
    },
  });
}
```

## 📧 Email Integration

### Option 1: Attach Video

```typescript
import { sendEmail } from '@/lib/email-service';
import { generateRecapVideo } from '@/scripts/generateRecapVideo';

async function sendRecapEmail(user: User, recapData: RecapData) {
  // Generate video
  const videoPath = await generateRecapVideo(user.id, recapData);
  
  // Send email with attachment
  await sendEmail({
    to: user.email,
    subject: `Your ${recapData.year} Fluoverse Wrapped`,
    html: `
      <h1>Your ${recapData.year} Recap is Ready!</h1>
      <p>Check out your personalized recap video attached below.</p>
    `,
    attachments: [{
      filename: `fluoverse-wrapped-${user.id}.mp4`,
      path: videoPath,
    }],
  });
}
```

### Option 2: Host Video & Link

```typescript
async function sendRecapEmail(user: User, recapData: RecapData) {
  // Generate video
  const videoPath = await generateRecapVideo(user.id, recapData);
  
  // Upload to cloud storage (S3, Cloudinary, etc.)
  const videoUrl = await uploadToStorage(videoPath, `recaps/${user.id}.mp4`);
  
  // Send email with link
  await sendEmail({
    to: user.email,
    subject: `Your ${recapData.year} Fluoverse Wrapped`,
    html: `
      <h1>Your ${recapData.year} Recap is Ready!</h1>
      <p>Watch your personalized recap:</p>
      <a href="${videoUrl}">Watch Your Recap</a>
      
      <!-- Or embed video -->
      <video width="428" height="926" controls>
        <source src="${videoUrl}" type="video/mp4">
      </video>
    `,
  });
}
```

## 🎨 Alternative: Simple Canvas-Based Solution

If Remotion is too complex, you can use HTML5 Canvas:

```typescript
// scripts/generateRecapVideoCanvas.ts
import { createCanvas, loadImage } from 'canvas';
import ffmpeg from 'fluent-ffmpeg';

async function generateRecapVideoCanvas(recapData: RecapData) {
  const width = 428;
  const height = 926;
  const fps = 30;
  const duration = 8; // seconds
  
  // Create frames
  const frames: Buffer[] = [];
  
  for (let i = 0; i < duration * fps; i++) {
    const canvas = createCanvas(width, height);
    const ctx = canvas.getContext('2d');
    
    // Draw background
    const gradient = ctx.createLinearGradient(0, 0, width, height);
    gradient.addColorStop(0, '#7c3aed');
    gradient.addColorStop(0.5, '#ec4899');
    gradient.addColorStop(1, '#f97316');
    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, width, height);
    
    // Draw slide content based on frame number
    const slideIndex = Math.floor(i / fps);
    drawSlide(ctx, slideIndex, recapData, i % fps);
    
    frames.push(canvas.toBuffer('image/png'));
  }
  
  // Convert frames to video using ffmpeg
  // (implementation depends on your setup)
  return videoPath;
}
```

## 📊 Quick Comparison

| Method | Setup Time | Quality | Control | Cost |
|--------|-----------|---------|---------|------|
| **Remotion** | Medium | High | High | Free |
| **Puppeteer** | Low | Medium | Medium | Free |
| **HTML2Video API** | Low | High | Low | Paid |
| **Canvas + FFmpeg** | High | High | High | Free |

## 🚀 Recommended Approach

1. **Start with Remotion** if you want full control and quality
2. **Use Puppeteer** for a quick proof of concept
3. **Consider external APIs** if you need it done fast with minimal setup

## 📚 Resources

- **Remotion Docs**: https://www.remotion.dev/docs
- **Puppeteer**: https://pptr.dev/
- **HTML2Video API**: https://html2.video/
- **FFmpeg**: https://ffmpeg.org/

## ✅ Next Steps

1. Choose your approach (Remotion recommended)
2. Install dependencies
3. Create video composition
4. Set up video generation script
5. Integrate with email service
6. Test with sample data
7. Deploy!

Good luck! 🎬


