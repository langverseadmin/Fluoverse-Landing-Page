// ignore_for_file: deprecated_member_use

// ignore: library_prefixes
import 'dart:math' as Math;

import 'package:flutter/material.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        "icon": Icons.star_rounded,
        "color": const Color(0xFFFFD700),
        "title": "Personalize Your Path",
        "description":
            "Before your first lesson, we take you through a quick onboarding to get to know:\n\n"
            "- Your goals (travel, career, conversation, etc.)\n"
            "- Your interests (food, music, gaming, etc.)\n"
            "- Your personality (ambitious, relaxed, playful…)\n"
            "- Your tutor vibe (kind, strict, funny…)\n\n"
            "With this, we generate a custom learning path — tailored just for you.",
      },
      {
        "icon": Icons.menu_book_rounded,
        "color": const Color(0xFFB39DFF),
        "title": "Vocabulary",
        "description":
            "Learn essential words through visual context and immediate pronunciation practice. Your AI language tutor corrects your accent in real-time, ensuring you sound natural from the start.\n\nNo flashcards, no memorization—just speaking words as you learn them.",
      },
      {
        "icon": Icons.menu_rounded,
        "color": const Color.fromARGB(255, 90, 152, 240),
        "title": "Reading",
        "description":
            "Practice comprehension with interactive stories that use your new vocabulary. Explore short scenes designed around your level and interests, helping you understand how words work in context.\n\nStories adapt to your level — challenging but never overwhelming.",
      },
      {
        "icon": Icons.headphones_rounded,
        "color": const Color(0xFF2CB67D),
        "title": "Listening",
        "description":
            "Train your ear with native speakers and natural conversations. Voice-based learning means you'll recognize real accents and speaking patterns.\n\nActive listening exercises prepare you for authentic dialogue.",
      },
      {
        "icon": Icons.record_voice_over_rounded,
        "color": const Color.fromARGB(255, 255, 145, 0),
        "title": "Scenario",
        "description":
            "Apply everything in realistic conversations with your AI coach. Order coffee, negotiate business deals, or chat about hobbies — scenarios match your goals.\n\nThe AI adapts to keep conversations flowing naturally, building your confidence.",
      },
    ];

    return Stack(
      children: [
        // Spectacular but subtle background: blurred glowing circles and gradients
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A1333), Color(0xFF7F5AF0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        // Glowing blurred circles
        Positioned(
          top: -120,
          left: -80,
          child: _SpectacularGlowCircle(
            color: const Color(0xFF7F5AF0).withOpacity(0.18),
            size: 320,
            blur: 120,
          ),
        ),
        Positioned(
          bottom: -100,
          right: -60,
          child: _SpectacularGlowCircle(
            color: const Color(0xFF1A1333).withOpacity(0.22),
            size: 260,
            blur: 100,
          ),
        ),
        Positioned(
          top: 180,
          right: 80,
          child: _SpectacularGlowCircle(
            color: const Color(0xFFB39DFF).withOpacity(0.13),
            size: 180,
            blur: 80,
          ),
        ),
        Positioned(
          bottom: 120,
          left: 60,
          child: _SpectacularGlowCircle(
            color: const Color(0xFFFFD700).withOpacity(0.10),
            size: 140,
            blur: 60,
          ),
        ),
        // Main content
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Header(),
                  const SizedBox(height: 60),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 800;
                      return Column(
                        children: List.generate(steps.length, (i) {
                          final step = steps[i];
                          final card = Flexible(
                            flex: 6,
                            child: _AnimatedStepTransition(
                              delay: Duration(milliseconds: 200 * i),
                              child: _StepCard(
                                icon: step["icon"] as IconData,
                                color: step["color"] as Color,
                                stepNumber: i + 1,
                                title: step["title"] as String,
                                description: step["description"] as String,
                                isLeft: isWide ? i.isEven : true,
                              ),
                            ),
                          );
                          final connector = isWide && i < steps.length
                              ? _AnimatedStepTransition(
                                  delay: Duration(milliseconds: 200 * i + 120),
                                  child: _StepConnector(
                                    color: steps[i]["color"] as Color,
                                    isLeft: i.isEven,
                                  ),
                                )
                              : const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: isWide
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: i.isEven
                                        ? [
                                            card,
                                            Expanded(child: connector),
                                            const Spacer(flex: 6),
                                          ]
                                        : [
                                            const Spacer(flex: 6),
                                            Expanded(child: connector),
                                            card,
                                          ],
                                  )
                                : Column(
                                    children: [
                                      card,
                                      if (i < steps.length - 1)
                                        _AnimatedStepTransition(
                                          delay: Duration(milliseconds: 200 * i + 120),
                                          child: _StepConnector(
                                            color: steps[i]["color"] as Color,
                                            isLeft: true,
                                            vertical: true,
                                          ),
                                        ),
                                    ],
                                  ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Fade/slide transition for step cards and connectors
class _AnimatedStepTransition extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _AnimatedStepTransition({
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<_AnimatedStepTransition> createState() => _AnimatedStepTransitionState();
}

class _AnimatedStepTransitionState extends State<_AnimatedStepTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _offset = Tween<Offset>(
      begin: const Offset(0.0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: widget.child,
      ),
    );
  }
}

class _SpectacularGlowCircle extends StatelessWidget {
  final Color color;
  final double size;
  final double blur;

  const _SpectacularGlowCircle({
    required this.color,
    required this.size,
    required this.blur,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: blur,
              spreadRadius: blur / 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color.fromARGB(255, 0, 157, 255), Color(0xFF7F5AF0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "How It Works",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.5,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Our AI-powered fluency cycle adapts to you—your goals, your vibe, your pace. Each step builds your confidence and skills in a natural, engaging way.",
          style: TextStyle(
            fontSize: 22,
            height: 1.8,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int stepNumber;
  final String title;
  final String description;
  final bool isLeft;

  const _StepCard({
    required this.icon,
    required this.color,
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutExpo,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.25),
            Colors.white.withOpacity(0.12),
            color.withOpacity(0.10),
          ],
          stops: [0.0, 0.7, 1.0],
          begin: isLeft ? Alignment.topLeft : Alignment.topRight,
          end: isLeft ? Alignment.bottomRight : Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.30),
            blurRadius: 48,
            offset: const Offset(0, 18),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.38),
          width: 3.5,
        ),
      ),
      child: Stack(
        children: [
          // Subtle glowing background effect
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: 0.18,
                duration: const Duration(milliseconds: 700),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        color.withOpacity(0.25),
                        Colors.transparent,
                      ],
                      radius: 0.85,
                      center: isLeft
                          ? const Alignment(-0.7, -0.7)
                          : const Alignment(0.7, -0.7),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(44),
            child: Column(
              crossAxisAlignment:
                  isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment:
                      isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    if (isLeft)
                      _AnimatedGlowIcon(icon: icon, color: color, premium: true)
                    else
                      const SizedBox(width: 0),
                    const SizedBox(width: 24),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          color,
                          Colors.white.withOpacity(0.7),
                          color.withOpacity(0.7)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds),
                      child: Text(
                        "Step $stepNumber",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.7,
                          shadows: [
                            Shadow(
                              color: color.withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    if (!isLeft)
                      _AnimatedGlowIcon(icon: icon, color: color, premium: true)
                    else
                      const SizedBox(width: 0),
                  ],
                ),
                const SizedBox(height: 28),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Colors.white,
                      color.withOpacity(0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    title,
                    textAlign: isLeft ? TextAlign.left : TextAlign.right,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.4,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  description,
                  textAlign: isLeft ? TextAlign.left : TextAlign.right,
                  style: const TextStyle(
                    fontSize: 19,
                    height: 1.85,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.13,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _AnimatedGlowIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final bool premium;

  const _AnimatedGlowIcon({
    required this.icon,
    required this.color,
    this.premium = false,
  });

  @override
  State<_AnimatedGlowIcon> createState() => _AnimatedGlowIconState();
}

class _AnimatedGlowIconState extends State<_AnimatedGlowIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  late Animation<double> _pulse;
  late Animation<double> _sparkleOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // Animation plays forever, no stop/start

    _rotation = Tween<double>(begin: 0, end: 2 * 3.1415926535).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _pulse = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
    _sparkleOpacity = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSpectacularGlow(double size) {
    // Multi-layered animated glows and gradients, extra shine
    return Stack(
      alignment: Alignment.center,
      children: [
        // Rotating outer glow ring (brighter)
        AnimatedBuilder(
          animation: _rotation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotation.value,
              child: Container(
                width: size + 36,
                height: size + 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      widget.color.withOpacity(0.0),
                      widget.color.withOpacity(0.22),
                      Colors.white.withOpacity(0.18),
                      widget.color.withOpacity(0.38),
                      widget.color.withOpacity(0.0),
                    ],
                    stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withOpacity(0.35),
                      blurRadius: 48,
                      spreadRadius: 16,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.12),
                      blurRadius: 32,
                      spreadRadius: 8,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // Pulsing radial glow (stronger)
        AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) {
            // Keep the widget size constant, only animate the opacity/blur
            return Container(
              width: size + 24,
              height: size + 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.18 * _pulse.value),
                    widget.color.withOpacity(0.32 * _pulse.value),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                  radius: 0.9,
                ),
              ),
            );
          },
        ),
        // Extra inner highlight
        Container(
          width: size + 8,
          height: size + 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withOpacity(0.18),
                widget.color.withOpacity(0.10),
                Colors.transparent,
              ],
              stops: const [0.0, 0.7, 1.0],
              radius: 0.95,
            ),
          ),
        ),
        // Subtle starburst overlay for extra shine
        IgnorePointer(
          child: CustomPaint(
            size: Size(size + 36, size + 36),
            painter: _StarburstPainter(color: widget.color.withOpacity(0.18)),
          ),
        ),
      ],
    );
  }

  Widget _buildSparkles(double size) {
    // More sparkles, more shine!
    final sparkleColor = Colors.white.withOpacity(0.98);
    final List<Widget> sparkles = [];
    for (int i = 0; i < 10; i++) {
      final t = i / 10.0;
      final radius = (size / 2 + 16) * (0.85 + 0.15 * (i % 2));
      final angle = 2 * 3.1415926535 * t;
      final dx = (size + 36) / 2 + radius * Math.cos(angle);
      final dy = (size + 36) / 2 + radius * Math.sin(angle);
      sparkles.add(
        Positioned(
          left: dx,
          top: dy,
          child: Opacity(
            opacity: _sparkleOpacity.value * (0.7 + 0.3 * (i % 2)),
            child: Icon(
              Icons.auto_awesome,
              color: sparkleColor,
              size: 12 + (i % 3) * 5.0,
              shadows: [
                Shadow(
                  color: widget.color.withOpacity(0.7),
                  blurRadius: 12,
                ),
                Shadow(
                  color: Colors.white.withOpacity(0.18),
                  blurRadius: 16,
                ),
              ],
            ),
          ),
        ),
      );
    }
    // Add a big sparkle on top for extra shine
    sparkles.add(
      Positioned(
        left: (size + 36) / 2 - 10,
        top: (size + 36) / 2 - 32,
        child: Opacity(
          opacity: _sparkleOpacity.value,
          child: Icon(
            Icons.star,
            color: Colors.white.withOpacity(0.85),
            size: 22,
            shadows: [
              Shadow(
                color: widget.color.withOpacity(0.7),
                blurRadius: 16,
              ),
            ],
          ),
        ),
      ),
    );
    return SizedBox(
      width: size + 36,
      height: size + 36,
      child: Stack(children: sparkles),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double size = 64;
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildSpectacularGlow(size),
        if (widget.premium) _buildSparkles(size),
        // Premium ring (brighter)
        if (widget.premium)
          Container(
            width: size + 14,
            height: size + 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.85),
                width: 3.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.28),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.10),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        // Icon itself
        CircleAvatar(
          backgroundColor: widget.color,
          radius: size / 2,
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Colors.white,
                widget.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Icon(widget.icon, color: Colors.white, size: 36),
          ),
        ),
      ],
    );
  }
}

// Custom painter for starburst shine
class _StarburstPainter extends CustomPainter {
  final Color color;
  _StarburstPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 12; i++) {
      final angle = 2 * 3.1415926535 * i / 12;
      final length = size.width / 2 * (i.isEven ? 1.0 : 0.7);
      canvas.drawLine(
        center,
        Offset(
          center.dx + length * Math.cos(angle),
          center.dy + length * Math.sin(angle),
        ),
        paint..color = color.withOpacity(i.isEven ? 0.22 : 0.12),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StepConnector extends StatelessWidget {
  final Color color;
  final bool isLeft;
  final bool vertical;

  const _StepConnector({
    required this.color,
    required this.isLeft,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    // Premium connector: animated shimmer, glow, and subtle sparkles
    final shimmerGradient = LinearGradient(
      colors: [
        color.withOpacity(0.35),
        color.withOpacity(0.75),
        color.withOpacity(0.18),
        color.withOpacity(0.55),
        color.withOpacity(0.12),
      ],
      stops: [0.0, 0.3, 0.5, 0.7, 1.0],
      begin: vertical
          ? Alignment.topCenter
          : (isLeft ? Alignment.centerLeft : Alignment.centerRight),
      end: vertical
          ? Alignment.bottomCenter
          : (isLeft ? Alignment.centerRight : Alignment.centerLeft),
    );

    Widget connectorBar({required double width, required double height}) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Glowing background
          Container(
            width: width + (vertical ? 8 : 24),
            height: height + (vertical ? 24 : 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.32),
                  blurRadius: 32,
                  spreadRadius: 4,
                ),
                BoxShadow(
                  color: color.withOpacity(0.10),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          // Animated shimmer (infinite loop)
          _ForeverShimmer(
            color: color,
            vertical: vertical,
            width: width,
            height: height,
            shimmerGradient: shimmerGradient,
          ),
          // Subtle sparkles
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _PremiumSparklePainter(
                  color: color,
                  vertical: vertical,
                ),
              ),
            ),
          ),
          // Premium border
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: color.withOpacity(0.38),
                width: 2,
              ),
            ),
          ),
        ],
      );
    }

    return vertical
        ? SizedBox(
            height: 64,
            child: Center(
              child: connectorBar(width: 12, height: 64),
            ),
          )
        : SizedBox(
            height: 16,
            child: Align(
              alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
              child: connectorBar(width: 112, height: 16),
            ),
          );
  }
}

class _ForeverShimmer extends StatefulWidget {
  final Color color;
  final bool vertical;
  final double width;
  final double height;
  final Gradient shimmerGradient;

  const _ForeverShimmer({
    required this.color,
    required this.vertical,
    required this.width,
    required this.height,
    required this.shimmerGradient,
  });

  @override
  State<_ForeverShimmer> createState() => _ForeverShimmerState();
}

class _ForeverShimmerState extends State<_ForeverShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
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
      builder: (context, child) {
        final value = _controller.value;
        return ShaderMask(
          shaderCallback: (bounds) {
            final double shimmerPos =
                value * (widget.vertical ? bounds.height : bounds.width);
            return LinearGradient(
              colors: [
                widget.color.withOpacity(0.18),
                Colors.white.withOpacity(0.55),
                widget.color.withOpacity(0.18),
              ],
              stops: [
                (shimmerPos - 40) / (widget.vertical ? bounds.height : bounds.width),
                shimmerPos / (widget.vertical ? bounds.height : bounds.width),
                (shimmerPos + 40) / (widget.vertical ? bounds.height : bounds.width),
              ],
              begin: widget.vertical ? Alignment.topCenter : Alignment.centerLeft,
              end: widget.vertical ? Alignment.bottomCenter : Alignment.centerRight,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: widget.shimmerGradient,
            ),
          ),
        );
      },
    );
  }
}

class _PremiumSparklePainter extends CustomPainter {
  final Color color;
  final bool vertical;
  _PremiumSparklePainter({required this.color, required this.vertical});

  @override
  void paint(Canvas canvas, Size size) {
    final sparklePaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    // Draw a few sparkles along the connector
    for (int i = 0; i < 3; i++) {
      final t = (i + 1) / 4;
      final dx = vertical ? size.width / 2 : size.width * t;
      final dy = vertical ? size.height * t : size.height / 2;
      canvas.drawCircle(Offset(dx, dy), 2.5 + i, sparklePaint..color = color.withOpacity(0.25 + 0.25 * i));
      canvas.drawCircle(Offset(dx, dy), 1.2 + i, Paint()..color = Colors.white.withOpacity(0.7 - 0.2 * i));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
