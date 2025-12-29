"use client";

import { useState, useEffect } from 'react';
import FluoverseWrappedModal from '@/components/FluoverseWrappedModal';
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

export default function WrappedPage() {
  // Get userId from URL params
  const [userId, setUserId] = useState<string | null>(null);
  const [recapData, setRecapData] = useState<FluoverseWrappedData | null>(null);
  const [captureMode, setCaptureMode] = useState(false);
  
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const params = new URLSearchParams(window.location.search);
      const urlUserId = params.get('userId');
      setUserId(urlUserId);
      setRecapData(getRecapData(urlUserId));
      setCaptureMode(params.get('capture') === 'true');
    }
  }, []);

  // Auto-open if ?auto=true is in URL (for video recording)
  const [showRecap, setShowRecap] = useState(() => {
    if (typeof window !== 'undefined') {
      const params = new URLSearchParams(window.location.search);
      return params.get('auto') === 'true';
    }
    return false;
  });
  const [selectedScenarioId, setSelectedScenarioId] = useState<string | undefined>();

  if (!recapData) {
    return <div>Loading...</div>;
  }

  return (
    <div className="min-h-screen flex items-center justify-center p-8 bg-gradient-to-br from-purple-900 via-pink-900 to-orange-900">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-white mb-4">
          Fluoverse Wrapped 2025
        </h1>
        <p className="text-xl text-white/80 mb-8">
          See your year in review!
        </p>
        <button
          onClick={() => setShowRecap(true)}
          className="bg-white text-purple-900 px-8 py-4 rounded-full font-semibold text-lg hover:bg-white/90 transition-colors shadow-lg"
        >
          View Your Recap
        </button>
      </div>

      <FluoverseWrappedModal
        data={recapData}
        isOpen={showRecap}
        onClose={() => setShowRecap(false)}
        captureMode={captureMode}
        onScenarioSelect={(lessonId) => {
          setSelectedScenarioId(lessonId);
          console.log('User selected scenario:', lessonId);
          // Here you would typically save this to your database
        }}
        selectedScenarioId={selectedScenarioId}
        onComplete={() => {
          console.log('Recap completed!');
          // Track completion in analytics
        }}
      />
    </div>
  );
}


