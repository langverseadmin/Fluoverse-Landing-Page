// homepage.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/homepage_widgets.dart';
import '../widgets/navigation_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Add this line to allow content behind the nav bar
      body: Stack(
        children: [
          Background(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80), // Reserve space for navigation bar
                  const HeroSection()
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slide(begin: const Offset(0, -0.2)),
                  const ComingSoonStrip()
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .scale(begin: const Offset(0.8, 0.8)),
                  const ValuePropsSection()
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slide(begin: const Offset(0, 0.2)),
                  const LearningCycleSection()
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slide(begin: const Offset(0, 0.2)),
                  const VisionSection()
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slide(begin: const Offset(0, 0.2)),
                  const FooterSection()
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slide(begin: const Offset(0, 0.2)),
                ],
              ),
            ),
          ),
          // Navigation bar is now outside the animated content and will not animate
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavigationBarWidget(),
          ),
        ],
      ),
    );
  }
}
