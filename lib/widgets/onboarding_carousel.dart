import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:go_router/go_router.dart'; // Unused

class OnboardingTour extends StatefulWidget {
  final Map<String, GlobalKey> targets;
  final List<TourStep> steps;
  final VoidCallback onComplete;

  const OnboardingTour({
    super.key,
    required this.targets,
    required this.steps,
    required this.onComplete,
  });

  @override
  State<OnboardingTour> createState() => _OnboardingTourState();
}

// Global callback for mobile menu action
class OnboardingTourCallback {
  static VoidCallback? _onMobileMenuOpened;
  static VoidCallback? _onMobileMenuClosed;
  static VoidCallback? _openMobileMenu;
  static VoidCallback? _closeMobileMenu;
  
  static void setMobileMenuCallback(VoidCallback callback) {
    _onMobileMenuOpened = callback;
  }
  
  static void setMobileMenuClosedCallback(VoidCallback callback) {
    _onMobileMenuClosed = callback;
  }
  
  static void notifyMobileMenuOpened() {
    _onMobileMenuOpened?.call();
  }

  static void notifyMobileMenuClosed() {
    _onMobileMenuClosed?.call();
  }

  // Allows UI (e.g., overlay) to trigger opening the mobile menu programmatically
  static void setOpenMobileMenu(VoidCallback? callback) {
    _openMobileMenu = callback;
  }

  static void setCloseMobileMenu(VoidCallback? callback) {
    _closeMobileMenu = callback;
  }

  static void triggerOpenMobileMenu() {
    _openMobileMenu?.call();
  }

  static void triggerCloseMobileMenu() {
    _closeMobileMenu?.call();
  }
}

class _OnboardingTourState extends State<OnboardingTour> with TickerProviderStateMixin {
  int _currentStep = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Rect _targetRect = Rect.zero;
  bool _waitingForAction = false;
  bool _isCompleted = false;
  // ScrollController? _scrollController; // No longer used
  List<TourStep> _filteredSteps = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _filteredSteps = List.from(widget.steps); // Initialize with all steps
    
    // Set up the global callbacks for mobile menu
    OnboardingTourCallback.setMobileMenuCallback(_onMobileMenuOpened);
    OnboardingTourCallback.setMobileMenuClosedCallback(_onMobileMenuClosed);

    // Filter steps and start tour after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filterSteps(); // Now filters the already initialized list
      _startTour();
    });
  }

  void _filterSteps() {
    final isMobileOrTablet = kIsWeb 
        ? MediaQuery.of(context).size.width < 900 
        : MediaQuery.of(context).size.width < 900;
    
    _filteredSteps = widget.steps.where((step) {
      // Skip mobile menu step for desktop/laptop
      if (step.targetKey == 'mobile-menu-button' && !isMobileOrTablet) {
        print('🚫 Skipping mobile menu step for desktop/laptop');
        return false;
      }
      // Skip close menu step for desktop/laptop
      if (step.targetKey == 'close-mobile-menu' && !isMobileOrTablet) {
        print('🚫 Skipping close menu step for desktop/laptop');
        return false;
      }
      // Skip second step (step 2) for mobile/tablet
      if (step.step == 2 && isMobileOrTablet) {
        print('🚫 Skipping second step for mobile/tablet');
        return false;
      }
      return true;
    }).toList();
    
    // Update step numbers
    for (int i = 0; i < _filteredSteps.length; i++) {
      _filteredSteps[i] = TourStep(
        step: i + 1,
        total: _filteredSteps.length,
        title: _filteredSteps[i].title,
        description: _filteredSteps[i].description,
        targetKey: _filteredSteps[i].targetKey,
        action: _filteredSteps[i].action,
        requiresAction: _filteredSteps[i].requiresAction,
      );
    }
    
    print('📱 Device type: ${isMobileOrTablet ? "Mobile/Tablet" : "Desktop/Laptop"}');
    print('📋 Filtered steps: ${_filteredSteps.length} (original: ${widget.steps.length})');
    
    // Debug: Print all filtered steps
    for (int i = 0; i < _filteredSteps.length; i++) {
      print('  Step ${i + 1}: ${_filteredSteps[i].targetKey} (requiresAction: ${_filteredSteps[i].requiresAction})');
    }
  }

  // Removed noisy scroll controller probing; we now use ensureVisible directly in _scrollToTarget.

  void _startTour() {
    if (mounted) {
      print('🚀 Starting tour with ${_filteredSteps.length} steps');
      print('🎯 Current step: ${_currentStep + 1} - ${_filteredSteps[_currentStep].targetKey} (waitingForAction: $_waitingForAction)');
      _measureCurrentTarget();
      _scrollToTarget();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    print('🎯 OnboardingTour dispose called');
    _animationController.dispose();
    // Clean up global callbacks
    OnboardingTourCallback.setOpenMobileMenu(null);
    OnboardingTourCallback.setCloseMobileMenu(null);
    super.dispose();
  }

  void _measureCurrentTarget() {
    final targetKey = _filteredSteps[_currentStep].targetKey;
    
    // Special handling for close-mobile-menu step - target the mobile menu button
    if (targetKey == 'close-mobile-menu') {
      // Use the mobile menu button as the target since it becomes the close button when menu is open
      final key = widget.targets['mobile-menu-button'];
      if (key?.currentContext != null) {
        try {
          final renderBox = key!.currentContext!.findRenderObject() as RenderBox;
          final position = renderBox.localToGlobal(Offset.zero);
          _targetRect = position & renderBox.size;
          print('✅ Measured close menu target (mobile menu button): $_targetRect');
        } catch (e) {
          print('❌ Error measuring close menu target: $e');
          // Fallback to center of screen
          final screenSize = MediaQuery.of(context).size;
          _targetRect = Rect.fromCenter(
            center: Offset(screenSize.width / 2, screenSize.height / 2),
            width: 1,
            height: 1,
          );
        }
      } else {
        // Fallback to center of screen
        final screenSize = MediaQuery.of(context).size;
        _targetRect = Rect.fromCenter(
          center: Offset(screenSize.width / 2, screenSize.height / 2),
          width: 1,
          height: 1,
        );
      }
      return;
    }
    
    // Check if this is a navigation item that requires the mobile menu to be open
    final navItems = <String>{
      'nav-home',
      'nav-how-it-works', 
      'nav-features',
      'nav-pricing',
      'nav-contact',
      'get-started-button',
    };
    
    if (navItems.contains(targetKey)) {
      // Add a small delay to ensure the mobile menu is fully open before measuring
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _measureTargetImmediate(targetKey);
        }
      });
      return;
    }
    
    _measureTargetImmediate(targetKey);
  }
  
  void _measureTargetImmediate(String targetKey) {
    
    final key = widget.targets[targetKey];
    
    // For mobile and tablet, don't highlight anything on the first step
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobileOrTablet = screenWidth < 1200; // Tablets are typically < 1200px
    if (isMobileOrTablet && _currentStep == 0 && targetKey == 'hero-section') {
      // Create an invisible 1x1 pixel target in the center of the screen
      final screenSize = MediaQuery.of(context).size;
      _targetRect = Rect.fromCenter(
        center: Offset(screenSize.width / 2, screenSize.height / 2),
        width: 1,
        height: 1,
      );
      print('✅ Mobile/Tablet first step - no highlight, invisible target at center');
      return;
    }
    
    if (key?.currentContext == null) {
      print('⚠️ Target widget not found: $targetKey');
      // Use fallback position
      final screenSize = MediaQuery.of(context).size;
      _targetRect = Rect.fromLTWH(
        screenSize.width * 0.1,
        screenSize.height * 0.2,
        screenSize.width * 0.8,
        100,
      );
      return;
    }

    try {
      final renderBox = key!.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      _targetRect = position & renderBox.size;
      
      // Make the first step (hero section) highlight smaller in height (desktop only)
      if (_currentStep == 0 && targetKey == 'hero-section' && !isMobileOrTablet) {
        final centerY = _targetRect.center.dy;
        final newHeight = _targetRect.height * 0.8;
        _targetRect = Rect.fromCenter(
          center: Offset(_targetRect.center.dx, centerY),
          width: _targetRect.width,
          height: newHeight,
        );
      }
      
      // Make the launch app button highlight slightly bigger
      if (targetKey == 'launch-app-button') {
        _targetRect = _targetRect.inflate(8);
      }
      
      print('✅ Measured target $targetKey: $_targetRect');
      
      // Trigger a rebuild to update the overlay with the new target position
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('❌ Error measuring target $targetKey: $e');
      // Use fallback position
      final screenSize = MediaQuery.of(context).size;
      _targetRect = Rect.fromLTWH(
        screenSize.width * 0.1,
        screenSize.height * 0.2,
        screenSize.width * 0.8,
        100,
      );
    }
  }

  void _scrollToTarget() {
    // Prefer ensureVisible on the target context; if no scrollable ancestor exists, just skip silently
    final targetKey = _filteredSteps[_currentStep].targetKey;
    
    // Skip scrolling for the final step (launch-app-button) to avoid unnecessary movement
    if (targetKey == 'launch-app-button') {
      print('🚫 Skipping scroll for final step to keep button visible');
      return;
    }
    
    final key = widget.targets[targetKey];
    final targetContext = key?.currentContext;
    if (targetContext == null) return;
    try {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.2,
      );
    } catch (_) {
      // No-op if there is no scrollable ancestor
    }
  }

  void _nextStep() {
    if (_currentStep < _filteredSteps.length - 1) {
      setState(() => _currentStep++);
      _waitingForAction = _filteredSteps[_currentStep].requiresAction;
      print('🔄 Next step: ${_currentStep + 1} - ${_filteredSteps[_currentStep].targetKey} (waitingForAction: $_waitingForAction)');
      _measureCurrentTarget();
      _scrollToTarget();
      _animationController.reset();
      _animationController.forward();
    } else {
      print('🎯 Final step completed, automatically closing tour');
      _completeTour();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _waitingForAction = _filteredSteps[_currentStep].requiresAction;
      _measureCurrentTarget();
      _scrollToTarget();
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _completeTour() {
    print('🎯 Tour completion started');
    // Immediately stop rendering overlay in this widget
    if (mounted) {
      setState(() {
        _isCompleted = true;
      });
    }

    // Force the animation to 0 and stop any running animations
    _animationController.stop();
    _animationController.value = 0.0;

    // Immediately notify parent to unmount this widget
    if (mounted) {
      print('🎯 Immediately calling onComplete callback');
      widget.onComplete();
    }
  }

  void _onActionCompleted() {
    if (_waitingForAction) {
      setState(() => _waitingForAction = false);
      _nextStep();
    }
  }

  void _onMobileMenuOpened() {
    // This is called when the mobile menu is opened
    print('🎯 Mobile menu opened! Current step: ${_currentStep + 1}, waiting: $_waitingForAction, target: ${_filteredSteps.isNotEmpty ? _filteredSteps[_currentStep].targetKey : "no steps"}');
    
    // Add a longer delay to ensure the menu animation is complete before proceeding
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted && _waitingForAction && _filteredSteps.isNotEmpty && _filteredSteps[_currentStep].targetKey == 'mobile-menu-button') {
        print('✅ Mobile menu action completed, proceeding to next step');
        setState(() {
          _waitingForAction = false;
        });
        _nextStep();
      } else {
        print('⚠️ Mobile menu opened but not waiting for action or wrong step. Current step: ${_currentStep + 1}, waiting: $_waitingForAction, target: ${_filteredSteps.isNotEmpty ? _filteredSteps[_currentStep].targetKey : "no steps"}');
        print('📋 All steps: ${_filteredSteps.map((s) => '${s.step}:${s.targetKey}').join(', ')}');
      }
    });
  }

  void _onMobileMenuClosed() {
    // This is called when the mobile menu is closed
    print('🎯 Mobile menu closed! Current step: ${_currentStep + 1}, waiting: $_waitingForAction, target: ${_filteredSteps.isNotEmpty ? _filteredSteps[_currentStep].targetKey : "no steps"}');
    
    // Add a small delay to ensure the tour state is properly set
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted && _waitingForAction && _filteredSteps.isNotEmpty && _filteredSteps[_currentStep].targetKey == 'close-mobile-menu') {
        print('✅ Mobile menu close action completed, proceeding to next step');
        setState(() {
          _waitingForAction = false;
        });
        _nextStep();
      } else {
        print('⚠️ Mobile menu closed but not waiting for action or wrong step. Current step: ${_currentStep + 1}, waiting: $_waitingForAction, target: ${_filteredSteps.isNotEmpty ? _filteredSteps[_currentStep].targetKey : "no steps"}');
        print('📋 All steps: ${_filteredSteps.map((s) => '${s.step}:${s.targetKey}').join(', ')}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isCompleted) {
      // Do not render anything once completed; prevents any lingering overlay
      return const SizedBox.shrink();
    }
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        // Only show the overlay if the animation is not at 0
        if (_fadeAnimation.value <= 0) {
          return const SizedBox.shrink();
        }
        
        return IgnorePointer(
          ignoring: _fadeAnimation.value <= 0,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: _TourOverlay(
              rect: _targetRect,
              step: _filteredSteps[_currentStep],
              onNext: _waitingForAction ? null : _nextStep,
              onPrevious: _waitingForAction ? null : _previousStep,
              onSkip: _completeTour,
              waitingForAction: _waitingForAction,
              onActionCompleted: _onActionCompleted,
            ),
          ),
        );
      },
    );
  }
}

class _TourOverlay extends StatelessWidget {
  final Rect rect;
  final TourStep step;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final VoidCallback onSkip;
  final bool waitingForAction;
  final VoidCallback onActionCompleted;

  const _TourOverlay({
    required this.rect,
    required this.step,
    required this.onNext,
    required this.onPrevious,
    required this.onSkip,
    required this.waitingForAction,
    required this.onActionCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final popupPosition = _calculatePopupPosition(screenSize);
    final isMobileMenuStep = step.targetKey == 'mobile-menu-button';
    final isCloseMobileMenuStep = step.targetKey == 'close-mobile-menu';

    if (isMobileMenuStep) {
      print('🎯 Mobile menu step active - overlay will forward taps to open menu');
    }
    
    if (isCloseMobileMenuStep) {
      print('🎯 Close mobile menu step active - overlay will forward taps to close menu');
    }

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Dark overlay with transparent hole
          Positioned.fill(
            child: ClipPath(
              clipper: isMobileMenuStep ? _MobileMenuSpotlightClipper(rect) : _SpotlightClipper(rect),
              child: Container(color: Colors.black.withOpacity(0.7)),
            ),
          ),

          // Blue border around the hole
          Positioned(
            left: rect.left - 2,
            top: rect.top - 2,
            child: Container(
              width: rect.width + 4,
              height: rect.height + 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue, width: 2),
              ),
            ),
          ),

          // For the mobile menu step, capture taps in the hole and programmatically open the menu
          if (isMobileMenuStep)
            Positioned(
              left: rect.left - 8,
              top: rect.top - 8,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  print('🎯 Overlay hole tapped -> triggering openMobileMenu');
                  OnboardingTourCallback.triggerOpenMobileMenu();
                },
                child: SizedBox(
                  width: rect.width + 16,
                  height: rect.height + 16,
                ),
              ),
            ),

          // For the close mobile menu step, capture taps in the hole and programmatically close the menu
          if (isCloseMobileMenuStep)
            Positioned(
              left: rect.left - 8,
              top: rect.top - 8,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  print('🎯 Close button tapped -> triggering closeMobileMenu');
                  OnboardingTourCallback.triggerCloseMobileMenu();
                },
                child: SizedBox(
                  width: rect.width + 16,
                  height: rect.height + 16,
                ),
              ),
            ),



          // Tour popup
          Positioned(
            left: popupPosition.dx,
            top: popupPosition.dy,
            child: _TourCard(
              step: step,
              onNext: onNext,
              onPrevious: onPrevious,
              onSkip: onSkip,
              waitingForAction: waitingForAction,
              onActionCompleted: onActionCompleted,
            ),
          ),

          // Skip button
          Positioned(
            bottom: 24,
            right: 20,
            child: _SkipButton(onSkip: onSkip),
          ),
        ],
      ),
    );
  }

    Offset _calculatePopupPosition(Size screenSize) {
    const popupWidth = 280.0; // Smaller width
    const popupHeight = 180.0; // Smaller height
    const margin = 16.0;
    
         // Special handling for mobile menu button
     if (step.targetKey == 'mobile-menu-button') {
       // Check if this is mobile/tablet
       final isMobileOrTablet = screenSize.width < 1200;
       
       double dx = (screenSize.width / 2 - popupWidth / 2).clamp(margin, screenSize.width - popupWidth - margin);
       double dy;
       
       if (isMobileOrTablet) {
         // For mobile/tablet, position higher up (around 1/3 from top)
         dy = screenSize.height * 0.3;
       } else {
         // For desktop, position at bottom
         dy = screenSize.height - popupHeight - margin;
       }
       
       return Offset(dx, dy);
     }
    
         // Special handling for close mobile menu step
     if (step.targetKey == 'close-mobile-menu') {
       // Position at top-center
       double dx = (screenSize.width / 2 - popupWidth / 2).clamp(margin, screenSize.width - popupWidth - margin);
       double dy = margin;
       return Offset(dx, dy);
     }
     
           // Special handling for launch app button (final step)
      if (step.targetKey == 'launch-app-button') {
        // Check if this is mobile/tablet
        final isMobileOrTablet = screenSize.width < 1200;
        
        double dx = (screenSize.width / 2 - popupWidth / 2).clamp(margin, screenSize.width - popupWidth - margin);
        double dy;
        
                 if (isMobileOrTablet) {
           // For mobile/tablet, position much higher up to completely avoid covering the button
           dy = screenSize.height * 0.45; // Position at 15% from top instead of just margin
         } else {
          // For desktop/laptop, position to the left of the button to avoid covering it
          dy = rect.center.dy - popupHeight / 2;
          dx = rect.left - popupWidth - margin; // Position to the left
          
          // If it doesn't fit to the left, position above
          if (dx < margin) {
            dx = (screenSize.width / 2 - popupWidth / 2).clamp(margin, screenSize.width - popupWidth - margin);
            dy = rect.top - popupHeight - margin;
          }
        }
        
        // Clamp to screen bounds
        dy = dy.clamp(margin, screenSize.height - popupHeight - margin);
        
        return Offset(dx, dy);
      }
    
    // Prefer placing the card ABOVE the target for nav items and CTA so the target stays visible
    final placeAboveTargets = <String>{
      'nav-home',
      'nav-how-it-works',
      'nav-features',
      'nav-pricing',
      'nav-contact',
      'get-started-button',
    };

    double dx = (rect.left + rect.width / 2 - popupWidth / 2)
        .clamp(margin, screenSize.width - popupWidth - margin);

    // For nav items and CTA buttons, ALWAYS place above with extra margin
    bool isNavOrCTA = placeAboveTargets.contains(step.targetKey);
    double dy;
    
    if (isNavOrCTA) {
      // Place above with extra margin to ensure target is visible
      dy = rect.top - popupHeight - 120; // Much more margin
    } else {
      // For other elements, try below first
      dy = rect.bottom + margin;
    }

    // If it doesn't fit above, try below (but only for nav/CTA items)
    if (isNavOrCTA && dy < margin) {
      dy = rect.bottom + margin;
    } else if (!isNavOrCTA && dy + popupHeight > screenSize.height - margin) {
      dy = rect.top - popupHeight - margin;
    }
    
    // Clamp to screen bounds
    dy = dy.clamp(margin, screenSize.height - popupHeight - margin);
    
    return Offset(dx, dy);
  }
}

class _SpotlightClipper extends CustomClipper<Path> {
  final Rect rect;
  
  _SpotlightClipper(this.rect);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(10)));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper is _SpotlightClipper && oldClipper.rect != rect;
  }
}

class _MobileMenuSpotlightClipper extends CustomClipper<Path> {
  final Rect rect;
  
  _MobileMenuSpotlightClipper(this.rect);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    // Create a larger hole for the mobile menu button to ensure touch events pass through
    final expandedRect = rect.inflate(4);
    path.addRRect(RRect.fromRectAndRadius(expandedRect, const Radius.circular(12)));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper is _MobileMenuSpotlightClipper && oldClipper.rect != rect;
  }
}

class _TourCard extends StatelessWidget {
  final TourStep step;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final VoidCallback onSkip;
  final bool waitingForAction;
  final VoidCallback onActionCompleted;

  const _TourCard({
    required this.step,
    required this.onNext,
    required this.onPrevious,
    required this.onSkip,
    required this.waitingForAction,
    required this.onActionCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // Match the smaller width
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${step.step}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  step.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            step.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Progress indicator
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: step.step / step.total,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${step.step}/${step.total}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Action buttons
          Row(
            children: [
              if (step.step > 1 && !waitingForAction) // Previous button always available unless waiting for action
                TextButton(
                  onPressed: onPrevious,
                  child: const Text(
                    'Previous',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                )
              else if (waitingForAction && step.targetKey != 'mobile-menu-button' && step.targetKey != 'close-mobile-menu') // Spacer for other action steps
                const SizedBox(width: 80)
              else if (!waitingForAction) // Spacer for first step (no previous)
                const SizedBox(width: 80),
              
              const Spacer(),
              
              if (waitingForAction)
                if (step.targetKey == 'mobile-menu-button' || step.targetKey == 'close-mobile-menu')
                  const SizedBox.shrink() // No button for mobile menu action steps
                else
                  ElevatedButton(
                    onPressed: onActionCompleted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'I did it!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                             else
                 ElevatedButton(
                   onPressed: () {
                     // For the final step, complete the tour immediately
                     if (step.targetKey == 'launch-app-button') {
                       print('🎯 Final step button clicked - completing tour immediately');
                       // Call onComplete directly to bypass any animation issues
                       print('🎯 Direct completion for final step');
                       onSkip(); // This calls _completeTour()
                     } else {
                       onNext?.call();
                     }
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.blue,
                     foregroundColor: Colors.white,
                     padding: const EdgeInsets.symmetric(
                       horizontal: 24,
                       vertical: 12,
                     ),
                     elevation: 0,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),
                     ),
                   ),
                   child: Text(
                     step.action,
                     style: const TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  final VoidCallback onSkip;

  const _SkipButton({required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSkip,
      style: TextButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        'Skip Tour',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class TourStep {
  final int step;
  final int total;
  final String title;
  final String description;
  final String targetKey;
  final String action;
  final bool requiresAction;

  TourStep({
    required this.step,
    required this.total,
    required this.title,
    required this.description,
    required this.targetKey,
    required this.action,
    this.requiresAction = false,
  });
}
