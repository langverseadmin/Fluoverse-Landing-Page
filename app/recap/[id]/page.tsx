"use client";

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import RecapModal from '@/components/RecapModal';
import type { RecapEmbeddedData } from '@/components/RecapEmbedded';

// This is an example - replace with your actual data fetching
async function fetchUserRecap(): Promise<RecapEmbeddedData | null> {
  // TODO: Replace with actual API call
  // const response = await fetch('/api/user/recap');
  // return await response.json();

  // Example data
  return {
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
}

export default function DashboardRecapPage({ params }: { params: { id: string } }) {
  const router = useRouter();
  const [showRecap, setShowRecap] = useState(true);
  const [recapData, setRecapData] = useState<RecapEmbeddedData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchUserRecap()
      .then((data) => {
        setRecapData(data);
        setLoading(false);
      })
      .catch((error) => {
        console.error('Failed to load recap:', error);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-xl">Loading your recap...</div>
      </div>
    );
  }

  if (!recapData) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-xl">Unable to load recap</div>
      </div>
    );
  }

  return (
    <RecapModal
      data={recapData}
      isOpen={showRecap}
      onClose={() => {
        setShowRecap(false);
        router.push('/dashboard'); // Navigate back to dashboard
      }}
      onComplete={() => {
        console.log('Recap completed!');
        // You can add analytics tracking here
      }}
    />
  );
}
