// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _currentPage = 0;

  final List<Map<String, String>> cardTexts = [
    {
      "title": "🧠 Our Mission",
      "content":
          "At Fluoverse, our mission is to reimagine language learning by breaking away from boring, impersonal education models. We believe true fluency doesn't come from memorizing flashcards — it comes from speaking, connecting, and experiencing language as if you were living in the country itself.\n\nWe’re building a world where every learner feels seen, where every session adapts to their pace, goals, and personality. Through immersive voice-first interaction and intelligent personalization, Fluoverse helps you speak confidently — faster.\n\nBecause we don’t just want you to learn the language.\n\nWe want you to live it.",
    },
    {
      "title": "👥 Our Team",
      "content":
          "Fluoverse is built by a small, fast-moving team of school friends driven by a shared obsession: fixing how people learn.\n\nWe blend empathy, creativity, and sharp problem-solving with backgrounds in engineering and IT — all focused on one thing: building something learners actually love to use.\n\nFrom day one, we've stayed close to real users, testing ideas, listening deeply, and refining everything until it feels right. Fluoverse isn’t just a product — it’s the result of countless conversations, bold ideas, and critical feedback from people like you.\n\nWe want you to feel something the moment you use it:\n\n“Finally — a language app that gets me.”",
    },
    {
      "title": "💬 Founders' Words",
      "content":
            "\"We built Fluoverse because we were tired of language apps that felt robotic, passive, and forgettable.\"\n\n"
            "\"Language is about people, not points. So we set out to build a tutor that feels more like a guide — someone who listens, responds, and adapts to you.\"\n\n"
            "\"Every decision, every feature, every lesson is crafted to help you stop studying about a language — and start speaking it with confidence.\"\n\n"
            "— Manolis & Panagiotis, Co-Founders",
    },
  ];

  void _goToPage(int index) {
    if (index < 0 || index >= cardTexts.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage = index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Image.asset('web/assets/Fluoverse_Logo.png', height: 280),
            const SizedBox(height: 24),
            const Text(
              "About Fluoverse",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 24),

            // Navigation Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _goToPage(_currentPage - 1),
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
                  iconSize: 28,
                  tooltip: 'Previous',
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _goToPage(_currentPage + 1),
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black54),
                  iconSize: 28,
                  tooltip: 'Next',
                ),
              ],
            ),

            // Card carousel (full height)
            SizedBox(
              height: 500,
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cardTexts.length,
                itemBuilder: (context, index) {
                  final card = cardTexts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    child: _GradientCard(
                      title: card["title"]!,
                      content: card["content"]!,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(cardTexts.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentPage == index ? 24 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.deepPurple
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),

            const SizedBox(height: 32),

            // Back button
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Back to Home"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                shadowColor: Colors.deepPurple.withOpacity(0.3),
                elevation: 6,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
}

class _GradientCard extends StatelessWidget {
  final String title;
  final String content;

  const _GradientCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      constraints: const BoxConstraints(
        minHeight: 800, // Adjust as needed
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.2),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(color: Colors.black38, blurRadius: 4),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

