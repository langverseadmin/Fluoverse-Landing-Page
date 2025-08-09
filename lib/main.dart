// lib/landing_page/landing_main.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import '../website/screens/homepage.dart'; // 👈 Make sure this matches your file structure
import '../website/screens/features.dart';
import '../website/screens/contact.dart';
import '../website/screens/get_started.dart';
// import '../website/screens/join_waitlist.dart'; // Disconnected waitlist page
import '../website/screens/pricing_v2.dart';
import '../website/screens/privacy_policy.dart';
import '../website/screens/terms_policy.dart';
import '../website/screens/how_it_works.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pjjiusivnjtpzzqlhpzd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqaml1c2l2bmp0cHp6cWxocHpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY4MjI2NTgsImV4cCI6MjA2MjM5ODY1OH0.OAhCRxjORCDmoBDipAc-GkLqp7xe8Tn2LV_sIoDXCqU',
  );
  runApp(const FluoverseWebsiteApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/features',
      builder: (context, state) => const FeaturesScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactScreen(),
    ),
    GoRoute(
      path: '/get-started',
      builder: (context, state) => const GetStartedScreen(),
    ),
    // GoRoute(
    //   path: '/join-waitlist',
    //   builder: (context, state) => const JoinWaitlist(),
    // ),
    GoRoute(
      path: '/pricing',
      builder: (context, state) => const PaymentScreen(),
    ),
    GoRoute(
      path: '/privacy',
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: '/terms',
      builder: (context, state) => const TermsPolicyScreen(),
    ),
    GoRoute(
      path: '/how-it-works',
      builder: (context, state) => const HowItWorksScreen(),
    ),
  ],
);

class FluoverseWebsiteApp extends StatelessWidget {
  const FluoverseWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fluoverse – Speak-First AI Language Tutor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent, // for gradient visibility
      ),
      routerConfig: _router,
    );
  }
}
