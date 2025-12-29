# Background Audio Recommendations for Recap Videos

This document provides recommendations for finding appropriate background music for your Fluoverse recap videos.

## Requirements

- **Duration**: ~48 seconds (or loopable for longer videos)
- **Style**: Upbeat, inspiring, celebratory
- **Mood**: Positive, motivating, reflective
- **License**: Royalty-free or with appropriate license for video use

## Recommended Sources

### 1. Pixabay Music (Free, No Attribution Required)

**Best Option**: [Pixabay Music](https://pixabay.com/music/)

**Recommended Tracks**:
- Search for: "upbeat", "inspiring", "motivational", "recap", "year in review"
- **Upbeat Instrumental Background Music for Short Video Stories** (37 seconds)
  - URL: https://pixabay.com/music/upbeat-instrumental-background-music-for-short-video-stories-blog-37-seconds-199949/
  - Note: You may need to extend or loop this for 48 seconds

- **Happy Inspiring Corporate** or similar tracks
  - Search: https://pixabay.com/music/search/upbeat%20inspiring/

**How to Use**:
1. Download MP3 file
2. Save to `public/audio/recap-music.mp3` (or your preferred name)
3. Use with video generator: `audioFile: './public/audio/recap-music.mp3'`

### 2. YouTube Audio Library (Free, Some Require Attribution)

**Access**: [YouTube Audio Library](https://www.youtube.com/audiolibrary)

**Recommended Styles**:
- Search for: "upbeat", "happy", "inspirational", "corporate"
- Many tracks are free to use (check license)
- Some require attribution in video description

### 3. Free Music Archive

**Access**: [Free Music Archive](https://freemusicarchive.org/)

**Recommended Genres**:
- Electronic/Dance (upbeat)
- Instrumental (no vocals for background)
- Ambient/Chill (subtle)

### 4. Bensound (Free with Attribution)

**Access**: [Bensound](https://www.bensound.com/)

**License**: Free for use with attribution (credits in video description)

**Recommended Tracks**:
- "Creative Minds"
- "New Dawn"
- "Memories"

### 5. Incompetech (Free with Attribution)

**Access**: [Incompetech](https://incompetech.com/music/)

**Creator**: Kevin MacLeod
**License**: Free with attribution

**Recommended Styles**:
- Search for "upbeat", "happy", "corporate"

## Installation Instructions

1. **Download your chosen audio file** (MP3 recommended)

2. **Save to project**:
   ```bash
   # Save to public/audio directory
   public/audio/recap-music.mp3
   ```

3. **Update video generation script**:
   
   Edit `scripts/generateVideo.ts`:
   ```typescript
   const videoPath = await generateRecapVideo({
     userId,
     recapData,
     outputDir: './videos',
     audioFile: './public/audio/recap-music.mp3', // Add this line
   });
   ```

4. **Generate video with audio**:
   ```bash
   npx tsx scripts/generateVideo.ts --userId=user-1
   ```

## Audio File Specifications

- **Format**: MP3, WAV, or M4A
- **Bitrate**: 192kbps or higher recommended
- **Duration**: Will be automatically looped/extended to match video length
- **Volume**: Consider using a track that's not too loud (background music)

## Tips

1. **Choose instrumental tracks** - Music with vocals can compete with any future voiceover
2. **Test volume levels** - Ensure music doesn't overpower the video content
3. **Match the mood** - Upbeat and positive works best for recap videos
4. **Check license** - Always verify the license allows commercial use if needed

## Quick Start

1. Visit [Pixabay Music](https://pixabay.com/music/search/upbeat%20inspiring/)
2. Download a track you like (MP3 format)
3. Save it as `public/audio/recap-music.mp3`
4. The video generator will automatically include it when you run:
   ```bash
   npx tsx scripts/generateVideo.ts --userId=user-1
   ```

---

**Note**: The video generator will automatically loop or extend the audio to match your video duration (48 seconds).

