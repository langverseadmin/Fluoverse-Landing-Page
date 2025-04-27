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
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                // ignore: deprecated_member_use
                colors: [Colors.purple.withOpacity(0.1), Colors.transparent],
              ),
            ),
          ).animate().fadeIn(duration: 2.seconds),
        ),
        Positioned(
          bottom: -150,
          right: -150,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                // ignore: deprecated_member_use
                colors: [Colors.blue.withOpacity(0.08), Colors.transparent],
              ),
            ),
          ).animate().fadeIn(duration: 2.seconds),
        ),
        SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.purpleAccent, Colors.blueAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: const Text(
                        "Why Choose Fluoverse",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ).animate().fade(duration: 800.ms),
                    const SizedBox(height: 20),
                    const Text(
                      "Master Spanish with Fluoverse",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ).animate().fade(duration: 1000.ms).moveY(begin: 30, end: 0),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Our innovative approach combines AI with proven methods for an unparalleled Spanish learning experience.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ).animate().fade(duration: 1200.ms),
                    const SizedBox(height: 60),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: features.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : 2,
                        crossAxisSpacing: 32,
                        mainAxisSpacing: 32,
                        childAspectRatio: isMobile ? 3 : 2.4,
                      ),
                      itemBuilder: (context, index) {
                        final feature = features[index];
                        return _FeatureCard(
                          icon: feature['icon'] as IconData,
                          title: feature['title'] as String,
                          description: feature['description'] as String,
                        ).animate().fade(duration: 700.ms, delay: (index * 300).ms).moveY(begin: 50, end: 0);
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
}

class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isHovering = true),
      onTapUp: (_) => setState(() => _isHovering = false),
      onTapCancel: () => setState(() => _isHovering = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 32 : 24,
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            // ignore: deprecated_member_use
            border: Border.all(color: Colors.white.withOpacity(0.8)),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: _isHovering ? Colors.blueAccent.withOpacity(0.3) : Colors.black.withOpacity(0.05),
                blurRadius: _isHovering ? 30 : 20,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: isMobile ? _buildMobileContent() : _buildDesktopContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(size: 28),
        const SizedBox(width: 24),
        Expanded(child: _buildTextContent(alignment: TextAlign.start)),
      ],
    );
  }

  Widget _buildMobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIcon(size: 32),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 280),
            child: _buildTextContent(alignment: TextAlign.center),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon({double size = 30}) {
    return Container(
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
  }

  Widget _buildTextContent({TextAlign alignment = TextAlign.center}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          textAlign: alignment,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.description,
          textAlign: alignment,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }
}