import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final highlights = [
      "Personalized learning paths",
      "Adaptive AI technology",
      "Real-world language scenarios",
      "Cultural context integration",
    ];

    return Container(
      color: const Color.fromARGB(255, 248, 249, 255),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 800;
              return Flex(
                direction: isWide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            "Our Mission",
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
                            "Personalized Learning\nThat Adapts to You",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "At Fluoverse, we create unique learning paths tailored to your individual needs, goals, and style. Our AI evolves with you for natural, engaging language acquisition.",
                          style: TextStyle(fontSize: 18, color: Colors.black54, height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        Column(
                          children: highlights.map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.purple, size: 20),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40, height: 40),
                  Expanded(
                    flex: 1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  // ignore: deprecated_member_use
                                  Colors.purple.withOpacity(0.1),
                                  // ignore: deprecated_member_use
                                  Colors.blue.withOpacity(0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Colors.purple, Colors.blue],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 30),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    "Fluoverse AI",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _chatBubble("What's your learning goal today?", isUser: false),
                              const SizedBox(height: 8),
                              _chatBubble("I'd like to practice ordering food in Spanish.", isUser: true),
                              const SizedBox(height: 8),
                              _chatBubble("Great! Let's create a realistic restaurant scenario to help you practice...", isUser: false),
                              const SizedBox(height: 16),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80",
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        // ignore: deprecated_member_use
                                        color: Colors.white.withOpacity(0.8),
                                        child: const Text(
                                          "¿Puedo ver el menú, por favor?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _chatBubble(String text, {required bool isUser}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isUser ? const EdgeInsets.only(left: 40) : const EdgeInsets.only(right: 40),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.purple.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.purple.shade800 : Colors.black87,
          ),
        ),
      ),
    );
  }
}
