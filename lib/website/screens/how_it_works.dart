import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/homepage_widgets.dart'; // For FooterSection
import '../widgets/navigation_bar_widget.dart';
import '../widgets/how_it_works_widgets.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Ensures background fills behind nav bar
      backgroundColor: Colors.transparent, // Prevents white flash
      body: Background(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: kToolbarHeight), // Space for nav bar
                    // Animate only the main content, not the nav bar
                    const HowItWorksPage()
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slide(begin: const Offset(0, -0.2)),
                    const FooterSection()
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slide(begin: const Offset(0, 0.2)),
                  ],
                ),
              ),
            ),
            // Do NOT animate the NavigationBarWidget
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavigationBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
