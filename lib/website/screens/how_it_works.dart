import 'package:flutter/material.dart';
import '../widgets/homepage_widgets.dart'; // For FooterSection
import '../widgets/navigation_bar_widget.dart';
import '../widgets/how_it_works_widgets.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Background(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    SizedBox(height: kToolbarHeight),

                    // 🚫 No animation here — animation should be internal
                    HowItWorksPage(),

                    FooterSection(), // If it includes animation, keep it INSIDE
                  ],
                ),
              ),
            ),

            // 🧊 This stays completely static
            Positioned(
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

