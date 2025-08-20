// lib/landing_page/landing_page.dart

import 'package:flutter/material.dart';
import 'package:frontend/landing_page/early_access_section.dart';
import 'hero_banner.dart';
import 'about_section.dart';
import 'features_section.dart';
import 'footer.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroBanner(),
            AboutSection(),
            FeaturesSection(),
            CallToActionSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
