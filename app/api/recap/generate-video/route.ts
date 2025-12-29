import { NextRequest, NextResponse } from 'next/server';
import { generateRecapVideo } from '@/lib/video-generator';
import { promises as fs } from 'fs';
import path from 'path';

/**
 * API Route for Generating Recap Videos
 * 
 * This endpoint generates MP4 videos from recap data.
 * 
 * IMPORTANT: This API uses hardcoded data - no backend data fetching is involved.
 * The client should provide recapData from lib/hardcoded-recap-data.ts or
 * from their own hardcoded data source.
 * 
 * @param userId - The user ID (for file naming)
 * @param recapData - The hardcoded recap data for this user
 */
export async function POST(request: NextRequest) {
  try {
    const { userId, recapData } = await request.json();

    if (!userId || !recapData) {
      return NextResponse.json(
        { error: 'userId and recapData are required' },
        { status: 400 }
      );
    }

    console.log(`🎬 Generating video for user: ${userId} (using hardcoded data)`);

    // Generate video
    const videoPath = await generateRecapVideo({
      userId,
      recapData,
      outputDir: './videos',
    });

    // Read video file
    const videoBuffer = await fs.readFile(videoPath);
    const stats = await fs.stat(videoPath);

    // Return video file
    return new NextResponse(videoBuffer, {
      headers: {
        'Content-Type': 'video/mp4',
        'Content-Length': stats.size.toString(),
        'Content-Disposition': `attachment; filename="fluoverse-wrapped-${userId}.mp4"`,
      },
    });
  } catch (error: any) {
    console.error('Error generating video:', error);
    return NextResponse.json(
      { error: error.message || 'Failed to generate video' },
      { status: 500 }
    );
  }
}

