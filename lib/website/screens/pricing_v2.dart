// ignore_for_file: deprecated_member_use, use_build_context_synchronously, library_private_types_in_public_api, unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui'; // Import for ImageFilter
import 'dart:math';
import 'dart:js_interop';
// Add for web postMessage
import 'package:web/web.dart' as web;
// Removed: import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/navigation_bar_widget.dart';
import '../widgets/homepage_widgets.dart';
import '../../services/first_time_visitor_service.dart';

// Define Plan class for clarity
class Plan {
  final String name;
  final double monthly, yearly;
  final List<String> features;
  final String? badge;
  final String monthlyPriceId;
  final String yearlyPriceId;
  Plan(this.name, this.monthly, this.yearly, this.features, {this.badge, required this.monthlyPriceId, required this.yearlyPriceId});
}

final List<Plan> plans = [
  // Plan('Explorer', 13.99, 48, [
  //   'Unlimited daily lessons',
  //   'Basic AI tutor',
  //   'Community support',
  // ]),
  Plan('Fluoversian', 16.0, 154.0, [
    'One Cycle per day',
    'Unlimited daily agent usage',
    'Fluency Battle Rooms (early access)',
    'Exclusive Rewards',

  ], badge: 'Most popular', monthlyPriceId: 'price_1RtuFxJlDbRIIvhYgzGfHeZC', yearlyPriceId: 'price_1Rpc2PJlDbRIIvhYNamSUptB'),
  // Plan('Fluoversian', 35.29, 180, [
  //   'Unlimited daily lessons',
  //   'Basic AI tutor',
  //   'Community support',
  //   'Fluency Battle Rooms',
  //   'Personalized AI tutor',
  //   'Priority support',
  //   '1:1 Live Coaching',
  //   'Early access to new features',
  //   'Exclusive webinars',
  // ]),
];

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with TickerProviderStateMixin {
  bool isYearly = false;
  int selectedPlan = 0; // Default to Fluoversian (only plan)
  bool showComparison = false;
  bool isProcessing = false;
  bool showLoginPrompt = false;

  late AnimationController _mainController;
  late AnimationController _cardsController;
  late Animation<double> _heroAnim;
  late Animation<double> _toggleAnim;
  late List<Animation<double>> _cardAnims;
  int _visibleCardCount = 3;
  late Animation<double> _comparisonAnim;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _plansKey = GlobalKey();
  int _carouselPage = 1;
  final GlobalKey _comparisonTableKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );
    _cardsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _heroAnim = CurvedAnimation(parent: _mainController, curve: const Interval(0.0, 0.19, curve: Curves.easeOutExpo));
    _toggleAnim = CurvedAnimation(parent: _mainController, curve: const Interval(0.10, 0.23, curve: Curves.easeOutCubic));
    _comparisonAnim = CurvedAnimation(parent: _mainController, curve: const Interval(0.80, 1.0, curve: Curves.easeOutCubic));
    _setupCardAnims(3, useCardsController: false);
    Future.delayed(const Duration(milliseconds: 180), () {
      if (mounted) {
        _mainController.forward();
      }
    });
    // After hero/toggle animation, scroll to plans, then animate cards
    Future.delayed(const Duration(milliseconds: 1400), () {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        final context = _plansKey.currentContext;
        if (context != null) {
          await Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOutCubic,
            alignment: 0.4, // Scroll a tiny bit less
          );
        }
        // Animate cards after scroll
        if (mounted) _cardsController.forward();
      });
    });
    // Check for payment param in URL (fragment or query)
    // Payment parameter handling removed - no longer polling or showing success/error modals
    // The payment flow is now handled entirely by Stripe
  }

  void _setupCardAnims(int count, {bool useCardsController = true}) {
    _visibleCardCount = count;
    // Spread out the intervals for a more relaxed, staggered effect
    _cardAnims = List.generate(count, (i) {
      final base = 0.20;
      final step = 0.18;
      final animLen = 0.32;
      final start = base + i * step;
      final end = min(start + animLen, 0.90);
      return CurvedAnimation(
        parent: useCardsController ? _cardsController : _mainController,
        curve: Interval(start, end, curve: Curves.elasticOut),
      );
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _cardsController.dispose();
    _scrollController.dispose();
    
    // Payment flow is now handled entirely by Stripe, no need to track payment success
    
    super.dispose();
  }

  // Helper to extract token from query or fragment
  String? _extractTokenFromUrl() {
    // Try normal query parameters first
    final token = Uri.base.queryParameters['token'];
    if (token != null && token.isNotEmpty) return token;

    // Try parsing from fragment (for hash routing)
    final fragment = Uri.base.fragment; // e.g. "pricing?token=..."
    if (fragment.contains('token=')) {
      final uri = Uri.parse('http://dummy/?${fragment.split('?').last}');
      return uri.queryParameters['token'];
    }
    return null;
  }

  Future<void> _startStripePayment() async {
    if (selectedPlan == -1) return;
    setState(() { isProcessing = true; });
    final plan = plans[selectedPlan];
    final period = isYearly ? 'yearly' : 'monthly';
    final price = isYearly ? plan.yearly : plan.monthly;
    final planName = plan.name;
    final features = plan.features;
    final token = _extractTokenFromUrl();
    if (token == null) {
      _showError('Missing token. Please return to the app and try again.');
      setState(() { isProcessing = false; });
      return;
    }
    try {
      // Get the price_id based on the selected plan and period
      final priceId = isYearly ? plan.yearlyPriceId : plan.monthlyPriceId;
      
      final response = await http.post(
        Uri.parse('https://fluoverse.onrender.com/create-checkout-session'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'price_id': priceId,  // Use Stripe's product catalog price_id
          'product_name': 'Fluoverse $planName ($period)',
          'features': features,
          'period': period,
          'token': token,
          'plan_name': planName,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final url = data['checkout_url'];
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          // Wait a moment for Stripe to open, then close the website tab
          await Future.delayed(const Duration(milliseconds: 500));
          // Close the website tab and let Stripe handle the payment flow independently
          web.window.close();
        } else {
          debugPrint('❌ Could not launch Stripe checkout URL: $url');
          _showError('Could not launch payment page. Please check your internet connection or try a different browser.');
          return;
        }
      } else {
        debugPrint('❌ Failed to create checkout session. Status: ${response.statusCode}, Body: ${response.body}');
        final errorMessage = response.statusCode == 400 
            ? 'Invalid request. Please check your login status and try again.'
            : response.statusCode == 401 
                ? 'Authentication failed. Please log in again.'
                : response.statusCode == 500
                    ? 'Server error. Please try again later.'
                    : 'Failed to create checkout session. Please try again.';
        throw errorMessage;
      }
    } catch (e, stack) {
      debugPrint('❌ Exception in _startStripePayment: $e');
      debugPrint(stack.toString());
      _showError('Error launching checkout: $e');
    } finally {
      setState(() { isProcessing = false; });
    }
  }



  // Retry payment check removed - no longer polling for payment status

  void _showError(String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => GlassmorphicErrorPopup(
        message: message,
        showRetryButton: false, // No retry since we're not polling
        onRetry: null,
        isRetrying: false,
      ),
    );
  }

  void _startStripePaymentFor(int planIndex, bool isYearly) async {
    setState(() {
      selectedPlan = planIndex;
      this.isYearly = isYearly;
    });
    await _startStripePayment();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    final token = _extractTokenFromUrl();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // --- Clean Professional Dark Gradient Background ---
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF181A2A), // deep navy
                    Color(0xFF23244D), // dark blue
                    Color(0xFF2D185A), // deep purple
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // --- Main Content ---
          ListView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            children: [
              const NavigationBarWidget(),
              const SizedBox(height: 24),
              // --- Hero Area ---
              AnimatedBuilder(
                animation: _heroAnim,
                builder: (context, child) => Opacity(
                  opacity: _heroAnim.value,
                  child: Transform.translate(
                    offset: Offset(0, 40 * (1 - _heroAnim.value)),
                    child: child,
                  ),
                ),
                child: const PaymentHero(key: Key('pricing-section')),
              ),
              // --- Billing Toggle ---
              AnimatedBuilder(
                animation: _toggleAnim,
                builder: (context, child) => Opacity(
                  opacity: _toggleAnim.value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - _toggleAnim.value)),
                    child: child,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              color: isYearly ? Colors.grey : Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            child: const Text('Monthly'),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              final newIsYearly = !isYearly;
                              final newVisibleCount = newIsYearly ? 1 : 3;
                              _cardsController.reset();
                              _setupCardAnims(newVisibleCount, useCardsController: true);
                              setState(() {
                                isYearly = newIsYearly;
                                showComparison = false;
                              });
                              _cardsController.forward();
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: 56,
                                height: 32,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.13),
                                  border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
                                ),
                                child: Stack(
                                  children: [
                                    AnimatedAlign(
                                      alignment: isYearly ? Alignment.centerRight : Alignment.centerLeft,
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeOutCubic,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: isYearly
                                                ? [Colors.amber, Color(0xFFF5D97A)] // Gold
                                                : [Colors.purple, Colors.purpleAccent],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: isYearly ? Color(0xFFBFA14A).withOpacity(0.32) : Colors.deepPurple.withOpacity(0.22),
                                              blurRadius: 12,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              color: isYearly ? Color(0xFFBFA14A) : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            child: const Text('Yearly'),
                          ),
                          // No badge for yearly
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80), // Add more space before plans
              // --- Plan Pricing Table ---
              Container(
                key: _plansKey,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 700;
                    // Determine visible cards
                    final visibleEntries = [
                      for (final entry in plans.asMap().entries)
                        if (!isYearly || entry.key == 0) entry
                    ];
                    if (_visibleCardCount != visibleEntries.length) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) setState(() => _setupCardAnims(visibleEntries.length));
                      });
                    }
                    final isTablet = constraints.maxWidth >= 700 && constraints.maxWidth < 1200;
                    final carouselLength = visibleEntries.length;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                      child: isMobile
                          ? Column(
                              children: [
                                for (int i = 0; i < visibleEntries.length; i++) ...[
                                  AnimatedBuilder(
                                    animation: _cardAnims[i],
                                    builder: (context, child) {
                                      final animVal = _cardAnims[i].value.clamp(0.0, 1.0);
                                      return Opacity(
                                        opacity: animVal,
                                        child: Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.identity()
                                            ..translate(0.0, 80 * (1 - animVal))
                                            ..scale(0.7 + 0.3 * animVal, 0.7 + 0.3 * animVal),
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: _SaasPricingCard(
                                        plan: visibleEntries[i].value,
                                        isMain: selectedPlan == visibleEntries[i].key,
                                        isSelected: selectedPlan == visibleEntries[i].key,
                                        onSelect: () => setState(() => selectedPlan = visibleEntries[i].key),
                                        isYearly: isYearly,
                                      ),
                                    ),
                                  ),
                                  if (i < visibleEntries.length - 1)
                                    const SizedBox(height: 24),
                                ],
                              ],
                            )
                          : isTablet
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 520,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.arrow_left, size: 36, color: _carouselPage == 0 ? Colors.grey : Colors.white),
                                          onPressed: _carouselPage == 0 ? null : () => setState(() => _carouselPage--),
                                        ),
                                        AnimatedBuilder(
                                          animation: _cardAnims[_carouselPage],
                                          builder: (context, child) {
                                            final animVal = _cardAnims[_carouselPage].value.clamp(0.0, 1.0);
                                            return Opacity(
                                              opacity: animVal,
                                              child: Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.identity()
                                                  ..translate(0.0, 80 * (1 - animVal))
                                                  ..scale(0.7 + 0.3 * animVal, 0.7 + 0.3 * animVal),
                                                child: child,
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: _SaasPricingCard(
                                              plan: visibleEntries[_carouselPage].value,
                                              isMain: selectedPlan == visibleEntries[_carouselPage].key,
                                              isSelected: selectedPlan == visibleEntries[_carouselPage].key,
                                              onSelect: () => setState(() => selectedPlan = visibleEntries[_carouselPage].key),
                                              isYearly: isYearly,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.arrow_right, size: 36, color: _carouselPage == carouselLength - 1 ? Colors.grey : Colors.white),
                                          onPressed: _carouselPage == carouselLength - 1 ? null : () => setState(() => _carouselPage++),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(carouselLength, (idx) => AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      width: _carouselPage == idx ? 18 : 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: _carouselPage == idx ? Colors.amber : Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    )),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < visibleEntries.length; i++)
                                    AnimatedBuilder(
                                      animation: _cardAnims[i],
                                      builder: (context, child) {
                                        final animVal = _cardAnims[i].value.clamp(0.0, 1.0);
                                        return Opacity(
                                          opacity: animVal,
                                          child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity()
                                              ..translate(0.0, 80 * (1 - animVal))
                                              ..scale(0.7 + 0.3 * animVal, 0.7 + 0.3 * animVal),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 14),
                                        child: _SaasPricingCard(
                                          plan: visibleEntries[i].value,
                                          isMain: selectedPlan == visibleEntries[i].key,
                                          isSelected: selectedPlan == visibleEntries[i].key,
                                          onSelect: () => setState(() => selectedPlan = visibleEntries[i].key),
                                          isYearly: isYearly,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              // --- Plan Comparison Reveal ---
              AnimatedBuilder(
                animation: _comparisonAnim,
                builder: (context, child) => Opacity(
                  opacity: _comparisonAnim.value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - _comparisonAnim.value)),
                    child: child,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: MouseRegion(
                    cursor: isYearly ? SystemMouseCursors.basic : SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                              setState(() => showComparison = !showComparison);
                              if (!showComparison) return;
                              await Future.delayed(const Duration(milliseconds: 100));
                              if (_scrollController.hasClients) {
                                final width = MediaQuery.of(context).size.width;
                                if (width >= 2000) {
                                  // Desktop: animate to bottom with extra
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent + 250.0,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOutCubic,
                                  );
                                } else if (width >= 1200) {
                                  // Laptop: animate to bottom with less extra
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent + 0.0,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOutCubic,
                                  );
                                } else {
                                  // Mobile/tablet: ensure comparison table is visible
                                  final ctx = _comparisonTableKey.currentContext;
                                  if (ctx != null) {
                                    await Scrollable.ensureVisible(
                                      ctx,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOutCubic,
                                    );
                                  }
                                }
                              }
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            showComparison ? Icons.expand_less : Icons.expand_more,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Compare all features',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Comparison table with key for scroll
              AnimatedCrossFade(
                crossFadeState: showComparison ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 250),
                firstChild: _MonthlyYearlyComparisonTable(key: _comparisonTableKey, isYearly: isYearly),
                secondChild: const SizedBox.shrink(),
              ),
              const SizedBox(height: 80),
              FaqSection(),
              const FooterSection(),
            ],
          ),
          // (No persistent checkout button)
          // --- Fancy Loader Overlay ---
         if (isProcessing)
           Positioned.fill(
             child: _FancyLoader(),
           ),
          // Success modal removed - no longer showing payment success since we're not polling
         // Error modal removed - no longer showing payment status errors since we're not polling
         if (showLoginPrompt)
           Positioned.fill(
             child: Container(
               color: Colors.black.withOpacity(0.55),
               child: Center(
                 child: Container(
                   padding: const EdgeInsets.all(32),
                   decoration: BoxDecoration(
                     color: Colors.white.withOpacity(0.10),
                     borderRadius: BorderRadius.circular(24),
                     border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.5),
                   ),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Icon(Icons.lock_outline, color: Colors.white, size: 48),
                       const SizedBox(height: 18),
                       Text(
                         'You need to log in or sign up to join Fluoverse Premium.',
                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                         ),
                         textAlign: TextAlign.center,
                       ),
                       const SizedBox(height: 24),
                       ElevatedButton.icon(
                         style: ElevatedButton.styleFrom(
                           backgroundColor: const Color(0xFF7B2FF2),
                           foregroundColor: Colors.white,
                           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                         ),
                         icon: const Icon(Icons.login),
                         label: const Text('Login / Sign Up'),
                         onPressed: () {
                           web.window.location.href = 'https://fluoverseapp.netlify.app/';
                         },
                       ),
                       const SizedBox(height: 16),
                       TextButton(
                         onPressed: () {
                           setState(() { showLoginPrompt = false; });
                         },
                         child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
        ],
      ),
    );
  }
}

class PaymentHero extends StatelessWidget {
  const PaymentHero({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withOpacity(0.18),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.10),
                  blurRadius: 32,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 44),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title first
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFFFB300), Color(0xFFFFF8E1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    "Unlock Fluoverse Premium",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      color: Colors.white,
                      letterSpacing: -1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.22),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                // Larger Lottie icon
                SizedBox(
                  height: 180,
                  child: Lottie.asset(
                    'web/assets/Premium.json',
                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                ),
                const SizedBox(height: 10),
                // Subtitle last
                Text(
                  "Choose the best plan for your journey.",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white.withOpacity(0.92),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 0.1,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.13),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MonthlyYearlyComparisonTable extends StatelessWidget {
  final bool isYearly;
  const _MonthlyYearlyComparisonTable({super.key, required this.isYearly});

  @override
  Widget build(BuildContext context) {
    // Define monthly and yearly features
    final monthlyFeatures = [
      'One Cycle per day',
      'Unlimited daily agent usage',
      'Fluency Battle Rooms',
      'Exclusive Rewards',
    ];
    
    final yearlyFeatures = [
      'One Cycle per day',
      'Unlimited daily agent usage',
      'Fluency Battle Rooms',
      'Exclusive Rewards',
      'Priority support',
      'Early access to new features',
      '1-on-1 feedback calls',
    ];
    
    final allFeatures = <String>{};
    allFeatures.addAll(monthlyFeatures);
    allFeatures.addAll(yearlyFeatures);
    final featuresList = allFeatures.toList();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF23244D), Color(0xFF181A2A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          width: 2.2,
          style: BorderStyle.solid,
          color: Colors.white.withOpacity(0.10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 44,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 120),
                Expanded(
                  child: Text(
                    'Fluoversian (monthly)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Fluoversian (yearly)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Colors.white.withOpacity(0.10),
                thickness: 1.1,
                height: 1,
              ),
            ),
            ...featuresList.map((feature) => _MonthlyYearlyComparisonRow(
              feature: feature,
              monthlyFeatures: monthlyFeatures,
              yearlyFeatures: yearlyFeatures,
            )),
          ],
        ),
      ),
    );
  }
}

class _MonthlyYearlyComparisonRow extends StatefulWidget {
  final String feature;
  final List<String> monthlyFeatures;
  final List<String> yearlyFeatures;
  const _MonthlyYearlyComparisonRow({
    required this.feature, 
    required this.monthlyFeatures, 
    required this.yearlyFeatures
  });

  @override
  State<_MonthlyYearlyComparisonRow> createState() => _MonthlyYearlyComparisonRowState();
}

class _MonthlyYearlyComparisonRowState extends State<_MonthlyYearlyComparisonRow> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    final hasMonthly = widget.monthlyFeatures.contains(widget.feature);
    final hasYearly = widget.yearlyFeatures.contains(widget.feature);
    
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: _hovering ? Colors.white.withOpacity(0.06) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                widget.feature,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.96),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.13,
                ),
              ),
            ),
            Expanded(
              child: Icon(
                hasMonthly ? Icons.check_circle_rounded : Icons.remove_circle_outline,
                color: hasMonthly ? Color(0xFF4ADE80) : Colors.white.withOpacity(0.13),
                size: 26,
              ),
            ),
            Expanded(
              child: Icon(
                hasYearly ? Icons.check_circle_rounded : Icons.remove_circle_outline,
                color: hasYearly ? Color(0xFF4ADE80) : Colors.white.withOpacity(0.13),
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComparisonRow extends StatefulWidget {
  final String feature;
  final List<Plan> plans;
  const _ComparisonRow({required this.feature, required this.plans});

  @override
  State<_ComparisonRow> createState() => _ComparisonRowState();
}

class _ComparisonRowState extends State<_ComparisonRow> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: _hovering ? Colors.white.withOpacity(0.06) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                widget.feature,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.96),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.13,
                ),
              ),
            ),
            ...widget.plans.map((p) => Expanded(
              child: Icon(
                (p.features as List).contains(widget.feature)
                    ? Icons.check_circle_rounded
                    : Icons.remove_circle_outline,
                color: (p.features as List).contains(widget.feature)
                    ? Color(0xFF4ADE80)
                    : Colors.white.withOpacity(0.13),
                size: 26,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// Add the new SaaS pricing card widget at the end of the file
class _SaasPricingCard extends StatelessWidget {
  final Plan plan;
  final bool isMain;
  final bool isSelected;
  final VoidCallback? onSelect;
  final bool isYearly;
  const _SaasPricingCard({required this.plan, this.isMain = false, this.isSelected = false, this.onSelect, this.isYearly = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final price = isYearly ? plan.yearly : plan.monthly;
    final priceText = '€${price.toStringAsFixed(2)}';
    final ctaText = 'Join Fluoverse';
    Color ctaColor, accentColor, badgeColor, hoverColor;
    // Gold color for Fluoversian/Mr Fluoverse: use a rich, deep gold
    const Color richGold = Colors.amber; // deep gold
    const Color goldAccent = Color(0xFFF5D97A); // lighter gold accent
    const Color goldBadge = Color(0xFFFFF8E1);
    // Fluoversian/Mr Fluoverse: Gold theme (rich gold)
    ctaColor = richGold;
    accentColor = goldAccent;
    badgeColor = goldBadge;
    hoverColor = richGold;
    final subText = ""; // Remove 'Billed monthly' and 'Billed yearly'
    // Features list - monthly features plus additional yearly perks
    final monthlyFeatures = [
      'One Cycle per day',
      'Unlimited daily agent usage',
      'Fluency Battle Rooms',
      'Exclusive Rewards',
    ];
    
    final yearlyAdditionalFeatures = [
      'Priority support',
      'Early access to new features',
      '1-on-1 feedback calls',
    ];
    
    final allFeatures = isYearly 
        ? [...monthlyFeatures, ...yearlyAdditionalFeatures]
        : monthlyFeatures;
    final bool isMainPlan = true; // Always true since we only have one plan
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onSelect,
        child: AnimatedScale(
          scale: isMainPlan ? 1.12 : 1.0, // Always larger for main plan
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Builder(
                builder: (context) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final isMobile = screenWidth < 700;
                  final cardWidth = isMobile ? 320.0 : (screenWidth < 2000 ? 290.0 : 380.0);
                  final cardHeight = isMobile ? 420.0 : (screenWidth < 2000 ? 500.0 : 560.0);
                  return Container(
                    width: cardWidth,
                    height: cardHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF181A2A),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        if (isMain)
                          BoxShadow(
                            color: accentColor.withOpacity(0.18),
                            blurRadius: 32,
                            offset: Offset(0, 12),
                          ),
                        if (isMainPlan)
                          BoxShadow(
                            color: Colors.amberAccent.withOpacity(0.85), // Stronger gold glow
                            blurRadius: 6,
                            spreadRadius: 2,
                            offset: Offset(0, 0),
                          ),
                      ],
                      border: Border.all(
                        color: isSelected ? ctaColor : Colors.white.withOpacity(0.08),
                        width: isMainPlan ? 4.5 : (isSelected ? 3.0 : 1.2),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // (No plan label here)
                        Center(
                          child: Text(
                            isYearly ? 'Fluoversian' : plan.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 16 : 22,
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 4 : 8),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                priceText,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: isMobile ? 22 : 32,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: isMobile ? 3 : 6),
                              Text(
                                isYearly ? '/year' : '/month',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                  fontSize: isMobile ? 11 : 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isMobile ? 1 : 2),
                        Center(
                          child: Text(
                            subText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              fontSize: isMobile ? 10 : 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 0),
                          child: Opacity(
                            opacity: 1.0, // Always show for the main plan
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: badgeColor.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '14-day free trial',
                                  style: TextStyle(
                                    color: accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _Animated3DButton(
                          color: isSelected ? ctaColor : ctaColor.withOpacity(0.7),
                          textColor: Colors.black, // Gold background with black text
                          label: ctaText,
                          borderColor: accentColor.withOpacity(0.5),
                          hoverColor: hoverColor,
                          enabled: isSelected,
                          onTap: () {
                            // Since we only have one plan, use index 0
                            final planIndex = 0;
                            final paymentScreenState = context.findAncestorStateOfType<_PaymentScreenState>();
                            final token = paymentScreenState?._extractTokenFromUrl();
                            if (token == null) {
                              // Show login/signup modal instead of redirecting immediately
                              if (paymentScreenState != null) {
                                paymentScreenState.setState(() {
                                  paymentScreenState.showLoginPrompt = true;
                                });
                              }
                              return;
                            }
                            if (paymentScreenState != null) {
                              paymentScreenState._startStripePaymentFor(planIndex, isYearly);
                            }
                          },
                        ),
                        const SizedBox(height: 18),
                        ...allFeatures.map((feature) {
                          // Show all features for the current billing period
                          // All features in this list are included
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: isMobile ? 2 : 3),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: accentColor,
                                  size: isMobile ? 14 : 18,
                                ),
                                SizedBox(width: isMobile ? 5 : 8),
                                Text(
                                  feature,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isMobile ? 12 : 15,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
              if (isMainPlan && isYearly)
                Positioned(
                  top: -22,
                  right: -22,
                  child: SizedBox(
                    height: 64,
                    width: 64,
                    child: Lottie.asset(
                      'web/assets/Sale.json',
                      repeat: true,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              if (isMainPlan && !isYearly)
                Positioned(
                  top: -22,
                  right: 22,
                  child: SizedBox(
                    height: 64,
                    width: 64,
                    child: Lottie.asset(
                      'web/assets/Hot.json',
                      repeat: true,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Modern animated 3D button
class _Animated3DButton extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String label;
  final Color borderColor;
  final Color hoverColor; // plan color for hover
  final VoidCallback onTap;
  final bool enabled;
  const _Animated3DButton({
    required this.color,
    required this.textColor,
    required this.label,
    required this.onTap,
    this.borderColor = Colors.transparent,
    required this.hoverColor,
    this.enabled = true,
  });

  @override
  State<_Animated3DButton> createState() => _Animated3DButtonState();
}

class _Animated3DButtonState extends State<_Animated3DButton> {
  double _scale = 1.0;
  bool _hovering = false;

  void _onEnter(PointerEnterEvent event) {
    if (widget.enabled) setState(() => _hovering = true);
  }

  void _onExit(PointerExitEvent event) {
    if (widget.enabled) setState(() => _hovering = false);
  }

  @override
  Widget build(BuildContext context) {
    // Neon colors for non-hover
    const Color neonPink = Color(0xFFFF2D8B);
    const Color neonBlue = Color(0xFF3B6CFF);
    final Color darkBg = const Color(0xFF181A1B);
    final Color textColor = _hovering ? Colors.black : Colors.white;
    final Color bgColor = _hovering ? widget.hoverColor : darkBg;
    final List<BoxShadow> glow = _hovering || !widget.enabled
        ? []
        : [
            BoxShadow(
              color: neonPink.withOpacity(0.45),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(-4, 4),
            ),
            BoxShadow(
              color: neonBlue.withOpacity(0.45),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(4, -4),
            ),
          ];
    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.forbidden,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTapDown: (_) {
          if (widget.enabled) setState(() => _scale = 0.96);
        },
        onTapUp: (_) {
          if (widget.enabled) setState(() => _scale = 1.0);
        },
        onTapCancel: () {
          if (widget.enabled) setState(() => _scale = 1.0);
        },
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: widget.enabled ? 1.0 : 0.6,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: bgColor,
                boxShadow: glow,
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: textColor,
                    letterSpacing: 0.2,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(widget.label),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GlassmorphicSuccessPopup extends StatelessWidget {
  final VoidCallback? onContinue;
  const GlassmorphicSuccessPopup({super.key, this.onContinue});

  @override
  Widget build(BuildContext context) {
    // Accent gradient for border and button
    final Gradient accentGradient = const LinearGradient(
      colors: [Color(0xFF7B2FF2), Color(0xFFF5D97A), Color(0xFF3B6CFF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: 380,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white.withOpacity(0.10),
            border: Border.all(
              width: 2.5,
              style: BorderStyle.solid,
              color: Colors.white.withOpacity(0.18),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 32,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return accentGradient.createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: Icon(Icons.celebration, size: 72, color: Colors.white),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 90,
                child: Lottie.asset(
                  'web/assets/Paid.json',
                  fit: BoxFit.contain,
                  repeat: false,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Welcome to Fluoverse!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color(0xFF7B2FF2), // Use a solid accent color
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Your premium journey begins now.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white.withOpacity(0.92),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.13),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: _Animated3DButton(
                  color: Color(0xFF7B2FF2),
                  textColor: Colors.white,
                  label: 'Continue',
                  hoverColor: Color(0xFFF5D97A),
                  enabled: true,
                  onTap: onContinue ?? () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlassmorphicErrorPopup extends StatelessWidget {
  final String message;
  final bool showRetryButton;
  final void Function()? onRetry;
  final bool isRetrying;
  
  const GlassmorphicErrorPopup({
    super.key, 
    required this.message,
    this.showRetryButton = false,
    this.onRetry,
    this.isRetrying = false,
  });

  @override
  Widget build(BuildContext context) {
    final Gradient accentGradient = const LinearGradient(
      colors: [Color(0xFF7B2FF2), Color(0xFFE53935), Color(0xFF3B6CFF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            width: 380,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 44),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white.withOpacity(0.10),
              border: Border.all(
                width: 2.5,
                style: BorderStyle.solid,
                color: Colors.white.withOpacity(0.18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 32,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return accentGradient.createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Icon(Icons.error_rounded, size: 72, color: Colors.white),
                ),
                const SizedBox(height: 18),
                Text(
                  'Payment Error',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFFE53935), // Use a solid accent color
                    letterSpacing: -0.5,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.92),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.13),
                        blurRadius: 8,
                      ),
                    ],
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 32),
                if (showRetryButton && onRetry != null) ...[
                  SizedBox(
                    width: double.infinity,
                    child: _Animated3DButton(
                      color: Color(0xFF7B2FF2),
                      textColor: Colors.white,
                      label: isRetrying ? 'Checking...' : 'Retry Payment Check',
                      hoverColor: Color(0xFFE53935),
                      enabled: !isRetrying,
                      onTap: isRetrying ? () {} : () {
                        Navigator.of(context).pop();
                        onRetry!();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                SizedBox(
                  width: double.infinity,
                  child: _Animated3DButton(
                    color: Color(0xFFE53935),
                    textColor: Colors.white,
                    label: 'Close',
                    hoverColor: Color(0xFF7B2FF2),
                    enabled: true,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Premium FAQ Section ---
class FaqSection extends StatelessWidget {
  final List<_FaqItem> faqs = const [
    _FaqItem(
      icon: Icons.autorenew_rounded,
      iconColor: Color(0xFFF87171),
      question: 'What exactly is a "cycle"?',
      answer:
          'A complete learning sequence: Vocabulary → Reading → Listening → Scenario. Each cycle takes 15 – 20 minutes and builds real fluency.',
    ),
    _FaqItem(
      icon: Icons.swap_horiz_rounded,
      iconColor: Color(0xFFF87171),
      question: 'Can I change plans anytime?',
      answer:
          'Absolutely! Upgrade or downgrade your plan whenever you want. Changes take effect immediately.',
    ),
    _FaqItem(
      icon: Icons.mic_rounded,
      iconColor: Color(0xFFF87171),
      question: 'Do I need special equipment?',
      answer:
          'Just a microphone! Our AI works with any device that can record audio - computer, phone, or tablet.',
    ),
    _FaqItem(
      icon: Icons.groups_rounded,
      iconColor: Color(0xFFF87171),
      question: 'When do Fluency Rooms launch?',
      answer:
          'Multi-user Fluency Rooms are coming this quarter! Join our waitlist to get early access.',
    ),
  ];

  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return Column(
      children: [
        const SizedBox(height: 32),
        Text(
          'Questions & Answers',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'Everything you need to know about your Spanish learning journey',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 36),
        LayoutBuilder(
          builder: (context, constraints) {
            return Wrap(
              spacing: 32,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: faqs.map((faq) {
                return _FaqCard(faq: faq, width: isWide ? 420 : constraints.maxWidth - 48);
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}

class _FaqItem {
  final IconData icon;
  final Color iconColor;
  final String question;
  final String answer;
  const _FaqItem({
    required this.icon,
    required this.iconColor,
    required this.question,
    required this.answer,
  });
}

class _FaqCard extends StatefulWidget {
  final _FaqItem faq;
  final double? width;
  const _FaqCard({required this.faq, this.width});

  @override
  State<_FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<_FaqCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    // Fixed size for all cards
    const double cardWidth = 380;
    const double cardHeight = 210;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.01 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          width: cardWidth,
          height: cardHeight,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
          decoration: BoxDecoration(
            color: const Color(0xF0181A2A),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _hovering ? Colors.white.withOpacity(0.18) : Colors.white.withOpacity(0.08),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.13),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.faq.icon, color: widget.faq.iconColor, size: 28),
              const SizedBox(height: 12),
              Text(
                widget.faq.question,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.faq.answer,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.85),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Fancy Loader Widget ---
class _FancyLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred dark overlay
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              color: Colors.black.withOpacity(0.55),
            ),
          ),
        ),
        // Centered fancy loader
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Glowing animated spinner
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.45),
                      blurRadius: 48,
                      spreadRadius: 8,
                    ),
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.18),
                      blurRadius: 32,
                      spreadRadius: 2,
                    ),
                  ],
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF5D97A), Color(0xFFBFA14A), Color(0xFF7C3AED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 7,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF5D97A)),
                    backgroundColor: Colors.white.withOpacity(0.13),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Color(0xFFF5D97A), Color(0xFFBFA14A), Color(0xFF7C3AED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Text(
                  "Redirecting to secure payment...",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Please wait, do not close this window.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 15,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
