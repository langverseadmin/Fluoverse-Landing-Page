# Install FFmpeg on Windows (Without Chocolatey)

## Option 1: Download Pre-built Binary (Easiest)

1. Download FFmpeg from: https://www.gyan.dev/ffmpeg/builds/
2. Download the "ffmpeg-release-essentials.zip" file
3. Extract the zip file to `C:\ffmpeg`
4. Add to PATH:
   - Right-click "This PC" → Properties
   - Click "Advanced system settings"
   - Click "Environment Variables"
   - Under "System variables", find "Path" and click "Edit"
   - Click "New" and add: `C:\ffmpeg\bin`
   - Click OK on all windows
5. Open a NEW PowerShell window and test:
   ```powershell
   ffmpeg -version
   ```

## Option 2: Use winget (Windows Package Manager)

```powershell
winget install ffmpeg
```

## Option 3: Use Scoop

If you have Scoop installed:
```powershell
scoop install ffmpeg
```

## Verify Installation

After installing, open a NEW terminal and run:
```powershell
ffmpeg -version
```

You should see FFmpeg version information.


