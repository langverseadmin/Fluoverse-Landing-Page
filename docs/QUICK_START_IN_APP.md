# Quick Start: In-App Recap

Get your in-app recap working quickly!

## ✅ What You Get

- **Embeddable Component** - Use anywhere in your app
- **Modal Version** - Ready-to-use modal wrapper
- **Mobile-First Design** - Always mobile layout
- **Deep Link Support** - Open recap from email/notifications

## 🚀 Quick Usage

### Option 1: Modal (Easiest)

```tsx
import { useState } from 'react';
import RecapModal from '@/components/RecapModal';

function Dashboard() {
  const [showRecap, setShowRecap] = useState(false);
  
  const recapData = {
    userName: "Alex",
    year: 2025,
    totalMinutes: 1250,
    totalSessions: 85,
    languagesLearned: ["English", "Spanish"],
    topLanguage: "Spanish",
    longestStreak: 45,
    totalConversations: 320,
    favoriteScenario: "Restaurant Ordering",
    levelProgress: 78,
  };

  return (
    <>
      <button onClick={() => setShowRecap(true)}>
        View Your Recap
      </button>

      <RecapModal
        data={recapData}
        isOpen={showRecap}
        onClose={() => setShowRecap(false)}
      />
    </>
  );
}
```

### Option 2: Full Screen

```tsx
import RecapEmbedded from '@/components/RecapEmbedded';

function RecapScreen() {
  return (
    <div className="h-screen">
      <RecapEmbedded
        data={recapData}
        onClose={() => router.back()}
      />
    </div>
  );
}
```

## 📧 Email Integration

Send email with app deep link:

```typescript
import { generateRecapEmailHTML } from '@/lib/email-templates/recap-email-template';

const emailHTML = generateRecapEmailHTML({
  userName: "Alex",
  year: 2025,
  totalMinutes: 1250,
  totalSessions: 85,
  topLanguage: "Spanish",
  appDeepLink: "fluoverse://recap/123",  // Opens in app
  webUrl: "https://fluoverse.com/app/recap",  // Fallback
});
```

## 📱 Deep Linking

### Web App
Use Next.js routing:
```
https://fluoverse.com/app/recap
```

### Mobile App (Flutter)
Set up deep link handler:
```dart
// Handle: fluoverse://recap/123
```

## 📁 Files

- `components/RecapEmbedded.tsx` - Core embeddable component
- `components/RecapModal.tsx` - Modal wrapper
- `app/dashboard/recap/page.tsx` - Example page
- `docs/IN_APP_RECAP_GUIDE.md` - Full guide

## 🎯 Next Steps

1. ✅ Components are ready
2. ⏭️ Integrate into your app
3. ⏭️ Set up deep linking
4. ⏭️ Update email templates
5. ⏭️ Test!

See `docs/IN_APP_RECAP_GUIDE.md` for complete details! 🚀


