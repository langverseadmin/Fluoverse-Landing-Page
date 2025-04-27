import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

// --- PARTICLE BACKGROUND CLASS ---
class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final List<_Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))
      ..repeat();

    for (var i = 0; i < 30; i++) {
      _particles.add(_Particle(_random));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          painter: _ParticlePainter(_particles, _controller.value),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _Particle {
  late Offset position;
  late double size;
  late double speed;
  late double direction;

  _Particle(Random random) {
    position = Offset(random.nextDouble(), random.nextDouble());
    size = random.nextDouble() * 2 + 1;
    speed = random.nextDouble() * 0.0005 + 0.0002;
    direction = random.nextDouble() * 2 * pi;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // ignore: deprecated_member_use
    final paint = Paint()..color = Colors.white.withOpacity(0.2);

    for (var p in particles) {
      final dx = p.position.dx + cos(p.direction) * p.speed * progress * size.width;
      final dy = p.position.dy + sin(p.direction) * p.speed * progress * size.height;

      final wrappedDx = (dx + 1) % 1;
      final wrappedDy = (dy + 1) % 1;

      canvas.drawCircle(
        Offset(wrappedDx * size.width, wrappedDy * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// --- MAIN CALL TO ACTION SECTION CLASS ---
class CallToActionSection extends StatefulWidget {
  const CallToActionSection({super.key});

  @override
  State<CallToActionSection> createState() => _CallToActionSectionState();
}

class _CallToActionSectionState extends State<CallToActionSection> {
  final emailController = TextEditingController();
  final confettiController = ConfettiController(duration: const Duration(seconds: 3));
  final supabase = Supabase.instance.client;

  Future<void> _showThankYouDialog() async {
    confettiController.play();
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -60,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [Colors.purple, Colors.blue, Colors.pink],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Text('🎉 Thank You! You\'re In!',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(height: 16),
                const Text('You\'ve successfully joined the Fluoverse Early Access waitlist! 🎯',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    confettiController.stop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    confettiController.dispose();
  }

  Future<void> _showEmailDialog() async {
    emailController.clear();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: const Text('Join the Fluoverse Early Access 🚀',
            textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'you@example.com',
                labelText: 'Email Address',
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.purple)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () async {
              final email = emailController.text.trim();
              if (email.isEmpty || !email.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('⚡ Please enter a valid email address')),
                );
                return;
              }
              try {
                final existing = await supabase
                    .from('waitlist')
                    .select('id')
                    .eq('email', email)
                    .maybeSingle();

                if (existing != null) {
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    await Future.delayed(const Duration(milliseconds: 200));
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('⚡ You have already joined the waitlist!')),
                    );
                  }
                } else {
                  await supabase.from('waitlist').insert({'email': email});
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    await Future.delayed(const Duration(milliseconds: 300));
                    _showThankYouDialog();
                  }
                }
              } catch (e) {
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('⚡ You have already signed up! Thank you!')),
                  );
                }
              }
            },
            child: const Text('Join Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: ParticleBackground()), // ✅ particles + gradient background
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.menu_book_rounded, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Join Our Early Access Program",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Be among the first to experience the future of language learning with Fluoverse.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  const SizedBox(height: 32),
                  const Column(
                    children: [
                      _BenefitItem(text: "✓ First access to new features"),
                      _BenefitItem(text: "✓ Personalized learning path setup"),
                      _BenefitItem(text: "✓ Free premium content during beta"),
                      _BenefitItem(text: "✓ Direct feedback channel to our team"),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _showEmailDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                    ),
                    child: const Text("Join Waitlist", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "We’ll never share your email with anyone else.",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
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

class _BenefitItem extends StatelessWidget {
  final String text;
  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white70),
      ),
    );
  }
}
