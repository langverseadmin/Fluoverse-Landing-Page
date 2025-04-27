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
        'description': 'Smart tutoring system that adapts to your learning style and progress in Spanish.',
      },
      {
        'icon': Icons.record_voice_over,
        'title': 'Real Spanish Conversations',
        'description': 'Practice with AI-generated native speakers in everyday situations.',
      },
      {
        'icon': Icons.mic,
        'title': 'Accent & Pronunciation',
        'description': 'Real-time feedback on your Spanish pronunciation and accent.',
      },
      {
        'icon': Icons.language,
        'title': 'Cultural Integration',
        'description': 'Learn Spanish within its cultural context for authentic understanding.',
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    return Stack(
      children: [
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
        SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.grey.shade50],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Section Title
                    Column(
                      children: [
                        Text(
                          'WHY CHOOSE FLUOVERSE',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 60,
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.purpleAccent, Colors.blueAccent],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ).animate().fade(duration: 800.ms),

                    const SizedBox(height: 24),

                    // Main Heading
                    const Text(
                      'Master Spanish with Fluoverse',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.black,
                      ),
                    )
                        .animate()
                        .fade(duration: 1000.ms)
                        .moveY(begin: 30, end: 0),

                    const SizedBox(height: 16),

                    // Subheading
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Experience a seamless blend of AI-driven lessons and cultural immersion for rapid, lasting mastery.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black54, height: 1.5),
                      ),
                    ).animate().fade(duration: 1200.ms),

                    const SizedBox(height: 60),

                    // Feature Cards
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: features.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : 2,
                        crossAxisSpacing: 32,
                        mainAxisSpacing: 32,
                        childAspectRatio: isMobile ? 1.2 : 2.4,
                      ),
                      itemBuilder: (context, index) {
                        final f = features[index];
                        return _FeatureCard(
                          icon: f['icon'] as IconData,
                          title: f['title'] as String,
                          description: f['description'] as String,
                        )
                            .animate()
                            .fade(duration: 700.ms, delay: (index * 300).ms)
                            .moveY(begin: 50, end: 0);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _orb(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              // ignore: deprecated_member_use
              RadialGradient(colors: [color.withOpacity(0.12), Colors.transparent]),
        ),
      )
          .animate()
          .fadeIn(duration: 2.seconds)
          .move(begin: const Offset(10, 10), end: Offset.zero);
}

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
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return GestureDetector(
      onTapDown: (_) => setState(() => _hovering = true),
      onTapUp: (_) => setState(() => _hovering = false),
      onTapCancel: () => setState(() => _hovering = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
              vertical: isMobile ? 32 : 28, horizontal: 24),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _hovering
                    // ignore: deprecated_member_use
                    ? Colors.purpleAccent.withOpacity(0.3)
                    // ignore: deprecated_member_use
                    : Colors.black.withOpacity(0.05),
                blurRadius: _hovering ? 30 : 20,
                offset: const Offset(0, 12),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.blue],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(widget.icon,
                        color: Colors.white, size: isMobile ? 32 : 28),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Colors.black54,
                        height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
