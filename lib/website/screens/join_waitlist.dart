// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:frontend/website/widgets/homepage_widgets.dart';
import '../widgets/join_waitlist_widgets.dart'; // Import for refactored widgets
import '../widgets/navigation_bar_widget.dart'; // Import NavigationBarWidget

class JoinWaitlist extends StatefulWidget {
  const JoinWaitlist({super.key});

  @override
  State<JoinWaitlist> createState() => _JoinWaitlistScreenState();
}
class _JoinWaitlistScreenState extends State<JoinWaitlist> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _submitted = false;

  void _submit() {
    setState(() => _submitted = true);
    // TO DO: Handle waitlist submission (e.g., Supabase or HTTP request)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: NavigationBarWidget(), // Add NavigationBarWidget
      ),
      body: Background(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 0),
                const TitleWidget(),
                const SizedBox(height: 32),
                JoinWaitlistForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  submitted: _submitted,
                  onSubmit: _submit,
                ),
                const SizedBox(height: 24),
                const WhyJoinWidget(),
                const SizedBox(height: 48),
                const FooterSection(), // Add FooterSection at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
