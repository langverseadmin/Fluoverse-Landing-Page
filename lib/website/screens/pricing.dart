// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import '../widgets/navigation_bar_widget.dart';
import '../widgets/pricing_widgets.dart';
import '../widgets/homepage_widgets.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow background behind nav bar
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Effects
          const Positioned.fill(
            child: BackgroundEffects(),
          ),

          // Main Content
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  SizedBox(height: kToolbarHeight + 120),

                  // Pricing Title Section
                  PricingTitleSection(),

                  // Pricing Cards Row
                  SizedBox(height: 64),
                  PricingCardsRow(isAnnual: false), // Default to monthly pricing

                  // FAQ Section
                  SizedBox(height: 100),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: FaqSection(),
                  ),

                  // Final CTA Section
                  SizedBox(height: 100),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: FinalCtaSection(),
                  ),

                  // Footer Section
                  SizedBox(height: 32),
                  FooterSection(),
                ],
              ),
            ),
          ),

          // Navigation Bar
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
