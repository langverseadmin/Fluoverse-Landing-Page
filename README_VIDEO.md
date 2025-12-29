# Video Generation - Quick Setup

## Install Dependencies

```bash
npm install puppeteer tsx
```

## Generate Video

```bash
npm run generate:video -- --userId=123
```

Video will be saved to: `./videos/recap-123-2025.mp4`

## Requirements

1. **Puppeteer** - for browser automation
2. **FFmpeg** - for converting frames to video

### Install FFmpeg:

**Windows:**
```bash
choco install ffmpeg
# OR download from https://ffmpeg.org/download.html
```

**Mac:**
```bash
brew install ffmpeg
```

**Linux:**
```bash
sudo apt install ffmpeg
```

## Usage in Code

```typescript
import { generateRecapVideo } from '@/lib/video-generator';

const videoPath = await generateRecapVideo({
  userId: '123',
  recapData: yourRecapData,
});

console.log('Video saved:', videoPath);
```


