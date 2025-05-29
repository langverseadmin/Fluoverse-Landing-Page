// homepage.dart

import 'package:flutter/material.dart';
import '../widgets/homepage_widgets.dart';
import '../widgets/navigation_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow background behind nav bar
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

                    // ✅ Only animate child widgets internally
                    HeroSection(),               // animations INSIDE
                    ComingSoonStrip(),
                    ValuePropsSection(),
                    LearningCycleSection(),
                    VisionSection(),
                    FooterSection(),
                  ],
                ),
              ),
            ),

            // ✅ Navigation bar remains completely static
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
