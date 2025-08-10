// lib/landing_page/landing_main.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
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
      builder: (context, child) {
        return GlobalPopupWrapper(child: child!);
      },
    );
  }
}

class GlobalPopupWrapper extends StatefulWidget {
  final Widget child;

  const GlobalPopupWrapper({super.key, required this.child});

  @override
  State<GlobalPopupWrapper> createState() => _GlobalPopupWrapperState();
}

class _GlobalPopupWrapperState extends State<GlobalPopupWrapper> with TickerProviderStateMixin {
  bool _showPopup = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Show popup after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _showPopup = true;
        });
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _launchWebApp() async {
    final url = Uri.parse('https://fluoverseapp.netlify.app/');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _dismissPopup() {
    _animationController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _showPopup = false;
        });
      }
    });
  }

  void _launchAndClose() async {
    _dismissPopup();
    final url = Uri.parse('https://fluoverseapp.netlify.app/');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_showPopup)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Container(
                    color: Colors.black.withOpacity(0.3 * _fadeAnimation.value),
                    child: Center(
                      child: Transform.scale(
                        scale: 0.8 + (0.2 * _fadeAnimation.value),
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 30,
                                spreadRadius: 0,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Header with close button
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF6A82FB), Color(0xFFB721FF)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.rocket_launch_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                                                             const Expanded(
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text(
                                                 'Ready to Start?',
                                                 style: TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.bold,
                                                   decoration: TextDecoration.none,
                                                 ),
                                               ),
                                               SizedBox(height: 4),
                                               Text(
                                                 'Your Spanish journey awaits',
                                                 style: TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w400,
                                                   decoration: TextDecoration.none,
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                    GestureDetector(
                                      onTap: _dismissPopup,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Content
                              Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Launch Fluoverse and begin your Spanish learning journey with AI-powered conversations!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        height: 1.5,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _launchAndClose,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF6A82FB),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.rocket_launch_rounded, size: 20),
                                            SizedBox(width: 8),
                                            Text(
                                              'Launch App',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
