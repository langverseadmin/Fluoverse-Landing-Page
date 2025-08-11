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
import '../services/first_time_visitor_service.dart';
import '../widgets/onboarding_carousel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pjjiusivnjtpzzqlhpzd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqaml1c2l2bmp0cHp6cWxocHpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY4MjI2NTgsImV4cCI6MjA2MjM5ODY1OH0.OAhCRxjORCDmoBDipAc-GkLqp7xe8Tn2LV_sIoDXCqU',
  );
  
  runApp(const FluoverseWebsiteApp());
}

// Create a wrapper widget to handle tour keys
class _HomePageWrapper extends StatelessWidget {
  final Map<String, GlobalKey>? tourKeys;
  final VoidCallback? onMobileMenuOpened;
  
  const _HomePageWrapper({
    this.tourKeys,
    this.onMobileMenuOpened,
  });

  @override
  Widget build(BuildContext context) {
    return HomePage(
      tourKeys: tourKeys,
      onMobileMenuOpened: onMobileMenuOpened,
    );
  }
}

class FluoverseWebsiteApp extends StatefulWidget {
  const FluoverseWebsiteApp({super.key});

  @override
  State<FluoverseWebsiteApp> createState() => _FluoverseWebsiteAppState();
}

class _FluoverseWebsiteAppState extends State<FluoverseWebsiteApp> {
  bool _showOnboarding = false;
  bool _isLoading = true; // Add loading state
  String? _initialFragment; // Store the initial fragment

  // Global keys for tour targets
  final Map<String, GlobalKey> _tourKeys = {
    'hero-section': GlobalKey(),
    'nav-home': GlobalKey(),
    'nav-features': GlobalKey(),
    'nav-pricing': GlobalKey(),
    'nav-how-it-works': GlobalKey(),
    'nav-contact': GlobalKey(),
    'get-started-button': GlobalKey(),
    'entire-navbar': GlobalKey(), // New key for entire navbar
    'launch-app-button': GlobalKey(), // New key for LAUNCH APP NOW button
    'mobile-menu-button': GlobalKey(), // New key for mobile menu button
  };

              // Tour steps
            final List<TourStep> _tourSteps = [
              TourStep(
                step: 1,
                total: 11,
                title: "Welcome to Fluoverse! 🚀",
                description: "Let's take a quick tour of your new Spanish learning platform. I'll show you around and explain everything you can do here.",
                targetKey: "hero-section",
                action: "Let's start!",
              ),
              TourStep(
                step: 2,
                total: 11,
                title: "Navigation Menu 📱",
                description: "This is your main navigation bar. Use these buttons to explore different sections of Fluoverse. Each tab takes you to specific features and content.",
                targetKey: "entire-navbar",
                action: "Got it!",
              ),
              TourStep(
                step: 3,
                total: 11,
                title: "Navigation Menu📱",
                description: "Tap the menu button to access all navigation options. This opens a beautiful menu with all the sections we'll explore.",
                targetKey: "mobile-menu-button",
                action: "Open Menu",
                requiresAction: true, // Now requires action
              ),
              TourStep(
                step: 4,
                total: 11,
                title: "Home Screen 🏠",
                description: "The Home button takes you to the main landing page. Here you'll find an overview of Fluoverse, key features, and quick access to start learning.",
                targetKey: "nav-home",
                action: "Show me more",
              ),
              TourStep(
                step: 5,
                total: 11,
                title: "How It Works 🔄",
                description: "Learn about our unique learning cycle! This section explains how our AI conversation tutor works, the learning methodology, and what makes Fluoverse different.",
                targetKey: "nav-how-it-works",
                action: "Continue",
              ),
              TourStep(
                step: 6,
                total: 11,
                title: "Features Section ✨",
                description: "Discover all the amazing features that make Fluoverse special. Learn about our AI conversation tutor, personalized learning, and real-world scenarios.",
                targetKey: "nav-features",
                action: "Next",
              ),
              TourStep(
                step: 7,
                total: 11,
                title: "Pricing Plans 💰",
                description: "Choose the perfect plan for your learning goals. Start with a 14-day free trial and upgrade for access to premium features with unlimited AI conversations and advanced tools.",
                targetKey: "nav-pricing",
                action: "Continue",
              ),
              TourStep(
                step: 8,
                total: 11,
                title: "Contact & Support 📧",
                description: "Need help or have questions? The Contact section connects you with our support team and provides all the information you need to get started.",
                targetKey: "nav-contact",
                action: "Almost done",
              ),
              TourStep(
                step: 9,
                total: 11,
                title: "Get Started Button 🎯",
                description: "Ready to begin your journey? Click 'Get Started' to create your account and access all the features we just explored.",
                targetKey: "get-started-button",
                action: "Next",
              ),
              TourStep(
                step: 10,
                total: 11,
                title: "Close Menu 📱",
                description: "Great! Now let's close the menu so we can see the final button. Tap the X button to close it.",
                targetKey: "close-mobile-menu",
                action: "Close Menu",
                requiresAction: true,
              ),
              TourStep(
                step: 11,
                total: 11,
                title: "Launch the App! 🚀",
                description: "Perfect! This 'LAUNCH FLUOVERSE NOW' button will take you directly to the Fluoverse app where you can sign up and start your Spanish learning journey immediately.",
                targetKey: "launch-app-button",
                action: "Start Learning!",
              ),
            ];

  // Create router with tour keys
  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => _HomePageWrapper(
          tourKeys: _tourKeys,
          onMobileMenuOpened: () {
            // This callback will be used by the onboarding tour
            print('🎯 Mobile menu opened from router callback');
          },
        ),
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

  @override
  void initState() {
    super.initState();
    print('🚀 App initializing...');
    print('🔗 Full URL: ${Uri.base}');
    print('🔗 Path: ${Uri.base.path}');
    print('🔗 Query: ${Uri.base.query}');
    print('🔗 Fragment: ${Uri.base.fragment}');
    _initialFragment = Uri.base.fragment; // Store the initial fragment
    _checkFirstTimeVisitor();
  }

  Future<void> _checkFirstTimeVisitor() async {
    try {
      print('🎯 Starting first-time visitor check...');
      
      // Check URL state
      final fullUrl = Uri.base.toString();
      final fragment = _initialFragment ?? Uri.base.fragment; // Use stored fragment if available
      final completeUrl = fragment.isNotEmpty ? '$fullUrl#$fragment' : fullUrl;
      final hasTokenInQuery = Uri.base.queryParameters['token'] != null;
      final hasTokenInFragment = completeUrl.contains('token=');
      final hasToken = hasTokenInQuery || hasTokenInFragment;
      
      print('🎯 URL Analysis:');
      print('  - Full URL: $fullUrl');
      print('  - Fragment: $fragment');
      print('  - Complete URL: $completeUrl');
      print('  - Current path: ${Uri.base.path}');
      print('  - Query parameters: ${Uri.base.queryParameters}');
      print('  - Has token in query: $hasTokenInQuery');
      print('  - Has token in fragment: $hasTokenInFragment');
      print('  - Has token: $hasToken');

      // 1) If a token exists anywhere, do not intervene at all
      if (hasToken) {
        if (mounted) {
          setState(() {
            _showOnboarding = false;
            _isLoading = false;
          });
        }
        return; // Let the router render the current route as-is
      }
      
      // 2) Otherwise, check onboarding status
      final isFirstTime = await FirstTimeVisitorService.instance.checkFirstTimeVisitor();
      final isOnboardingDeferred = await FirstTimeVisitorService.instance.isOnboardingDeferred();
      print('🎯 App started - First-time: $isFirstTime, Deferred: $isOnboardingDeferred');
      
      // Clear loading first, then optionally trigger onboarding after a short delay
      if (mounted) {
        setState(() {
          _isLoading = false;
          _showOnboarding = false; // will enable after a short delay if needed
        });
      }

      final shouldShowOnboarding = isFirstTime || isOnboardingDeferred;

      if (shouldShowOnboarding) {
        // Wait briefly to allow route to settle, then show onboarding (home only)
        await Future.delayed(const Duration(milliseconds: 700));
        final stillNoToken = !(Uri.base.queryParameters['token'] != null || (Uri.base.toString().contains('token=')));
        final onHomeRoute = Uri.base.path == '/';
        if (mounted && stillNoToken && onHomeRoute) {
          setState(() {
            _showOnboarding = true;
          });
        }
      }
    } catch (e) {
      print('❌ Error checking first-time visitor: $e');
      if (mounted) {
        setState(() {
          _showOnboarding = false; // Don't show onboarding on error
          _isLoading = false;
        });
      }
    }
  }

  void _completeOnboarding() {
    print('🎯 _completeOnboarding called, setting _showOnboarding to false');
    setState(() {
      _showOnboarding = false;
    });
    print('🎯 _showOnboarding is now: $_showOnboarding');
    
    // Clear the deferred onboarding flag when onboarding is completed
    FirstTimeVisitorService.instance.clearDeferredOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while checking first-time visitor status
    if (_isLoading) {
      return MaterialApp(
        title: 'Fluoverse – Loading',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    // Main app with optional onboarding tour
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
        Widget appContent = GlobalPopupWrapper(
          child: child!,
          showOnboarding: _showOnboarding,
          onOnboardingComplete: _completeOnboarding,
        );
        
        // Wrap with onboarding tour if needed - now inside MaterialApp context
        if (_showOnboarding) {
          appContent = Stack(
            children: [
              appContent,
              OnboardingTour(
                targets: _tourKeys,
                steps: _tourSteps,
                onComplete: _completeOnboarding,
              ),
            ],
          );
        }
        
        return appContent;
      },
    );
  }
}

class GlobalPopupWrapper extends StatefulWidget {
  final Widget child;
  final bool showOnboarding;
  final VoidCallback onOnboardingComplete;

  const GlobalPopupWrapper({
    super.key,
    required this.child,
    required this.showOnboarding,
    required this.onOnboardingComplete,
  });

  @override
  State<GlobalPopupWrapper> createState() => _GlobalPopupWrapperState();
}

class _GlobalPopupWrapperState extends State<GlobalPopupWrapper> with TickerProviderStateMixin {
  bool _showPopup = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _suppressPopupForPaymentFlow = false; // Do not show popup during payment

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

    // Detect payment flow via token in URL or being on pricing route
    final fullUrl = Uri.base.toString();
    final hasToken = Uri.base.queryParameters['token'] != null || fullUrl.contains('token=');
    final onPricingRoute = Uri.base.path == '/pricing';
    _suppressPopupForPaymentFlow = hasToken || onPricingRoute;

    // Start popup timer based on onboarding state
    _startPopupTimer();
  }

  void _startPopupTimer() {
    if (widget.showOnboarding || _suppressPopupForPaymentFlow) {
      // For new users or payment flow, do not show popup automatically
      return;
    } else {
      // For returning users, show popup after 4 seconds
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted && !_showPopup) {
          setState(() {
            _showPopup = true;
          });
          _animationController.forward();
        }
      });
    }
  }

  void _onOnboardingComplete() {
    // On mobile, do not show the post-onboarding popup to avoid grey overlay blocking UI
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    if (!isMobile && !_suppressPopupForPaymentFlow) {
      // Show popup after onboarding completes (with a small delay)
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && !_showPopup) {
          setState(() {
            _showPopup = true;
          });
          _animationController.forward();
        }
      });
    }
    // Call the parent's onboarding complete callback
    widget.onOnboardingComplete();
  }

  @override
  void didUpdateWidget(GlobalPopupWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If onboarding state changes, update accordingly
    if (oldWidget.showOnboarding && !widget.showOnboarding) {
      // Onboarding just completed
      _onOnboardingComplete();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
        if (_showPopup && !widget.showOnboarding && !_suppressPopupForPaymentFlow)
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
                                              'Launch Fluoverse',
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
