// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactTitle extends StatelessWidget {
  const ContactTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            'Get in Touch',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 68,
              fontWeight: FontWeight.bold,
              color: Colors.white, // This will be masked by the gradient
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: const Text(
            'We’d love to hear from you! Whether you have a question, feedback, or just want to say hi, feel free to reach out.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}



class ContactFormSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final VoidCallback? onSubmit;

  const ContactFormSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    this.onSubmit,
  });

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection>
  with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  String? _feedbackMessage;
  late AnimationController _animationController;
  late Animation<double> _formFadeAnimation;
  late Animation<double> _infoFadeAnimation;

  // Focus nodes for accessibility and UX
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();

  @override
  void initState() {
  super.initState();
  _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );
  _formFadeAnimation = CurvedAnimation(
    parent: _animationController,
    curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
  );
  _infoFadeAnimation = CurvedAnimation(
    parent: _animationController,
    curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
  );
  _animationController.forward();
  }

  @override
  void dispose() {
  _animationController.dispose();
  _nameFocus.dispose();
  _emailFocus.dispose();
  _messageFocus.dispose();
  super.dispose();
  }

  Future<void> _sendEmail() async {
  setState(() {
    _isSending = true;
    _feedbackMessage = null;
  });
  
  const endpoint = 'https://fluoverse.onrender.com/contact'; // or your deployed URL

  final response = await http.post(
    Uri.parse(endpoint),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': widget.nameController.text,
      'email': widget.emailController.text,
      'message': widget.messageController.text,
    }),
  );


  setState(() {
    _isSending = false;
    if (response.statusCode == 200) {
    _feedbackMessage = '🎉 Thank you! Your message has been sent.';
    widget.nameController.clear();
    widget.emailController.clear();
    widget.messageController.clear();
    } else {
    _feedbackMessage =
      '❌ Sorry, something went wrong. Please try again later.';
    }
  });

  if (widget.onSubmit != null) widget.onSubmit!();
  }

  InputDecoration _inputDecoration({
  required String label,
  required IconData icon,
  required FocusNode focusNode,
  int? maxLength,
  }) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white.withOpacity(0.18),
    contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: BorderSide(color: Colors.white.withOpacity(0.20)),
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: const BorderSide(color: Color(0xFF6A82FB), width: 2.5),
    ),
    labelText: label,
    labelStyle: TextStyle(
    color: focusNode.hasFocus ? const Color(0xFF6A82FB) : Colors.white70,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: 0.2,
    ),
    floatingLabelStyle: const TextStyle(
    color: Color(0xFF6A82FB),
    fontWeight: FontWeight.bold,
    fontSize: 19,
    ),
    prefixIcon: Icon(icon, color: Colors.white54, size: 26),
    counterText: maxLength != null ? null : '',
  );
  }

  Widget _buildAnimatedForm(double cardHeight) {
  return FadeTransition(
    opacity: _formFadeAnimation,
    child: AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
    width: 520,
    height: cardHeight,
    padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 44),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.09),
      borderRadius: BorderRadius.circular(32),
      boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        blurRadius: 40,
        offset: const Offset(0, 18),
      ),
      ],
      border: Border.all(color: Colors.white.withOpacity(0.15)),
    ),
    child: Form(
      key: _formKey,
      child: AutofillGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        // Name
        Focus(
          focusNode: _nameFocus,
          child: TextFormField(
          controller: widget.nameController,
          decoration: _inputDecoration(
            label: 'Your Name',
            icon: Icons.person_rounded,
            focusNode: _nameFocus,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18),
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
          validator: (value) => value == null || value.trim().isEmpty
            ? 'Please enter your name'
            : null,
          onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_emailFocus),
          ),
        ),
        const SizedBox(height: 26),
        // Email
        Focus(
          focusNode: _emailFocus,
          child: TextFormField(
          controller: widget.emailController,
          decoration: _inputDecoration(
            label: 'Your Email',
            icon: Icons.email_rounded,
            focusNode: _emailFocus,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
            return 'Please enter your email';
            }
            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
            if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email';
            }
            return null;
          },
          onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_messageFocus),
          ),
        ),
        const SizedBox(height: 26),
        // Message
        Focus(
          focusNode: _messageFocus,
          child: TextFormField(
          controller: widget.messageController,
          decoration: _inputDecoration(
            label: 'Your Message',
            icon: Icons.message_rounded,
            focusNode: _messageFocus,
            maxLength: 800,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18),
          maxLines: 7,
          minLines: 4,
          maxLength: 800,
          textInputAction: TextInputAction.newline,
          autofillHints: const [AutofillHints.addressCityAndState],
          validator: (value) => value == null || value.trim().isEmpty
            ? 'Please enter your message'
            : null,
          ),
        ),
        const SizedBox(height: 38),
        // Animated Send Button
        SizedBox(
          width: 260, // Increased width for a bigger button
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: _isSending
          ? ElevatedButton.icon(
              key: const ValueKey('sending'),
              onPressed: null,
              icon: const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor:
                AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              label: const Text(
                'Sending...',
                style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Color(0xFF6A82FB),
                shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
            )
          : ElevatedButton(
              key: const ValueKey('send'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
            _sendEmail();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: const Color(0xFF6A82FB),
                shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 19),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
            Icon(Icons.send_rounded,
                color: Colors.white, size: 25),
            SizedBox(width: 10),
            Text(
              'Send Message',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
                ],
              ),
            ),
          ),
        ),
        if (_feedbackMessage != null) ...[
          const SizedBox(height: 20),
          AnimatedOpacity(
          opacity: _feedbackMessage != null ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          child: Text(
            _feedbackMessage!,
            style: TextStyle(
            color: _feedbackMessage!.startsWith('🎉')
              ? Colors.greenAccent
              : Colors.redAccent,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          ),
        ],
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Icon(Icons.lock_outline,
            color: Colors.white38, size: 18),
          const SizedBox(width: 7),
          const Text(
            'We respect your privacy. Your information is safe.',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
          ],
        ),
        ],
      ),
      ),
    ),
    ),
  );
  }

  Widget _buildContactInfo(double cardHeight) {
  return FadeTransition(
    opacity: _infoFadeAnimation,
    child: Container(
    height: cardHeight,
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.07),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white.withOpacity(0.10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Text(
        'Contact Information',
        style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
        ),
      ),
      const SizedBox(height: 24),
      _infoRow(
        icon: Icons.email_outlined,
        label: 'Email',
        value: 'lingovrse@gmail.com',
      ),
      const SizedBox(height: 18),
      _infoRow(
        icon: Icons.phone_outlined,
        label: 'Phone',
        value: '+1 (555) 123-4567',
      ),
      const SizedBox(height: 18),
      _infoRow(
        icon: Icons.location_on_outlined,
        label: 'Location',
        value: 'San Francisco, CA',
      ),
      const SizedBox(height: 32),
      const Divider(color: Colors.white24, thickness: 1),
      const SizedBox(height: 24),
      Row(
        children: [
        Icon(Icons.public, color: Colors.blue.shade100, size: 22),
        const SizedBox(width: 10),
        const Text(
          'fluoverse.com',
          style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          ),
        ),
        ],
      ),
      const SizedBox(height: 32),
      const Text(
        'Our team will get back to you within 24 hours. For urgent matters, please use the contact details above.',
        style: TextStyle(
        color: Colors.white60,
        fontSize: 16,
        height: 1.5,
        ),
      ),
      const SizedBox(height: 32),
      Row(
        children: [
        Icon(Icons.verified_user_outlined,
          color: Colors.greenAccent.shade100, size: 22),
        const SizedBox(width: 10),
        const Text(
          'Trusted & Secure',
          style: TextStyle(
          color: Colors.white70,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          ),
        ),
        ],
      ),
      const SizedBox(height: 14),
      Row(
        children: [
        Icon(Icons.support_agent_outlined,
          color: Colors.purpleAccent.shade100, size: 22),
        const SizedBox(width: 10),
        const Text(
          'Friendly Support',
          style: TextStyle(
          color: Colors.white70,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          ),
        ),
        ],
      ),
      const SizedBox(height: 14),
      Row(
        children: [
        Icon(Icons.flash_on_outlined,
          color: Colors.yellowAccent.shade100, size: 22),
        const SizedBox(width: 10),
        const Text(
            'Fast Response',
          style: TextStyle(
          color: Colors.white70,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          ),
        ),
        ],
      ),
      ],
    ),
    ),
  );
  }

  Widget _infoRow({
  required IconData icon,
  required String label,
  required String value,
  }) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Icon(icon, color: Colors.white70, size: 22),
    const SizedBox(width: 14),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
        label,
        style: const TextStyle(
        color: Colors.white54,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 2),
      SelectableText(
        value,
        style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        ),
      ),
      ],
    ),
    ],
  );
  }

  @override
  Widget build(BuildContext context) {
  return Center(
    child: ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 1200),
    child: LayoutBuilder(
      builder: (context, constraints) {
      final isWide = constraints.maxWidth > 900;
      // Calculate the max height of both cards
      // Use a stateful builder to measure heights after build
      return _EqualHeightRow(
        isWide: isWide,
        buildForm: (height) => _buildAnimatedForm(height),
        buildInfo: (height) => _buildContactInfo(height),
      );
      },
    ),
    ),
  );
  }
}

/// Helper widget to ensure both cards have the same height
class _EqualHeightRow extends StatefulWidget {
  final bool isWide;
  final Widget Function(double height) buildForm;
  final Widget Function(double height) buildInfo;

  const _EqualHeightRow({
  required this.isWide,
  required this.buildForm,
  required this.buildInfo,
  });

  @override
  State<_EqualHeightRow> createState() => _EqualHeightRowState();
}

class _EqualHeightRowState extends State<_EqualHeightRow> {
  final GlobalKey _formKey = GlobalKey();
  final GlobalKey _infoKey = GlobalKey();
  double _maxHeight = 0;

  @override
  void initState() {
  super.initState();
  // Wait for the first frame to measure
  WidgetsBinding.instance.addPostFrameCallback((_) => _updateHeight());
  }

  void _updateHeight() {
  final formContext = _formKey.currentContext;
  final infoContext = _infoKey.currentContext;
  if (formContext != null && infoContext != null) {
    final formBox = formContext.findRenderObject() as RenderBox;
    final infoBox = infoContext.findRenderObject() as RenderBox;
    final maxHeight = formBox.size.height > infoBox.size.height
      ? formBox.size.height
      : infoBox.size.height;
    if (_maxHeight != maxHeight) {
    setState(() {
      _maxHeight = maxHeight;
    });
    }
  }
  }

  @override
  Widget build(BuildContext context) {
  // If maxHeight is 0, build children without height to measure
  final form = Container(
    key: _formKey,
    child: widget.buildForm(_maxHeight > 0 ? _maxHeight : 680),
  );
  final info = Container(
    key: _infoKey,
    child: widget.buildInfo(_maxHeight > 0 ? _maxHeight : 680),
  );
  WidgetsBinding.instance.addPostFrameCallback((_) => _updateHeight());

  if (widget.isWide) {
    return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      form,
      const SizedBox(width: 56),
      Expanded(child: info),
    ],
    );
  } else {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      form,
      const SizedBox(height: 56),
      info,
    ],
    );
  }
  }
}
