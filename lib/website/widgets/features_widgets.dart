// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:frontend/website/screens/join_waitlist.dart';
import 'package:frontend/website/screens/pricing.dart';

// Add this widget definition if it does not exist elsewhere
class PremiumSpectacularButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Gradient? gradient;

  const PremiumSpectacularButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.gradient,
  });

  @override
  State<PremiumSpectacularButton> createState() => _PremiumSpectacularButtonState();
}

class _PremiumSpectacularButtonState extends State<PremiumSpectacularButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    // Use percentages of screen width/height, but keep the same look
    double horizontalPad = isMobile ? size.width * 0.045 : size.width * 0.027;
    double verticalPad = isMobile ? size.height * 0.012 : size.height * 0.022;
    double borderRadius = isMobile ? size.width * 0.04 : size.width * 0.016;
    double iconSize = isMobile ? size.width * 0.057 : size.width * 0.021;
    double fontSize = isMobile ? size.width * 0.04 : size.width * 0.016;
    double spacing = isMobile ? size.width * 0.023 : size.width * 0.01;

    // Clamp values to original hardcoded values to avoid visual changes
    horizontalPad = isMobile
        ? horizontalPad.clamp(18.0, 18.0)
        : horizontalPad.clamp(32.0, 32.0);
    verticalPad = isMobile
        ? verticalPad.clamp(10.0, 10.0)
        : verticalPad.clamp(18.0, 18.0);
    borderRadius = isMobile
        ? borderRadius.clamp(14.0, 14.0)
        : borderRadius.clamp(22.0, 22.0);
    iconSize = isMobile
        ? iconSize.clamp(20.0, 20.0)
        : iconSize.clamp(28.0, 28.0);
    fontSize = isMobile
        ? fontSize.clamp(14.0, 14.0)
        : fontSize.clamp(19.0, 19.0);
    spacing = isMobile
        ? spacing.clamp(8.0, 8.0)
        : spacing.clamp(14.0, 14.0);

    final goldGradient = const LinearGradient(
      colors: [
        Color(0xFFFFD700),
        Color(0xFFFFB300),
        Color(0xFFFFF6A3),
        Color(0xFFFFD700),
      ],
      stops: [0.0, 0.5, 0.8, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final scale = _hovering && !isMobile ? 1.045 : 1.0;
    final shadowColor = _hovering && !isMobile
        ? Colors.amberAccent.withOpacity(0.55)
        : Colors.amberAccent.withOpacity(0.35);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            gradient: widget.gradient ?? goldGradient,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: _hovering && !isMobile ? 28 : 18,
                spreadRadius: _hovering && !isMobile ? 4 : 2,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Colors.amberAccent.withOpacity(_hovering && !isMobile ? 1.0 : 0.7),
              width: isMobile ? 2 : 3,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: widget.onPressed,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPad,
                  vertical: verticalPad,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return goldGradient.createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: iconSize,
                        shadows: [
                          Shadow(
                            color: Colors.amberAccent.withOpacity(0.7),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spacing),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return goldGradient.createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                      child: Text(
                        widget.label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.8,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 4,
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
        ),
      ),
    );
  }
}

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final features = [
      (
        icon: Icons.auto_fix_high_rounded,
        iconBg: [Color.fromARGB(255, 106, 238, 238), Color.fromARGB(255, 75, 164, 223)],
        title: 'Personalized Learning',
        description:
            'Fluoverse adapts to your goals, interests, and style. Get a custom path and content that fits you.',
        tags: [
          _FeatureTag('Personalization', Color.fromARGB(255, 106, 238, 238)),
          _FeatureTag('Custom Path',Color.fromARGB(255, 75, 164, 223)),
          _FeatureTag('Motivation', Color.fromARGB(255, 0, 29, 251)),
        ],
        alignLeft: true,
      ),
      (
        icon: Icons.repeat_rounded,
        iconBg: [Color.fromARGB(255, 238, 236, 106), Color.fromARGB(255, 251, 171, 0)],
        title: 'Speak-First Cycles',
        description:
            'Our lessons will get you speaking in no time. Move from vocab to conversation fast, with cycles for vocab, reading, listening, and real scenarios.',
        tags: [
          _FeatureTag('Vocabulary', Color.fromARGB(255, 255, 224, 68)),
          _FeatureTag('Reading', Color.fromARGB(255, 255, 223, 12)),
          _FeatureTag('Listening', Color(0xFFFBAB00)),
          _FeatureTag('Speaking', Color.fromARGB(255, 251, 71, 0)),
        ],
        alignLeft: false,
      ),
      (
        icon: Icons.mic_rounded,
        iconBg: [Color(0xFFB993D6), Color(0xFFFB72B1)],
        title: 'Fluoverse AI Coach',
        description:
            'Practice with the Fluoverse AI coach. Get instant feedback and support in live voice sessions.',
        tags: [
          _FeatureTag('AI Coach', Color(0xFFB993D6)),
          _FeatureTag('Live Practice', Color(0xFFFB72B1)),
          _FeatureTag('Supportive', Color.fromARGB(255, 192, 0, 251)),
        ],
        alignLeft: true,
      ),
      (
        icon: Icons.people_alt_rounded,
        iconBg: [Color(0xFF6AEEA1), Color(0xFF4BDFB1)],
        title: 'Solo & Social',
        description:
            'Start with private practice, then join social sessions as you grow. Build confidence at your pace.',
        tags: [
          _FeatureTag('Solo Practice', Color(0xFF6AEEA1)),
          _FeatureTag('Social', Color(0xFF4BDFB1)),
          _FeatureTag('Confidence', Color.fromARGB(255, 0, 163, 81)),
        ],
        alignLeft: false,
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 175, 63, 227), Color.fromARGB(255, 0, 42, 255)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: isMobile ? size.height * 0.04 : size.height * 0.06),
              const _SectionHeader(),
              SizedBox(height: isMobile ? size.height * 0.035 : size.height * 0.05),
              ...List.generate(features.length, (i) {
                final f = features[i];
                return Padding(
                  padding: EdgeInsets.only(
                    top: i == 0 ? 0 : (isMobile ? size.height * 0.026 : size.height * 0.04),
                    left: isMobile ? size.width * 0.014 : 0,
                    right: isMobile ? size.width * 0.014 : 0,
                  ),
                  child: _FeaturePanel(
                    icon: f.icon,
                    iconBg: f.iconBg,
                    title: f.title,
                    description: f.description,
                    tags: f.tags,
                    alignLeft: isMobile ? true : f.alignLeft,
                  ),
                );
              }),
              SizedBox(height: isMobile ? size.height * 0.045 : size.height * 0.06),
              const UpcomingSpectacularFeature(),
              SizedBox(height: isMobile ? size.height * 0.045 : size.height * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingSpectacularFeature extends StatelessWidget {
  const UpcomingSpectacularFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Column(
      children: [
        SizedBox(height: isMobile ? 40 : 100),
        // "Spectacular" animated timeline for upcoming features
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final bubbleTop = isMobile ? 100.0 : 120.0; // Increased for mobile
            final bubbleLeft = isMobile ? width * 0.05 : width * 0.18;
            final bubbleRight = isMobile ? width * 0.05 : width * 0.18;
            final timelineTop = isMobile ? 50.0 : 60.0; // Increased for mobile
            final timelineHeight = isMobile ? 4.0 : 6.0;
            // Increase stackHeight for mobile to allow more space for buttons
            final stackHeight = isMobile ? 880.0 : 760.0; // <<-- increased for mobile
            // Move buttons lower on mobile
            final buttonBottom = isMobile ? 10.0 : 32.0; // <<-- decreased for mobile (closer to bottom)
            return SizedBox(
              height: stackHeight,
              width: width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Animated glowing timeline
                  Positioned(
                    top: timelineTop,
                    left: bubbleLeft,
                    right: bubbleRight,
                    child: Container(
                      height: timelineHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.blueAccent.withOpacity(0.5),
                            Colors.white.withOpacity(0.15),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Feature 1: Fluency Rooms
                  Positioned(
                    top: bubbleTop,
                    left: isMobile ? 0 : bubbleLeft,
                    right: isMobile ? 0 : null,
                    child: isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _SpectacularFeatureBubble(
                                icon: Icons.forum_rounded,
                                title: 'Fluency Rooms',
                                description:
                                    'Step into live themed voice rooms — practice real conversations, build confidence, make friends and experience language as it’s truly spoken!',
                                highlight: true,
                              ),
                              SizedBox(height: 40),
                              _SpectacularFeatureBubble(
                                icon: Icons.sports_martial_arts,
                                title: 'Fluency Battle Rooms',
                                description:
                                    'Challenge others in real-time language duels. Climb the leaderboards and earn exclusive rewards — all while having fun!',
                                highlight: false,
                              ),
                            ],
                          )
                        : _SpectacularFeatureBubble(
                            icon: Icons.forum_rounded,
                            title: 'Fluency Rooms',
                            description:
                                'Step into live themed voice rooms — practice real conversations, build confidence, make friends and experience language as it’s truly spoken!',
                            highlight: true,
                          ),
                  ),
                  // Feature 2: Fluency Battle Rooms (only for desktop/tablet)
                  if (!isMobile)
                    Positioned(
                      top: bubbleTop,
                      right: bubbleRight,
                      child: _SpectacularFeatureBubble(
                        icon: Icons.sports_martial_arts,
                        title: 'Fluency Battle Rooms',
                        description:
                            'Challenge others in real-time language duels. Climb the leaderboards and earn exclusive rewards — all while having fun!',
                        highlight: false,
                      ),
                    ),
                  // Animated "Coming Soon" rocket in the center
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, -10 * (1 - value)),
                              child: child,
                            );
                          },
                          child: Icon(
                            Icons.rocket_launch_rounded,
                            color: Colors.amberAccent.shade200,
                            size: isMobile ? 38 : 54,
                            shadows: [
                              Shadow(
                                color: Colors.amberAccent.withOpacity(0.6),
                                blurRadius: 24,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Spectacular Features\nComing Soon!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            letterSpacing: 1.1,
                            shadows: const [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Premium Spectacular Buttons at the very bottom
                  Positioned(
                    bottom: buttonBottom,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
                      child: isMobile
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PremiumSpectacularButton(
                                  label: "Experience All Features",
                                  icon: Icons.star_rounded,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => PricingPage()),
                                    );
                                  },
                                  gradient: const LinearGradient(
                                    colors: [Color.fromARGB(255, 183, 0, 255), Color.fromARGB(255, 183, 0, 255), Color.fromARGB(255, 183, 0, 255)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                PremiumSpectacularButton(
                                  label: "Stay Informed for Upcoming Features",
                                  icon: Icons.notifications_active_rounded,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const JoinWaitlist(),
                                    );
                                  },
                                  gradient: const LinearGradient(
                                    colors: [Color.fromARGB(255, 183, 0, 255), Color.fromARGB(255, 183, 0, 255), Color.fromARGB(255, 183, 0, 255)],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PremiumSpectacularButton(
                                  label: "Experience All Features",
                                  icon: Icons.star_rounded,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => PricingPage()),
                                    );
                                  },
                                  gradient: const LinearGradient(
                                    colors: [Color.fromARGB(255, 183, 0, 255), Color.fromARGB(255, 183, 0, 255), Color.fromARGB(255, 183, 0, 255)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                const SizedBox(width: 32),
                                PremiumSpectacularButton(
                                  label: "Stay Informed for Upcoming Features",
                                  icon: Icons.notifications_active_rounded,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const JoinWaitlist(),
                                    );
                                  },
                                  gradient: const LinearGradient(
                                    colors: [Color.fromARGB(255, 183, 0, 255), Color.fromARGB(255, 183, 0, 255), Color.fromARGB(255, 183, 0, 255)],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SpectacularFeatureBubble extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool highlight;

  const _SpectacularFeatureBubble({
    required this.icon,
    required this.title,
    required this.description,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    // Responsive sizes
    final double bubbleSize = isMobile ? 68 : 100;
    final double ringSize = isMobile ? 84 : 120;
    final double glowSize = isMobile ? 110 : 160;
    final double iconSize = isMobile ? 32 : 54;
    final double titleFontSize = isMobile ? 18 : 28;
    final double descFontSize = isMobile ? 13.5 : 16;
    final double width = isMobile ? 180 : 280;
    final double descWidth = isMobile ? 150 : 230;
    final double ribbonFontSize = isMobile ? 8.5 : 11;
    final double ribbonPadH = isMobile ? 7 : 12;
    final double ribbonPadV = isMobile ? 2 : 3;
// for future fine-tuning

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Glowing, animated, layered icon with sparkles and animated ring
          Stack(
            alignment: Alignment.center,
            children: [
              // Animated pulsing glow
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.95, end: 1.15),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutCubic,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: glowSize,
                      height: glowSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: highlight
                              ? [
                                  Colors.blueAccent.withOpacity(0.55),
                                  Colors.purpleAccent.withOpacity(0.22),
                                  Colors.transparent,
                                ]
                              : [
                                  Colors.deepPurple.withOpacity(0.28),
                                  Colors.blueGrey.withOpacity(0.13),
                                  Colors.transparent,
                                ],
                          stops: const [0.25, 0.7, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: highlight
                                ? Colors.amberAccent.withOpacity(0.18)
                                : Colors.cyanAccent.withOpacity(0.10),
                            blurRadius: 32,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Animated rotating ring
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 2 * 3.14159),
                duration: const Duration(seconds: 7),
                curve: Curves.linear,
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: value,
                    child: Container(
                      width: ringSize,
                      height: ringSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: highlight
                              ? Colors.amberAccent.withOpacity(0.7)
                              : Colors.cyanAccent.withOpacity(0.5),
                          width: isMobile ? 3 : 5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: highlight
                                ? Colors.amberAccent.withOpacity(0.25)
                                : Colors.cyanAccent.withOpacity(0.13),
                            blurRadius: 18,
                            spreadRadius: 2,
                          ),
                        ],
                        gradient: SweepGradient(
                          colors: highlight
                              ? [
                                  Colors.amberAccent.withOpacity(0.7),
                                  Colors.blueAccent.withOpacity(0.4),
                                  Colors.purpleAccent.withOpacity(0.3),
                                  Colors.amberAccent.withOpacity(0.7),
                                ]
                              : [
                                  Colors.cyanAccent.withOpacity(0.5),
                                  Colors.deepPurple.withOpacity(0.3),
                                  Colors.blueGrey.withOpacity(0.2),
                                  Colors.cyanAccent.withOpacity(0.5),
                                ],
                          stops: const [0.0, 0.4, 0.7, 1.0],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Main icon bubble with animated scale
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.92, end: 1.0),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: bubbleSize,
                      height: bubbleSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: highlight
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFF7F7FD5),
                                  Color(0xFF86A8E7),
                                  Color(0xFF91EAE4),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : const LinearGradient(
                                colors: [
                                  Color(0xFFB993D6),
                                  Color(0xFF8CA6DB),
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                        boxShadow: [
                          BoxShadow(
                            color: highlight
                                ? Colors.blueAccent.withOpacity(0.5)
                                : Colors.deepPurple.withOpacity(0.25),
                            blurRadius: 38,
                            spreadRadius: 10,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.28),
                          width: isMobile ? 1.5 : 2.5,
                        ),
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: highlight
                                ? [Colors.amberAccent, Colors.white]
                                : [Colors.cyanAccent, Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcATop,
                        child: Icon(
                          icon,
                          size: iconSize,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: highlight
                                  ? Colors.amberAccent.withOpacity(0.6)
                                  : Colors.cyanAccent.withOpacity(0.4),
                              blurRadius: isMobile ? 10 : 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Sparkle effects (same for both bubbles)
              ..._buildSparkles(isMobile: isMobile),
              // Ribbon "upcoming"
              Positioned(
                top: isMobile ? 10 : 20,
                right: 0,
                child: Transform.rotate(
                  angle: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ribbonPadH, vertical: ribbonPadV),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 64, 64).withOpacity(0.92),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'UPCOMING',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: ribbonFontSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        fontFamily: 'Montserrat',
                        shadows: const [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 22),
          // Animated title with shimmer and scale
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.85, end: 1.0),
            duration: const Duration(milliseconds: 900),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: highlight
                          ? [Colors.amberAccent, Colors.white, Colors.amberAccent]
                          : [Colors.cyanAccent, Colors.white, Colors.cyanAccent],
                      stops: const [0.2, 0.5, 0.8],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: child,
                ),
              );
            },
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'Montserrat',
                letterSpacing: 1.2,
                shadows: const [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: isMobile ? 7 : 12),
          // Animated description with fade-in and slide
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1100),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: SizedBox(
              width: descWidth,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: descFontSize,
                  color: Colors.white70,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 1.45,
                  shadows: const [
                    Shadow(
                      color: Colors.black12,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build animated sparkles (responsive for mobile)
  static List<Widget> _buildSparkles({required bool isMobile}) {
    if (isMobile) {
      return [
        _AnimatedSparkle(
          dx: 20,
          dy: -18,
          color: Colors.amberAccent,
          size: 12,
          delay: 0,
        ),
        _AnimatedSparkle(
          dx: -22,
          dy: -14,
          color: Colors.white,
          size: 7,
          delay: 300,
        ),
        _AnimatedSparkle(
          dx: 0,
          dy: 28,
          color: Colors.amberAccent.shade100,
          size: 8,
          delay: 600,
        ),
        _AnimatedSparkle(
          dx: 24,
          dy: 14,
          color: Colors.amber,
          size: 6,
          delay: 900,
        ),
      ];
    } else {
      return [
        _AnimatedSparkle(
          dx: 36,
          dy: -34,
          color: Colors.amberAccent,
          size: 22,
          delay: 0,
        ),
        _AnimatedSparkle(
          dx: -38,
          dy: -28,
          color: Colors.white,
          size: 13,
          delay: 300,
        ),
        _AnimatedSparkle(
          dx: 0,
          dy: 48,
          color: Colors.amberAccent.shade100,
          size: 14,
          delay: 600,
        ),
        _AnimatedSparkle(
          dx: 44,
          dy: 28,
          color: Colors.amber,
          size: 10,
          delay: 900,
        ),
      ];
    }
  }
}

class _AnimatedSparkle extends StatefulWidget {
  final double dx;
  final double dy;
  final Color color;
  final double size;
  final int delay;

  const _AnimatedSparkle({
    required this.dx,
    required this.dy,
    required this.color,
    required this.size,
    required this.delay,
  });

  @override
  State<_AnimatedSparkle> createState() => _AnimatedSparkleState();
}

class _AnimatedSparkleState extends State<_AnimatedSparkle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _scale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 0.7), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _opacity = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 70),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive sparkle position
    final isMobile = MediaQuery.of(context).size.width < 700;
    final double offset = isMobile ? 34.0 : 50.0;
    return Positioned(
      left: offset + widget.dx,
      top: offset + widget.dy,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.scale(
              scale: _scale.value,
              child: Icon(
                Icons.auto_awesome,
                color: widget.color.withOpacity(0.85),
                size: widget.size,
                shadows: [
                  Shadow(
                    color: widget.color.withOpacity(0.7),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Column(
      children: [
        Text(
          'Features That Accelerate Fluency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 32 : 68,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontFamily: 'Montserrat',
            letterSpacing: 1.2,
            shadows: const [
              Shadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 8 : 16),
        Text(
          'Experience next-generation language learning powered by AI coaching, gamified progression, and real conversation practice.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 14 : 18,
            color: Colors.white70,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

class _FeaturePanel extends StatelessWidget {
  final IconData icon;
  final List<Color> iconBg;
  final String title;
  final String description;
  final List<_FeatureTag> tags;
  final bool alignLeft;

  const _FeaturePanel({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.description,
    required this.tags,
    required this.alignLeft,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    final iconWidget = Container(
      width: isMobile ? 60 : 110,
      height: isMobile ? 60 : 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: iconBg,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: iconBg.first.withOpacity(0.25),
            blurRadius: isMobile ? 10 : 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.25),
          width: isMobile ? 1 : 2,
        ),
      ),
      child: Icon(icon, size: isMobile ? 28 : 54, color: Colors.white),
    );

    final textWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 18 : 32,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontFamily: 'Montserrat',
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: isMobile ? 8 : 16),
        Text(
          description,
          style: TextStyle(
            fontSize: isMobile ? 13 : 18,
            color: Colors.white,
            height: 1.6,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isMobile ? 10 : 20),
        Wrap(
          spacing: isMobile ? 7 : 12,
          runSpacing: isMobile ? 6 : 10,
          children: tags,
        ),
      ],
    );

    return Container(
      width: isMobile ? double.infinity : 900,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 18 : 36,
        horizontal: isMobile ? 14 : 36,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.20),
        borderRadius: BorderRadius.circular(isMobile ? 18 : 32),
        border: Border.all(
          color: Colors.white.withOpacity(0.18),
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: iconBg.first.withOpacity(0.13),
            blurRadius: isMobile ? 12 : 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: alignLeft
                  ? [
                      iconWidget,
                      SizedBox(height: 14),
                      textWidget,
                    ]
                  : [
                      textWidget,
                      SizedBox(height: 14),
                      iconWidget,
                    ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: alignLeft
                  ? [
                      iconWidget,
                      const SizedBox(width: 36),
                      Expanded(child: textWidget),
                    ]
                  : [
                      Expanded(child: textWidget),
                      const SizedBox(width: 36),
                      iconWidget,
                    ],
            ),
    );
  }
}

class _FeatureTag extends StatelessWidget {
  final String label;
  final Color color;

  const _FeatureTag(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 12,
        vertical: isMobile ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(isMobile ? 10 : 16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: isMobile ? 10 : 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
