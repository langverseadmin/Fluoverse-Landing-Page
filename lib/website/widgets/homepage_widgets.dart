// homepage_widgets.dart

// ignore_for_file: deprecated_member_use, unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';

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
                              fontSize: 48,
                            ),
                          ),
                        ).animate().fadeIn(duration: 800.ms),
                        const SizedBox(height: 24),
                        Text(
                          'Build fluency through conversation, not just study. \n\nSpeak, listen, and interact as if you are truly there. 🌍✨',
                          textAlign: isWide ? TextAlign.left : TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: kAccentBlue.withOpacity(0.85),
                                fontSize: 16,
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
                                onPressed: () {},
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

/// Premium Glassmorphic Footer Section (simplified)
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(
          color: Colors.white.withOpacity(0.13),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: kAccentBlue.withOpacity(0.10),
            blurRadius: 32,
            spreadRadius: 2,
            offset: const Offset(0, -8),
          ),
        ],
        backgroundBlendMode: BlendMode.srcOver,
      ),
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.language_rounded,
            color: kAccentBlue.withOpacity(0.92),
            size: 38,
          ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2, end: 0, duration: 700.ms),
          const SizedBox(height: 18),
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
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: kAccentBlue,
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 900.ms),
          const SizedBox(height: 18),
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
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterSocialIcon(Icons.email_rounded, onTap: () {}),
              const SizedBox(width: 18),
              _FooterSocialIcon(Icons.language, onTap: () {}),
              const SizedBox(width: 18),
              _FooterSocialIcon(Icons.language, onTap: () {}),
            ],
          ).animate().fadeIn(duration: 1300.ms),
        ],
      ),
    );
  }
}



// Value Propositions Section
class ValuePropsSection extends StatelessWidget {
  const ValuePropsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF6F8FE),
      ),
      child: Column(
        children: [
          Text(
            'Why Fluoverse?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ValueCard(
                icon: Icons.mic_rounded,
                title: 'Speak from Day One',
                description: 'You start talking from the first minute with AI feedback.',
              ),
              _ValueCard(
                icon: Icons.games_rounded,
                title: 'Gamified Cycles',
                description: 'Vocabulary → Reading → Listening → Scenario.',
              ),
              _ValueCard(
                icon: Icons.flash_on_rounded,
                title: 'Built for Fluency',
                description: 'Daily progress you can feel and measure.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ValueCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Color(0xFF4B4EFC)),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Learning Cycle Overview
class LearningCycleSection extends StatelessWidget {
  const LearningCycleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF0F4FF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Your Daily Cycle to Fluency',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: const [
              _CycleStep(title: 'Vocabulary', icon: Icons.menu_book_rounded, color: Colors.pinkAccent),
              _CycleStep(title: 'Reading', icon: Icons.menu_rounded, color: Colors.orangeAccent),
              _CycleStep(title: 'Listening', icon: Icons.headphones_rounded, color: Colors.green),
              _CycleStep(title: 'Scenario', icon: Icons.record_voice_over_rounded, color: Colors.indigoAccent),
            ],
          ),
        ],
      ),
    );
  }
}

class _CycleStep extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _CycleStep({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
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
