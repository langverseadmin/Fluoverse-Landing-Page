// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'homepage_widgets.dart'; // For shared constants and styles
import 'package:supabase_flutter/supabase_flutter.dart';


// Title widget with gradient background that takes full screen width
class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full screen width
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kPremiumPurple, kAccentBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 96), // No horizontal padding
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.workspace_premium_rounded,
                color: Colors.white,
                size: 64,
              ),
              const SizedBox(height: 28),
              Text(
                'Fluoverse - Where learning meets real conversations',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: 32),
              Text(
                'Join the Fluoverse waitlist and be\n'
                'among the first to practice Spanish and start speaking\n'
                'in no time',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white.withOpacity(0.98),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      height: 1.35,
                    ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.28),
                    width: 1.2,
                  ),
                ),
                child: Text(
                  'Premium access • Early perks • Shape the future',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.92),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Join waitlist form widget

class JoinWaitlistForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final bool submitted;
  final VoidCallback onSubmit;

  const JoinWaitlistForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.submitted,
    required this.onSubmit,
  });

  @override
  State<JoinWaitlistForm> createState() => _JoinWaitlistFormState();
}

class _JoinWaitlistFormState extends State<JoinWaitlistForm> {
  bool _submitted = false;
  bool _loading = false;
  String? _error;

  Future<void> _handleSubmit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final email = widget.emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _error = 'Please enter your email.';
        _loading = false;
      });
      return;
    }
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('waitlist').insert({'email': email});
      setState(() {
        _submitted = true;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to join waitlist. Please try again.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitted = _submitted || widget.submitted;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: Container(
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withOpacity(0.18),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: kAccentBlue.withOpacity(0.15),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [kAccentBlue, kPremiumPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Icon(
                Icons.language_rounded,
                color: Colors.white,
                size: 56,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Fluency begins here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: kAccentBlue.withOpacity(0.25),
                        blurRadius: 12,
                      ),
                    ],
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Join the movement that makes language a lived experience.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 32),
            if (!submitted) ...[
              TextField(
                controller: widget.firstNameController,
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.12),
                  hintText: 'First name',
                  hintStyle: const TextStyle(color: Colors.white60, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.person_rounded, color: Colors.white.withOpacity(0.7)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: widget.lastNameController,
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.12),
                  hintText: 'Last name',
                  hintStyle: const TextStyle(color: Colors.white60, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.white.withOpacity(0.7)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: widget.emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.12),
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.white60, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.email_rounded, color: Colors.white.withOpacity(0.7)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: widget.passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.12),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white60, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.lock_rounded, color: Colors.white.withOpacity(0.7)),
                ),
              ),
              const SizedBox(height: 20),
              _PremiumButton(
                text: _loading ? 'Joining...' : 'Join Waitlist',
                icon: Icons.star_rounded,
                background: const LinearGradient(
                  colors: [kAccentBlue, kPremiumPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onPressed: _loading ? () {} : () => _handleSubmit(),
                glowColor: kAccentBlue.withOpacity(0.32),
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 12),
              Text(
                'We’ll notify you when Fluoverse launches. No spam. Ever.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ] else ...[
              const Icon(Icons.verified_rounded, color: Colors.greenAccent, size: 56),
              const SizedBox(height: 24),
              Text(
                'You’re on the list! We’ll keep you posted. 🎉',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

// Premium "Why Join" Widget

class WhyJoinWidget extends StatelessWidget {
  const WhyJoinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF8F6FF),
            Color(0xFFEAF1FF),
            Color(0xFFF5F7FA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: const Color(0xFFE0D7FF), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB6B6F8).withOpacity(0.18),
            blurRadius: 48,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Spectacular animated gradient icon
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Color(0xFF7B61FF), Color(0xFF00CFFF), Color(0xFFFFC700)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Icon(Icons.workspace_premium_rounded, size: 54, color: Colors.white),
          ),
          const SizedBox(height: 18),
          Text(
            'Unlock the Premium Experience',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2B2250),
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      color: const Color(0xFFB6B6F8).withOpacity(0.18),
                      blurRadius: 12,
                    ),
                  ],
                ),
          ),
          const SizedBox(height: 18),
          Text(
            'Be among the first to shape the future of language learning.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4A3F7A),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: 36),
          // Centered bullets
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              _WhyJoinBullet(
                icon: Icons.rocket_launch_rounded,
                iconGradient: LinearGradient(
                  colors: [Color(0xFF00CFFF), Color(0xFF7B61FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                text: 'Priority early access to Fluoverse and all new features.',
              ),
              SizedBox(height: 22),
              _WhyJoinBullet(
                icon: Icons.military_tech_rounded,
                iconGradient: LinearGradient(
                  colors: [Color(0xFFFFC700), Color(0xFF7B61FF)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                text: 'VIP perks, exclusive badges, and premium community invites.',
              ),
              SizedBox(height: 22),
              _WhyJoinBullet(
                icon: Icons.lightbulb_rounded,
                iconGradient: LinearGradient(
                  colors: [Color(0xFFFFA726), Color(0xFF00CFFF)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                text: 'Direct influence on features—your feedback shapes Fluoverse.',
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7B61FF), Color(0xFF00CFFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7B61FF).withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              'Premium. Early. Unforgettable.',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WhyJoinBullet extends StatelessWidget {
  final IconData icon;
  final Gradient iconGradient;
  final String text;

  const _WhyJoinBullet({
    required this.icon,
    required this.iconGradient,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) => iconGradient.createShader(bounds),
          child: Icon(icon, size: 28, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF2B2250),
                  fontSize: 17,
                  height: 1.6,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}


// Custom Premium Button Widget
class _PremiumButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Gradient background;
  final VoidCallback onPressed;
  final Color glowColor;

  const _PremiumButton({
    required this.text,
    required this.icon,
    required this.background,
    required this.onPressed,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glowing effect
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: glowColor,
                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
          ).copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (states) => null,
            ),
          ),
          icon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return background.createShader(bounds);
            },
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          label: ShaderMask(
            shaderCallback: (Rect bounds) {
              return background.createShader(bounds);
            },
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.1,
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
