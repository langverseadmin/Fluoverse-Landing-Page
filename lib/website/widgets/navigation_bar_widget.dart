// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../screens/homepage.dart';
import '../screens/how_it_works.dart';
import '../screens/features.dart';
import '../screens/pricing.dart';
import '../screens/get_started.dart'; // Import GetStartedScreen

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
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
            const SizedBox(width: 32),
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
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E5BFF), Color(0xFF00C6FB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.12),
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.blur_on,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'Fluoverse',
          style: TextStyle(
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.w900,
            fontSize: 32,
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
    // Get current route name
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    // Helper to check if this button is selected
    bool isSelected(String routeName) => currentRoute == routeName;

    return Row(
      children: [
        _NavButton(
          label: 'Home',
          icon: Icons.home_outlined,
          selected: isSelected('/home'),
          onTap: () {
            if (!isSelected('/home')) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                  settings: const RouteSettings(name: '/home'),
                ),
                (route) => false, // Remove all previous routes
              );

            }
          },
        ),
        _PremiumDivider(),
        _NavButton(
          label: 'How It Works',
          icon: Icons.info_outline,
          selected: isSelected('/howitworks'),
          onTap: () {
            if (!isSelected('/howitworks')) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HowItWorksScreen(),
                  settings: const RouteSettings(name: '/howitworks',
                  ),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeaturesScreen(),
                  settings: const RouteSettings(name: '/features',
                  ),
                ),
              );
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PricingPage(),
                  settings: const RouteSettings(name: '/pricing',
                  ),
                ),
              );
            }
          },
        ),
        _PremiumDivider(),
        _NavButton(
          label: 'Contact',
          icon: Icons.mail_outline,
          selected: isSelected('/contact'),
          onTap: () {
            // TO DO: Implement Contact navigation
          },
        ),
      ],
    );
  }
}

class _PremiumDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
            padding: isActive
                ? const EdgeInsets.symmetric(horizontal: 28, vertical: 14)
                : const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: isActive
                            ? Colors.white
                            : (_hovering ? underlineColor : Color(0xFF263159)),
                        fontSize: 17,
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
                  width: 38,
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
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 0,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Montserrat',
              letterSpacing: 1.1,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GetStartedScreen()),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.rocket_launch_outlined,
                color: Colors.white,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text('Get Started'),
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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

class _MobileMenuButton extends StatefulWidget {
  @override
  State<_MobileMenuButton> createState() => _MobileMenuButtonState();
}

class _MobileMenuButtonState extends State<_MobileMenuButton> {
  bool _open = false;

  void _toggleMenu() {
    setState(() {
      _open = !_open;
    });
    if (_open) {
      showDialog(
        context: context,
        builder: (context) => _MobileMenuDialog(onClose: _toggleMenu),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_open ? Icons.close : Icons.menu, color: Color(0xFF2E5BFF)),
      onPressed: _toggleMenu,
      iconSize: 32,
      splashRadius: 24,
    );
  }
}

class _MobileMenuDialog extends StatelessWidget {
  final VoidCallback onClose;

  const _MobileMenuDialog({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MobileMenuItem(
              label: 'Home',
              icon: Icons.home_outlined,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                onClose();
              },
            ),
            _MobileMenuItem(
              label: 'How It Works',
              icon: Icons.info_outline,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HowItWorksScreen()),
                );
                onClose();
              },
            ),
            _MobileMenuItem(
              label: 'Features',
              icon: Icons.star_outline,
              onTap: () {
                Navigator.pop(context);
                // TO DO: Implement Features navigation
                onClose();
              },
            ),
            _MobileMenuItem(
              label: 'Pricing',
              icon: Icons.attach_money_outlined,
              onTap: () {
                Navigator.pop(context);
                // TO DO: Implement Pricing navigation
                onClose();
              },
            ),
            _MobileMenuItem(
              label: 'Contact',
              icon: Icons.mail_outline,
              onTap: () {
                Navigator.pop(context);
                // TO DO: Implement Contact navigation
                onClose();
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E5BFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 0,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  // TO DO: Add premium action
                  onClose();
                },
                icon: Icon(Icons.rocket_launch_outlined, size: 22),
                label: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _MobileMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF2E5BFF)),
      title: Text(
        label,
        style: TextStyle(
          color: Color(0xFF263159),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Colors.blue.withOpacity(0.08),
    );
  }
}


