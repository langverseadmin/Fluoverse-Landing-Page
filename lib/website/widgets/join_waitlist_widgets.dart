// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'homepage_widgets.dart'; // For shared constants and styles
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';


// Title widget with gradient background that takes full screen width
class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kPremiumPurple, kAccentBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 56 : 96,
        horizontal: isMobile ? 16 : 0,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 1100,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.workspace_premium_rounded,
                color: Colors.white,
                size: isMobile ? 44 : 64,
              ),
              SizedBox(height: isMobile ? 18 : 28),
              Text(
                'Fluoverse - Where learning meets real conversations',
                textAlign: TextAlign.center,
                style: (isMobile
                        ? Theme.of(context).textTheme.headlineSmall
                        : Theme.of(context).textTheme.displayMedium)
                    ?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  fontSize: isMobile ? 22 : null,
                ),
              ),
              SizedBox(height: isMobile ? 20 : 32),
              Text(
                'Join the Fluoverse waitlist and be\n'
                'among the first to practice Spanish and start speaking\n'
                'in no time',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.98),
                      fontWeight: FontWeight.w600,
                      fontSize: isMobile ? 16 : 20,
                      height: 1.35,
                    ),
              ),
              SizedBox(height: isMobile ? 14 : 18),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: isMobile ? 12 : 24,
                ),
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.92),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                        fontSize: isMobile ? 13.5 : 16,
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
  bool _awaitingVerification = false;
  String? _pendingEmail;
  String? _pendingPassword;

  // Check if user exists in users table
  Future<bool> _userExists(String email) async {
    try {
      final response = await http.get(
        Uri.parse('https://fluoverse.onrender.com/auth/user_exists?email=$email'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['exists'] == true;
      }
    } catch (_) {}
    return false;
  }

  // Save email to Supabase waitlist table directly
  Future<void> _saveToWaitlistSupabase(String email) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from('waitlist').insert({'email': email});
    } catch (e) {
      // Ignore errors, as user may already be on waitlist
    }
  }

  Future<void> _handleSubmit() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final email = widget.emailController.text.trim();
    final password = widget.passwordController.text.trim();
    final firstName = widget.firstNameController.text.trim();
    final lastName = widget.lastNameController.text.trim();

    if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      setState(() {
        _error = 'Please fill in all fields.';
        _loading = false;
      });
      return;
    }

    // Save to Supabase waitlist table regardless of backend result
    await _saveToWaitlistSupabase(email);

    // Check if user already exists in users table
    final existsInUsers = await _userExists(email);

    if (existsInUsers) {
      setState(() {
        _error = 'You are already registered!';
        _loading = false;
      });
      return;
    }

    try {
      // Call backend /signup endpoint
      final response = await http.post(
        Uri.parse('https://fluoverse.onrender.com/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        setState(() {
          _submitted = true;
          _loading = false;
        });
      } else if (response.statusCode == 202) {
        setState(() {
          _awaitingVerification = true;
          _pendingEmail = email;
          _pendingPassword = password;
          _loading = false;
          _error = null;
        });
      } else if (response.statusCode == 409) {
        setState(() {
          _error = 'You are already registered!';
          _loading = false;
        });
      } else {
        setState(() {
          _error = data['error']?.toString() ?? 'Failed to join waitlist. Please try again.';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to join waitlist. Please try again.';
        _loading = false;
      });
    }
  }

  Future<void> _retryAfterVerification() async {
    if (_pendingEmail == null || _pendingPassword == null) {
      setState(() {
        _error = 'Missing information. Please try again.';
        _awaitingVerification = false;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://fluoverse.onrender.com/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _pendingEmail!,
          'password': _pendingPassword!,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _submitted = true;
          _loading = false;
          _awaitingVerification = false;
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _error = 'Email not verified yet or invalid credentials. Please check your inbox and try again.';
          _loading = false;
        });
      } else {
        setState(() {
          _error = data['error']?.toString() ?? 'Failed to join waitlist. Please try again!';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Something went wrong. Please try again later.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitted = _submitted || widget.submitted;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : 480,
        ),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 18 : 36),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(isMobile ? 18 : 32),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: kAccentBlue.withOpacity(0.15),
                blurRadius: isMobile ? 16 : 32,
                offset: Offset(0, isMobile ? 6 : 12),
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
                  size: isMobile ? 40 : 56,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 18),
              Text(
                'Fluency begins here.',
                textAlign: TextAlign.center,
                style: (isMobile
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.headlineMedium)
                    ?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  fontSize: isMobile ? 20 : null,
                  shadows: [
                    Shadow(
                      color: kAccentBlue.withOpacity(0.25),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 10 : 16),
              Text(
                'Create an account and join the movement that makes language a lived experience.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                      fontSize: isMobile ? 15 : 18,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: isMobile ? 18 : 32),
              if (_awaitingVerification) ...[
                Icon(Icons.mark_email_unread_rounded, color: Colors.amber, size: isMobile ? 38 : 56),
                SizedBox(height: isMobile ? 16 : 24),
                Text(
                  'Please confirm your email address.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 17 : null,
                      ),
                ),
                SizedBox(height: isMobile ? 8 : 12),
                Text(
                  'We’ve sent a verification link to your email. Once you confirm, click below to complete joining the waitlist.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: isMobile ? 13 : 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: isMobile ? 14 : 20),
                _PremiumButton(
                  text: _loading ? 'Verifying...' : 'I have confirmed my email',
                  icon: Icons.verified_rounded,
                  background: const LinearGradient(
                    colors: [kAccentBlue, kPremiumPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onPressed: _loading ? () {} : _retryAfterVerification,
                  glowColor: kAccentBlue.withOpacity(0.32),
                ),
                if (_error != null) ...[
                  SizedBox(height: 10),
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: isMobile ? 8 : 12),
                Text(
                  'Didn’t get the email? Check your spam folder or try again later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: isMobile ? 11 : 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ] else if (!submitted) ...[
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
                      borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.person_rounded, color: Colors.white.withOpacity(0.7)),
                    contentPadding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 18),
                  ),
                ),
                SizedBox(height: isMobile ? 10 : 16),
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
                      borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.white.withOpacity(0.7)),
                    contentPadding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 18),
                  ),
                ),
                SizedBox(height: isMobile ? 10 : 16),
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
                      borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.email_rounded, color: Colors.white.withOpacity(0.7)),
                    contentPadding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 18),
                  ),
                ),
                SizedBox(height: isMobile ? 10 : 16),
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
                      borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock_rounded, color: Colors.white.withOpacity(0.7)),
                    contentPadding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 18),
                  ),
                ),
                SizedBox(height: isMobile ? 14 : 20),
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
                  SizedBox(height: 10),
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: isMobile ? 8 : 12),
                Text(
                  'We’ll notify you when Fluoverse launches. No spam. Ever.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: isMobile ? 11 : 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ] else ...[
                Icon(Icons.verified_rounded, color: Colors.greenAccent, size: isMobile ? 38 : 56),
                SizedBox(height: isMobile ? 16 : 24),
                Text(
                  'You’re on the list! We’ll keep you posted. 🎉',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 17 : null,
                      ),
                ),
              ]
            ],
          ),
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 56,
        horizontal: isMobile ? 16 : 40,
      ),
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
        borderRadius: BorderRadius.circular(isMobile ? 12 : 0),
        border: Border.all(color: const Color(0xFFE0D7FF), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB6B6F8).withOpacity(0.18),
            blurRadius: isMobile ? 18 : 48,
            offset: Offset(0, isMobile ? 8 : 24),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Color(0xFF7B61FF), Color(0xFF00CFFF), Color(0xFFFFC700)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Icon(Icons.workspace_premium_rounded, size: isMobile ? 38 : 54, color: Colors.white),
          ),
          SizedBox(height: isMobile ? 12 : 18),
          Text(
            'Unlock the Premium Experience',
            textAlign: TextAlign.center,
            style: (isMobile
                    ? Theme.of(context).textTheme.titleLarge
                    : Theme.of(context).textTheme.displaySmall)
                ?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF2B2250),
              letterSpacing: 1.2,
              fontSize: isMobile ? 20 : null,
              shadows: [
                Shadow(
                  color: const Color(0xFFB6B6F8).withOpacity(0.18),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 12 : 18),
          Text(
            'Be among the first to shape the future of language learning.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4A3F7A),
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 15 : 20,
                  height: 1.35,
                ),
          ),
          SizedBox(height: isMobile ? 22 : 36),
          // Centered bullets
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _WhyJoinBullet(
                icon: Icons.rocket_launch_rounded,
                iconGradient: const LinearGradient(
                  colors: [Color(0xFF00CFFF), Color(0xFF7B61FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                text: 'Priority early access to Fluoverse and all new features.',
                isMobile: isMobile,
              ),
              SizedBox(height: isMobile ? 14 : 22),
              _WhyJoinBullet(
                icon: Icons.military_tech_rounded,
                iconGradient: const LinearGradient(
                  colors: [Color(0xFFFFC700), Color(0xFF7B61FF)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                text: 'VIP perks, exclusive rewards, and premium community invites.',
                isMobile: isMobile,
              ),
              SizedBox(height: isMobile ? 14 : 22),
              _WhyJoinBullet(
                icon: Icons.lightbulb_rounded,
                iconGradient: const LinearGradient(
                  colors: [Color(0xFFFFA726), Color(0xFF00CFFF)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                text: 'Direct influence on features—your feedback shapes Fluoverse.',
                isMobile: isMobile,
              ),
            ],
          ),
          SizedBox(height: isMobile ? 22 : 32),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 8 : 10,
              horizontal: isMobile ? 16 : 28,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7B61FF), Color(0xFF00CFFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7B61FF).withOpacity(0.12),
                  blurRadius: isMobile ? 8 : 16,
                  offset: Offset(0, isMobile ? 3 : 6),
                ),
              ],
            ),
            child: Text(
              'Premium. Early. Unforgettable.',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: isMobile ? 13.5 : null,
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
  final bool isMobile;

  const _WhyJoinBullet({
    required this.icon,
    required this.iconGradient,
    required this.text,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) => iconGradient.createShader(bounds),
          child: Icon(icon, size: isMobile ? 22 : 28, color: Colors.white),
        ),
        SizedBox(width: isMobile ? 10 : 16),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF2B2250),
                  fontSize: isMobile ? 14.5 : 17,
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glowing effect
        Container(
          width: double.infinity,
          height: isMobile ? 46 : 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
            boxShadow: [
              BoxShadow(
                color: glowColor,
                blurRadius: isMobile ? 14 : 24,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(isMobile ? 46 : 56),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 10 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
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
            child: Icon(icon, color: Colors.white, size: isMobile ? 22 : 28),
          ),
          label: ShaderMask(
            shaderCallback: (Rect bounds) {
              return background.createShader(bounds);
            },
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 15 : 18,
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
