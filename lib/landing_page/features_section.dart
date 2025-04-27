import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.school,
        'title': 'AI-Powered Spanish Tutor',
        'description':
            'Smart tutoring system that adapts to your learning style and progress in Spanish.',
      },
      {
        'icon': Icons.record_voice_over,
        'title': 'Real Spanish Conversations',
        'description':
            'Practice with AI-generated native speakers in everyday situations.',
      },
      {
        'icon': Icons.mic,
        'title': 'Accent & Pronunciation',
        'description':
            'Real-time feedback on your Spanish pronunciation and accent.',
      },
      {
        'icon': Icons.language,
        'title': 'Cultural Integration',
        'description':
            'Learn Spanish within its cultural context for authentic understanding.',
      },
    ];

    final isMobile = MediaQuery.of(context).size.width < 700;

    return Stack(children: [
      // ————————— soft orbs —————————
      Positioned(
        top: -100,
        left: -100,
        child: _orb(300, Colors.purple),
      ),
      Positioned(
        bottom: -150,
        right: -150,
        child: _orb(400, Colors.blue),
      ),

      // ————————— content —————————
      SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _gradientText('Why Choose Fluoverse', 20)
                      .animate()
                      .fade(duration: 800.ms),
                  const SizedBox(height: 20),
                  const Text(
                    'Master Spanish with Fluoverse',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                      .animate()
                      .fade(duration: 1000.ms)
                      .moveY(begin: 30, end: 0),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Our innovative approach combines AI with proven methods for an unparalleled Spanish learning experience.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ).animate().fade(duration: 1200.ms),
                  const SizedBox(height: 60),

                  // ——— grid / list of cards
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: features.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : 2,
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 32,
                      // <- CRITICAL: give phones a taller card
                      childAspectRatio: isMobile ? 1.15 : 2.4,
                    ),
                    itemBuilder: (_, i) => _FeatureCard(
                      icon: features[i]['icon'] as IconData,
                      title: features[i]['title'] as String,
                      description: features[i]['description'] as String,
                    )
                        .animate()
                        .fade(duration: 700.ms, delay: (i * 300).ms)
                        .moveY(begin: 50, end: 0),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }

  // helper widgets
  Widget _orb(double size, Color c) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              // ignore: deprecated_member_use
              RadialGradient(colors: [c.withOpacity(0.1), Colors.transparent]),
        ),
      ).animate().fadeIn(duration: 2.seconds);

  Widget _gradientText(String t, double sz) => ShaderMask(
        shaderCallback: (b) => const LinearGradient(
          colors: [Colors.purpleAccent, Colors.blueAccent],
        ).createShader(b),
        child: Text(t,
            style: TextStyle(
                fontSize: sz,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      );
}

// ——————————————————————————————————————————————————————
// CARD
// ——————————————————————————————————————————————————————
class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  const _FeatureCard(
      {required this.icon, required this.title, required this.description});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return GestureDetector(
      onTapDown: (_) => setState(() => _hover = true),
      onTapUp: (_) => setState(() => _hover = false),
      onTapCancel: () => setState(() => _hover = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
              vertical: isMobile ? 28 : 24, horizontal: 24),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            // ignore: deprecated_member_use
            border: Border.all(color: Colors.white.withOpacity(0.85)),
            boxShadow: [
              BoxShadow(
                color: _hover
                    // ignore: deprecated_member_use
                    ? Colors.blueAccent.withOpacity(0.33)
                    // ignore: deprecated_member_use
                    : Colors.black.withOpacity(0.05),
                blurRadius: _hover ? 30 : 20,
                offset: const Offset(0, 12),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: isMobile ? _mobile() : _desktop(),
            ),
          ),
        ),
      ),
    );
  }

  // desktop / chrome
  Widget _desktop() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _icon(size: 28),
          const SizedBox(width: 24),
          Expanded(child: _text(TextAlign.start)),
        ],
      );

  // phone layout
  Widget _mobile() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _icon(size: 32),
          const SizedBox(height: 16),
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _text(TextAlign.center),
          ),
        ],
      );

  Widget _icon({double size = 30}) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(widget.icon, color: Colors.white, size: size),
      );

  Widget _text(TextAlign a) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,
              textAlign: a,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 6),
          Text(widget.description,
              textAlign: a,
              style:
                  const TextStyle(fontSize: 16, color: Colors.black54)),
        ],
      );
}
