// ignore_for_file: deprecated_member_use, unused_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/homepage.dart';
import '../screens/how_it_works.dart';
import '../screens/features.dart';
import '../screens/pricing.dart';
import '../screens/get_started.dart'; // Import GetStartedScreen
import '../screens/contact.dart'; // Import ContactScreen

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Use mobile navigation bar for small screens
    if (width < 900) {
      return _MobileNavigationBar();
    }
    
    // Calculate responsive padding based on screen width
    final double horizontalPadding = width < 1100 ? 16.0 : (width < 1400 ? 20.0 : 48.0);
    final double spacing = width < 1100 ? 8.0 : (width < 1400 ? 12.0 : 32.0);
    
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 18),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: const Border(
            bottom: BorderSide(
              color: Color(0xFFE5E9F2),
              width: 1.2,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.04),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            _BrandLogo(),
            const Spacer(),
            _NavButtonBar(),
            SizedBox(width: spacing),
            _PremiumButton(),
          ],
        ),
      ),
    );
  }
}

class _BrandLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double logoSize = width < 900 ? 36 : (width < 1100 ? 36 : (width < 1400 ? 38 : 44));
    final double fontSize = width < 900 ? 22 : (width < 1100 ? 24 : (width < 1400 ? 26 : 32));
    final double spacing = width < 900 ? 10 : (width < 1100 ? 8 : (width < 1400 ? 10 : 16));
    
    return Row(
      children: [
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 255, 255),  Color.fromARGB(100, 136, 0, 255)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.30),
                blurRadius: 4,
                offset: Offset(-2, 4),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'web/assets/android-chrome-192x192.png',
              width: logoSize * 0.65,
              height: logoSize * 0.65,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: spacing),
        Text(
          'Fluoverse',
          style: TextStyle(
            foreground: Paint()
              ..shader = LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              ).createShader(Rect.fromLTWH(0, 0, 200, 40)),
            fontWeight: FontWeight.w900,
            fontSize: fontSize,
            letterSpacing: 1.5,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }
}

class _NavButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Hide nav buttons on mobile, show only on desktop/tablet
    if (width < 900) return SizedBox.shrink();

    // Get current route name
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    // Helper to check if this button is selected
    bool isSelected(String routeName) => currentRoute == routeName;

    return Row(
      children: [
        _NavButton(
          label: 'Home',
          icon: Icons.home_outlined,
          selected: isSelected('/'),
          onTap: () {
            if (!isSelected('/')) {
              context.go('/');
            }
          },
        ),
        _PremiumDivider(),
        _NavButton(
          label: 'How It Works',
          icon: Icons.info_outline,
          selected: isSelected('/how-it-works'),
          onTap: () {
            if (!isSelected('/how-it-works')) {
              context.go('/how-it-works');
            }
          },
        ),
        _PremiumDivider(),
        _NavButton(
          label: 'Features',
          icon: Icons.star_outline,
          selected: isSelected('/features'),
          onTap: () {
            if (!isSelected('/features')) {
              context.go('/features');
            }
          },
        ),
        _PremiumDivider(),
        _NavButton(
          label: 'Pricing',
          icon: Icons.attach_money_outlined,
          selected: isSelected('/pricing'),
          onTap: () {
            if (!isSelected('/pricing')) {
              context.go('/pricing');
            }
          },
        ),
        _PremiumDivider(),
        _NavButton(
          label: 'Contact',
          icon: Icons.mail_outline,
          selected: isSelected('/contact'),
          onTap: () {
            if (!isSelected('/contact')) {
              context.go('/contact');
            }
          },
        ),
      ],
    );
  }
}

class _PremiumDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Hide divider on mobile for a cleaner look
    if (width < 900) return SizedBox.shrink();
    
    // Use smaller margin on laptop screens
    final double margin = width < 1100 ? 2.0 : (width < 1400 ? 3.0 : 8.0);
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      height: 28,
      width: 1.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E5BFF), Color(0xFF00C6FB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;

  const _NavButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.selected = false,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final underlineColor = Color(0xFF2E5BFF);
    final bool isActive = widget.selected;
    final width = MediaQuery.of(context).size.width;

    // Hide nav buttons on mobile
    if (width < 900) return SizedBox.shrink();

    // Responsive sizing for laptop screens
    final bool isSmallLaptop = width < 1100;
    final bool isLaptop = width < 1400;
    final double horizontalPadding = isActive 
        ? (isSmallLaptop ? 12.0 : (isLaptop ? 16.0 : 28.0))
        : (isSmallLaptop ? 8.0 : (isLaptop ? 12.0 : 18.0));
    final double verticalPadding = isActive 
        ? (isSmallLaptop ? 8.0 : (isLaptop ? 10.0 : 14.0))
        : (isSmallLaptop ? 4.0 : (isLaptop ? 6.0 : 10.0));
    final double fontSize = isSmallLaptop ? 13.0 : (isLaptop ? 14.0 : 17.0);
    final double iconSize = isSmallLaptop ? 14.0 : (isLaptop ? 16.0 : 20.0);
    final double iconSpacing = isSmallLaptop ? 2.0 : (isLaptop ? 3.0 : 6.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: isActive
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E5BFF), Color(0xFF00C6FB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.18),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              )
            : BoxDecoration(
                color: _hovering ? Colors.blue.withOpacity(0.06) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: _hovering
                    ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.10),
                          blurRadius: 16,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
        child: InkWell(
          borderRadius: BorderRadius.circular(isActive ? 28 : 10),
          onTap: widget.onTap,
          splashColor: Colors.blue.withOpacity(0.12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      widget.icon,
                      color: isActive
                          ? Colors.white
                          : (_hovering ? underlineColor : Color(0xFF2E5BFF)),
                      size: iconSize,
                    ),
                    SizedBox(width: iconSpacing),
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: isActive
                            ? Colors.white
                            : (_hovering ? underlineColor : Color(0xFF263159)),
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.7,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                AnimatedUnderline(
                  show: _hovering || isActive,
                  width: isSmallLaptop ? 28 : (isLaptop ? 32 : 38),
                  color: isActive ? Colors.white : underlineColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumButton extends StatefulWidget {
  @override
  State<_PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<_PremiumButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Responsive sizing for different screen sizes
    final isMobile = width < 900;
    final isSmallLaptop = width < 1100;
    final isLaptop = width < 1400;
    
    // Calculate responsive padding and sizes
    final double horizontalPadding = isMobile 
        ? 22.0 
        : (isSmallLaptop ? 20.0 : (isLaptop ? 24.0 : 38.0));
    final double verticalPadding = isMobile 
        ? 12.0 
        : (isSmallLaptop ? 10.0 : (isLaptop ? 12.0 : 18.0));
    final double fontSize = isMobile ? 15.0 : (isSmallLaptop ? 14.0 : (isLaptop ? 15.0 : 18.0));
    final double iconSize = isMobile ? 18.0 : (isSmallLaptop ? 16.0 : (isLaptop ? 18.0 : 22.0));
    
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hovering
                ? [Color(0xFF00C6FB), Color(0xFF2E5BFF)]
                : [Color(0xFF2E5BFF), Color(0xFF00C6FB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            if (_hovering)
              BoxShadow(
                color: Colors.blue.withOpacity(0.18),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 0,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              fontFamily: 'Montserrat',
              letterSpacing: 1.1,
            ),
          ),
          onPressed: () {
            context.go('/get-started');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.rocket_launch_outlined,
                color: Colors.white,
                size: iconSize,
              ),
              const SizedBox(width: 10),
              Text('Get Started'),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Below are additional widgets and helpers for a premium, clean feel ---

class NavigationBarShadow extends StatelessWidget {
  const NavigationBarShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: IgnorePointer(
        child: Container(
          height: 16,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.08),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedUnderline extends StatefulWidget {
  final bool show;
  final double width;
  final Color color;

  const AnimatedUnderline({
    required this.show,
    required this.width,
    required this.color,
    super.key,
  });

  @override
  State<AnimatedUnderline> createState() => _AnimatedUnderlineState();
}

class _AnimatedUnderlineState extends State<AnimatedUnderline> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      height: 2,
      width: widget.show ? widget.width : 0,
      color: widget.color,
    );
  }
}

class ResponsiveNavigationBar extends StatelessWidget {
  const ResponsiveNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 900) {
      return _MobileNavigationBar();
    }
    return NavigationBarWidget();
  }
}

class _MobileNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            _BrandLogo(),
            const Spacer(),
            _MobileMenuButton(),
          ],
        ),
      ),
    );
  }
}

// Enhanced mobile menu with beautiful slide & fade animation, blur, and smooth transitions

class _MobileMenuButton extends StatefulWidget {
  @override
  State<_MobileMenuButton> createState() => _MobileMenuButtonState();
}

class _MobileMenuButtonState extends State<_MobileMenuButton> with SingleTickerProviderStateMixin {
  bool _open = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 420),
      vsync: this,
    );
  }

  void _toggleMenu() async {
    if (!_open) {
      setState(() => _open = true);
      _controller.forward(from: 0);
      await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Menu",
        barrierColor: Colors.black.withOpacity(0.18),
        transitionDuration: const Duration(milliseconds: 420),
        pageBuilder: (context, anim1, anim2) {
          return _MobileMenuDialog(
            controller: _controller,
            onClose: _closeMenu,
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          final curved = CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic);
          return FadeTransition(
            opacity: curved,
            child: child,
          );
        },
      ).then((_) {
        // Ensure menu state is reset after dialog is dismissed (including tap outside)
        if (mounted) _closeMenu();
      });
    } else {
      _closeMenu();
    }
  }

  void _closeMenu() {
    if (_open) {
      _controller.reverse();
      setState(() => _open = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 320),
      transitionBuilder: (child, anim) => RotationTransition(
        turns: Tween<double>(begin: 0.85, end: 1).animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      ),
      child: IconButton(
        key: ValueKey(_open),
        icon: Icon(_open ? Icons.close : Icons.menu, color: Color(0xFF2E5BFF)),
        onPressed: _toggleMenu,
        iconSize: 32,
        splashRadius: 24,
        tooltip: _open ? "Close menu" : "Open menu",
      ),
    );
  }
}

class _MobileMenuDialog extends StatelessWidget {
  final VoidCallback onClose;
  final AnimationController controller;

  const _MobileMenuDialog({
    required this.onClose,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dialogWidth = width < 400 ? width * 0.98 : 340.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Frosted glass blur background
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Dismiss the dialog
              onClose(); // Animate controller and update state
            },

            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) => Opacity(
                opacity: controller.value * 0.9,
                child: child,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  color: Colors.white.withOpacity(0.12),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          // Slide-in menu
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final slide = Tween<Offset>(
                begin: const Offset(1.0, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));
              final fade = CurvedAnimation(parent: controller, curve: Curves.easeIn);
              return SlideTransition(
                position: slide,
                child: FadeTransition(
                  opacity: fade,
                  child: child,
                ),
              );
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: dialogWidth,
                margin: EdgeInsets.symmetric(
                  horizontal: width < 400 ? 4 : 24,
                  vertical: 60,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.98),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.10),
                      blurRadius: 32,
                      offset: Offset(-8, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PremiumMobileMenuItem(
                        label: 'Home',
                        icon: Icons.home_outlined,
                        gradient: LinearGradient(
                          colors: [Color(0xFF2E5BFF), Color(0xFF00C6FB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/');
                          onClose();
                        },
                      ),
                      _PremiumMobileMenuItem(
                        label: 'How It Works',
                        icon: Icons.info_outline,
                        gradient: LinearGradient(
                          colors: [Color(0xFF00C6FB), Color(0xFF2E5BFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/how-it-works');
                          onClose();
                        },
                      ),
                      _PremiumMobileMenuItem(
                        label: 'Features',
                        icon: Icons.star_outline,
                        gradient: LinearGradient(
                          colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/features');
                          onClose();
                        },
                      ),
                      _PremiumMobileMenuItem(
                        label: 'Pricing',
                        icon: Icons.attach_money_outlined,
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFA17F), Color(0xFFFFE53B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/pricing');
                          onClose();
                        },
                      ),
                      _PremiumMobileMenuItem(
                        label: 'Contact',
                        icon: Icons.mail_outline,
                        gradient: LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/contact');
                          onClose();
                        },
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E5BFF),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            context.go('/get-started');
                            onClose();
                          },
                          icon: const Icon(Icons.rocket_launch_outlined, size: 22),
                          label: const Text('Get Started'),
                        ),
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

class _PremiumMobileMenuItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Gradient gradient;

  const _PremiumMobileMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.gradient,
  });

  @override
  State<_PremiumMobileMenuItem> createState() => _PremiumMobileMenuItemState();
}

class _PremiumMobileMenuItemState extends State<_PremiumMobileMenuItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _pressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: Container(
            decoration: BoxDecoration(
              gradient: _pressed
                  ? widget.gradient
                  : LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.98),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: widget.gradient.colors.first.withOpacity(0.13),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(
                color: widget.gradient.colors.first.withOpacity(0.18),
                width: 1.2,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: widget.gradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.gradient.colors.first.withOpacity(0.18),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(7),
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: _pressed
                          ? Colors.white
                          : const Color(0xFF263159),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      letterSpacing: 0.5,
                      shadows: _pressed
                          ? [
                              Shadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : [],
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _pressed ? 1 : 0,
                  duration: const Duration(milliseconds: 120),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 18,
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
