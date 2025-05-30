// homepage_widgets.dart

// ignore_for_file: deprecated_member_use, unused_element_parameter, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';

import 'package:frontend/website/screens/join_waitlist.dart';

const Color kAccentBlue = Color(0xFF6A82FB);
const Color kPremiumPurple = Color(0xFFB721FF);

/// Revamped Background with simplified gradient and subtle particle effects
class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF232347), Color(0xFF3B4A6B)], // subtle blue shades
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _ParticlePainter(),
          ),
        ),
        child,
      ],
    );
  }
}

class _ParticlePainter extends CustomPainter {
  static final List<_Star> _stars = _generateStars(60);

  static List<_Star> _generateStars(int count) {
    final random = Random(42);
    return List.generate(count, (_) {
      final dx = random.nextDouble();
      final dy = random.nextDouble();
      final radius = 1.2 + random.nextDouble() * 1.8;
      final points = 5;
      final rotation = random.nextDouble() * pi * 2;
      final opacity = 0.06 + random.nextDouble() * 0.12;
      return _Star(dx, dy, radius, points, rotation, opacity);
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in _stars) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(star.opacity)
        ..style = PaintingStyle.fill;
      final center = Offset(star.dx * size.width, star.dy * size.height);
      final path = _starPath(center, star.radius, star.points, star.rotation);
      canvas.drawPath(path, paint);
    }
  }

  Path _starPath(Offset center, double radius, int points, double rotation) {
    final path = Path();
    final angle = pi / points;
    for (int i = 0; i < points * 2; i++) {
      final r = (i % 2 == 0) ? radius : radius / 2.2;
      final a = i * angle + rotation;
      final x = center.dx + r * cos(a);
      final y = center.dy + r * sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Star {
  final double dx, dy, radius, rotation, opacity;
  final int points;
  _Star(this.dx, this.dy, this.radius, this.points, this.rotation, this.opacity);
}

/// Revamped Hero Section with premium, connected design
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF3EAFE), // light lila / purple
            Color(0xFFF6F8FE),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          // Center the content by wrapping with Center and using maxWidth
          final double maxContentWidth = 1100;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxContentWidth,
              ),
              child: Flex(
                direction: isWide ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text content
                  Expanded(
                    flex: isWide ? 2 : 0,
                    child: Column(
                      crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [kAccentBlue, kPremiumPurple],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                          },
                          child: Text(
                          'Fluoverse: Speak. Connect. Belong!',
                          textAlign: isWide ? TextAlign.left : TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 68,
                            ),
                          ),
                        ).animate().fadeIn(duration: 800.ms),
                        const SizedBox(height: 24),
                        Text(
                          'Build fluency through conversation, not just study. \n\nSpeak, listen, and interact as if you are truly there. 🌍✨',
                          textAlign: isWide ? TextAlign.left : TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: kAccentBlue.withOpacity(0.85),
                                fontSize: 18,
                              ),
                        ).animate().fadeIn(duration: 1000.ms),
                        const SizedBox(height: 32), // Reduced spacing
                        Wrap(
                          spacing: 24,
                          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
                          children: [
                            _PremiumButton(
                              text: 'Start Speaking',
                              icon: Icons.mic_rounded,
                              background: const LinearGradient(
                                colors: [kAccentBlue, kPremiumPurple],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              onPressed: () {},
                              glowColor: kAccentBlue.withOpacity(0.32),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isWide)
                    const SizedBox(width: 24) // Reduced width for closer layout
                  else
                    const SizedBox(height: 32), // Reduced height for closer layout
                  // Animated conversation demo with premium glassmorphic card and visual connector
                  Expanded(
                    flex: isWide ? 1 : 0,
                    child: Stack(
                      alignment: Alignment.center,
                        children: [
                        // Glowing connector between text and chat (with fillets)
                        if (isWide)
                          Positioned(
                          left: -36, // Move connector closer
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Container(
                            width: 36,
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                              colors: [
                                kAccentBlue.withOpacity(0.0),
                                kAccentBlue.withOpacity(0.18),
                                kPremiumPurple.withOpacity(0.22),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            ),
                          ),
                          ),
                        // Glassmorphic chat demo with premium glow (with fillets)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.85),
                              kAccentBlue.withOpacity(0.08),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                            BoxShadow(
                              color: kPremiumPurple.withOpacity(0.13),
                              blurRadius: 36,
                              spreadRadius: 6,
                              offset: const Offset(0, 18),
                            ),
                            ],
                            border: Border.all(
                            color: kAccentBlue.withOpacity(0.13),
                            width: 1.5,
                            ),
                            backgroundBlendMode: BlendMode.srcOver,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: _ConversationDemo(),
                          ),
                          ),
                        ),
                        // Subtle floating particles for premium effect (with fillets)
                        Positioned.fill(
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: IgnorePointer(
                            child: Opacity(
                            opacity: 0.18,
                            child: _AnimatedParticles(),
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),
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

/// Animated conversation demo widget (premium style, more connected)
class _ConversationDemo extends StatefulWidget {
  const _ConversationDemo();

  @override
  State<_ConversationDemo> createState() => _ConversationDemoState();
}

class _ConversationDemoState extends State<_ConversationDemo>
  with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  final List<_ChatBubble> _bubbles = [
  _ChatBubble(
    text: '¡Hola! How do you say "good morning" in Spanish?',
    isUser: true,
  ),
  _ChatBubble(
    text: 'Buenos días',
    isUser: false,
  ),
  _ChatBubble(
    text: 'Great! Now try saying it yourself.',
    isUser: true,
  ),
  _ChatBubble(
    text: '"Buenos días!"',
    isUser: false,
  ),
  _ChatBubble(
    text: '✅ Great Job! You pronounced it perfectly!',
    isUser: true,
  ),
  ];

  @override
  void initState() {
  super.initState();
  // Each chat lasts 1 second longer: duration = bubbles.length * 2 seconds
  _controller = AnimationController(
    duration: Duration(seconds: _bubbles.length * 3),
    vsync: this,
  )..repeat();
  _animation = Tween<double>(begin: 0, end: _bubbles.length.toDouble() + 0.999)
    .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
  _controller.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Center(
    child: AnimatedBuilder(
    animation: _animation,
    builder: (context, _) {
      final visibleCount = (_animation.value).clamp(1, _bubbles.length).toInt();

      return Container(
      width: 320, // Slightly reduced width for a tighter look
      constraints: const BoxConstraints(
        minHeight: 320.0,
        maxHeight: 440.0,
      ),
      padding: const EdgeInsets.all(20), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(28), // <-- Added fillets (rounded corners)
        boxShadow: [
        BoxShadow(
          color: kAccentBlue.withOpacity(0.10),
          blurRadius: 28,
          spreadRadius: 2,
          offset: const Offset(0, 10),
          // Add fillet (rounded corners) by specifying borderRadius
          // Note: BoxShadow itself does not support borderRadius directly,
          // but the shadow will follow the borderRadius of the parent container.
        ),
        BoxShadow(
          color: kPremiumPurple.withOpacity(0.09),
          blurRadius: 18,
          spreadRadius: 1,
          offset: const Offset(0, 4),
          // Same as above: shadow follows parent borderRadius.
        ),
        ],
        border: Border.all(
        color: kAccentBlue.withOpacity(0.09),
        width: 1.2,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ...List.generate(_bubbles.length, (i) {
              return AnimatedOpacity(
              opacity: i < visibleCount ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              child: IgnorePointer(
                ignoring: i >= visibleCount,
                child: Padding(
                padding: EdgeInsets.only(
                  bottom: i == _bubbles.length - 1 ? 0 : 8, // Reduced spacing
                ),
                child: _bubbles[i],
                ),
              ),
              );
            }),
            const SizedBox(height: 10),
            AnimatedOpacity(
              opacity: visibleCount == _bubbles.length ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 34,
              ),
              ),
            ),
            ],
          ),
          ),
        );
        },
      ),
      );
    },
    ),
  );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  const _ChatBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2), // Reduced margin
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11), // Reduced padding
        decoration: BoxDecoration(
          gradient: isUser
              ? const LinearGradient(
                  colors: [kPremiumPurple, kAccentBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFFB2E0FF), Color(0xFFD1C4E9)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
          borderRadius: BorderRadius.circular(16), // Slightly tighter radius
          boxShadow: [
            BoxShadow(
              color: (isUser ? kPremiumPurple : kAccentBlue).withOpacity(0.10),
              blurRadius: 7,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : kAccentBlue,
            fontWeight: FontWeight.w600,
            fontSize: 15,
            height: 1.32,
          ),
        ),
      ),
    );
  }
}

/// Premium "Coming Soon" Strip with enhanced wow effect and larger, more magnetic design
class ComingSoonStrip extends StatefulWidget {
  const ComingSoonStrip({super.key});

  @override
  State<ComingSoonStrip> createState() => _ComingSoonStripState();
}

class _ComingSoonStripState extends State<ComingSoonStrip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_BorderStar> _stars;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    // Generate a few (6-10) stars at random border positions
    final random = Random(2025);
    _stars = List.generate(8, (i) {
      // t: 0..1, position along border
      final t = random.nextDouble();
      // Gold or white
      final isGold = random.nextBool();
      // Each star animates in/out at a random phase
      final phase = random.nextDouble();
      // Size
      final size = 18.0 + random.nextDouble() * 10.0;
      return _BorderStar(
        t: t,
        isGold: isGold,
        phase: phase,
        size: size,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 72),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Stronger glowing animated background
          Positioned.fill(
            child: AnimatedContainer(
              duration: 1200.ms,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    kPremiumPurple.withOpacity(0.22),
                    kAccentBlue.withOpacity(0.16),
                    Colors.transparent,
                  ],
                  radius: 1.6,
                  center: Alignment.topCenter,
                ),
              ),
            ),
          ),
          // More animated floating particles
          Positioned.fill(
            child: IgnorePointer(
              child: _AnimatedParticles(
                count: 28,
                maxSize: 32,
                minOpacity: 0.18,
                maxOpacity: 0.28,
              ),
            ),
          ),
          // Main content with smaller, more premium glassmorphic card
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 840,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
// rough estimate
                return Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 44),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        color: Colors.white.withOpacity(0.38),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.55),
                          width: 2.6,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: kPremiumPurple.withOpacity(0.23),
                            blurRadius: 72,
                            spreadRadius: 16,
                            offset: const Offset(0, 36),
                          ),
                          BoxShadow(
                            color: kAccentBlue.withOpacity(0.13),
                            blurRadius: 40,
                            spreadRadius: 10,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        backgroundBlendMode: BlendMode.srcOver,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon with glow and border for pop
                            Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                              BoxShadow(
                                color: kPremiumPurple.withOpacity(0.45),
                                blurRadius: 32,
                                spreadRadius: 2,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.35),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                              ],
                              border: Border.all(
                              color: Colors.white.withOpacity(0.85),
                              width: 3,
                              ),
                              gradient: const LinearGradient(
                              colors: [kPremiumPurple, kAccentBlue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [Colors.white, Colors.white70],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                              },
                              child: Icon(
                              Icons.rocket_launch_rounded,
                              color: Colors.white,
                              size: 64,
                              shadows: [
                                Shadow(
                                color: kPremiumPurple.withOpacity(0.7),
                                blurRadius: 24,
                                ),
                                Shadow(
                                color: Colors.black.withOpacity(0.18),
                                blurRadius: 8,
                                ),
                              ],
                              ),
                            ),
                            )
                              .animate()
                              .fadeIn(duration: 600.ms)
                              .slideY(begin: 0.3, end: 0, duration: 600.ms),
                            const SizedBox(width: 32),
                            // Text with strong shadow and stroke for pop
                            Stack(
                            children: [
                              // Stroke effect
                              Text(
                              'Coming Soon',
                              style: TextStyle(
                                fontSize: 54,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.2,
                                foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.black.withOpacity(0.18),
                              ),
                              ),
                              ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                colors: [kPremiumPurple, kAccentBlue],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: Text(
                                'Coming Soon',
                                style: const TextStyle(
                                fontSize: 54,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.2,
                                color: Colors.white,
                                ),
                              ),
                              ),
                            ],
                            )
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .slideY(begin: -0.2, end: 0, duration: 800.ms),
                          ],
                          ),
                          const SizedBox(height: 32),
                          Text(
                          'Fluoverse is almost here — a bold new way to learn by speaking.\n\nJoin early and shape the future of language learning.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.92),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            shadows: [
                            Shadow(
                              color: Colors.white.withOpacity(0.7),
                              blurRadius: 12,
                            ),
                            Shadow(
                              color: kAccentBlue.withOpacity(0.18),
                              blurRadius: 16,
                            ),
                            ],
                          ),
                          ).animate().fadeIn(duration: 1200.ms),
                          const SizedBox(height: 40),
                          SizedBox(
                          height: 62,
                          child: Center(
                            child: _PremiumButton(
                            text: 'Join Waitlist',
                            icon: Icons.star_rounded,
                            background: const LinearGradient(
                              colors: [kAccentBlue, kPremiumPurple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => JoinWaitlist(),
                              ),
                              );
                            },
                            glowColor: kPremiumPurple.withOpacity(0.38),
                            ).animate().fadeIn(duration: 1400.ms),
                          ),
                          ),
                        ],
                      ),
                    ),
                    // Shiny border stars
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) {
                            return CustomPaint(
                              painter: _BorderStarsPainter(
                                stars: _stars,
                                progress: _controller.value,
                                borderRadius: 36,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// Only 4 corner stars, well-defined and ultra-shiny, appear even more rarely (1-2 at a time)
class _BorderStar {
  final double t; // 0..1, position along border (corners only)
  final bool isGold;
  final double phase; // 0..1, animation phase offset
  final double size;
  _BorderStar({
    required this.t,
    required this.isGold,
    required this.phase,
    required this.size,
  });
}

class _BorderStarsPainter extends CustomPainter {
  final List<_BorderStar> stars;
  final double progress;
  final double borderRadius;

  _BorderStarsPainter({
    required this.stars,
    required this.progress,
    required this.borderRadius,
  });

  static const List<double> _cornerTs = [0.0, 0.25, 0.5, 0.75];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final r = borderRadius;
    final border = RRect.fromRectAndRadius(rect, Radius.circular(r));

    // Each star appears for 2.5s every 12s, with long gaps and smooth fade in/out
    // Fade in: 0.3s, visible: 1.9s, fade out: 0.3s
    const double appearStart = 0.18;
    const double fadeInDuration = 0.025; // 0.3s / 12s
    const double visibleDuration = 0.158; // 1.9s / 12s
    const double fadeOutDuration = 0.025; // 0.3s / 12s
    const double appearEnd = appearStart + fadeInDuration + visibleDuration + fadeOutDuration;

    int visibleCount = 0;
    for (int i = 0; i < _cornerTs.length; i++) {
      final star = stars[i];
      final t = ((progress + star.phase) % 1.0);

      double opacity = 0;
      if (t > appearStart && t < appearStart + fadeInDuration) {
        opacity = ((t - appearStart) / fadeInDuration).clamp(0, 1);
      } else if (t >= appearStart + fadeInDuration && t < appearStart + fadeInDuration + visibleDuration) {
        opacity = 1;
      } else if (t >= appearStart + fadeInDuration + visibleDuration && t < appearEnd) {
        opacity = ((appearEnd - t) / fadeOutDuration).clamp(0, 1);
      }
      // Only show if visible, and randomly skip some to max 2 at a time
      if (opacity < 0.05) continue;
      if (visibleCount >= 2) continue;
      visibleCount++;

      final pos = _pointOnRRectBorder(border, _cornerTs[i]);
      final starSize = star.size;
      // Ultra-shiny: strong white/gold, crisp, with a sharp highlight and a glow
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.transparent;

      // Draw star shape
      final path = _starPath(pos, starSize / 2, 5, pi / 2 + t * 2 * pi);

      // Ultra-shiny gradient overlay for gold or white
      final gradient = RadialGradient(
        colors: star.isGold
            ? [
                Colors.white.withOpacity(opacity * 1.0),
                const Color(0xFFFFF7B2).withOpacity(opacity * 0.95),
                const Color(0xFFFFE066).withOpacity(opacity * 0.85),
                Colors.transparent,
              ]
            : [
                Colors.white.withOpacity(opacity * 1.0),
                Colors.white.withOpacity(opacity * 0.85),
                Colors.white.withOpacity(opacity * 0.5),
                Colors.transparent,
              ],
        stops: const [0.0, 0.35, 0.7, 1.0],
      );
      final rectGrad = Rect.fromCircle(center: pos, radius: starSize / 2);
      paint.shader = gradient.createShader(rectGrad);

      canvas.drawPath(path, paint);

      // Add a crisp white highlight for extra shine
      final highlightPaint = Paint()
        ..color = Colors.white.withOpacity(opacity * 0.95)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2;
      canvas.drawPath(path, highlightPaint);

      // Add a subtle glow around the star
      final glowPaint = Paint()
        ..color = (star.isGold
                ? const Color(0xFFFFF7B2)
                : Colors.white)
            .withOpacity(opacity * 0.45)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
      canvas.drawCircle(pos, starSize * 0.85, glowPaint);
    }
  }

  // Returns a point along the border of a rounded rectangle, t in [0,1)
  Offset _pointOnRRectBorder(RRect rrect, double t) {
    final w = rrect.width;
    final h = rrect.height;
    final r = rrect.tlRadiusX;
    final perim = 2 * (w + h - 4 * r) + 2 * pi * r;
    final d = t * perim;

    // Sides: top, top-right arc, right, bottom-right arc, bottom, bottom-left arc, left, top-left arc
    final straight = [w - 2 * r, h - 2 * r, w - 2 * r, h - 2 * r];
    final arc = [pi / 2 * r, pi / 2 * r, pi / 2 * r, pi / 2 * r];
    final segs = [
      straight[0], // top
      arc[0], // top-right
      straight[1], // right
      arc[1], // bottom-right
      straight[2], // bottom
      arc[2], // bottom-left
      straight[3], // left
      arc[3], // top-left
    ];
    double acc = 0;
    for (int i = 0; i < segs.length; i++) {
      if (d < acc + segs[i]) {
        final local = d - acc;
        switch (i) {
          case 0: // top
            return Offset(r + local, 0);
          case 1: // top-right arc
            final theta = local / r;
            return Offset(w - r + r * cos(-pi / 2 + theta), r + r * sin(-pi / 2 + theta));
          case 2: // right
            return Offset(w, r + local);
          case 3: // bottom-right arc
            final theta2 = local / r;
            return Offset(w - r + r * cos(0 + theta2), h - r + r * sin(0 + theta2));
          case 4: // bottom
            return Offset(w - r - local, h);
          case 5: // bottom-left arc
            final theta3 = local / r;
            return Offset(r + r * cos(pi / 2 + theta3), h - r + r * sin(pi / 2 + theta3));
          case 6: // left
            return Offset(0, h - r - local);
          case 7: // top-left arc
            final theta4 = local / r;
            return Offset(r + r * cos(pi + theta4), r + r * sin(pi + theta4));
        }
      }
      acc += segs[i];
    }
    return Offset(r, 0);
  }

  Path _starPath(Offset center, double radius, int points, double rotation) {
    final path = Path();
    final angle = pi / points;
    for (int i = 0; i < points * 2; i++) {
      final r = (i % 2 == 0) ? radius : radius / 2.2;
      final a = i * angle + rotation;
      final x = center.dx + r * cos(a);
      final y = center.dy + r * sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _BorderStarsPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Animated floating particles for wow effect (blue/purple only)
class _AnimatedParticles extends StatefulWidget {
  final int count;
  final double maxSize;
  final double minOpacity;
  final double maxOpacity;

  const _AnimatedParticles({
    this.count = 14,
    this.maxSize = 18,
    this.minOpacity = 0.13,
    this.maxOpacity = 0.26,
    super.key,
  });

  @override
  State<_AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<_AnimatedParticles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();

    _particles = List.generate(widget.count, (i) {
      final random = Random(i * 2025);
      final colorOptions = [
        kAccentBlue,
        kPremiumPurple,
      ];
      return _Particle(
        dx: random.nextDouble(),
        dy: random.nextDouble(),
        size: 12.0 + random.nextDouble() * (widget.maxSize - 12.0),
        color: colorOptions[random.nextInt(2)].withOpacity(
          widget.minOpacity + random.nextDouble() * (widget.maxOpacity - widget.minOpacity),
        ),
        speed: 0.2 + random.nextDouble() * 0.7,
        direction: random.nextDouble() * 2 * pi,
      );
    });
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
      builder: (_, __) {
        return CustomPaint(
          painter: _ParticlesPainter(
            _particles,
            _controller.value,
          ),
        );
      },
    );
  }
}

class _Particle {
  final double dx, dy, size, speed, direction;
  final Color color;
  _Particle({
    required this.dx,
    required this.dy,
    required this.size,
    required this.color,
    required this.speed,
    required this.direction,
  });
}

class _ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  _ParticlesPainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed + p.dx + p.dy) % 1.0;
      final angle = p.direction + t * 2 * pi;
      final radius = 64.0 + 96.0 * p.speed;
      final offset = Offset(
        (p.dx * size.width) + cos(angle) * radius,
        (p.dy * size.height) + sin(angle) * radius,
      );
      final paint = Paint()
        ..color = p.color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
      canvas.drawCircle(offset, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Ultra-Premium Footer Section with Animated Glow, Gradient Text, and Socials


class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated glowing background
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedContainer(
              duration: 1200.ms,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    kPremiumPurple.withOpacity(0.22),
                    kAccentBlue.withOpacity(0.16),
                    Colors.transparent,
                  ],
                  radius: 1.7,
                  center: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
        // Subtle floating particles for extra wow
        const Positioned.fill(
          child: IgnorePointer(
            child: _AnimatedParticles(
              count: 28,
              maxSize: 38,
              minOpacity: 0.13,
              maxOpacity: 0.28,
            ),
          ),
        ),
        // Ultra-premium content with floating, glowing, layered effects
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Floating glowing logo with layered shine
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const SweepGradient(
                          colors: [
                            kPremiumPurple,
                            kAccentBlue,
                            kPremiumPurple,
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: kPremiumPurple.withOpacity(0.38),
                            blurRadius: 60,
                            spreadRadius: 16,
                          ),
                          BoxShadow(
                            color: kAccentBlue.withOpacity(0.18),
                            blurRadius: 32,
                            spreadRadius: 4,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.85),
                          width: 3.5,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [kAccentBlue, kPremiumPurple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.22),
                            blurRadius: 24,
                            spreadRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.92),
                          width: 2.2,
                        ),
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Colors.white, Colors.white70],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Image.asset(
                          'web/assets/android-chrome-192x192.png',
                          width: 54,
                          height: 54,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.18, end: 0, duration: 700.ms),
                const SizedBox(height: 28),
                // Gradient animated text with stroke and shadow
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Stroke effect
                    Text(
                      'Fluoverse © 2025',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.8,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black.withOpacity(0.18),
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [kAccentBlue, kPremiumPurple],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds);
                      },
                      child: const Text(
                        'Fluoverse © 2025',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 900.ms),
                const SizedBox(height: 28),
                // Premium links with animated underline and glow
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FooterLink('Privacy'),
                    _FooterDot(),
                    _FooterLink('Terms'),
                    _FooterDot(),
                    _FooterLink('Contact'),
                  ],
                ).animate().fadeIn(duration: 1100.ms),
                const SizedBox(height: 36),
                // Social icons with premium hover and animated glow
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FooterSocialIcon(Icons.email_rounded, onTap: () {}),
                    const SizedBox(width: 22),
                    // Replace with a generic chat icon for Discord
                    _FooterSocialIcon(Icons.chat_rounded, onTap: () {}),
                    const SizedBox(width: 22),
                    // Replace with send icon for Telegram
                    _FooterSocialIcon(Icons.send_rounded, onTap: () {}),
                    const SizedBox(width: 22),
                    _FooterSocialIcon(Icons.language, onTap: () {}),
                  ],
                ).animate().fadeIn(duration: 1300.ms),
                const SizedBox(height: 26),
                // Subtle animated tagline
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [kPremiumPurple, kAccentBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds);
                  },
                  child: const Text(
                    'Speak. Connect. Belong.',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.9,
                      shadows: [
                        Shadow(
                          color: kPremiumPurple,
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 1500.ms).slideY(begin: 0.12, end: 0, duration: 700.ms),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



// Value Propositions Section (Premium Version)
class ValuePropsSection extends StatelessWidget {
  const ValuePropsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [kAccentBlue, kPremiumPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              'Why Fluoverse?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40,
                    letterSpacing: 1.4,
                    shadows: [
                      Shadow(
                        color: kPremiumPurple.withOpacity(0.22),
                        blurRadius: 18,
                      ),
                      Shadow(
                        color: kAccentBlue.withOpacity(0.12),
                        blurRadius: 8,
                      ),
                    ],
                  ),
            ),
          ),
          const SizedBox(height: 48),
          // Use IntrinsicHeight to prevent parent height change on hover
          IntrinsicHeight(
            child: Wrap(
              spacing: 40,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: const [
                _ValueCardPremium(
                  icon: Icons.record_voice_over_rounded,
                  gradient: LinearGradient(
                    colors: [kPremiumPurple, kAccentBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  iconGlow: kPremiumPurple,
                  title: 'Speak from Day One',
                  description: 'Start speaking from your first session.',
                ),
                _ValueCardPremium(
                  icon: Icons.auto_awesome_rounded,
                  gradient: LinearGradient(
                    colors: [kAccentBlue, kPremiumPurple],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  iconGlow: kAccentBlue,
                  title: 'AI Coaching',
                  description: 'AI coach supports and grows with you.',
                ),
                _ValueCardPremium(
                  icon: Icons.person_rounded,
                  gradient: LinearGradient(
                    colors: [kAccentBlue, kPremiumPurple],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  iconGlow: kAccentBlue,
                  title: 'Personalized Learning',
                  description: 'Learning adapts to your interests.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueCardPremium extends StatefulWidget {
  final IconData icon;
  final LinearGradient gradient;
  final Color iconGlow;
  final String title;
  final String description;

  const _ValueCardPremium({
    required this.icon,
    required this.gradient,
    required this.iconGlow,
    required this.title,
    required this.description,
  });

  @override
  State<_ValueCardPremium> createState() => _ValueCardPremiumState();
}

class _ValueCardPremiumState extends State<_ValueCardPremium> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    // Premium: more glass, more glow, more color, more depth, more wow
    const double cardWidth = 250;
    const double cardHeight = 320;
    final double scale = _hovering ? 1.06 : 1.0;
    final Duration duration = const Duration(milliseconds: 220);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glowing animated background for extra premium feel
            AnimatedContainer(
              duration: duration,
              curve: Curves.easeOutCubic,
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: _hovering
                    ? widget.gradient
                    : const LinearGradient(
                        colors: [Colors.white, Color(0xFFF6F8FE)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                border: Border.all(
                  color: _hovering
                      ? Colors.white.withOpacity(0.98)
                      : kAccentBlue.withOpacity(0.13),
                  width: _hovering ? 2.6 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.iconGlow.withOpacity(_hovering ? 0.32 : 0.13),
                    blurRadius: _hovering ? 44 : 18,
                    spreadRadius: _hovering ? 12 : 3,
                    offset: const Offset(0, 18),
                  ),
                  if (_hovering)
                    BoxShadow(
                      color: Colors.white.withOpacity(0.18),
                      blurRadius: 36,
                      spreadRadius: 2,
                    ),
                ],
                backgroundBlendMode: BlendMode.srcOver,
              ),
              child: Stack(
                children: [
                  // Subtle floating particles for premium glass effect
                  if (_hovering)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Opacity(
                          opacity: 0.13,
                          child: _AnimatedParticles(
                            count: 7,
                            maxSize: 18,
                            minOpacity: 0.10,
                            maxOpacity: 0.18,
                          ),
                        ),
                      ),
                    ),
                  // Card content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 36),
                    child: AnimatedScale(
                      scale: scale,
                      duration: duration,
                      curve: Curves.easeOutBack,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Glowing icon background
                              AnimatedContainer(
                                duration: duration,
                                width: _hovering ? 68 : 58,
                                height: _hovering ? 68 : 58,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: widget.gradient,
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.iconGlow.withOpacity(_hovering ? 0.45 : 0.22),
                                      blurRadius: _hovering ? 38 : 18,
                                      spreadRadius: _hovering ? 10 : 3,
                                    ),
                                    if (_hovering)
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.22),
                                        blurRadius: 18,
                                        spreadRadius: 1,
                                      ),
                                  ],
                                  border: Border.all(
                                    color: Colors.white.withOpacity(_hovering ? 0.98 : 0.7),
                                    width: _hovering ? 3.6 : 2.2,
                                  ),
                                ),
                              ),
                              // Icon with gradient shine
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    colors: [Colors.white, Colors.white70],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  widget.icon,
                                  size: _hovering ? 38 : 32,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: widget.iconGlow.withOpacity(0.7),
                                      blurRadius: 18,
                                    ),
                                    Shadow(
                                      color: Colors.black.withOpacity(0.13),
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          // Gradient title with strong shadow, turns white on hover
                          AnimatedDefaultTextStyle(
                            duration: duration,
                            curve: Curves.easeOutCubic,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: _hovering ? Colors.white : null,
                              letterSpacing: 0.2,
                              shadows: [
                                Shadow(
                                  color: widget.iconGlow.withOpacity(0.22),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: _hovering
                                ? Text(
                                    widget.title,
                                    textAlign: TextAlign.center,
                                  )
                                : ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return widget.gradient.createShader(bounds);
                                    },
                                    child: Text(
                                      widget.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 14),
                          // Description with animated color and shadow
                          AnimatedDefaultTextStyle(
                            duration: duration,
                            curve: Curves.easeOutCubic,
                            style: TextStyle(
                              fontSize: 15.5,
                              color: _hovering
                                  ? Colors.white.withOpacity(0.96)
                                  : Colors.black.withOpacity(0.82),
                              fontWeight: FontWeight.w500,
                              shadows: _hovering
                                  ? [
                                      Shadow(
                                        color: widget.iconGlow.withOpacity(0.18),
                                        blurRadius: 10,
                                      ),
                                    ]
                                  : [],
                            ),
                            textAlign: TextAlign.center,
                            child: Text(widget.description),
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
    );
  }
}


// Learning Cycle Overview (Premium Version)
class LearningCycleSection extends StatelessWidget {
  const LearningCycleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF3EAFE),
            Color(0xFFE5E8FE),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [kAccentBlue, kPremiumPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              'The Fluoverse Method',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 48,
                    letterSpacing: 2.2,
                  ),
            ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 18),
          Text(
            'Four steps to fluency, one cycle at a time',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: kAccentBlue.withOpacity(0.82),
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  letterSpacing: 0.7,
                ),
          ).animate().fadeIn(duration: 900.ms),
          const SizedBox(height: 64),
          // Steps with premium glass and connectors
          SizedBox(
            height: 270,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Animated connectors between steps (premium)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _CycleConnectorsPainterPremium(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _CycleStepPremium(
                      step: 1,
                      title: 'Vocabulary',
                      subtitle: 'Learn key words with context',
                      icon: Icons.menu_book_rounded,
                      gradient: LinearGradient(
                        colors: [kAccentBlue, kPremiumPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      iconGlow: kAccentBlue,
                    ),
                    SizedBox(width: 48),
                    _CycleStepPremium(
                      step: 2,
                      title: 'Reading',
                      subtitle: 'Understand in interactive scenarios',
                      icon: Icons.menu_rounded,
                      gradient: LinearGradient(
                        colors: [kPremiumPurple, kAccentBlue],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      iconGlow: kPremiumPurple,
                    ),
                    SizedBox(width: 48),
                    _CycleStepPremium(
                      step: 3,
                      title: 'Listening',
                      subtitle: 'Train your ear with native audio',
                      icon: Icons.headphones_rounded,
                      gradient: LinearGradient(
                        colors: [kAccentBlue, kPremiumPurple],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      iconGlow: kAccentBlue,
                    ),
                    SizedBox(width: 48),
                    _CycleStepPremium(
                      step: 4,
                      title: 'Scenario',
                      subtitle: 'Practice speaking in real life situations',
                      icon: Icons.record_voice_over_rounded,
                      gradient: LinearGradient(
                        colors: [kPremiumPurple, kAccentBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      iconGlow: kPremiumPurple,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CycleStepPremium extends StatefulWidget {
  final int step;
  final String title;
  final String subtitle;
  final IconData icon;
  final LinearGradient gradient;
  final Color iconGlow;

  const _CycleStepPremium({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.iconGlow,
  });

  @override
  State<_CycleStepPremium> createState() => _CycleStepPremiumState();
}

class _CycleStepPremiumState extends State<_CycleStepPremium> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 180;
    const double cardHeight = 210;
    final double scale = _hovering ? 1.08 : 1.0;
    final Duration duration = const Duration(milliseconds: 200);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: scale,
        duration: duration,
        curve: Curves.easeOutBack,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: duration,
              curve: Curves.easeOutCubic,
              width: cardWidth,
              height: cardHeight,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: _hovering
                    ? widget.gradient
                    : const LinearGradient(
                        colors: [Colors.white, Color(0xFFF6F8FE)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                border: Border.all(
                  color: _hovering
                      ? Colors.white.withOpacity(0.99)
                      : kAccentBlue.withOpacity(0.13),
                  width: _hovering ? 2.2 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.iconGlow.withOpacity(_hovering ? 0.18 : 0.08),
                    blurRadius: _hovering ? 22 : 10,
                    spreadRadius: _hovering ? 6 : 2,
                    offset: const Offset(0, 8),
                  ),
                ],
                backgroundBlendMode: BlendMode.srcOver,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glowing icon background
                      AnimatedContainer(
                        duration: duration,
                        width: _hovering ? 58 : 48,
                        height: _hovering ? 58 : 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: widget.gradient,
                          boxShadow: [
                            BoxShadow(
                              color: widget.iconGlow.withOpacity(_hovering ? 0.22 : 0.10),
                              blurRadius: _hovering ? 18 : 8,
                              spreadRadius: _hovering ? 4 : 1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(_hovering ? 0.98 : 0.7),
                            width: _hovering ? 2.6 : 1.6,
                          ),
                        ),
                      ),
                      // Icon with gradient shine
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Colors.white, Colors.white70],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Icon(
                          widget.icon,
                          size: _hovering ? 30 : 26,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Gradient title with strong shadow, turns white on hover
                  AnimatedDefaultTextStyle(
                    duration: duration,
                    curve: Curves.easeOutCubic,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: _hovering ? Colors.white : null,
                      letterSpacing: 0.3,
                    ),
                    child: _hovering
                        ? Text(
                            widget.title,
                            textAlign: TextAlign.center,
                          )
                        : ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return widget.gradient.createShader(bounds);
                            },
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedDefaultTextStyle(
                    duration: duration,
                    curve: Curves.easeOutCubic,
                    style: TextStyle(
                      fontSize: 14.5,
                      color: _hovering
                          ? Colors.white.withOpacity(0.96)
                          : kAccentBlue.withOpacity(0.82),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    child: Text(widget.subtitle),
                  ),
                ],
              ),
            ),
            // Step number badge: only visible on hover, below the card
            AnimatedOpacity(
              opacity: _hovering ? 1.0 : 0.0,
              duration: duration,
              curve: Curves.easeOutCubic,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.98),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: widget.iconGlow.withOpacity(0.10),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    '${widget.step}',
                    style: TextStyle(
                      color: widget.iconGlow,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Draws animated connectors between cycle steps for premium look
class _CycleConnectorsPainterPremium extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Calculate positions for 4 steps in a row (responsive)
    const double cardWidth = 180;
    const double spacing = 48;
    final totalWidth = cardWidth * 4 + spacing * 3;
    final startX = (size.width - totalWidth) / 2 + cardWidth / 2;
    final y = size.height / 2;

    final points = List.generate(4, (i) => Offset(startX + i * (cardWidth + spacing), y));

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          kAccentBlue.withOpacity(0.13),
          kPremiumPurple.withOpacity(0.18),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromPoints(points.first, points.last))
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final mid = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
      final control1 = Offset(mid.dx, p1.dy - 36);
      final control2 = Offset(mid.dx, p2.dy - 36);
      final path = Path()
        ..moveTo(p1.dx, p1.dy)
        ..cubicTo(control1.dx, control1.dy, control2.dx, control2.dy, p2.dx, p2.dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


/// Ultra-premium Vision Section — Striking, Minimal, and Futuristic
class VisionSection extends StatelessWidget {
  const VisionSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Use a deep space background with animated nebula glow and a floating glass planet (no particles)
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0B0E1A),
            Color(0xFF232347),
            Color(0xFF181A2A),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // --- SPECTACULAR: Animated Aurora/Nebula Glow Layer ---
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    AlwaysStoppedAnimation(DateTime.now().millisecondsSinceEpoch / 40000.0),
                  ]),
                  builder: (context, _) {
                    final t = (DateTime.now().millisecondsSinceEpoch / 40000.0) % 1.0;
                    return CustomPaint(
                      painter: _AuroraGlowPainter(t),
                    );
                  },
                ),
              ),
            ),
            // END SPECTACULAR
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Floating glass planet with animated rings (now above the title, not overlapping)
                  SizedBox(
                    height: 180,
                    child: Center(
                      child: _AnimatedGlassPlanet(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Futuristic, minimal, all-caps title with animated letter spacing
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: 1.18),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOutExpo,
                    builder: (context, spacing, _) {
                      return ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [kAccentBlue, kPremiumPurple],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          'THE VISION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 54,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.8 * spacing,
                            color: Colors.white,
                            fontFamily: 'Orbitron',
                            shadows: [
                              Shadow(
                                color: kAccentBlue.withOpacity(0.38),
                                blurRadius: 24,
                              ),
                              Shadow(
                                color: kPremiumPurple.withOpacity(0.18),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 54),
                  // Minimal animated divider (neon line)
                  Container(
                    height: 4,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: const LinearGradient(
                        colors: [kAccentBlue, kPremiumPurple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kAccentBlue.withOpacity(0.22),
                          blurRadius: 18,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                  // Vision statement in a floating glass card with a single bold sentence
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 48),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white.withOpacity(0.09),
                      border: Border.all(
                        color: kAccentBlue.withOpacity(0.22),
                        width: 2.2,
                      ),
                      // Removed boxShadow for minimal look
                      backgroundBlendMode: BlendMode.srcOver,
                    ),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [kAccentBlue, kPremiumPurple],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds);
                      },
                      child: Text(
                        "Language is more than vocabulary — it's connection. Fluoverse is building a global community where learners don't just study languages, they build real relationships through them.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 38,
                              letterSpacing: 2.2,
                              fontFamily: 'Orbitron',
                              height: 1.32,
                              shadows: [
                                Shadow(
                                  color: kPremiumPurple.withOpacity(0.22),
                                  blurRadius: 24,
                                ),
                              ],
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                  // Three futuristic "vision chips" with icons, glass, and neon glow
                  Wrap(
                    spacing: 54,
                    runSpacing: 38,
                    alignment: WrapAlignment.center,
                    children: const [
                      _VisionChip(
                        icon: Icons.rocket_launch_rounded,
                        label: "Bridge\nCultures",
                        color: kAccentBlue,
                      ),
                      _VisionChip(
                        icon: Icons.hub_rounded,
                        label: "Connect\nLearners",
                        color: kPremiumPurple,
                      ),
                      _VisionChip(
                        icon: Icons.lightbulb_rounded,
                        label: "Ignite\nMinds",
                        color: kAccentBlue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  // Subtle animated "space code" line (ASCII/Spanish words, not Chinese)
                  SizedBox(
                    height: 60,
                    child: _SpaceCodeLine(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- SPECTACULAR: Aurora/Nebula Glow Painter ---
class _AuroraGlowPainter extends CustomPainter {
  final double t;
  _AuroraGlowPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.38);
    final double w = size.width;
    final double h = size.height;

    // Aurora 1: Blue
    final paint1 = Paint()
      ..shader = RadialGradient(
        colors: [
          kAccentBlue.withOpacity(0.22 + 0.08 * (0.5 + 0.5 * (sin(t * 2 * pi)))),
          Colors.transparent,
        ],
        radius: 0.6 + 0.08 * sin(t * 2 * pi),
        center: Alignment(0.0, -0.2 + 0.08 * cos(t * 2 * pi)),
      ).createShader(Rect.fromCircle(center: center, radius: w * 0.45))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120);

    canvas.drawCircle(center, w * (0.38 + 0.06 * sin(t * 2 * pi)), paint1);

    // Aurora 2: Purple
    final paint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          kPremiumPurple.withOpacity(0.18 + 0.08 * (0.5 + 0.5 * cos(t * 2 * pi))),
          Colors.transparent,
        ],
        radius: 0.5 + 0.09 * cos(t * 2 * pi + 1.2),
        center: Alignment(-0.3 + 0.1 * sin(t * 2 * pi + 1.2), -0.1),
      ).createShader(Rect.fromCircle(center: center.translate(-w * 0.18, 0), radius: w * 0.32))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 90);

    canvas.drawCircle(center.translate(-w * 0.18, 0), w * (0.28 + 0.04 * cos(t * 2 * pi + 1.2)), paint2);

    // Aurora 3: White shimmer
    final paint3 = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.09 + 0.06 * (0.5 + 0.5 * sin(t * 2 * pi + 2.1))),
          Colors.transparent,
        ],
        radius: 0.38 + 0.07 * sin(t * 2 * pi + 2.1),
        center: Alignment(0.25, -0.18 + 0.1 * cos(t * 2 * pi + 2.1)),
      ).createShader(Rect.fromCircle(center: center.translate(w * 0.22, -h * 0.08), radius: w * 0.22))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 70);

    canvas.drawCircle(center.translate(w * 0.22, -h * 0.08), w * (0.13 + 0.03 * sin(t * 2 * pi + 2.1)), paint3);
  }

  @override
  bool shouldRepaint(covariant _AuroraGlowPainter oldDelegate) => true;
}

// REMOVED: _NeonBorderPainter

// Animated floating glass planet with shifting gradient and orbiting ring
class _AnimatedGlassPlanet extends StatefulWidget {
  @override
  State<_AnimatedGlassPlanet> createState() => _AnimatedGlassPlanetState();
}

class _AnimatedGlassPlanetState extends State<_AnimatedGlassPlanet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
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
      builder: (_, __) {
        final t = _controller.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            // Orbiting ring
            Transform.rotate(
              angle: t * 2 * 3.1415,
              child: CustomPaint(
                size: const Size(200, 200),
                painter: _PlanetRingPainter(),
              ),
            ),
            // Floating planet
            Transform.translate(
              offset: Offset(0, 30 * (0.5 - 0.5 * (1 + sin(t * 2 * 3.1415)))),
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      kAccentBlue,
                      kPremiumPurple,
                      kAccentBlue,
                    ],
                    stops: [
                      0.0,
                      (0.5 + 0.5 * cos(t * 2 * 3.1415)).clamp(0.0, 1.0),
                      1.0
                    ],
                    transform: GradientRotation(t * 2 * 3.1415),
                  ),
                  // Removed boxShadow for minimal look
                  border: Border.all(
                    color: Colors.white.withOpacity(0.85),
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.public_rounded,
                    color: Colors.white.withOpacity(0.93),
                    size: 70,
                    shadows: [
                      Shadow(
                        color: kAccentBlue.withOpacity(0.32),
                        blurRadius: 24,
                      ),
                      Shadow(
                        color: kPremiumPurple.withOpacity(0.18),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Painter for the planet's orbiting ring
class _PlanetRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(center: center, width: 180, height: 60);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          kAccentBlue.withOpacity(0.38),
          kPremiumPurple.withOpacity(0.38),
          Colors.white.withOpacity(0.12),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Futuristic glass "chip" with neon glow and icon
class _VisionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _VisionChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(
          color: color.withOpacity(0.32),
          width: 2.2,
        ),
        // Removed boxShadow for minimal look
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [color, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Icon(
              icon,
              color: Colors.white,
              size: 34,
              // Removed icon shadow for minimal look
            ),
          ),
          const SizedBox(width: 18),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.93),
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Orbitron',
              letterSpacing: 0.7,
              // Removed text shadow for minimal look
            ),
          ),
        ],
      ),
    );
  }
}

// Animated "space code" line with Spanish words and ASCII symbols
class _SpaceCodeLine extends StatefulWidget {
  @override
  State<_SpaceCodeLine> createState() => _SpaceCodeLineState();
}

class _SpaceCodeLineState extends State<_SpaceCodeLine>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<String> _words;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();
    // Spanish words and space/ASCII symbols
    _words = [
      'Conexión', 'Unidos', 'Comunidad', 'Amistad', 'Vínculo', 'Colaborar', 'Compartir', 'Apoyar',
      'Escuchar', 'Hablar', 'Juntos', 'Red', 'Encuentro', 'Cultura', 'Diversidad', 'Empatía',
      'Bienvenida', 'Participar', 'Crecer', 'Colmena', 'Tribu', 'Solidaridad', 'Voz', 'Grupo',
      'Colaboración', 'Intercambio', 'Pertenecer', 'Junt@s', 'Aliados', 'Puente', 'Familia', 'Equipo'
    ];
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
      builder: (_, __) {
        final t = _controller.value;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_words.length, (i) {
              final opacity = 0.3 + 0.7 * ((t + i / _words.length) % 1.0);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Opacity(
                  opacity: opacity,
                  child: Text(
                    _words[i],
                    style: TextStyle(
                      color: i % 2 == 0 ? kAccentBlue : kPremiumPurple,
                      fontSize: 18,
                      fontFamily: 'Fira Mono',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}


class _FooterLink extends StatefulWidget {
  final String text;
  const _FooterLink(this.text);

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 180),
        style: TextStyle(
          color: _hovering
              ? kAccentBlue
              : Colors.white.withOpacity(0.72),
          fontWeight: FontWeight.w600,
          fontSize: 15.5,
          letterSpacing: 0.2,
          decoration: _hovering ? TextDecoration.underline : TextDecoration.none,
          shadows: _hovering
              ? [
                  const Shadow(
                    color: kAccentBlue,
                    blurRadius: 8,
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

class _FooterDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: kAccentBlue.withOpacity(0.22),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _FooterSocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _FooterSocialIcon(this.icon, {required this.onTap});

  @override
  State<_FooterSocialIcon> createState() => _FooterSocialIconState();
}

class _FooterSocialIconState extends State<_FooterSocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: _hovering
                ? const LinearGradient(
                    colors: [kAccentBlue, kPremiumPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: _hovering
                ? null
                : kAccentBlue.withOpacity(0.10),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: kAccentBlue.withOpacity(0.18),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            widget.icon,
            color: _hovering
                ? Colors.white
                : kAccentBlue.withOpacity(0.82),
            size: 22,
          ),
        ),
      ),
    );
  }
}

/// Premium glassmorphic button with dynamic hover, glow, and icon
class _PremiumButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Gradient background;
  final VoidCallback onPressed;
  final bool outlined;
  final Color glowColor;

  const _PremiumButton({
    required this.text,
    required this.icon,
    required this.background,
    required this.onPressed,
    this.outlined = false,
    required this.glowColor,
  });

  @override
  State<_PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<_PremiumButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final double scale = _hovering ? 1.06 : 1.0;
    final double blur = _hovering ? 18 : 8;
    final double shadowOpacity = _hovering ? 0.55 : 0.32;
    final Duration duration = const Duration(milliseconds: 220);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: scale,
        duration: duration,
        curve: Curves.easeOutBack,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: duration,
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
            decoration: BoxDecoration(
              gradient: widget.outlined ? null : widget.background,
              borderRadius: BorderRadius.circular(18),
              border: widget.outlined
                  ? Border.all(color: Colors.white.withOpacity(_hovering ? 0.95 : 0.7), width: 1.7)
                  : null,
              color: widget.outlined
                  ? Colors.white.withOpacity(_hovering ? 0.12 : 0.07)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: widget.glowColor.withOpacity(shadowOpacity),
                  blurRadius: blur * 2,
                  spreadRadius: _hovering ? 4 : 2,
                  offset: const Offset(0, 10),
                ),
                if (_hovering)
                  BoxShadow(
                    color: Colors.white.withOpacity(0.08),
                    blurRadius: 32,
                    spreadRadius: 1,
                  ),
              ],
              backgroundBlendMode: BlendMode.srcOver,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: duration,
                  curve: Curves.easeOutCubic,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: _hovering
                        ? [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.18),
                              blurRadius: 16,
                              spreadRadius: 1,
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(
                    widget.icon,
                    color: Colors.white.withOpacity(_hovering ? 1 : 0.92),
                    size: _hovering ? 25 : 22,
                  ),
                ),
                const SizedBox(width: 14),
                AnimatedDefaultTextStyle(
                  duration: duration,
                  curve: Curves.easeOutCubic,
                  style: TextStyle(
                    color: Colors.white.withOpacity(_hovering ? 1 : 0.93),
                    fontWeight: FontWeight.bold,
                    fontSize: _hovering ? 18.5 : 17,
                    letterSpacing: 0.3,
                    shadows: _hovering
                        ? [
                            Shadow(
                              color: Colors.white.withOpacity(0.18),
                              blurRadius: 16,
                            ),
                          ]
                        : [],
                  ),
                  child: Text(widget.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
