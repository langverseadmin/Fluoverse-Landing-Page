// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math' as math;

class GetStartedTitle extends StatelessWidget {
  const GetStartedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 68,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              height: 1.1,
            ),
            children: [
              TextSpan(
                text: 'Welcome to\n',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              TextSpan(
                text: 'Fluoverse',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [Color(0xFFB16CEA), Color(0xFFFF5E69)],
                    ).createShader(Rect.fromLTWH(0, 0, 200, 60)),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Your journey to Spanish fluency starts here.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}



class GetStartedFeature extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const GetStartedFeature({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<GetStartedFeature> createState() => _GetStartedFeatureState();
}

class _GetStartedFeatureState extends State<GetStartedFeature>
    with SingleTickerProviderStateMixin {
  bool _hovering = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(bool hover) {
    setState(() {
      _hovering = hover;
      if (hover) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final double tilt = _controller.value * 0.04;
          final double scale = 1 + _controller.value * 0.03;
          final double glow = _controller.value * 12;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(tilt)
              ..scale(scale),
            child: Stack(
              children: [
                // Glowing background
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: _hovering ? 1 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFB16CEA).withOpacity(0.18 + _controller.value * 0.18),
                              const Color(0xFFFF5E69).withOpacity(0.10 + _controller.value * 0.12),
                              Colors.transparent,
                            ],
                            radius: 1.1 + _controller.value * 0.2,
                            center: Alignment(0, -0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  width: 660,
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10 + _controller.value * 0.06),
                    borderRadius: BorderRadius.circular(28 + _controller.value * 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18 + _controller.value * 0.07),
                        blurRadius: 32 + glow,
                        offset: Offset(0, 16 + _controller.value * 4),
                      ),
                      BoxShadow(
                        color: const Color(0xFFB16CEA).withOpacity(0.18 + _controller.value * 0.07),
                        blurRadius: 16 + glow,
                        offset: Offset(0, 4 + _controller.value * 2),
                      ),
                    ],
                    border: Border.all(
                      color: Color.lerp(
                        const Color(0xFFB16CEA),
                        const Color(0xFFFF5E69),
                        _controller.value,
                      )!
                          .withOpacity(0.32 + _controller.value * 0.10),
                      width: 2.5 + _controller.value * 0.7,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {},
                    hoverColor: Colors.white.withOpacity(0.03),
                    splashColor: Colors.pinkAccent.withOpacity(0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated Icon with glow and spin
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutCubic,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color.lerp(const Color(0xFFB16CEA), const Color(0xFFFF5E69), _controller.value)!,
                                Color.lerp(const Color(0xFFFF5E69), const Color(0xFFB16CEA), _controller.value)!,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.lerp(const Color(0xFFB16CEA), const Color(0xFFFF5E69), _controller.value)!
                                    .withOpacity(0.45 + _controller.value * 0.15),
                                blurRadius: 18 + glow,
                                spreadRadius: 1 + _controller.value * 1,
                                offset: Offset(0, 6 + _controller.value * 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(22 + _controller.value * 3),
                          child: Transform.rotate(
                            angle: _controller.value * 2 * math.pi,
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Colors.white,
                                    const Color(0xFFFF5E69),
                                    Colors.white,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ).createShader(bounds);
                              },
                              child: Icon(
                                widget.icon,
                                size: 48 + _controller.value * 6,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.pinkAccent.withOpacity(0.20 + _controller.value * 0.15),
                                    blurRadius: 10 + glow,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                const Color(0xFFB16CEA),
                                const Color(0xFFFF5E69),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28 + _controller.value * 3,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.4,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.22 + _controller.value * 0.10),
                                  blurRadius: 8 + _controller.value * 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOutCubic,
                            style: TextStyle(
                              fontSize: 18 + _controller.value * 1,
                              color: Colors.white.withOpacity(0.80 + _controller.value * 0.10),
                              height: 1.5,
                              shadows: [
                                Shadow(
                                  color: Colors.pinkAccent.withOpacity(0.10 + _controller.value * 0.10),
                                  blurRadius: 6 + _controller.value * 4,
                                ),
                              ],
                            ),
                            child: Text(
                              widget.description,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Particle sparkle effect (simple, for demo)
                if (_hovering)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _SparklePainter(_controller.value),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SparklePainter extends CustomPainter {
  final double progress;
  _SparklePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15 + progress * 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final random = math.Random(42);
    for (int i = 0; i < 12; i++) {
      final dx = size.width * random.nextDouble();
      final dy = size.height * random.nextDouble();
      final radius = 2.0 + random.nextDouble() * 3.0 + progress * 6;
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(_SparklePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class GetStartedActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const GetStartedActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<GetStartedActionButton> createState() => _GetStartedActionButtonState();
}

class _GetStartedActionButtonState extends State<GetStartedActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 320),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hover) {
    setState(() {
      if (hover) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double scale = 1.0 + _controller.value * 0.04;
            final double glow = 8 + _controller.value * 18;
            final Color bgColor = Color.lerp(
              const Color(0xFFB16CEA),
              const Color(0xFFFF5E69),
              _controller.value,
            )!;
            return Transform.scale(
              scale: scale,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      bgColor,
                      Color.lerp(const Color(0xFFFF5E69), const Color(0xFFB16CEA), _controller.value)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20 + _controller.value * 6),
                  boxShadow: [
                    BoxShadow(
                      color: bgColor.withOpacity(0.38 + _controller.value * 0.18),
                      blurRadius: glow,
                      spreadRadius: 1 + _controller.value * 2,
                      offset: Offset(0, 6 + _controller.value * 2),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.18 + _controller.value * 0.18),
                    width: 2.2 + _controller.value * 1.2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 18),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Colors.white,
                            const Color.fromARGB(255, 255, 255, 255),
                            Colors.white,
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        widget.icon,
                        size: 28 + _controller.value * 6,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.pinkAccent.withOpacity(0.22 + _controller.value * 0.18),
                            blurRadius: 8 + _controller.value * 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 255, 255, 255),
                            const Color.fromARGB(255, 255, 255, 255),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: Text(
                        widget.label,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20 + _controller.value * 2,
                          color: Colors.white,
                          letterSpacing: 0.7,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.18 + _controller.value * 0.10),
                              blurRadius: 6 + _controller.value * 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
