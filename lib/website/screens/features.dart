import 'package:flutter/material.dart';
import 'package:frontend/website/widgets/homepage_widgets.dart';
import '../widgets/features_widgets.dart';
import '../widgets/navigation_bar_widget.dart';


class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  SizedBox(height: kToolbarHeight),
                  FeaturesSection(),
                  FooterSection(), // Add FooterSection at the bottom
                ],
              ),
            ),
          ),
          Positioned(
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
