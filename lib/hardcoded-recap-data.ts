/**
 * Hardcoded Recap Data for Video Generation
 * 
 * This file contains hardcoded recap data for each user.
 * No backend or data sourcing is involved - all data is defined here.
 */

import type { FluoverseWrappedData } from '@/components/FluoverseWrapped';

/**
 * Hardcoded user recap data mapping
 * Add new users here with their personalized recap data
 */
export const HARDCODED_RECAP_DATA: Record<string, FluoverseWrappedData> = {
  // User 1: Vera Georgouli Class (Aggregated)
  'user-1': {
    userName: 'Your Class',
    year: 2025,
    totalMinutes: 133,
    learningAgeDays: 24,
    totalScenariosCompleted: 35,
    topScenarios: [
      {
        lessonId: 'lesson-taverna',
        lessonTitle: 'First Night at the Taverna',
        completionCount: 13,
        averageScore: 80.0,
        totalTimeSpent: 3215, // 53.58 minutes * 60 = 3214.8 seconds
      },
    ],
    uniqueWordsMastered: 119,
    personalizedMessage: 'Your class has made incredible progress this year!',
    biggestAchievement: 'Your class completed 35 sessions with 119 unique words mastered!',
  },

  // User 2: Fomintsev Leonidas (fomintsev.moda@gmail.com)
  'user-2': {
    userName: 'Leonidas',
    year: 2025,
    totalMinutes: 1,
    learningAgeDays: 16,
    totalScenariosCompleted: 1,
    topScenarios: [
      {
        lessonId: 'lesson-restaurant',
        lessonTitle: 'First Dinner at a Local Restaurant',
        completionCount: 1,
        averageScore: 0.0,
        totalTimeSpent: 30, // Minimum 30 seconds for display
      },
    ],
    uniqueWordsMastered: 7,
    personalizedMessage: 'Welcome to Fluoverse! Great start on your learning journey!',
    biggestAchievement: 'You\'ve been with us for 16 days - keep practicing!',
  },

  // Example user 3 - Add more users as needed
  'user-3': {
    userName: 'John',
    year: 2025,
    totalMinutes: 850,
    learningAgeDays: 90,
    totalScenariosCompleted: 32,
    topScenarios: [
      {
        lessonId: 'lesson-5',
        lessonTitle: 'Basic Greetings',
        completionCount: 10,
        averageScore: 78,
        totalTimeSpent: 800,
      },
    ],
    uniqueWordsMastered: 180,
    personalizedMessage: 'Great start to your Spanish learning journey!',
    biggestAchievement: 'Completed 32 lessons in your first 90 days!',
  },

  // Class/Tutor Recap - Aggregated stats for entire class
  'class-tutor': {
    userName: 'Your Class',
    year: 2025,
    totalMinutes: 404,
    learningAgeDays: 22,
    totalScenariosCompleted: 81,
    topScenarios: [
      {
        lessonId: 'lesson-1',
        lessonTitle: 'First Dinner at a Local Restaurant',
        completionCount: 33,
        averageScore: 75.0,
        totalTimeSpent: 9783, // 163.05 minutes in seconds
      },
    ],
    uniqueWordsMastered: 438,
    personalizedMessage: 'Your class has made incredible progress this year!',
    biggestAchievement: 'Next year will be even greater!',
  },
};

/**
 * Get hardcoded recap data for a user
 * @param userId - The user ID to get data for
 * @returns The recap data for the user, or null if not found
 */
export function getHardcodedRecapData(userId: string): FluoverseWrappedData | null {
  return HARDCODED_RECAP_DATA[userId] || null;
}

/**
 * Check if a user has hardcoded data
 * @param userId - The user ID to check
 * @returns True if data exists for this user
 */
export function hasHardcodedData(userId: string): boolean {
  return userId in HARDCODED_RECAP_DATA;
}

/**
 * Get all user IDs that have hardcoded data
 * @returns Array of user IDs
 */
export function getAllUserIds(): string[] {
  return Object.keys(HARDCODED_RECAP_DATA);
}

/**
 * Example usage for API route:
 * 
 * ```typescript
 * import { getHardcodedRecapData } from '@/lib/hardcoded-recap-data';
 * 
 * // In your API handler or client code:
 * const recapData = getHardcodedRecapData(userId);
 * if (recapData) {
 *   // Use recapData in API call or video generation
 *   const response = await fetch('/api/recap/generate-video', {
 *     method: 'POST',
 *     headers: { 'Content-Type': 'application/json' },
 *     body: JSON.stringify({ userId, recapData }),
 *   });
 * }
 * ```
 */

