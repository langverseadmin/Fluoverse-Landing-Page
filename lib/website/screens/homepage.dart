// homepage.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/homepage_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero, // Removed vertical padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HeroSection()
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .slide(begin: const Offset(0, -0.2)),

              const ComingSoonStrip()
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .scale(begin: const Offset(0.8, 0.8)),

              const ValuePropsSection()
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .slide(begin: const Offset(0, 0.2)),

              const LearningCycleSection()
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .slide(begin: const Offset(0, 0.2)),

              const FooterSection()
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .slide(begin: const Offset(0, 0.2)),
            ],
          ),
        ),
      ),
    );
  }
}
