import 'package:flutter/material.dart';

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
    final isMobile = screenWidth < 600;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  "Why Choose Fluoverse",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: const Text(
                  "Master Spanish with Fluoverse",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Our innovative approach combines advanced AI with proven teaching methods for an unparalleled Spanish learning experience.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: features.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 2, // 📱 1 on mobile, 2 on desktop
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: isMobile ? 3 : 3, // Adjust for mobile
                ),
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return _FeatureCard(
                    icon: feature['icon'] as IconData,
                    title: feature['title'] as String,
                    description: feature['description'] as String,
                  );
                },
              ),
            ],
          ),
        ),
      ),
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: _isHovering ? Colors.black.withOpacity(0.15) : Colors.black.withOpacity(0.05),
              blurRadius: _isHovering ? 20 : 12,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(widget.icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isHovering ? Colors.purple : Colors.black87,
                    ),
                    child: Text(widget.title),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
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
