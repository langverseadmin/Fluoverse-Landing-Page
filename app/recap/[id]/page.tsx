"use client";

import RecapMobile from '@/components/RecapMobile';
import type { RecapData } from '@/components/RecapMobile';
import { useEffect, useState } from 'react';

// This would come from your API/database
async function fetchRecapData(userId: string): Promise<RecapData | null> {
  // TODO: Replace with actual API call
  // const response = await fetch(`/api/recap/${userId}`);
  // return await response.json();
  
  // Example data for now
  return {
    userName: "Alex",
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
}

export default function RecapPage({ params }: { params: { id: string } }) {
  const [data, setData] = useState<RecapData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchRecapData(params.id)
      .then((recapData) => {
        if (recapData) {
          setData(recapData);
        } else {
          setError('Recap not found');
        }
        setLoading(false);
      })
      .catch((err) => {
        setError('Failed to load recap');
        setLoading(false);
      });
  }, [params.id]);

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-purple-900 via-pink-900 to-orange-900 flex items-center justify-center">
        <div className="text-white text-xl">Loading your recap...</div>
      </div>
    );
  }

  if (error || !data) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-purple-900 via-pink-900 to-orange-900 flex items-center justify-center">
        <div className="text-white text-xl">{error || 'Recap not found'}</div>
      </div>
    );
  }

  return (
    <RecapMobile 
      data={data}
      shareable={true}
      onComplete={() => {
        // Optional: Track completion
        console.log('Recap completed');
      }}
    />
  );
}

