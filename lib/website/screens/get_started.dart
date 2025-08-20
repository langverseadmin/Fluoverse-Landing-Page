// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/get_started_widgets.dart';
// import '../screens/join_waitlist.dart'; // Disconnected waitlist page
import '../widgets/homepage_widgets.dart'; // Import for FooterSection
import '../widgets/navigation_bar_widget.dart'; // Import for NavigationBarWidget
import 'package:go_router/go_router.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232946),
      body: Column(
        children: [
          const NavigationBarWidget(), // Add navigation bar at the top
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const GetStartedTitle(),
                  const SizedBox(height: 48),
                  const GetStartedFeature(
                    icon: LucideIcons.zap,
                    title: 'Fast-Track Fluency',
                    description:
                        'Learn Spanish with AI-powered coaching and real-world scenarios.',
                  ),
                  const SizedBox(height: 24),
                  const GetStartedFeature(
                    icon: LucideIcons.star,
                    title: 'Personalized Learning',
                    description:
                        'Get a custom learning path tailored to your goals and interests.',
                  ),
                  const SizedBox(height: 24),
                  const GetStartedFeature(
                    icon: LucideIcons.group,
                    title: 'Join the Community',
                    description:
                        'Practice with others and grow your confidence in live sessions.',
                  ),
                  const SizedBox(height: 48),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      GetStartedActionButton(
                        label: 'Launch Web App',
                        icon: LucideIcons.rocket,
                        onPressed: () async {
                          final url = Uri.parse('https://fluoverseapp.netlify.app/');
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        },
                      ),
                      GetStartedActionButton(
                        label: 'Create Account',
                        icon: LucideIcons.userPlus,
                        onPressed: () async {
                          final url = Uri.parse('https://fluoverseapp.netlify.app/');
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  const FooterSection(), // Footer at the bottom of the scrollable content
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
