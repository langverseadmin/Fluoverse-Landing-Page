"use client";

import NotFound from '@/app/not-found';

// RECAP ROUTE TEMPORARILY DISABLED
export default function RecapPage() {
  return <NotFound />;
}

/* COMMENTED OUT - RECAP ROUTE CODE (KEEP FOR FUTURE USE)
import { useState, useEffect } from 'react';
import FluoverseWrapped from '@/components/FluoverseWrapped';
import type { FluoverseWrappedData } from '@/components/FluoverseWrapped';
import { getHardcodedRecapData } from '@/lib/hardcoded-recap-data';

// Get data from hardcoded source or use default
function getRecapData(userId?: string | null): FluoverseWrappedData {
  if (userId) {
    const data = getHardcodedRecapData(userId);
    if (data) return data;
  }
  
  // Fallback to default example data
  return {
    userName: "Alex",
    year: 2025,
    totalMinutes: 1250,
    learningAgeDays: 120,
    totalScenariosCompleted: 45,
    topScenarios: [
      {
        lessonId: "lesson-1",
        lessonTitle: "Restaurant Ordering",
        completionCount: 15,
        averageScore: 85,
        totalTimeSpent: 1200,
      },
      {
        lessonId: "lesson-2",
        lessonTitle: "Travel & Tourism",
        completionCount: 12,
        averageScore: 78,
        totalTimeSpent: 900,
      },
      {
        lessonId: "lesson-3",
        lessonTitle: "Family & Relationships",
        completionCount: 10,
        averageScore: 82,
        totalTimeSpent: 750,
      },
      {
        lessonId: "lesson-4",
        lessonTitle: "Shopping & Stores",
        completionCount: 8,
        averageScore: 80,
        totalTimeSpent: 600,
      },
    ],
    uniqueWordsMastered: 250,
    personalizedMessage: "You've made incredible progress this year! Your dedication to learning is inspiring.",
    biggestAchievement: "Completed 45 lessons with an average score of 82%!",
  };
}

export default function RecapPage() {
  // Get userId from URL params (optional)
  const [userId, setUserId] = useState<string | null>(null);
  const [recapData, setRecapData] = useState<FluoverseWrappedData | null>(null);
  
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const params = new URLSearchParams(window.location.search);
      const urlUserId = params.get('userId');
      setUserId(urlUserId);
      setRecapData(getRecapData(urlUserId));
    }
  }, []);


  if (!recapData) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-purple-900 via-pink-900 to-orange-900 flex items-center justify-center">
        <div className="text-white text-xl">Loading your recap...</div>
      </div>
    );
  }

  // Show the recap exactly as it appears in the video (with capture mode styling but auto-play enabled)
  return (
    <div className="min-h-[100dvh] bg-gradient-to-br from-purple-900 via-pink-900 to-orange-900 md:flex md:items-center md:justify-center md:p-4">
      <div className="w-screen h-[100dvh] overflow-hidden shadow-none md:w-full md:max-w-md md:h-[90vh] md:rounded-2xl md:shadow-2xl">
        <FluoverseWrapped
          data={recapData}
          autoPlay={true}
          captureMode={false} // Don't use capture mode (so it auto-plays)
          hideControls={true} // Hide all UI controls to match video
          onComplete={() => {
            console.log('Recap completed!');
          }}
          className="h-full md:rounded-2xl"
        />
      </div>
    </div>
  );
}
*/
