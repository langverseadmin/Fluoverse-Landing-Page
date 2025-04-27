import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:confetti/confetti.dart';

class HeroBanner extends StatefulWidget {
  const HeroBanner({super.key});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final confettiController = ConfettiController(duration: const Duration(seconds: 3));
  final supabase = Supabase.instance.client;

  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    confettiController.dispose();
    super.dispose();
  }

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
                const Text('🎉 Thank You!',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(height: 16),
                const Text('You\'ve successfully joined the Fluoverse waitlist!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
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
                  child: const Text('Back to Home',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEmailDialog() async {
    emailController.clear();

    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Email Waitlist',
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation1, curve: Curves.easeOutBack),
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              title: const Text('Join the Fluoverse Waitlist 🚀',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'you@example.com',
                      labelText: 'Email Address',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
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
                      final existing = await supabase.from('waitlist').select('id').eq('email', email).maybeSingle();
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF6F6FF), Color(0xFFF0F0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.menu_book_rounded, size: 48, color: Color(0xFF8B5CF6)),
            ),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _glowController,
              builder: (context, child) {
                return ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      // ignore: deprecated_member_use
                      Colors.purple.withOpacity(0.7 + (_glowController.value * 0.3)),
                      // ignore: deprecated_member_use
                      Colors.blue.withOpacity(0.7 + (_glowController.value * 0.3)),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: child,
                );
              },
              child: Text(
                'Fluoverse: Learn the Language by Living It!',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Experience a revolutionary way to master languages with real-world scenarios and AI-driven conversations.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _showEmailDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Join Us Today!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
