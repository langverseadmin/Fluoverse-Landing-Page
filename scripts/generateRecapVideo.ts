/**
 * Video Generation Script for Fluoverse Wrapped
 * 
 * This script generates MP4 videos from recap data using Remotion.
 * 
 * Usage:
 *   npm run generate:recap -- --userId=123
 *   OR
 *   node scripts/generateRecapVideo.ts
 */

import { bundle } from '@remotion/bundler';
import { renderMedia, selectComposition } from '@remotion/renderer';
import path from 'path';
import { promises as fs } from 'fs';
import type { FluoverseWrappedData } from '@/components/FluoverseWrapped';
import { getHardcodedRecapData, getAllUserIds } from '@/lib/hardcoded-recap-data';

// Note: This script uses hardcoded data from lib/hardcoded-recap-data.ts
// No backend or data sourcing is involved - all data is hardcoded.

interface GenerateVideoOptions {
  userId: string;
  recapData: FluoverseWrappedData;
  outputDir?: string;
}

/**
 * Generate MP4 video from recap data
 */
export async function generateRecapVideo({
  userId,
  recapData,
  outputDir = './public/recaps',
}: GenerateVideoOptions): Promise<string> {
  try {
    // Ensure output directory exists
    await fs.mkdir(outputDir, { recursive: true });

    // Bundle Remotion project
    // Note: You'll need to set up Remotion project structure first
    const bundleLocation = await bundle({
      entryPoint: path.resolve('./src/video/index.ts'),
      webpackOverride: (config) => config,
    });

    // Select composition
    const composition = await selectComposition({
      serveUrl: bundleLocation,
      id: 'recap',
      inputProps: recapData,
    });

    // Generate output path
    const outputPath = path.join(outputDir, `recap-${userId}-${recapData.year}.mp4`);

    // Render video
    await renderMedia({
      composition,
      serveUrl: bundleLocation,
      codec: 'h264',
      outputLocation: outputPath,
      inputProps: recapData,
      imageFormat: 'jpeg',
      jpegQuality: 90,
      pixelFormat: 'yuv420p',
      audioCodec: null, // No audio for now
      onProgress: ({ renderedFrames, encodedFrames, renderedTimeInSeconds }) => {
        console.log(`Rendering: ${renderedFrames}/${composition.durationInFrames} frames`);
        console.log(`Encoded: ${encodedFrames}/${composition.durationInFrames} frames`);
        console.log(`Time: ${renderedTimeInSeconds.toFixed(2)}s`);
      },
    });

    console.log(`✅ Video generated: ${outputPath}`);
    return outputPath;
  } catch (error) {
    console.error('❌ Error generating video:', error);
    throw error;
  }
}

/**
 * Alternative: Generate video using Puppeteer (simpler but less control)
 */
export async function generateRecapVideoPuppeteer({
  userId,
  recapData,
  outputDir = './public/recaps',
}: GenerateVideoOptions): Promise<string> {
  // This is a placeholder - you would implement Puppeteer recording here
  // See docs/VIDEO_RECAP_GUIDE.md for implementation details
  
  throw new Error('Puppeteer video generation not implemented yet. Use Remotion instead.');
}

// CLI usage
if (require.main === module) {
  const args = process.argv.slice(2);
  const userIdArg = args.find(arg => arg.startsWith('--userId='));
  const userId = userIdArg?.split('=')[1];

  if (!userId) {
    console.error('Usage: npm run generate:recap -- --userId=user-1');
    process.exit(1);
  }

  // Get hardcoded data for this user
  const recapData = getHardcodedRecapData(userId);
  
  if (!recapData) {
    console.error(`❌ Error: No hardcoded data found for user ID: ${userId}`);
    const availableIds = getAllUserIds();
    console.log(`Available user IDs: ${availableIds.join(', ')}`);
    process.exit(1);
  }

  generateRecapVideo({
    userId,
    recapData,
  })
    .then((outputPath) => {
      console.log(`Success! Video saved to: ${outputPath}`);
      process.exit(0);
    })
    .catch((error) => {
      console.error('Failed to generate video:', error);
      process.exit(1);
    });
}

