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
            "Immerse yourself in interactive stories that bring your vocabulary to life. Explore short, engaging scenes tailored to your level and interests — designed to help you truly understand how words work in context.\n\nEvery story adjusts to your level — challenging but never overwhelming.",
      },
      {
        "icon": Icons.headphones_rounded,
        "color": const Color(0xFF2CB67D),
        "title": "Listening",
        "description":
            "Train your ear with native voices and real conversations. Voice-based learning helps you recognize natural accents, rhythm, and speaking patterns.\n\nEngaging listening exercises prepare you for confident, authentic dialogue.",
      },
      {
        "icon": Icons.record_voice_over_rounded,
        "color": const Color.fromARGB(255, 255, 145, 0),
        "title": "Scenario",
        "description":
            "Apply everything you've learned in realistic conversations with your AI coach. Order coffee, negotiate business deals, or chat about hobbies — each scenario is tailored to your goals.\n\nThe AI adapts to your level and responses, keeping conversations natural and building real confidence.",
      },
    ];

    final isMobile = MediaQuery.of(context).size.width < 600;

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
        if (!isMobile) ...[
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
        ],
        // Main content
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 1200,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 32,
                vertical: isMobile ? 24 : 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(isMobile: isMobile),
                  SizedBox(height: isMobile ? 28 : 60),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = !isMobile && constraints.maxWidth > 800;
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
                            padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 12 : 24,
                            ),
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
  final bool isMobile;
  const _Header({this.isMobile = false});

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
          child: Text(
            "How It Works",
            style: TextStyle(
              fontSize: isMobile ? 36 : 68,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.5,
              shadows: const [
                Shadow(
                  color: Colors.black54,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: isMobile ? 12 : 24),
        Text(
          "Our AI-powered fluency cycle adapts to you—your goals, your vibe, your pace. Each step builds your confidence and skills in a natural, engaging way.",
          style: TextStyle(
            fontSize: isMobile ? 15 : 18,
            height: 1.8,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
            shadows: const [
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double cardPadding = isMobile ? 22 : 44;
    final double iconSize = isMobile ? 44 : 64;
    final double titleFontSize = isMobile ? 22 : 32;
    final double stepFontSize = isMobile ? 15 : 22;
    final double descFontSize = isMobile ? 15 : 19;
    final double borderRadius = isMobile ? 22 : 40;
    final double borderWidth = isMobile ? 2.2 : 3.5;

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
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.30),
            blurRadius: isMobile ? 24 : 48,
            offset: Offset(0, isMobile ? 8 : 18),
            spreadRadius: isMobile ? 1 : 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: isMobile ? 6 : 12,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.38),
          width: borderWidth,
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
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              crossAxisAlignment:
                  isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment:
                      isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    if (isLeft)
                      _AnimatedGlowIcon(
                        icon: icon,
                        color: color,
                        premium: true,
                        size: iconSize,
                      )
                    else
                      const SizedBox(width: 0),
                    SizedBox(width: isMobile ? 10 : 24),
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
                          fontSize: stepFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.7,
                          shadows: [
                            Shadow(
                              color: color.withOpacity(0.35),
                              blurRadius: isMobile ? 6 : 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 10 : 24),
                    if (!isLeft)
                      _AnimatedGlowIcon(
                        icon: icon,
                        color: color,
                        premium: true,
                        size: iconSize,
                      )
                    else
                      const SizedBox(width: 0),
                  ],
                ),
                SizedBox(height: isMobile ? 16 : 28),
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
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.4,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: isMobile ? 6 : 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 10 : 18),
                Text(
                  description,
                  textAlign: isLeft ? TextAlign.left : TextAlign.right,
                  style: TextStyle(
                    fontSize: descFontSize,
                    height: 1.7,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.13,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: isMobile ? 3 : 6,
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
  final double? size;

  const _AnimatedGlowIcon({
    required this.icon,
    required this.color,
    this.premium = false,
    this.size,
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
    )..repeat();

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
    return Stack(
      alignment: Alignment.center,
      children: [
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
        AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) {
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
    final double size = widget.size ?? 64;
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildSpectacularGlow(size),
        if (widget.premium) _buildSparkles(size),
        if (widget.premium)
          Container(
            width: size + 14,
            height: size + 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.85),
                width: size < 50 ? 2.2 : 3.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.28),
                  blurRadius: size < 50 ? 12 : 24,
                  spreadRadius: size < 50 ? 2 : 4,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.10),
                  blurRadius: size < 50 ? 4 : 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
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
            child: Icon(widget.icon, color: Colors.white, size: size / 1.8),
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double width = vertical
        ? (isMobile ? 7 : 12)
        : (isMobile ? 60 : 112);
    final double height = vertical
        ? (isMobile ? 36 : 64)
        : (isMobile ? 8 : 16);

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
          Container(
            width: width + (vertical ? 4 : 12),
            height: height + (vertical ? 12 : 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 8 : 18),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.32),
                  blurRadius: isMobile ? 12 : 32,
                  spreadRadius: isMobile ? 2 : 4,
                ),
                BoxShadow(
                  color: color.withOpacity(0.10),
                  blurRadius: isMobile ? 3 : 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          _ForeverShimmer(
            color: color,
            vertical: vertical,
            width: width,
            height: height,
            shimmerGradient: shimmerGradient,
          ),
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
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 6 : 14),
              border: Border.all(
                color: color.withOpacity(0.38),
                width: isMobile ? 1.2 : 2,
              ),
            ),
          ),
        ],
      );
    }

    return vertical
        ? SizedBox(
            height: height,
            child: Center(
              child: connectorBar(width: width, height: height),
            ),
          )
        : SizedBox(
            height: height,
            child: Align(
              alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
              child: connectorBar(width: width, height: height),
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final borderRadius = BorderRadius.circular(isMobile ? 8 : 14);
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
                widget.color.withOpacity(isMobile ? 0.12 : 0.18),
                Colors.white.withOpacity(isMobile ? 0.38 : 0.55),
                widget.color.withOpacity(isMobile ? 0.12 : 0.18),
              ],
              stops: [
                (shimmerPos - (isMobile ? 24 : 40)) /
                    (widget.vertical ? bounds.height : bounds.width),
                shimmerPos / (widget.vertical ? bounds.height : bounds.width),
                (shimmerPos + (isMobile ? 24 : 40)) /
                    (widget.vertical ? bounds.height : bounds.width),
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
              borderRadius: borderRadius,
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
    final isMobile = size.shortestSide < 60;
    final sparklePaint = Paint()
      ..color = Colors.white.withOpacity(isMobile ? 0.55 : 0.7)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, isMobile ? 1.2 : 2);

    // Draw a few sparkles along the connector
    for (int i = 0; i < (isMobile ? 2 : 3); i++) {
      final t = (i + 1) / (isMobile ? 3 : 4);
      final dx = vertical ? size.width / 2 : size.width * t;
      final dy = vertical ? size.height * t : size.height / 2;
      canvas.drawCircle(
        Offset(dx, dy),
        (isMobile ? 1.8 : 2.5) + i,
        sparklePaint..color = color.withOpacity((isMobile ? 0.18 : 0.25) + 0.25 * i),
      );
      canvas.drawCircle(
        Offset(dx, dy),
        (isMobile ? 0.8 : 1.2) + i,
        Paint()..color = Colors.white.withOpacity((isMobile ? 0.5 : 0.7) - 0.2 * i),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
