# In-App Recap Implementation Guide

This guide explains how to embed the recap directly in your app (web or mobile) instead of using separate URLs.

## 🎯 Overview

Instead of serving recaps as web URLs, you can embed them directly in your app as:
- **Modal/Dialog** - Popup overlay
- **Full Screen** - Full page/screen component
- **Inline Component** - Embedded in existing pages

## 📦 Components Available

### 1. `RecapEmbedded.tsx`
The core embeddable component that can be used anywhere in your app.

**Features:**
- ✅ Mobile-first design (always mobile layout)
- ✅ Swipe gestures for navigation
- ✅ Auto-advancing slides
- ✅ Manual navigation buttons
- ✅ Progress indicators
- ✅ Close button support
- ✅ Completion callbacks

### 2. `RecapModal.tsx`
A ready-to-use modal wrapper for the embedded recap.

**Features:**
- ✅ Modal overlay with backdrop
- ✅ Smooth animations
- ✅ Click outside to close
- ✅ Auto-close on completion

## 🚀 Usage Examples

### Option 1: Modal (Recommended for Web)

```tsx
"use client";

import { useState } from 'react';
import RecapModal from '@/components/RecapModal';

export default function Dashboard() {
  const [showRecap, setShowRecap] = useState(false);

  const recapData = {
    userName: "Alex",
    year: 2025,
    totalMinutes: 1250,
    totalSessions: 85,
    languagesLearned: ["English", "Spanish", "Greek"],
    topLanguage: "Spanish",
    longestStreak: 45,
    totalConversations: 320,
    favoriteScenario: "Restaurant Ordering",
    levelProgress: 78,
  };

  return (
    <div>
      <button onClick={() => setShowRecap(true)}>
        View Your 2025 Recap
      </button>

      <RecapModal
        data={recapData}
        isOpen={showRecap}
        onClose={() => setShowRecap(false)}
        onComplete={() => {
          console.log('Recap completed!');
        }}
      />
    </div>
  );
}
```

### Option 2: Full Screen Component

```tsx
"use client";

import { useState } from 'react';
import RecapEmbedded from '@/components/RecapEmbedded';

export default function RecapScreen() {
  const recapData = {
    userName: "Alex",
    year: 2025,
    totalMinutes: 1250,
    totalSessions: 85,
    languagesLearned: ["English", "Spanish", "Greek"],
    topLanguage: "Spanish",
    longestStreak: 45,
    totalConversations: 320,
    favoriteScenario: "Restaurant Ordering",
    levelProgress: 78,
  };

  return (
    <div className="h-screen w-screen">
      <RecapEmbedded
        data={recapData}
        onClose={() => router.back()} // Navigate back
        onComplete={() => {
          console.log('Recap completed!');
        }}
        autoPlay={true}
        className="h-full w-full"
      />
    </div>
  );
}
```

### Option 3: Inline in Existing Page

```tsx
"use client";

import RecapEmbedded from '@/components/RecapEmbedded';

export default function ProfilePage() {
  const recapData = {
    // ... recap data
  };

  return (
    <div className="container mx-auto py-8">
      <h1>Your Profile</h1>
      
      {/* Other profile content */}
      
      <div className="mt-8 h-[600px]">
        <RecapEmbedded
          data={recapData}
          autoPlay={false}
          className="h-full"
        />
      </div>
    </div>
  );
}
```

## 📱 For Flutter App (Mobile)

Since you have a Flutter app, you have a few options:

### Option A: WebView (Embed React Component)

```dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecapScreen extends StatelessWidget {
  final Map<String, dynamic> recapData;

  const RecapScreen({Key? key, required this.recapData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final htmlContent = _generateRecapHTML(recapData);
    
    return Scaffold(
      body: WebView(
        initialUrl: Uri.dataFromString(
          htmlContent,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
```

### Option B: Native Flutter Implementation

Create a similar experience using Flutter widgets:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RecapScreen extends StatefulWidget {
  final RecapData data;
  
  const RecapScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<RecapScreen> createState() => _RecapScreenState();
}

class _RecapScreenState extends State<RecapScreen> {
  int currentSlide = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF7c3aed),
              Color(0xFFec4899),
              Color(0xFFf97316),
            ],
          ),
        ),
        child: PageView(
          controller: pageController,
          onPageChanged: (index) => setState(() => currentSlide = index),
          children: [
            _buildWelcomeSlide(),
            _buildStatSlide('Minutes', widget.data.totalMinutes),
            _buildStatSlide('Sessions', widget.data.totalSessions),
            // ... more slides
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSlide() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${widget.data.year}',
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ).animate().scale(duration: 600.ms, delay: 200.ms),
          SizedBox(height: 24),
          Text(
            'Your Fluoverse Year',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
          Text(
            widget.data.userName,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
        ],
      ),
    );
  }

  Widget _buildStatSlide(String label, int value) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
```

## 📧 Email Integration (In-App Recap)

For emails, you have two approaches:

### Approach 1: Email with App Deep Link

Send an email that opens the recap in your app:

```typescript
// Email template
const emailHTML = `
  <a href="fluoverse://recap/{{userId}}">
    View Your Recap in App
  </a>
  
  <!-- Fallback for web -->
  <a href="https://fluoverse.com/app/recap">
    View on Web
  </a>
`;
```

### Approach 2: Email with Preview Image/Video

Generate a static preview (image or video) and embed it in email:

```typescript
// Generate preview image
import { generateRecapPreviewImage } from '@/lib/recap-preview-generator';

const previewImage = await generateRecapPreviewImage(recapData);

const emailHTML = `
  <img src="${previewImage}" alt="Your 2025 Recap Preview" />
  <a href="fluoverse://recap/{{userId}}">
    Open in App to View Full Recap
  </a>
`;
```

## 🔗 App Deep Linking Setup

### For Web App

Use Next.js routing:

```tsx
// app/recap/page.tsx (or app/dashboard/recap/page.tsx)
"use client";

import RecapModal from '@/components/RecapModal';

export default function RecapPage() {
  // Fetch user data from your API/context
  const { user, recapData } = useAuth();
  
  return (
    <RecapModal
      data={recapData}
      isOpen={true}
      onClose={() => router.push('/dashboard')}
    />
  );
}
```

### For Mobile App (Flutter)

Set up deep linking:

```dart
// main.dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/recap': (context) => RecapScreen(data: _getRecapData()),
      },
      onGenerateRoute: (settings) {
        // Handle deep links like: fluoverse://recap/123
        if (settings.name?.startsWith('/recap') == true) {
          final userId = settings.name?.split('/').last;
          return MaterialPageRoute(
            builder: (context) => RecapScreen(data: _getRecapDataForUser(userId)),
          );
        }
        return null;
      },
    );
  }
}
```

## 📊 Component Props

### RecapEmbedded Props

```typescript
interface RecapEmbeddedProps {
  data: RecapEmbeddedData;      // Recap data
  onClose?: () => void;          // Called when close button is clicked
  onComplete?: () => void;       // Called when recap finishes
  autoPlay?: boolean;            // Auto-advance slides (default: true)
  className?: string;            // Additional CSS classes
}
```

### RecapModal Props

```typescript
interface RecapModalProps {
  data: RecapEmbeddedData;       // Recap data
  isOpen: boolean;               // Control modal visibility
  onClose: () => void;           // Called when modal closes
  onComplete?: () => void;       // Called when recap completes
}
```

## 🎨 Customization

### Change Colors

Edit the gradient in `RecapEmbedded.tsx`:

```tsx
className="bg-gradient-to-br from-purple-900 via-pink-900 to-orange-900"
```

### Adjust Timing

Change auto-advance duration:

```tsx
<RecapEmbedded
  data={data}
  autoPlay={true}
  // Auto-advance is controlled in component (default: 4000ms)
/>
```

### Add Custom Slides

Edit the `slides` array in `RecapEmbedded.tsx` to add/remove slides.

## ✅ Best Practices

1. **Fetch Data Before Showing** - Load recap data before opening modal
2. **Handle Loading States** - Show loading spinner while fetching data
3. **Error Handling** - Handle cases where recap data isn't available
4. **Analytics** - Track when users view/complete recaps
5. **Performance** - Lazy load the recap component if needed

## 📚 Next Steps

1. Choose your approach (Modal, Full Screen, or Inline)
2. Integrate into your app navigation
3. Set up deep linking (for mobile apps)
4. Update email templates to link to app
5. Test on all target devices
6. Deploy!

Good luck! 🚀


