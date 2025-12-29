/**
 * Generate MP4 video from recap data
 * Saves video to ./videos/recap-[userId].mp4
 */

import puppeteer from 'puppeteer';
import { promises as fs } from 'fs';
import path from 'path';
import type { FluoverseWrappedData } from '@/components/FluoverseWrapped';

interface GenerateVideoOptions {
  userId: string;
  recapData: FluoverseWrappedData;
  outputDir?: string;
  outputFilename?: string; // Optional custom output filename (without extension)
  useLocalServer?: boolean;
  serverUrl?: string;
  /**
   * Optional path to background audio file (MP3, WAV, etc.)
   * Audio will be looped/extended to match video duration
   * Example: './public/audio/recap-music.mp3'
   */
  audioFile?: string;
}

export async function generateRecapVideo({
  userId,
  recapData,
  outputDir = './videos',
  outputFilename,
  useLocalServer = true,
  serverUrl = 'http://localhost:3000',
  audioFile,
}: GenerateVideoOptions): Promise<string> {
  // Ensure output directory exists
  await fs.mkdir(outputDir, { recursive: true });

  const filename = outputFilename || `recap-${userId}-${recapData.year}`;
  const outputPath = path.resolve(outputDir, `${filename}.mp4`);

  console.log('🎬 Starting video generation...');
  console.log(`📁 Output: ${outputPath}`);

  let pageUrl: string;
  
  if (useLocalServer) {
    // Use the actual Next.js app at /wrapped?auto=true
    // Note: This requires the Next.js server to be running
    // Use /recap endpoint which has autoPlay=true and proper configuration
    pageUrl = `${serverUrl}/recap?userId=${userId}`;
    console.log(`🌐 Using /recap endpoint: ${pageUrl}`);
    console.log(`⚠️  Make sure your Next.js dev server is running on ${serverUrl}`);
  } else {
    // Fallback: Create HTML page with recap component
  const html = generateRecapHTML(recapData);
  const tempHtmlPath = path.resolve(outputDir, `temp-${userId}.html`);
  await fs.writeFile(tempHtmlPath, html);
    pageUrl = `file://${tempHtmlPath}`;
  }

  try {
    // Launch Puppeteer with flags to prevent timer throttling in headless mode
    // This ensures animations and timers run at real-time speed
    const browser = await puppeteer.launch({
      headless: 'new' as any, // New headless mode respects real-time timers
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-background-timer-throttling',
        '--disable-backgrounding-occluded-windows',
        '--disable-renderer-backgrounding',
        '--disable-features=CalculateNativeWinOcclusion',
      ],
    });

    const page = await browser.newPage();
    
    // Capture console logs to debug timer issues
    page.on('console', msg => {
      const text = msg.text();
      if (text.includes('[FluoverseWrapped]')) {
        console.log('🔵 Browser:', text);
      }
    });
    
    // Set viewport for PORTRAIT (9:16) output while keeping Tailwind in "mobile" breakpoints.
    // Tailwind's `md` breakpoint starts at 768px; if we used width=1080 we'd accidentally render desktop styles.
    // So we render at 540px CSS width (<768) and scale pixels up to 1080 via deviceScaleFactor=2.0.
    // Smaller viewport = content appears larger in final video output.
    await page.setViewport({
      width: 540,
      height: 960,
      deviceScaleFactor: 2.0, // 540*2=1080, 960*2=1920
    });

    // Load the page (either local server or file)
    await page.goto(pageUrl, { waitUntil: 'networkidle0', timeout: 30000 });
    
    // Force page to be visible and prevent background throttling
    await page.bringToFront();
    await page.evaluate(() => {
      Object.defineProperty(document, 'visibilityState', { value: 'visible', writable: false });
      Object.defineProperty(document, 'hidden', { value: false, writable: false });
    });

    const recapSelector = '[data-fluoverse-wrapped-root="true"]';

    // Wait for recap UI to render and start playing
    if (useLocalServer) {
      console.log('⏳ Waiting for recap UI...');
      await page.waitForSelector(recapSelector, { timeout: 10000 }).catch(() => {});
      // Wait for UI to start auto-playing (component waits 600ms, recap page waits 800ms, plus buffer)
      await new Promise(resolve => setTimeout(resolve, 2000));
      // Verify UI is playing by checking if slide has advanced from 0
      const initialSlide = await page.evaluate(() => (window as any).__fluoverseCurrentSlide ?? 0);
      console.log(`✅ Starting frame capture - initial slide: ${initialSlide}`);
    } else {
      // For static HTML, just wait for page to render
      await new Promise(resolve => setTimeout(resolve, 500));
    }

    const framesDir = path.resolve(outputDir, `frames-${userId}`);
    await fs.mkdir(framesDir, { recursive: true });

    // Capture for 52 seconds (8 slides × 6 seconds each + 4 seconds buffer for last slide)
    // Extended to ensure last slide is fully captured
    const fps = 30; // target output fps
    const durationSeconds = 52; // Total duration: 8 slides × 6 seconds + 4 seconds buffer

    // --- Capture frames via CDP Screencast (much closer to real 30fps than repeated page.screenshot()) ---
    // This avoids the heavy "screenshot request per frame" overhead which caps at ~15-17fps on many machines.
    const client = await page.target().createCDPSession();
    await client.send('Page.enable');

    let frameCount = 0;
    let lastLog = Date.now();
    let firstTs: number | null = null;
    let lastTs: number | null = null;

    // Queue writes so we preserve ordering without blocking frame ACKs
    let writeChain: Promise<void> = Promise.resolve();

    const startedAt = Date.now();
    const stopAt = startedAt + durationSeconds * 1000;

    console.log(`⏳ Recording ${durationSeconds}s of UI time (CDP screencast, targeting ~${fps}fps)...`);

    const onFrame = (params: any) => {
      // CDP provides metadata.timestamp (seconds)
      const ts = typeof params?.metadata?.timestamp === 'number' ? params.metadata.timestamp : null;
      if (ts != null) {
        if (firstTs == null) firstTs = ts;
        lastTs = ts;
      }

      const idx = frameCount++;
      const framePath = path.join(framesDir, `frame-${String(idx).padStart(6, '0')}.jpg`);
      const buf = Buffer.from(params.data, 'base64');

      // ACK immediately so Chrome keeps streaming
      void client.send('Page.screencastFrameAck', { sessionId: params.sessionId }).catch(() => {});

      // Write asynchronously in-order
      writeChain = writeChain.then(() => fs.writeFile(framePath, buf));

      const now = Date.now();
      if (now - lastLog >= 1000) {
        const elapsed = (now - startedAt) / 1000;
        const effectiveFps = frameCount / Math.max(0.001, elapsed);
        // Don't block frame handling on evaluate()
        void page
          .evaluate(() => (window as any).__fluoverseCurrentSlide ?? 0)
          .then(currentSlide => {
            console.log(
              `📸 Frames: ${frameCount} | Real: ${elapsed.toFixed(1)}s | Effective capture: ${effectiveFps.toFixed(2)} fps | Slide: ${currentSlide + 1}/8`
            );
          })
          .catch(() => {});
        lastLog = now;
      }
    };

    client.on('Page.screencastFrame', onFrame);

    await client.send('Page.startScreencast', {
      format: 'jpeg',
      quality: 95, // high quality for better image quality
      maxWidth: 1080,
      maxHeight: 1920,
      everyNthFrame: 1,
    } as any);

    // Wait until duration elapses
    while (Date.now() < stopAt) {
      await new Promise(resolve => setTimeout(resolve, 50));
    }

    await client.send('Page.stopScreencast').catch(() => {});
    // Ensure all pending writes complete
    await writeChain;

    const endedAt = Date.now();
    const totalTime = (endedAt - startedAt) / 1000;
    // Prefer screencast timestamps when available (more accurate to actual delivered frames)
    const tsDuration = firstTs != null && lastTs != null ? Math.max(0.001, lastTs - firstTs) : null;
    const effectiveCaptureFps =
      tsDuration != null ? frameCount / tsDuration : frameCount / Math.max(0.001, totalTime);

    console.log(`✅ Finished capturing ${frameCount} frames in ${totalTime.toFixed(1)} seconds`);
    console.log(`📊 Effective capture fps: ${effectiveCaptureFps.toFixed(3)} (target output: ${fps})`);

    await browser.close();

    // Clean up temp HTML if we created one
    if (!useLocalServer && pageUrl.startsWith('file://')) {
      const tempHtmlPath = pageUrl.replace('file://', '');
      await fs.unlink(tempHtmlPath).catch(() => {}); // Ignore errors if file doesn't exist
    }

    console.log('✅ Screenshots captured. Converting to video...');

    // Check if audio file exists (if provided)
    let audioPath: string | null = null;
    if (audioFile) {
      const resolvedAudioPath = path.resolve(audioFile);
      try {
        await fs.access(resolvedAudioPath);
        audioPath = resolvedAudioPath;
        console.log(`🎵 Using background audio: ${audioPath}`);
      } catch {
        console.log(`⚠️  Audio file not found: ${resolvedAudioPath}`);
        console.log(`   Continuing without audio...`);
      }
    }

    // If ffmpeg is available, convert automatically
    try {
      const { execSync } = require('child_process');
      const os = require('os');
      
      // Use forward slashes for ffmpeg pattern (works on both Windows and Unix)
      const framesPattern = path.join(framesDir, 'frame-%06d.jpg').replace(/\\/g, '/');
      const outputPathEscaped = outputPath.replace(/\\/g, '/');
      
      // Use the effective capture fps as input, output at stable 30fps
      const inputFps = Math.max(1, Number(effectiveCaptureFps.toFixed(3)));
      const outputFps = fps;
      
      // Build FFmpeg command with optional audio
      let ffmpegCmd: string;
      if (audioPath) {
        const audioPathEscaped = audioPath.replace(/\\/g, '/');
        // With audio: mix video and audio, loop audio if needed to match video duration
        // -stream_loop -1: loop audio infinitely
        // -shortest: stop when shortest stream (video) ends, ensuring audio is cut to match video
        // -map 0:v:0: use video from first input (frames)
        // -map 1:a:0: use audio from second input (audio file)
        ffmpegCmd = `ffmpeg -y -framerate ${inputFps} -i "${framesPattern}" -stream_loop -1 -i "${audioPathEscaped}" -c:v libx264 -pix_fmt yuv420p -r ${outputFps} -c:a aac -b:a 192k -shortest -map 0:v:0 -map 1:a:0 "${outputPathEscaped}"`;
      } else {
        // Without audio: video only
        ffmpegCmd = `ffmpeg -y -framerate ${inputFps} -i "${framesPattern}" -c:v libx264 -pix_fmt yuv420p -r ${outputFps} "${outputPathEscaped}"`;
      }
      
      // On Windows, use PowerShell to refresh PATH before running ffmpeg
      if (os.platform() === 'win32') {
        const winCmd = `$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"); ${ffmpegCmd}`;
        execSync(winCmd, {
          stdio: 'inherit',
          shell: 'powershell.exe',
        });
      } else {
        execSync(ffmpegCmd, {
        stdio: 'inherit',
          shell: true,
      });
      }
      
      // Clean up frames
      await fs.rm(framesDir, { recursive: true, force: true });
      
      console.log(`✅ Video saved: ${outputPath}`);
      return outputPath;
    } catch (error: any) {
      // FFmpeg not found or conversion failed - frames are saved, user can convert manually
      console.log('\n⚠️  FFmpeg not found or conversion failed.');
      console.log(`📂 Frames saved to: ${framesDir}`);
      console.log(`\n💡 To convert manually:`);
      console.log(`   1. Install FFmpeg (see scripts/install-ffmpeg-windows.md for Windows)`);
      console.log(`   2. Run this command:`);
      
      // Show command with proper path format for the user's OS
      const framesPattern = path.join(framesDir, 'frame-%06d.jpg');
      const isWindows = process.platform === 'win32';
      const cmd = isWindows 
        ? `ffmpeg -framerate 30 -i "${framesPattern.replace(/\\/g, '/')}" -c:v libx264 -pix_fmt yuv420p "${outputPath}"`
        : `ffmpeg -framerate 30 -i "${framesPattern}" -c:v libx264 -pix_fmt yuv420p "${outputPath}"`;
      console.log(`      ${cmd}`);
      console.log(`\n   Or install FFmpeg and run this script again.`);
      
      // Don't throw error - frames are saved successfully
      // Return frames directory path so user knows where to find them
      return framesDir;
    }

  } catch (error) {
    console.error('❌ Error generating video:', error);
    throw error;
  }
}

function generateRecapHTML(data: FluoverseWrappedData): string {
  return `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fluoverse Wrapped</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://unpkg.com/framer-motion@latest/dist/framer-motion.umd.js"></script>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { 
      width: 428px; 
      height: 926px; 
      overflow: hidden;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateX(100px); }
      to { opacity: 1; transform: translateX(0); }
    }
    @keyframes countUp {
      from { opacity: 0; transform: scale(0.8); }
      to { opacity: 1; transform: scale(1); }
    }
    .slide {
      animation: fadeIn 0.5s ease-out;
    }
    .stat-number {
      animation: countUp 1s ease-out;
    }
  </style>
</head>
<body>
  <div id="recap-container" style="width: 428px; height: 926px; position: relative; overflow: hidden; background: linear-gradient(135deg, #7c3aed 0%, #ec4899 50%, #f97316 100%);">
    <!-- Slides will be rendered here via JavaScript -->
  </div>

  <script>
    const data = ${JSON.stringify(data)};
    const container = document.getElementById('recap-container');
    let currentSlide = 0;
    const slides = [];
    let slideInterval;

    // Welcome Slide
    slides.push(\`
      <div class="slide" style="position: absolute; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 2rem;">
        <h1 style="font-size: 5rem; font-weight: 900; color: white; margin-bottom: 1.5rem;">\${data.year}</h1>
        <p style="font-size: 1.5rem; color: rgba(255,255,255,0.9); margin-bottom: 0.75rem; font-weight: 600;">Your Fluoverse Year</p>
        <p style="font-size: 1.25rem; color: rgba(255,255,255,0.7);">\${data.userName}</p>
      </div>
    \`);

    // Total Minutes
    const hours = Math.floor(data.totalMinutes / 60);
    slides.push(\`
      <div class="slide" style="position: absolute; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 2rem;">
        <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #3b82f6, #06b6d4); display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3);">
          <svg width="40" height="40" fill="white" viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm.5-13H11v6l5.25 3.15.75-1.23-4.5-2.67z"/></svg>
        </div>
        <div class="stat-number" style="font-size: 4rem; font-weight: 900; color: white; margin-bottom: 1rem;">\${hours.toLocaleString()}</div>
        <p style="font-size: 1.25rem; color: rgba(255,255,255,0.9); margin-bottom: 0.5rem; font-weight: 600;">Hours Learned</p>
        <p style="font-size: 1rem; color: rgba(255,255,255,0.7);">You spent \${hours} hours learning this year!</p>
      </div>
    \`);

    // Learning Age
    slides.push(\`
      <div class="slide" style="position: absolute; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 2rem;">
        <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #a855f7, #ec4899); display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3);">
          <svg width="40" height="40" fill="white" viewBox="0 0 24 24"><path d="M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z"/></svg>
        </div>
        <div class="stat-number" style="font-size: 4rem; font-weight: 900; color: white; margin-bottom: 1rem;">\${data.learningAgeDays.toLocaleString()}</div>
        <p style="font-size: 1.25rem; color: rgba(255,255,255,0.9); margin-bottom: 0.5rem; font-weight: 600;">Days Learning</p>
        <p style="font-size: 1rem; color: rgba(255,255,255,0.7);">You've been learning for \${data.learningAgeDays} days!</p>
      </div>
    \`);

    // Total Scenarios
    slides.push(\`
      <div class="slide" style="position: absolute; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 2rem;">
        <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #f97316, #ef4444); display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3);">
          <svg width="40" height="40" fill="white" viewBox="0 0 24 24"><path d="M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z"/></svg>
        </div>
        <div class="stat-number" style="font-size: 4rem; font-weight: 900; color: white; margin-bottom: 1rem;">\${data.totalScenariosCompleted.toLocaleString()}</div>
        <p style="font-size: 1.25rem; color: rgba(255,255,255,0.9); margin-bottom: 0.5rem; font-weight: 600;">Lessons Completed</p>
        <p style="font-size: 1rem; color: rgba(255,255,255,0.7);">You completed \${data.totalScenariosCompleted} lessons this year!</p>
      </div>
    \`);

    // Top Scenario (use first one)
    const topScenario = data.topScenarios[0];
    slides.push(\`
      <div class="slide" style="position: absolute; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 2rem;">
        <p style="font-size: 1.25rem; color: rgba(255,255,255,0.8); margin-bottom: 1.5rem;">Your #1 Lesson</p>
        <div style="background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); border-radius: 1.5rem; padding: 1.5rem; border: 1px solid rgba(255,255,255,0.2); box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3); margin-bottom: 1.5rem;">
          <svg width="48" height="48" fill="white" viewBox="0 0 24 24" style="margin: 0 auto 1rem;"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>
          <p style="font-size: 1.5rem; font-weight: bold; color: white; margin-bottom: 1rem;">\${topScenario.lessonTitle}</p>
          <div style="text-align: left; color: rgba(255,255,255,0.9); font-size: 0.875rem;">
            <div style="margin-bottom: 0.5rem;"><strong>Completions:</strong> \${topScenario.completionCount}</div>
            <div style="margin-bottom: 0.5rem;"><strong>Average Score:</strong> \${topScenario.averageScore}%</div>
            <div><strong>Time Spent:</strong> \${Math.floor(topScenario.totalTimeSpent / 60)} minutes</div>
          </div>
        </div>
      </div>
    \`);

    // Unique Words
    slides.push(\`
      <div class="slide" style="position: absolute; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 2rem;">
        <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #10b981, #059669); display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3);">
          <svg width="40" height="40" fill="white" viewBox="0 0 24 24"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
        </div>
        <div class="stat-number" style="font-size: 4rem; font-weight: 900; color: white; margin-bottom: 1rem;">\${data.uniqueWordsMastered.toLocaleString()}</div>
        <p style="font-size: 1.25rem; color: rgba(255,255,255,0.9); margin-bottom: 0.5rem; font-weight: 600;">Words Mastered</p>
        <p style="font-size: 1rem; color: rgba(255,255,255,0.7);">You mastered \${data.uniqueWordsMastered} words!</p>
      </div>
    \`);

    // Thank You
    slides.push(\`
      <div class="slide" style="position: absolute; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 2rem;">
        <div style="width: 96px; height: 96px; border-radius: 50%; background: linear-gradient(135deg, #a855f7, #ec4899); display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.3);">
          <svg width="48" height="48" fill="white" viewBox="0 0 24 24"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
        </div>
        <h2 style="font-size: 1.875rem; font-weight: bold; color: white; margin-bottom: 1rem;">Thanks for Learning with Us</h2>
        \${data.biggestAchievement ? \`<p style="font-size: 1.25rem; color: rgba(255,255,255,0.9); margin-bottom: 1rem; font-weight: 600;">\${data.biggestAchievement}</p>\` : ''}
        \${data.personalizedMessage ? \`<p style="font-size: 1.125rem; color: rgba(255,255,255,0.8); margin-bottom: 1rem;">\${data.personalizedMessage}</p>\` : ''}
        <p style="font-size: 1.125rem; color: rgba(255,255,255,0.7);">\${data.userName}</p>
      </div>
    \`);

    function showSlide(index) {
      container.innerHTML = slides[index] || '';
    }

    // Show slides sequentially (4 seconds each)
    showSlide(0);
    currentSlide = 0;
    
    slideInterval = setInterval(() => {
      currentSlide++;
      if (currentSlide >= slides.length) {
        clearInterval(slideInterval);
      } else {
        showSlide(currentSlide);
      }
    }, 4000);
  </script>
</body>
</html>
  `;
}

