// homepage_widgets.dart

// ignore_for_file: deprecated_member_use, unused_element_parameter, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:frontend/website/screens/contact.dart';
import 'dart:math';

import 'package:frontend/website/screens/join_waitlist.dart';
import 'package:frontend/website/screens/pricing.dart';

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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width < 900;
    final double maxContentWidth = isMobile ? double.infinity : 1100;
    final double horizontalPadding = isMobile ? 12 : isTablet ? 20 : 32;
    final double verticalPadding = isMobile ? 36 : isTablet ? 60 : 80;
    final double titleFontSize = isMobile ? 34 : isTablet ? 48 : 68;
    final double chatWidth = isMobile ? double.infinity : 320;
    final double chatMinHeight = isMobile ? 220 : 320;
    final double chatMaxHeight = isMobile ? 320 : 440;

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
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800 && !isMobile;
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
                      crossAxisAlignment: isWide
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
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
                                  fontSize: titleFontSize,
                                ),
                          ),
                        ).animate().fadeIn(duration: 800.ms),
                        SizedBox(height: isMobile ? 14 : 24),
                        Text(
                          'Build fluency through conversation, not just study. \n\nSpeak, listen, and interact as if you are truly there. 🌍✨',
                          textAlign: isWide ? TextAlign.left : TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: kAccentBlue.withOpacity(0.85),
                                fontSize: isMobile ? 15 : 18,
                              ),
                        ).animate().fadeIn(duration: 1000.ms),
                        SizedBox(height: isMobile ? 18 : 32),
                        Wrap(
                          spacing: isMobile ? 12 : 24,
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
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PricingPage(),
                                  ),
                                );
                              },
                              glowColor: kAccentBlue.withOpacity(0.32),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isWide)
                    const SizedBox(width: 24)
                  else
                    SizedBox(height: isMobile ? 18 : 32),
                  // Animated conversation demo with premium glassmorphic card and visual connector
                  Expanded(
                    flex: isWide ? 1 : 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glowing connector between text and chat (with fillets)
                        if (isWide)
                          Positioned(
                            left: -36,
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
                            width: chatWidth,
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
                              child: _ConversationDemo(
                                width: chatWidth,
                                minHeight: chatMinHeight,
                                maxHeight: chatMaxHeight,
                                isMobile: isMobile,
                              ),
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
  final double width;
  final double minHeight;
  final double maxHeight;
  final bool isMobile;

  const _ConversationDemo({
    this.width = 320,
    this.minHeight = 320,
    this.maxHeight = 440,
    this.isMobile = false,
  });

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
            width: widget.width,
            constraints: BoxConstraints(
              minHeight: widget.minHeight,
              maxHeight: widget.maxHeight,
            ),
            padding: EdgeInsets.all(widget.isMobile ? 10 : 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: kAccentBlue.withOpacity(0.10),
                  blurRadius: 28,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: kPremiumPurple.withOpacity(0.09),
                  blurRadius: 18,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
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
                                  bottom: i == _bubbles.length - 1 ? 0 : (widget.isMobile ? 4 : 8),
                                ),
                                child: _bubbles[i].copyWith(isMobile: widget.isMobile),
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: widget.isMobile ? 4 : 10),
                        AnimatedOpacity(
                          opacity: visibleCount == _bubbles.length ? 1 : 0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          child: Padding(
                            padding: EdgeInsets.only(top: widget.isMobile ? 4.0 : 8.0),
                            child: Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                              size: widget.isMobile ? 24 : 34,
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
  final bool isMobile;
  const _ChatBubble({required this.text, required this.isUser, this.isMobile = false});

  _ChatBubble copyWith({bool? isMobile}) =>
      _ChatBubble(text: text, isUser: isUser, isMobile: isMobile ?? this.isMobile);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: isMobile ? 1 : 2),
        padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 10 : 16, vertical: isMobile ? 7 : 11),
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
          borderRadius: BorderRadius.circular(isMobile ? 10 : 16),
          boxShadow: [
            BoxShadow(
              color: (isUser ? kPremiumPurple : kAccentBlue).withOpacity(0.10),
              blurRadius: isMobile ? 3 : 7,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : kAccentBlue,
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 13 : 15,
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
  final mq = MediaQuery.of(context);
  final isMobile = mq.size.width < 600;
  final width = mq.size.width;
  final height = mq.size.height;

  // Use screen percentage for sizing, but clamp to original look
  double percent(double v, {double min = 0, double? max}) {
    final val = v;
    if (max != null) return val.clamp(min, max);
    return val < min ? min : val;
  }

  final double horizontalPadding = percent(width * 0.04, min: 12, max: 48);
  final double verticalPadding = percent(height * 0.03, min: 18, max: 44);
  final double borderRadius = percent(width * 0.03, min: 14, max: isMobile ? 18 : 36);
  final double iconSize = percent(width * 0.06, min: 32, max: isMobile ? 38 : 64);
  final double iconPadding = percent(iconSize * 0.11, min: 3, max: isMobile ? 4 : 8);
  final double titleFontSize = percent(width * 0.045, min: 22, max: isMobile ? 28 : 54);
  final double titleLetterSpacing = isMobile ? 1.1 : 2.2;
  final double maxWidth = isMobile ? percent(width * 0.96, min: 220, max: 380) : percent(width * 0.8, min: 320, max: 840);
  final double textFontSize = percent(width * 0.022, min: 13, max: isMobile ? 15 : 18);
  final double buttonHeight = percent(height * 0.06, min: 38, max: isMobile ? 48 : 62);
  final double gap1 = percent(height * 0.015, min: 10, max: isMobile ? 16 : 32);
  final double gap2 = percent(height * 0.018, min: 12, max: isMobile ? 18 : 40);
  final double gap3 = percent(height * 0.018, min: 12, max: isMobile ? 18 : 40);

  return Padding(
    padding: EdgeInsets.symmetric(vertical: isMobile ? percent(height * 0.045, min: 24, max: 72) : percent(height * 0.09, min: 36, max: 72)),
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
        count: isMobile ? 12 : 28,
        maxSize: isMobile ? 18 : 32,
        minOpacity: 0.18,
        maxOpacity: 0.28,
        ),
      ),
      ),
      // Main content with smaller, more premium glassmorphic card
      ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
        return Stack(
          children: [
          Container(
            padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
            ),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white.withOpacity(isMobile ? 0.65 : 0.38),
            border: Border.all(
              color: Colors.white.withOpacity(0.55),
              width: isMobile ? 1.6 : 2.6,
            ),
            boxShadow: [
              BoxShadow(
              color: kPremiumPurple.withOpacity(isMobile ? 0.13 : 0.23),
              blurRadius: isMobile ? 32 : 72,
              spreadRadius: isMobile ? 6 : 16,
              offset: Offset(0, isMobile ? 12 : 36),
              ),
              BoxShadow(
              color: kAccentBlue.withOpacity(isMobile ? 0.09 : 0.13),
              blurRadius: isMobile ? 18 : 40,
              spreadRadius: isMobile ? 3 : 10,
              offset: Offset(0, isMobile ? 4 : 10),
              ),
            ],
            backgroundBlendMode: BlendMode.srcOver,
            ),
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isMobile
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  // Icon
                  Container(
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                      color: kPremiumPurple.withOpacity(0.45),
                      blurRadius: 18,
                      spreadRadius: 1,
                      ),
                      BoxShadow(
                      color: Colors.white.withOpacity(0.35),
                      blurRadius: 4,
                      spreadRadius: 1,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.85),
                      width: 2,
                    ),
                    gradient: const LinearGradient(
                      colors: [kPremiumPurple, kAccentBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    ),
                    padding: EdgeInsets.all(iconPadding),
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
                      size: iconSize,
                      shadows: [
                      Shadow(
                        color: kPremiumPurple.withOpacity(0.7),
                        blurRadius: 12,
                      ),
                      Shadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 4,
                      ),
                      ],
                    ),
                    ),
                  )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0, duration: 600.ms),
                  SizedBox(height: gap1),
                  // Title
                  Stack(
                    children: [
                    // Stroke effect
                    Text(
                      'Coming Soon',
                      style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w900,
                      letterSpacing: titleLetterSpacing,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.2
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
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w900,
                        letterSpacing: titleLetterSpacing,
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
                )
                : Row(
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
                    padding: EdgeInsets.all(iconPadding),
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
                      size: iconSize,
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
                  SizedBox(width: gap1),
                  // Text with strong shadow and stroke for pop
                  Stack(
                    children: [
                    // Stroke effect
                    Text(
                      'Coming Soon',
                      style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w900,
                      letterSpacing: titleLetterSpacing,
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
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w900,
                        letterSpacing: titleLetterSpacing,
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
              SizedBox(height: gap2),
              Text(
              'Fluoverse is almost here — a bold new way to learn by speaking.\n\nJoin early and shape the future of language learning.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.92),
                fontSize: textFontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                shadows: [
                Shadow(
                  color: Colors.white.withOpacity(0.7),
                  blurRadius: 8,
                ),
                Shadow(
                  color: kAccentBlue.withOpacity(0.18),
                  blurRadius: 8,
                ),
                ],
              ),
              ).animate().fadeIn(duration: 1200.ms),
              SizedBox(height: gap3),
              SizedBox(
              height: buttonHeight,
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
                borderRadius: borderRadius,
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
    // Responsive: reduce particle count/size on mobile for clarity/performance
    final isMobile = MediaQuery.of(context).size.width < 600;
    final count = isMobile ? (widget.count / 2).ceil() : widget.count;
    final maxSize = isMobile ? (widget.maxSize * 0.7).clamp(8, 18) : widget.maxSize;
    final minOpacity = isMobile ? (widget.minOpacity * 0.8) : widget.minOpacity;
    final maxOpacity = isMobile ? (widget.maxOpacity * 0.8) : widget.maxOpacity;

    // Re-generate particles if config changes (rare)
    final particles = isMobile
        ? _particles.take(count).map((p) => _Particle(
              dx: p.dx,
              dy: p.dy,
              size: ((p.size * 0.7).clamp(6, maxSize) as double),
              color: p.color.withOpacity(
                  (p.color.opacity * 0.8).clamp(minOpacity, maxOpacity)),
              speed: p.speed,
              direction: p.direction,
            )).toList()
        : _particles;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _ParticlesPainter(
            particles,
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double logoSize = isMobile ? 68 : 110;
    final double logoIconSize = isMobile ? 32 : 54;
    final double logoBorder = isMobile ? 2.2 : 3.5;
    final double logoInnerBorder = isMobile ? 1.2 : 2.2;
    final double logoPadding = isMobile ? 10 : 18;
    final double titleFontSize = isMobile ? 19 : 34;
    final double titleLetterSpacing = isMobile ? 0.7 : 1.8;
    final double socialSpacing = isMobile ? 12 : 22;
    final double taglineFontSize = isMobile ? 13.5 : 19;
    final double taglineSpacing = isMobile ? 0.5 : 0.9;
    final double verticalPadding = isMobile ? 38 : 80;
    final double sectionSpacing = isMobile ? 16 : 28;
    final double socialRowSpacing = isMobile ? 18 : 36;
    final double taglineSpacingY = isMobile ? 10 : 26;

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
        Positioned.fill(
          child: IgnorePointer(
            child: _AnimatedParticles(
              count: isMobile ? 12 : 28,
              maxSize: isMobile ? 18 : 38,
              minOpacity: 0.13,
              maxOpacity: 0.28,
            ),
          ),
        ),
        // Ultra-premium content with floating, glowing, layered effects
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Floating glowing logo with layered shine
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: logoSize,
                      height: logoSize,
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
                            blurRadius: isMobile ? 28 : 60,
                            spreadRadius: isMobile ? 6 : 16,
                          ),
                          BoxShadow(
                            color: kAccentBlue.withOpacity(0.18),
                            blurRadius: isMobile ? 14 : 32,
                            spreadRadius: isMobile ? 2 : 4,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.85),
                          width: logoBorder,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(logoPadding),
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
                            blurRadius: isMobile ? 10 : 24,
                            spreadRadius: isMobile ? 1 : 2,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.92),
                          width: logoInnerBorder,
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
                          width: logoIconSize,
                          height: logoIconSize,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.18, end: 0, duration: 700.ms),
                SizedBox(height: sectionSpacing),
                // Gradient animated text with stroke and shadow
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Stroke effect
                    Text(
                      'Fluoverse © 2025',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w900,
                        letterSpacing: titleLetterSpacing,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = isMobile ? 1.5 : 3
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
                      child: Text(
                        'Fluoverse © 2025',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w900,
                          letterSpacing: titleLetterSpacing,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 900.ms),
                SizedBox(height: sectionSpacing),
                // Premium links with animated underline and glow
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: isMobile ? 8 : 0,
                  runSpacing: isMobile ? 8 : 0,
                  children: [
                    _FooterLink('Privacy'),
                    _FooterDot(),
                    _FooterLink('Terms'),
                    _FooterDot(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ContactScreen(),
                          ),
                        );
                      },
                      child: _FooterLink('Support'),
                    ),
                  ],
                ).animate().fadeIn(duration: 1100.ms),
                SizedBox(height: socialRowSpacing),
                // Social icons with premium hover and animated glow
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: socialSpacing,
                  children: [
                    _FooterSocialIcon(Icons.email_rounded, onTap: () {}),
                    // Replace with a generic chat icon for Discord
                    _FooterSocialIcon(Icons.chat_rounded, onTap: () {}),
                    // Replace with send icon for Telegram
                    _FooterSocialIcon(Icons.send_rounded, onTap: () {}),
                    _FooterSocialIcon(Icons.language, onTap: () {}),
                  ],
                ).animate().fadeIn(duration: 1300.ms),
                SizedBox(height: taglineSpacingY),
                // Subtle animated tagline
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [kPremiumPurple, kAccentBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    'Speak. Connect. Belong.',
                    style: TextStyle(
                      fontSize: taglineFontSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: taglineSpacing,
                      shadows: [
                        Shadow(
                          color: kPremiumPurple,
                          blurRadius: isMobile ? 6 : 12,
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double verticalPadding = isMobile ? 48 : 90;
    final double horizontalPadding = isMobile ? 8 : 16;
    final double titleFontSize = isMobile ? 28 : 40;
    final double spacing = isMobile ? 18 : 40;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
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
                    fontSize: titleFontSize,
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
          SizedBox(height: isMobile ? 28 : 48),
          // Use IntrinsicHeight to prevent parent height change on hover
          LayoutBuilder(
            builder: (context, constraints) {
              if (isMobile) {
                // Stack vertically for mobile
                return Column(
                  mainAxisSize: MainAxisSize.min,
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
                      isMobile: true,
                      cardWidth: 210, // smaller width for mobile
                    ),
                    SizedBox(height: 18),
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
                      isMobile: true,
                      cardWidth: 210,
                    ),
                    SizedBox(height: 18),
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
                      isMobile: true,
                      cardWidth: 210,
                    ),
                  ],
                );
              } else {
                // Use Wrap for desktop/tablet
                return IntrinsicHeight(
                  child: Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
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
                        isMobile: false,
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
                        isMobile: false,
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
                        isMobile: false,
                      ),
                    ],
                  ),
                );
              }
            },
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
  final bool isMobile;
  final double? cardWidth;

  const _ValueCardPremium({
    required this.icon,
    required this.gradient,
    required this.iconGlow,
    required this.title,
    required this.description,
    this.isMobile = false,
    this.cardWidth,
  });

  @override
  State<_ValueCardPremium> createState() => _ValueCardPremiumState();
}

class _ValueCardPremiumState extends State<_ValueCardPremium> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    final double cardWidth = widget.isMobile
        ? (widget.cardWidth ?? 210)
        : 250;
    final double cardHeight = widget.isMobile ? 210 : 320;
    final double iconSize = widget.isMobile ? 28 : 32;
    final double iconBgSize = widget.isMobile ? 48 : 58;
    final double iconBgSizeHover = widget.isMobile ? 56 : 68;
    final double iconBgBorder = widget.isMobile ? 2.2 : 3.6;
    final double iconBgBorderHover = widget.isMobile ? 2.8 : 3.6;
    final double titleFontSize = widget.isMobile ? 16.5 : 19;
    final double descFontSize = widget.isMobile ? 13.5 : 15.5;
    final double scale = _hovering && !widget.isMobile ? 1.06 : 1.0;
    final Duration duration = const Duration(milliseconds: 220);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!widget.isMobile) setState(() => _hovering = true);
      },
      onExit: (_) {
        if (!widget.isMobile) setState(() => _hovering = false);
      },
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
                borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 22),
                gradient: _hovering && !widget.isMobile
                    ? widget.gradient
                    : const LinearGradient(
                        colors: [Colors.white, Color(0xFFF6F8FE)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                border: Border.all(
                  color: _hovering && !widget.isMobile
                      ? Colors.white.withOpacity(0.98)
                      : kAccentBlue.withOpacity(0.13),
                  width: _hovering && !widget.isMobile ? 2.6 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.iconGlow.withOpacity(
                        (_hovering && !widget.isMobile) ? 0.32 : 0.13),
                    blurRadius: (_hovering && !widget.isMobile) ? 44 : 18,
                    spreadRadius: (_hovering && !widget.isMobile) ? 12 : 3,
                    offset: const Offset(0, 18),
                  ),
                  if (_hovering && !widget.isMobile)
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
                  if (_hovering && !widget.isMobile)
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
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.isMobile ? 14 : 22,
                        vertical: widget.isMobile ? 18 : 36),
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
                                width: _hovering && !widget.isMobile
                                    ? iconBgSizeHover
                                    : iconBgSize,
                                height: _hovering && !widget.isMobile
                                    ? iconBgSizeHover
                                    : iconBgSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: widget.gradient,
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.iconGlow.withOpacity(
                                          (_hovering && !widget.isMobile)
                                              ? 0.45
                                              : 0.22),
                                      blurRadius: (_hovering && !widget.isMobile)
                                          ? 38
                                          : 18,
                                      spreadRadius:
                                          (_hovering && !widget.isMobile)
                                              ? 10
                                              : 3,
                                    ),
                                    if (_hovering && !widget.isMobile)
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.22),
                                        blurRadius: 18,
                                        spreadRadius: 1,
                                      ),
                                  ],
                                  border: Border.all(
                                    color: Colors.white.withOpacity(
                                        (_hovering && !widget.isMobile)
                                            ? 0.98
                                            : 0.7),
                                    width: (_hovering && !widget.isMobile)
                                        ? iconBgBorderHover
                                        : iconBgBorder,
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
                                  size: (_hovering && !widget.isMobile)
                                      ? iconSize + 6
                                      : iconSize,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: widget.iconGlow.withOpacity(0.7),
                                      blurRadius: widget.isMobile ? 8 : 18,
                                    ),
                                    Shadow(
                                      color: Colors.black.withOpacity(0.13),
                                      blurRadius: widget.isMobile ? 3 : 7,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: widget.isMobile ? 12 : 22),
                          // Gradient title with strong shadow, turns white on hover
                          AnimatedDefaultTextStyle(
                            duration: duration,
                            curve: Curves.easeOutCubic,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: titleFontSize,
                              color: (_hovering && !widget.isMobile)
                                  ? Colors.white
                                  : null,
                              letterSpacing: 0.2,
                              shadows: [
                                Shadow(
                                  color: widget.iconGlow.withOpacity(0.22),
                                  blurRadius: widget.isMobile ? 4 : 10,
                                ),
                              ],
                            ),
                            child: (_hovering && !widget.isMobile)
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
                          SizedBox(height: widget.isMobile ? 8 : 14),
                          // Description with animated color and shadow
                          AnimatedDefaultTextStyle(
                            duration: duration,
                            curve: Curves.easeOutCubic,
                            style: TextStyle(
                              fontSize: descFontSize,
                              color: (_hovering && !widget.isMobile)
                                  ? Colors.white.withOpacity(0.96)
                                  : Colors.black.withOpacity(0.82),
                              fontWeight: FontWeight.w500,
                              shadows: (_hovering && !widget.isMobile)
                                  ? [
                                      Shadow(
                                        color: widget.iconGlow.withOpacity(0.18),
                                        blurRadius: widget.isMobile ? 4 : 10,
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
    final mq = MediaQuery.of(context);
    final isMobile = mq.size.width < 600;
    final width = mq.size.width;
    final height = mq.size.height;

    // Helper for percent with min/max clamp
    double percent(double v, {double min = 0, double? max}) {
      final val = v;
      if (max != null) return val.clamp(min, max);
      return val < min ? min : val;
    }

    final double verticalPadding = percent(height * 0.06, min: 32, max: isMobile ? 60 : 120);
    final double horizontalPadding = percent(width * 0.03, min: 8, max: isMobile ? 18 : 32);
    final double titleFontSize = percent(width * 0.045, min: 22, max: isMobile ? 32 : 54);
    final double subtitleFontSize = percent(width * 0.022, min: 13, max: isMobile ? 16 : 22);
    final double stepCardWidth = isMobile
      ? percent(width * 0.82, min: 120, max: 510)
      : percent(width * 0.19, min: 120, max: 220);
    final double stepCardHeight = isMobile ? percent(height * 0.23, min: 90, max: 180) : percent(height * 0.16, min: 120, max: 220);
    final double stepIconSize = isMobile ? percent(width * 0.055, min: 16, max: 28) : percent(width * 0.025, min: 18, max: 32);
    final double stepIconBgSize = isMobile ? percent(width * 0.16, min: 24, max: 44) : percent(width * 0.08, min: 32, max: 56);
    final double stepSpacing = isMobile ? percent(height * 0.018, min: 10, max: 24) : percent(width * 0.04, min: 24, max: 64);
    final double stepTitleFontSize = isMobile ? percent(width * 0.088, min: 11, max: 20) : percent(width * 0.018, min: 13, max: 22);
    final double stepSubtitleFontSize = isMobile ? percent(width * 0.082, min: 10, max: 14) : percent(width * 0.014, min: 11, max: 16);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
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
                    fontSize: titleFontSize,
                    letterSpacing: 2.2,
                  ),
            ),
          ).animate().fadeIn(duration: 600.ms),
          SizedBox(height: isMobile ? 10 : 18),
          Text(
            'Four steps to fluency, one cycle at a time',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: kAccentBlue.withOpacity(0.82),
                  fontWeight: FontWeight.w600,
                  fontSize: subtitleFontSize,
                  letterSpacing: 0.7,
                ),
          ).animate().fadeIn(duration: 900.ms),
          SizedBox(height: isMobile ? 32 : 64),
          // Steps with premium glass and connectors
          isMobile
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CycleStepPremium(
                      step: 1,
                      title: 'Vocabulary',
                      subtitle: 'Learn key words with context',
                      icon: Icons.menu_book_rounded,
                      gradient: const LinearGradient(
                        colors: [kAccentBlue, kPremiumPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      iconGlow: kAccentBlue,
                      width: stepCardWidth,
                      height: stepCardHeight,
                      iconSize: stepIconSize,
                      iconBgSize: stepIconBgSize,
                      titleFontSize: stepTitleFontSize,
                      subtitleFontSize: stepSubtitleFontSize,
                      isMobile: true,
                    ),
                    SizedBox(height: stepSpacing),
                    _CycleStepPremium(
                      step: 2,
                      title: 'Reading',
                      subtitle: 'Understand in interactive scenarios',
                      icon: Icons.menu_rounded,
                      gradient: const LinearGradient(
                        colors: [kPremiumPurple, kAccentBlue],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      iconGlow: kPremiumPurple,
                      width: stepCardWidth,
                      height: stepCardHeight,
                      iconSize: stepIconSize,
                      iconBgSize: stepIconBgSize,
                      titleFontSize: stepTitleFontSize,
                      subtitleFontSize: stepSubtitleFontSize,
                      isMobile: true,
                    ),
                    SizedBox(height: stepSpacing),
                    _CycleStepPremium(
                      step: 3,
                      title: 'Listening',
                      subtitle: 'Train your ear with native audio',
                      icon: Icons.headphones_rounded,
                      gradient: const LinearGradient(
                        colors: [kAccentBlue, kPremiumPurple],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      iconGlow: kAccentBlue,
                      width: stepCardWidth,
                      height: stepCardHeight,
                      iconSize: stepIconSize,
                      iconBgSize: stepIconBgSize,
                      titleFontSize: stepTitleFontSize,
                      subtitleFontSize: stepSubtitleFontSize,
                      isMobile: true,
                    ),
                    SizedBox(height: stepSpacing),
                    _CycleStepPremium(
                      step: 4,
                      title: 'Scenario',
                      subtitle: 'Practice speaking in real life situations',
                      icon: Icons.record_voice_over_rounded,
                      gradient: const LinearGradient(
                        colors: [kPremiumPurple, kAccentBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      iconGlow: kPremiumPurple,
                      width: stepCardWidth,
                      height: stepCardHeight,
                      iconSize: stepIconSize,
                      iconBgSize: stepIconBgSize,
                      titleFontSize: stepTitleFontSize,
                      subtitleFontSize: stepSubtitleFontSize,
                      isMobile: true,
                    ),
                  ],
                )
              : SizedBox(
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
                        children: [
                          _CycleStepPremium(
                            step: 1,
                            title: 'Vocabulary',
                            subtitle: 'Learn key words with context',
                            icon: Icons.menu_book_rounded,
                            gradient: const LinearGradient(
                              colors: [kAccentBlue, kPremiumPurple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            iconGlow: kAccentBlue,
                            width: stepCardWidth,
                            height: stepCardHeight,
                            iconSize: stepIconSize,
                            iconBgSize: stepIconBgSize,
                            titleFontSize: stepTitleFontSize,
                            subtitleFontSize: stepSubtitleFontSize,
                            isMobile: false,
                          ),
                          SizedBox(width: stepSpacing),
                          _CycleStepPremium(
                            step: 2,
                            title: 'Reading',
                            subtitle: 'Understand in interactive scenarios',
                            icon: Icons.menu_rounded,
                            gradient: const LinearGradient(
                              colors: [kPremiumPurple, kAccentBlue],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            iconGlow: kPremiumPurple,
                            width: stepCardWidth,
                            height: stepCardHeight,
                            iconSize: stepIconSize,
                            iconBgSize: stepIconBgSize,
                            titleFontSize: stepTitleFontSize,
                            subtitleFontSize: stepSubtitleFontSize,
                            isMobile: false,
                          ),
                          SizedBox(width: stepSpacing),
                          _CycleStepPremium(
                            step: 3,
                            title: 'Listening',
                            subtitle: 'Train your ear with native audio',
                            icon: Icons.headphones_rounded,
                            gradient: const LinearGradient(
                              colors: [kAccentBlue, kPremiumPurple],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            iconGlow: kAccentBlue,
                            width: stepCardWidth,
                            height: stepCardHeight,
                            iconSize: stepIconSize,
                            iconBgSize: stepIconBgSize,
                            titleFontSize: stepTitleFontSize,
                            subtitleFontSize: stepSubtitleFontSize,
                            isMobile: false,
                          ),
                          SizedBox(width: stepSpacing),
                          _CycleStepPremium(
                            step: 4,
                            title: 'Scenario',
                            subtitle: 'Practice speaking in real life situations',
                            icon: Icons.record_voice_over_rounded,
                            gradient: const LinearGradient(
                              colors: [kPremiumPurple, kAccentBlue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            iconGlow: kPremiumPurple,
                            width: stepCardWidth,
                            height: stepCardHeight,
                            iconSize: stepIconSize,
                            iconBgSize: stepIconBgSize,
                            titleFontSize: stepTitleFontSize,
                            subtitleFontSize: stepSubtitleFontSize,
                            isMobile: false,
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
  final double width;
  final double height;
  final double iconSize;
  final double iconBgSize;
  final double titleFontSize;
  final double subtitleFontSize;
  final bool isMobile;

  const _CycleStepPremium({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.iconGlow,
    required this.width,
    required this.height,
    required this.iconSize,
    required this.iconBgSize,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.isMobile,
  });

  @override
  State<_CycleStepPremium> createState() => _CycleStepPremiumState();
}

class _CycleStepPremiumState extends State<_CycleStepPremium> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final double scale = _hovering && !widget.isMobile ? 1.08 : 1.0;
    final Duration duration = const Duration(milliseconds: 200);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!widget.isMobile) setState(() => _hovering = true);
      },
      onExit: (_) {
        if (!widget.isMobile) setState(() => _hovering = false);
      },
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
              width: widget.width,
              height: widget.height,
              padding: EdgeInsets.symmetric(
                horizontal: widget.isMobile ? 10 : 18,
                vertical: widget.isMobile ? 12 : 22,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.isMobile ? 18 : 28),
                gradient: (_hovering && !widget.isMobile)
                    ? widget.gradient
                    : const LinearGradient(
                        colors: [Colors.white, Color(0xFFF6F8FE)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                border: Border.all(
                  color: (_hovering && !widget.isMobile)
                      ? Colors.white.withOpacity(0.99)
                      : kAccentBlue.withOpacity(0.13),
                  width: (_hovering && !widget.isMobile) ? 2.2 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.iconGlow.withOpacity(
                        (_hovering && !widget.isMobile) ? 0.18 : 0.08),
                    blurRadius: (_hovering && !widget.isMobile) ? 22 : 10,
                    spreadRadius: (_hovering && !widget.isMobile) ? 6 : 2,
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
                        width: (_hovering && !widget.isMobile)
                            ? widget.iconBgSize + 10
                            : widget.iconBgSize,
                        height: (_hovering && !widget.isMobile)
                            ? widget.iconBgSize + 10
                            : widget.iconBgSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: widget.gradient,
                          boxShadow: [
                            BoxShadow(
                              color: widget.iconGlow.withOpacity(
                                  (_hovering && !widget.isMobile) ? 0.22 : 0.10),
                              blurRadius:
                                  (_hovering && !widget.isMobile) ? 18 : 8,
                              spreadRadius:
                                  (_hovering && !widget.isMobile) ? 4 : 1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(
                                (_hovering && !widget.isMobile) ? 0.98 : 0.7),
                            width: (_hovering && !widget.isMobile) ? 2.6 : 1.6,
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
                          size: (_hovering && !widget.isMobile)
                              ? widget.iconSize + 4
                              : widget.iconSize,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: widget.isMobile ? 10 : 18),
                  // Gradient title with strong shadow, turns white on hover
                  AnimatedDefaultTextStyle(
                    duration: duration,
                    curve: Curves.easeOutCubic,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.titleFontSize,
                      color: (_hovering && !widget.isMobile)
                          ? Colors.white
                          : null,
                      letterSpacing: 0.3,
                    ),
                    child: (_hovering && !widget.isMobile)
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
                  SizedBox(height: widget.isMobile ? 4 : 8),
                  AnimatedDefaultTextStyle(
                    duration: duration,
                    curve: Curves.easeOutCubic,
                    style: TextStyle(
                      fontSize: widget.subtitleFontSize,
                      color: (_hovering && !widget.isMobile)
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
            // Step number badge: only visible on hover, below the card (desktop only)
            if (!widget.isMobile)
              AnimatedOpacity(
                opacity: _hovering ? 1.0 : 0.0,
                duration: duration,
                curve: Curves.easeOutCubic,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
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

// Draws animated connectors between cycle steps for premium look (desktop only)
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double verticalPadding = isMobile ? 60 : 140;
    final double planetHeight = isMobile ? 110 : 180;
    final double titleFontSize = isMobile ? 28 : 54;
    final double titleSpacing = isMobile ? 1.2 : 2.8;
    final double dividerHeight = isMobile ? 2.5 : 4;
    final double dividerWidth = isMobile ? 60 : 120;
    final double cardPaddingV = isMobile ? 28 : 60;
    final double cardPaddingH = isMobile ? 14 : 48;
    final double cardFontSize = isMobile ? 18 : 38;
    final double cardRadius = isMobile ? 18 : 40;
    final double chipSpacing = isMobile ? 18 : 54;
    final double chipRunSpacing = isMobile ? 14 : 38;
    final double chipWidth = isMobile ? 120 : 210;
    final double chipHeight = isMobile ? 48 : 80;
    final double chipIconSize = isMobile ? 22 : 34;
    final double chipFontSize = isMobile ? 12.5 : 18;
    final double spaceCodeHeight = isMobile ? 32 : 60;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 0),
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
            // Aurora/Nebula Glow Layer
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
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 1300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Floating glass planet
                  SizedBox(
                    height: planetHeight,
                    child: Center(
                      child: _AnimatedGlassPlanet(
                        size: isMobile ? 80 : 160,
                        iconSize: isMobile ? 36 : 70,
                        ringSize: isMobile ? 100 : 200,
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 10 : 24),
                  // Title
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
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w900,
                            letterSpacing: titleSpacing * spacing,
                            color: Colors.white,
                            fontFamily: 'Orbitron',
                            shadows: [
                              Shadow(
                                color: kAccentBlue.withOpacity(0.38),
                                blurRadius: isMobile ? 8 : 24,
                              ),
                              Shadow(
                                color: kPremiumPurple.withOpacity(0.18),
                                blurRadius: isMobile ? 4 : 12,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: isMobile ? 18 : 54),
                  // Divider
                  Container(
                    height: dividerHeight,
                    width: dividerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(dividerHeight),
                      gradient: const LinearGradient(
                        colors: [kAccentBlue, kPremiumPurple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kAccentBlue.withOpacity(0.22),
                          blurRadius: isMobile ? 6 : 18,
                          spreadRadius: isMobile ? 1 : 2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 24 : 64),
                  // Vision statement card
                  Container(
                    padding: EdgeInsets.symmetric(vertical: cardPaddingV, horizontal: cardPaddingH),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cardRadius),
                      color: Colors.white.withOpacity(0.09),
                      border: Border.all(
                        color: kAccentBlue.withOpacity(0.22),
                        width: isMobile ? 1.2 : 2.2,
                      ),
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
                              fontSize: cardFontSize,
                              letterSpacing: isMobile ? 0.7 : 2.2,
                              fontFamily: 'Orbitron',
                              height: 1.32,
                              shadows: [
                                Shadow(
                                  color: kPremiumPurple.withOpacity(0.22),
                                  blurRadius: isMobile ? 8 : 24,
                                ),
                              ],
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 24 : 64),
                  // Vision chips
                  Wrap(
                    spacing: chipSpacing,
                    runSpacing: chipRunSpacing,
                    alignment: WrapAlignment.center,
                    children: [
                      _VisionChip(
                        icon: Icons.rocket_launch_rounded,
                        label: "Bridge\nCultures",
                        color: kAccentBlue,
                        width: chipWidth,
                        height: chipHeight,
                        iconSize: chipIconSize,
                        fontSize: chipFontSize,
                      ),
                      _VisionChip(
                        icon: Icons.hub_rounded,
                        label: "Connect\nLearners",
                        color: kPremiumPurple,
                        width: chipWidth,
                        height: chipHeight,
                        iconSize: chipIconSize,
                        fontSize: chipFontSize,
                      ),
                      _VisionChip(
                        icon: Icons.lightbulb_rounded,
                        label: "Ignite\nMinds",
                        color: kAccentBlue,
                        width: chipWidth,
                        height: chipHeight,
                        iconSize: chipIconSize,
                        fontSize: chipFontSize,
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 24 : 64),
                  // Space code line
                  SizedBox(
                    height: spaceCodeHeight,
                    child: _SpaceCodeLine(
                      fontSize: isMobile ? 11.5 : 18,
                      padding: isMobile ? 6 : 14,
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

// Aurora/Nebula Glow Painter (unchanged)
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

// Animated floating glass planet with shifting gradient and orbiting ring
class _AnimatedGlassPlanet extends StatefulWidget {
  final double size;
  final double iconSize;
  final double ringSize;
  const _AnimatedGlassPlanet({
    this.size = 160,
    this.iconSize = 70,
    this.ringSize = 200,
    super.key,
  });

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
                size: Size(widget.ringSize, widget.ringSize),
                painter: _PlanetRingPainter(strokeWidth: widget.size * 0.045),
              ),
            ),
            // Floating planet
            Transform.translate(
              offset: Offset(0, widget.size * 0.19 * (0.5 - 0.5 * (1 + sin(t * 2 * 3.1415)))),
              child: Container(
                width: widget.size,
                height: widget.size,
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
                  border: Border.all(
                    color: Colors.white.withOpacity(0.85),
                    width: widget.size * 0.025,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.public_rounded,
                    color: Colors.white.withOpacity(0.93),
                    size: widget.iconSize,
                    shadows: [
                      Shadow(
                        color: kAccentBlue.withOpacity(0.32),
                        blurRadius: widget.size * 0.15,
                      ),
                      Shadow(
                        color: kPremiumPurple.withOpacity(0.18),
                        blurRadius: widget.size * 0.08,
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
  final double strokeWidth;
  const _PlanetRingPainter({this.strokeWidth = 7});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(center: center, width: size.width * 0.9, height: size.height * 0.3);
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
      ..strokeWidth = strokeWidth
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
  final double width;
  final double height;
  final double iconSize;
  final double fontSize;

  const _VisionChip({
    required this.icon,
    required this.label,
    required this.color,
    this.width = 210,
    this.height = 80,
    this.iconSize = 34,
    this.fontSize = 18,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.22),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(
          color: color.withOpacity(0.32),
          width: 2.2,
        ),
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
              size: iconSize,
            ),
          ),
          SizedBox(width: width * 0.09),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.93),
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              fontFamily: 'Orbitron',
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}

// Animated "space code" line with Spanish words and ASCII symbols
class _SpaceCodeLine extends StatefulWidget {
  final double fontSize;
  final double padding;
  const _SpaceCodeLine({this.fontSize = 18, this.padding = 14, super.key});
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
                padding: EdgeInsets.symmetric(horizontal: widget.padding),
                child: Opacity(
                  opacity: opacity,
                  child: Text(
                    _words[i],
                    style: TextStyle(
                      color: i % 2 == 0 ? kAccentBlue : kPremiumPurple,
                      fontSize: widget.fontSize,
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 180),
        style: TextStyle(
          color: _hovering
              ? kAccentBlue
              : Colors.white.withOpacity(isMobile ? 0.85 : 0.72),
          fontWeight: FontWeight.w600,
          fontSize: isMobile ? 14 : 15.5,
          letterSpacing: 0.2,
          decoration: _hovering ? TextDecoration.underline : TextDecoration.none,
          shadows: _hovering
              ? [
                  Shadow(
                    color: kAccentBlue.withOpacity(isMobile ? 0.5 : 1),
                    blurRadius: isMobile ? 4 : 8,
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 3 : 6, vertical: isMobile ? 2 : 0),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

class _FooterDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 2 : 3),
      child: Container(
        width: isMobile ? 4 : 5,
        height: isMobile ? 4 : 5,
        decoration: BoxDecoration(
          color: kAccentBlue.withOpacity(isMobile ? 0.28 : 0.22),
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(isMobile ? 7 : 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: _hovering && !isMobile
                ? const LinearGradient(
                    colors: [kAccentBlue, kPremiumPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: _hovering && !isMobile
                ? null
                : kAccentBlue.withOpacity(isMobile ? 0.18 : 0.10),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: kAccentBlue.withOpacity(isMobile ? 0.13 : 0.18),
                      blurRadius: isMobile ? 8 : 16,
                      spreadRadius: isMobile ? 1 : 2,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            widget.icon,
            color: _hovering
                ? Colors.white
                : kAccentBlue.withOpacity(isMobile ? 0.93 : 0.82),
            size: isMobile ? 18 : 22,
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double scale = _hovering && !isMobile ? 1.06 : 1.0;
    final double blur = _hovering && !isMobile ? 18 : 8;
    final double shadowOpacity = _hovering && !isMobile ? 0.55 : 0.32;
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
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 18 : 34, vertical: isMobile ? 12 : 20),
            decoration: BoxDecoration(
              gradient: widget.outlined
                  ? null
                  : (isMobile
                      ? LinearGradient(
                          colors: [
                            kAccentBlue.withOpacity(0.92),
                            kPremiumPurple.withOpacity(0.92)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : widget.background),
              borderRadius: BorderRadius.circular(isMobile ? 12 : 18),
              border: widget.outlined
                  ? Border.all(
                      color: Colors.white.withOpacity(
                          _hovering && !isMobile ? 0.95 : 0.7),
                      width: isMobile ? 1.2 : 1.7)
                  : null,
              color: widget.outlined
                  ? Colors.white.withOpacity(
                      _hovering && !isMobile ? 0.12 : 0.07)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: widget.glowColor.withOpacity(
                      isMobile ? 0.22 : shadowOpacity),
                  blurRadius: isMobile ? 18 : blur * 2,
                  spreadRadius: isMobile ? 2 : (_hovering && !isMobile ? 4 : 2),
                  offset: Offset(0, isMobile ? 4 : 10),
                ),
                if (_hovering && !isMobile)
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
                    boxShadow: _hovering && !isMobile
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
                    color: Colors.white.withOpacity(
                        _hovering && !isMobile ? 1 : 0.92),
                    size: isMobile
                        ? (_hovering && !isMobile ? 22 : 19)
                        : (_hovering ? 25 : 22),
                  ),
                ),
                SizedBox(width: isMobile ? 8 : 14),
                AnimatedDefaultTextStyle(
                  duration: duration,
                  curve: Curves.easeOutCubic,
                  style: TextStyle(
                    color: Colors.white.withOpacity(
                        _hovering && !isMobile ? 1 : 0.93),
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile
                        ? (_hovering && !isMobile ? 16 : 15)
                        : (_hovering ? 18.5 : 17),
                    letterSpacing: 0.3,
                    shadows: _hovering && !isMobile
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
