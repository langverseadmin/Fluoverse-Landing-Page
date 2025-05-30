// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:frontend/website/screens/join_waitlist.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          _FeatureTag('Listening', Color.fromARGB(255, 251, 171, 0)),
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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              const _SectionHeader(),
              const SizedBox(height: 40),
              ...List.generate(features.length, (i) {
                final f = features[i];
                return Padding(
                  padding: EdgeInsets.only(
                    top: i == 0 ? 0 : 32,
                  ),
                  child: _FeaturePanel(
                    icon: f.icon,
                    iconBg: f.iconBg,
                    title: f.title,
                    description: f.description,
                    tags: f.tags,
                    alignLeft: f.alignLeft,
                  ),
                );
              }),
              const SizedBox(height: 48),
              const UpcomingSpectacularFeature(),
              const SizedBox(height: 48),
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
    return Column(
      children: [
        const SizedBox(height: 100),
        // "Spectacular" animated timeline for upcoming features
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            // Provide bounded constraints for the Stack
            return SizedBox(
              height: 760, // Increased height to fit buttons
              width: width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Animated glowing timeline
                  Positioned(
                    top: 60,
                    left: width * 0.15,
                    right: width * 0.15,
                    child: Container(
                      height: 6,
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
                    top: 120, // Ensures both bubbles are at the same height
                    left: width * 0.18,
                    child: _SpectacularFeatureBubble(
                      icon: Icons.forum_rounded,
                      title: 'Fluency Rooms',
                        description:
                          'Step into live themed voice rooms — practice real conversations, build confidence, make friends and experience language as it’s truly spoken!',
                      highlight: true,
                    ),
                  ),
                  // Feature 2: Fluency Battle Rooms
                  Positioned(
                    top: 120, // Ensures both bubbles are at the same height
                    right: width * 0.18,
                    child: _SpectacularFeatureBubble(
                        icon: Icons.sports_martial_arts, // Use martial arts icon for a "battle" theme
                      title: 'Fluency Battle Rooms',
                      description:
                          'Challenge others in real-time language duels. Climb the leaderboards and earn exclusive rewards — all while having fun!',
                      highlight: false,
                    ),
                  ),
                  // Animated "Coming Soon" rocket in the center
                  Positioned(
                    top: 0,
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
                            size: 54,
                            shadows: [
                              Shadow(
                                color: Colors.amberAccent.withOpacity(0.6),
                                blurRadius: 24,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Spectacular Features\nComing Soon!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            letterSpacing: 1.1,
                            shadows: [
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
                    bottom: 32,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PremiumSpectacularButton(
                          label: "Experience All Features",
                          icon: Icons.star_rounded,
                          onPressed: () {
                            // TO DO: Implement navigation or action
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
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class PremiumSpectacularButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Gradient gradient;

  const PremiumSpectacularButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.gradient,
  });

  @override
  State<PremiumSpectacularButton> createState() => _PremiumSpectacularButtonState();
}

class _PremiumSpectacularButtonState extends State<PremiumSpectacularButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    // Make button smaller
    final padding = isMobile
        ? const EdgeInsets.symmetric(horizontal: 18, vertical: 10)
        : const EdgeInsets.symmetric(horizontal: 28, vertical: 14);
    final fontSize = isMobile ? 15.0 : 18.0;
    final iconSize = isMobile ? 22.0 : 28.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(40),
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: padding,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.amberAccent.withOpacity(_hovering ? 0.35 : 0.25),
                  blurRadius: _hovering ? 60 : 40,
                  spreadRadius: _hovering ? 8 : 4,
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(_hovering ? 0.28 : 0.18),
                  blurRadius: _hovering ? 36 : 24,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(_hovering ? 0.32 : 0.22),
                width: 2.2,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Animated glowing ring behind the button
                Positioned.fill(
                  child: IgnorePointer(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.95, end: 1.15),
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInOutCubic,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(48),
                              gradient: RadialGradient(
                                colors: [
                                  Colors.amberAccent.withOpacity(_hovering ? 0.28 : 0.18),
                                  Colors.purpleAccent.withOpacity(_hovering ? 0.16 : 0.08),
                                  Colors.transparent,
                                ],
                                stops: const [0.2, 0.7, 1.0],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.92, end: 1.0),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) => Transform.scale(
                        scale: _hovering ? value * 1.08 : value,
                        child: child,
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Colors.amberAccent, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcATop,
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                          size: iconSize,
                          shadows: [
                            Shadow(
                              color: Colors.amberAccent.withOpacity(0.7),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.85, end: 1.0),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) => Transform.scale(
                        scale: _hovering ? value * 1.05 : value,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [Colors.white, Colors.amberAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcATop,
                          child: child,
                        ),
                      ),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Montserrat',
                          letterSpacing: 1.1,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(widget.label),
                      ),
                    ),
                    // Multiple sparkles for more spectacular effect
                    const _ButtonSparkle(),
                    const _ButtonSparkle(),
                  ],
                ),
                // Extra animated sparkle at the top right
                Positioned(
                  top: 4,
                  right: 10,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.7, end: 1.2),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) => Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: 0.7 * (1.2 - value),
                        child: Icon(
                          Icons.auto_awesome,
                          color: Colors.amberAccent.withOpacity(0.85),
                          size: 14,
                          shadows: [
                            Shadow(
                              color: Colors.amberAccent.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Extra animated sparkle at the bottom left
                Positioned(
                  bottom: 4,
                  left: 10,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.2, end: 0.7),
                    duration: const Duration(milliseconds: 1400),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) => Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: 0.7 * (value - 0.7),
                        child: Icon(
                          Icons.auto_awesome,
                          color: Colors.white.withOpacity(0.7),
                          size: 10,
                          shadows: [
                            Shadow(
                              color: Colors.white.withOpacity(0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
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

class _ButtonSparkle extends StatefulWidget {
  const _ButtonSparkle();

  @override
  State<_ButtonSparkle> createState() => _ButtonSparkleState();
}

class _ButtonSparkleState extends State<_ButtonSparkle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _opacity = Tween(begin: 0.0, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scale = Tween(begin: 0.7, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.scale(
          scale: _scale.value,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.auto_awesome,
              color: Colors.amberAccent.withOpacity(0.85),
              size: 18,
              shadows: [
                Shadow(
                  color: Colors.amberAccent.withOpacity(0.5),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
      ),
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
    // Set fixed sizes for both bubbles
    const double bubbleSize = 100;
    const double ringSize = 120;
    const double glowSize = 160;
    const double iconSize = 54;

    return SizedBox(
      width: 280,
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
                          width: 5,
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
                          width: 2.5,
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
                              blurRadius: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Sparkle effects (same for both bubbles)
              ..._buildSparkles(),
              // Ribbon "upcoming"
              Positioned(
                top: 20,
                right: 0,
                child: Transform.rotate(
                  angle: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
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
                    child: const Text(
                      'UPCOMING',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        fontFamily: 'Montserrat',
                        shadows: [
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
          const SizedBox(height: 22),
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
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'Montserrat',
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
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
              width: 230,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 1.55,
                  shadows: [
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

  // Helper to build animated sparkles (same for both bubbles)
  static List<Widget> _buildSparkles() {
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
    return Positioned(
      left: 50.0 + widget.dx,
      top: 50.0 + widget.dy,
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
    return Column(
      children: const [
        Text(
          'Features That Accelerate Fluency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontFamily: 'Montserrat',
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Experience next-generation language learning powered by AI coaching, gamified progression, and real conversation practice.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
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
    final iconWidget = Container(
      width: 110,
      height: 110,
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
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.25),
          width: 2,
        ),
      ),
      child: Icon(icon, size: 54, color: Colors.white),
    );

    final textWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontFamily: 'Montserrat',
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            height: 1.6,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: tags,
        ),
      ],
    );

    return Container(
      width: 900,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 36),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.20),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withOpacity(0.18),
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: iconBg.first.withOpacity(0.13),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
