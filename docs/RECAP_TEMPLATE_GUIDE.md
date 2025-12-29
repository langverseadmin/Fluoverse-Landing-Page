# Fluoverse Recap Template Guide

This guide explains how to create Spotify Wrapped-style recaps for your Fluoverse users, including the template code and resources.

## Overview

The recap template uses:
- **React/Next.js** - Component framework
- **Framer Motion** - Smooth animations (already in your dependencies)
- **Tailwind CSS** - Styling (already configured)
- **TypeScript** - Type safety

## How Spotify Wrapped-Style Recaps Work

### Key Features:
1. **Full-screen slide animations** - Each stat gets its own slide
2. **Smooth transitions** - Slides fade and scale between states
3. **Animated counters** - Numbers count up for visual impact
4. **Gradient backgrounds** - Dynamic, animated backgrounds
5. **Auto-play progression** - Slides advance automatically
6. **Progress indicators** - Visual dots showing current slide

### Technical Approach:

1. **Slide-based Layout**: Each statistic is displayed on its own full-screen slide
2. **Animation Libraries**: 
   - Framer Motion for transitions and animations
   - CSS animations for background effects
3. **Data Visualization**: 
   - Animated counters (numbers count up)
   - Icon-based visualizations
   - Gradient cards for emphasis

## Using the Template

### Basic Usage

```tsx
import Recap, { RecapData } from '@/components/Recap';

const userRecapData: RecapData = {
  userName: "John Doe",
  totalMinutes: 1250,
  totalSessions: 85,
  languagesLearned: ["English", "Spanish", "Greek"],
  topLanguage: "Spanish",
  longestStreak: 45,
  totalConversations: 320,
  favoriteScenario: "Restaurant Ordering",
  levelProgress: 78,
  year: 2025,
};

// In your page/component
<Recap 
  data={userRecapData} 
  onComplete={() => {
    // Handle completion (e.g., show share button, redirect)
    console.log("Recap complete!");
  }}
/>
```

### Creating a Recap Page

Create a new page at `app/recap/page.tsx`:

```tsx
"use client";

import Recap, { RecapData } from '@/components/Recap';
import { useSearchParams } from 'next/navigation';

export default function RecapPage() {
  const searchParams = useSearchParams();
  const userId = searchParams.get('userId');

  // Fetch user data here (from your API/database)
  const userData: RecapData = {
    userName: "User Name",
    totalMinutes: 1250,
    totalSessions: 85,
    languagesLearned: ["English", "Spanish"],
    topLanguage: "Spanish",
    longestStreak: 45,
    totalConversations: 320,
    favoriteScenario: "Restaurant Ordering",
    levelProgress: 78,
    year: 2025,
  };

  return (
    <Recap 
      data={userData}
      onComplete={() => {
        // Handle completion
      }}
    />
  );
}
```

## Customization

### Changing Colors

Edit the gradient classes in `components/Recap.tsx`:

```tsx
// Change stat slide gradients
gradient="bg-gradient-to-br from-blue-500 to-cyan-500" // Change these colors
```

### Adding New Slides

1. Create a new slide component
2. Add it to the `slides` array in the `Recap` component
3. Update the `totalSlides` count

Example:

```tsx
const CustomSlide = ({ customData }: { customData: string }) => (
  <div className="text-center px-8">
    <motion.h2
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      className="text-4xl font-bold text-white"
    >
      {customData}
    </motion.h2>
  </div>
);

// Add to slides array:
const slides = [
  // ... existing slides
  <CustomSlide key="custom" customData="Your Custom Data" />,
];
```

### Adjusting Timing

Change the `slideDuration` in the `useEffect` hook:

```tsx
const slideDuration = 3500; // Change this value (in milliseconds)
```

### Manual Navigation

To allow users to skip slides, add navigation buttons:

```tsx
const handleNext = () => {
  setCurrentSlide(prev => Math.min(prev + 1, slides.length - 1));
};

const handlePrevious = () => {
  setCurrentSlide(prev => Math.max(prev - 1, 0));
};
```

## External Resources & Templates

### Design Templates (Graphic Design):
- **Kapwing Templates**: https://www.kapwing.com/explore/spotify-wrapped-2025-template-with-font-to-edit-free-download
- **Premade Pixels**: https://www.premadepixels.com/product/spotify-year-wrapped-2025-template ($6 Photoshop template)
- **Behance Template Generator**: https://www.behance.net/gallery/240606621/Spotify-Wrapped-2025-Animated-Template-Generator
- **SlideChef Free Template**: https://slidechef.net/templates/free-animated-spotify-wrapped-template/

### Video Tutorials:
- **YouTube Tutorial**: https://www.youtube.com/watch?v=vw-0M1MSzfw (How to design Spotify Wrapped layout)

### Code Libraries (Alternative Approaches):

If you want to explore other animation libraries:

1. **GSAP (GreenSock)**: More powerful animations
   - Website: https://greensock.com/gsap/
   - GitHub: https://github.com/greensock/GSAP

2. **React Spring**: Physics-based animations
   - Website: https://www.react-spring.dev/
   - GitHub: https://github.com/pmndrs/react-spring

3. **Three.js / React Three Fiber**: For 3D graphics
   - Website: https://threejs.org/
   - React wrapper: https://github.com/pmndrs/react-three-fiber

## Data Collection

To create meaningful recaps, you'll need to collect:

1. **User Activity Metrics**:
   - Total minutes practiced
   - Number of sessions
   - Number of conversations
   - Longest streak

2. **Learning Progress**:
   - Languages learned
   - Top language (most practiced)
   - Level progress
   - Favorite scenarios

3. **Timing Data**:
   - Daily usage patterns
   - Most active days
   - Peak practice times

## Sharing Features

Consider adding:

1. **Screenshot Generation**: Use libraries like `html2canvas` to generate shareable images
2. **Video Export**: Create animated video versions
3. **Social Sharing**: Direct share buttons for Twitter, Instagram, etc.

Example screenshot generation:

```tsx
import html2canvas from 'html2canvas';

const handleShare = async () => {
  const element = document.getElementById('recap-container');
  if (element) {
    const canvas = await html2canvas(element);
    const dataUrl = canvas.toDataURL('image/png');
    // Share or download the image
  }
};
```

## Performance Tips

1. **Lazy Loading**: Load slides as needed
2. **Image Optimization**: Optimize any images used
3. **Animation Performance**: Use `will-change` CSS property for smooth animations
4. **Reduced Motion**: Respect `prefers-reduced-motion` for accessibility

## Accessibility

Add support for reduced motion:

```tsx
const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

// Use simpler animations if user prefers reduced motion
transition={{ duration: prefersReducedMotion ? 0 : 0.8 }}
```

## Next Steps

1. **Integrate with your backend** to fetch real user data
2. **Customize colors** to match Fluoverse branding
3. **Add more slides** based on your specific metrics
4. **Implement sharing** functionality
5. **Test on mobile** devices
6. **Add analytics** to track recap views and shares

## Questions?

For questions about implementation, refer to:
- Framer Motion docs: https://www.framer.com/motion/
- Next.js docs: https://nextjs.org/docs
- Tailwind CSS docs: https://tailwindcss.com/docs


