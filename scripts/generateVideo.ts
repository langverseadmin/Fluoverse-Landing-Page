/**
 * Generate recap video - saves to ./videos/recap-[userId].mp4
 * 
 * Uses hardcoded data from lib/hardcoded-recap-data.ts
 * No backend or data sourcing involved - all data is hardcoded.
 * 
 * Run: npx tsx scripts/generateVideo.ts --userId=user-1
 */

import { generateRecapVideo } from '../lib/video-generator';
import { getHardcodedRecapData } from '../lib/hardcoded-recap-data';

async function main() {
  const args = process.argv.slice(2);
  const userIdArg = args.find(arg => arg.startsWith('--userId='));
  const userId = userIdArg?.split('=')[1] || 'user-1';
  
  const audioFileArg = args.find(arg => arg.startsWith('--audio='));
  let audioFile = audioFileArg?.split('=')[1];
  
  const outputFilenameArg = args.find(arg => arg.startsWith('--output='));
  const outputFilename = outputFilenameArg?.split('=')[1];
  
  // If no audio file specified, try to use the default recap-audio.mp3
  if (!audioFile) {
    const { promises: fs } = require('fs');
    const path = require('path');
    const defaultAudioPath = path.resolve('./public/audio/recap-audio.mp3');
    try {
      await fs.access(defaultAudioPath);
      audioFile = './public/audio/recap-audio.mp3';
    } catch {
      // Audio file doesn't exist, continue without it
    }
  }

  console.log(`🎬 Generating video for user: ${userId}`);
  if (audioFile) {
    console.log(`🎵 Using audio file: ${audioFile}`);
  } else {
    console.log(`ℹ️  No audio file specified (use --audio=path/to/audio.mp3 to add background music)`);
  }
  
  // Get hardcoded data for this user
  const recapData = getHardcodedRecapData(userId);
  
  if (!recapData) {
    console.error(`❌ Error: No hardcoded data found for user ID: ${userId}`);
    console.log(`Available user IDs: user-1, user-2, user-3, class-tutor`);
    process.exit(1);
  }
  
  try {
    // Use local Next.js server to record the actual /wrapped page
    // Make sure to run 'npm run dev' in another terminal first!
    const videoPath = await generateRecapVideo({
      userId,
      recapData,
      outputDir: './videos',
      outputFilename, // Optional: custom output filename (without .mp4)
      useLocalServer: true,
      serverUrl: process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000',
      audioFile, // Optional: path to background audio file
    });
    
    console.log(`\n✅ Success! Video saved to: ${videoPath}`);
    console.log(`📁 Full path: ${require('path').resolve(videoPath)}`);
  } catch (error) {
    console.error('\n❌ Error:', error);
    process.exit(1);
  }
}

main();

