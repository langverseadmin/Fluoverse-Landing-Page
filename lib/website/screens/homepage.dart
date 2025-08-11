// homepage.dart

import 'package:flutter/material.dart';
import '../widgets/homepage_widgets.dart';
import '../widgets/navigation_bar_widget.dart';

class HomePage extends StatelessWidget {
  final Map<String, GlobalKey>? tourKeys;
  final VoidCallback? onMobileMenuOpened;
  
  const HomePage({
    super.key, 
    this.tourKeys,
    this.onMobileMenuOpened,
  });

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
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    HeroSection(key: tourKeys?['hero-section'], tourKeys: tourKeys),
                    ValuePropsSection(key: Key('features-section')),
                    LearningCycleSection(key: Key('how-it-works-section')),
                    VisionSection(),
                    FooterSection(),
                  ],
                ),
              ),
            ),
                                    Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: NavigationBarWidget(
                            tourKeys: tourKeys,
                            onMenuOpened: onMobileMenuOpened,
                          ),
                        ),
          ],
        ),
      ),
    );
  }
}
