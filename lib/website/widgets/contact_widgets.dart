// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactTitle extends StatelessWidget {
  const ContactTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    // Reduce font sizes for web
    final double titleFontSize = isMobile
        ? size.width * 0.09
        : size.width * 0.032; // smaller for web
    final double descFontSize = isMobile ? 18 : 13; // slightly smaller for web
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
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: size.width * 0.02,
                  offset: Offset(0, size.width * 0.006),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? size.width * 0.85 : size.width * 0.34, // smaller for web
          ),
          child: Text(
            'We’d love to hear from you! Whether you have a question, feedback, or just want to say hi, feel free to reach out.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? descFontSize : 18, // bigger for web
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.04),
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

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();

  // Track last cardHeight to keep it stable after feedback
  double? _lastCardHeight;

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

    const endpoint = 'https://fluoverse.onrender.com/contact';

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
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.18),
      contentPadding: EdgeInsets.symmetric(
        vertical: isMobile
            ? size.height * 0.02
            : size.height * 0.014, // smaller for web
        horizontal: isMobile
            ? size.width * 0.035
            : size.width * 0.022, // smaller for web
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            isMobile ? size.width * 0.03 : size.width * 0.012), // smaller for web
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            isMobile ? size.width * 0.03 : size.width * 0.012),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            isMobile ? size.width * 0.03 : size.width * 0.012),
        borderSide: const BorderSide(color: Color(0xFF6A82FB), width: 2.0),
      ),
      labelText: label,
      labelStyle: TextStyle(
        color: focusNode.hasFocus ? const Color(0xFF6A82FB) : Colors.white70,
        fontWeight: FontWeight.w700,
        fontSize: isMobile
            ? size.width * 0.037
            : size.width * 0.009, // smaller for web
        letterSpacing: 0.2,
      ),
      floatingLabelStyle: TextStyle(
        color: const Color(0xFF6A82FB),
        fontWeight: FontWeight.bold,
        fontSize: isMobile
            ? size.width * 0.04
            : size.width * 0.01, // smaller for web
      ),
      prefixIcon: Icon(icon,
          color: Colors.white54,
          size: isMobile
              ? size.width * 0.055
              : size.width * 0.012), // smaller for web
      counterText: maxLength != null ? null : '',
    );
  }

  Widget _buildAnimatedForm(double cardHeight) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    // Keep the cardHeight stable after first build
    if (cardHeight > 0) {
      _lastCardHeight ??= cardHeight;
    }
    final usedCardHeight = _lastCardHeight ?? cardHeight;

    // Always use the same height for the form, even when sending
    return FadeTransition(
      opacity: _formFadeAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: isMobile ? double.infinity : size.width * 0.22, // smaller for web
        height: isMobile ? null : usedCardHeight * 0.82, // keep height stable
        padding: EdgeInsets.symmetric(
          vertical: isMobile
              ? size.height * 0.035
              : size.height * 0.022, // smaller for web
          horizontal: isMobile
              ? size.width * 0.035
              : size.width * 0.025, // smaller for web
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.09),
          borderRadius: BorderRadius.circular(
              isMobile ? size.width * 0.045 : size.width * 0.012), // smaller for web
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: isMobile
                  ? size.width * 0.045
                  : size.width * 0.012, // smaller for web
              offset: Offset(
                  0,
                  isMobile
                      ? size.height * 0.01
                      : size.height * 0.008), // smaller for web
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
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: isMobile
                            ? size.width * 0.037
                            : size.width * 0.009), // smaller for web
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.name],
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Please enter your name'
                        : null,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_emailFocus),
                  ),
                ),
                SizedBox(
                    height: isMobile
                        ? size.height * 0.02
                        : size.height * 0.012), // smaller for web
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
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: isMobile
                            ? size.width * 0.037
                            : size.width * 0.009),
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
                SizedBox(
                    height: isMobile
                        ? size.height * 0.02
                        : size.height * 0.012), // smaller for web
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
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: isMobile
                            ? size.width * 0.037
                            : size.width * 0.009),
                    maxLines: isMobile ? 5 : 5,
                    minLines: isMobile ? 3 : 3,
                    maxLength: 800,
                    textInputAction: TextInputAction.newline,
                    autofillHints: const [AutofillHints.addressCityAndState],
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Please enter your message'
                        : null,
                  ),
                ),
                SizedBox(
                    height: isMobile
                        ? size.height * 0.03
                        : size.height * 0.018), // smaller for web
                // Animated Send Button
                SizedBox(
                  width: isMobile
                      ? double.infinity
                      : size.width * 0.09, // smaller for web
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: _isSending
                        ? ElevatedButton.icon(
                            key: const ValueKey('sending'),
                            onPressed: null,
                            icon: SizedBox(
                              width: isMobile
                                  ? size.width * 0.045
                                  : size.width * 0.018, // smaller for web
                              height: isMobile
                                  ? size.width * 0.045
                                  : size.width * 0.018, // smaller for web
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            label: Text(
                              'Sending...',
                              style: TextStyle(
                                fontSize: isMobile
                                    ? size.width * 0.042
                                    : size.width * 0.01, // smaller for web
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: isMobile
                                      ? size.height * 0.02
                                      : size.height * 0.01), // smaller for web
                              backgroundColor: Color(0xFF6A82FB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(isMobile
                                    ? size.width * 0.025
                                    : size.width * 0.006), // smaller for web
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
                              padding: EdgeInsets.symmetric(
                                  vertical: isMobile
                                      ? size.height * 0.02
                                      : size.height * 0.01),
                              backgroundColor: const Color(0xFF6A82FB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(isMobile
                                    ? size.width * 0.025
                                    : size.width * 0.006),
                              ),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile
                                      ? size.width * 0.042
                                      : size.width * 0.01),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.send_rounded,
                                    color: Colors.white,
                                    size: isMobile
                                        ? size.width * 0.052
                                        : size.width * 0.014), // smaller for web
                                SizedBox(
                                    width: isMobile
                                        ? size.width * 0.018
                                        : size.width * 0.003), // smaller for web
                                Text(
                                  'Send Message',
                                  style: TextStyle(
                                    fontSize: isMobile
                                        ? size.width * 0.042
                                        : size.width * 0.01,
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
                  SizedBox(
                      height: isMobile
                          ? size.height * 0.018
                          : size.height * 0.01), // smaller for web
                  // Use a fixed height for feedback to avoid shrinking the card
                  SizedBox(
                    height: isMobile
                        ? size.height * 0.03
                        : size.height * 0.025,
                    child: AnimatedOpacity(
                      opacity: _feedbackMessage != null ? 1 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        _feedbackMessage!,
                        style: TextStyle(
                          color: _feedbackMessage!.startsWith('🎉')
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontSize: isMobile
                              ? size.width * 0.037
                              : size.width * 0.008, // smaller for web
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ] else ...[
                  // Reserve space for feedback even when not shown
                  SizedBox(
                    height: isMobile
                        ? size.height * 0.03
                        : size.height * 0.025,
                  ),
                ],
                SizedBox(
                    height: isMobile
                        ? size.height * 0.018
                        : size.height * 0.01), // smaller for web
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline,
                        color: Colors.white38,
                        size: isMobile
                            ? size.width * 0.03
                            : size.width * 0.01), // smaller for web
                    SizedBox(width: isMobile
                        ? size.width * 0.01
                        : size.width * 0.003), // smaller for web
                    Flexible(
                      child: Text(
                        'We respect your privacy. Your information is safe.',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: isMobile
                              ? size.width * 0.03
                              : size.width * 0.008, // smaller for web
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
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
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    // Use the same stable cardHeight as the form
    final usedCardHeight = _lastCardHeight ?? cardHeight;

    return FadeTransition(
      opacity: _infoFadeAnimation,
      child: Container(
        height: isMobile ? null : usedCardHeight * 0.82, // keep height stable
        padding: EdgeInsets.symmetric(
            vertical: isMobile
                ? size.height * 0.03
                : size.height * 0.018, // smaller for web
            horizontal: isMobile
                ? size.width * 0.025
                : size.width * 0.018), // smaller for web
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(
              isMobile ? size.width * 0.035 : size.width * 0.008), // smaller for web
          border: Border.all(color: Colors.white.withOpacity(0.10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile
                    ? size.width * 0.045
                    : size.width * 0.011, // smaller for web
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(
                height: isMobile
                    ? size.height * 0.018
                    : size.height * 0.01), // smaller for web
            _infoRow(
              icon: Icons.email_outlined,
              label: 'Email',
              value: 'lingovrse@gmail.com',
              isMobile: isMobile,
            ),
            SizedBox(
                height: isMobile
                    ? size.height * 0.013
                    : size.height * 0.008), // smaller for web
            _infoRow(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: '-',
              isMobile: isMobile,
            ),
            SizedBox(
                height: isMobile
                    ? size.height * 0.013
                    : size.height * 0.008), // smaller for web
            _infoRow(
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: 'Athens, Greece',
              isMobile: isMobile,
            ),
            SizedBox(
                height: isMobile
                    ? size.height * 0.023
                    : size.height * 0.012), // smaller for web
            Divider(color: Colors.white24, thickness: 1),
            SizedBox(
                height: isMobile
                    ? size.height * 0.018
                    : size.height * 0.01), // smaller for web
            Row(
              children: [
                Icon(Icons.public,
                    color: Colors.blue.shade100,
                    size: isMobile
                        ? size.width * 0.045
                        : size.width * 0.01), // smaller for web
                SizedBox(
                    width: isMobile
                        ? size.width * 0.018
                        : size.width * 0.003), // smaller for web
                Text(
                  'fluoverse.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile
                        ? size.width * 0.032
                        : size.width * 0.007, // smaller for web
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
                height: isMobile
                    ? size.height * 0.023
                    : size.height * 0.012), // smaller for web
            Text(
              'Our team will get back to you within 24 hours. For urgent matters, please use the contact details above.',
              style: TextStyle(
                color: Colors.white60,
                fontSize: isMobile
                    ? size.width * 0.032
                    : size.width * 0.007, // smaller for web
                height: 1.5,
              ),
            ),
            SizedBox(
                height: isMobile
                    ? size.height * 0.023
                    : size.height * 0.012), // smaller for web
            Row(
              children: [
                Icon(Icons.verified_user_outlined,
                    color: Colors.greenAccent.shade100,
                    size: isMobile
                        ? size.width * 0.045
                        : size.width * 0.01),
                SizedBox(
                    width: isMobile
                        ? size.width * 0.018
                        : size.width * 0.003),
                Text(
                  'Trusted & Secure',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile
                        ? size.width * 0.03
                        : size.width * 0.006, // smaller for web
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
                height: isMobile
                    ? size.height * 0.01
                    : size.height * 0.006), // smaller for web
            Row(
              children: [
                Icon(Icons.support_agent_outlined,
                    color: Colors.purpleAccent.shade100,
                    size: isMobile
                        ? size.width * 0.045
                        : size.width * 0.01),
                SizedBox(
                    width: isMobile
                        ? size.width * 0.018
                        : size.width * 0.003),
                Text(
                  'Friendly Support',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile
                        ? size.width * 0.03
                        : size.width * 0.006,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
                height: isMobile
                    ? size.height * 0.01
                    : size.height * 0.006),
            Row(
              children: [
                Icon(Icons.flash_on_outlined,
                    color: Colors.yellowAccent.shade100,
                    size: isMobile
                        ? size.width * 0.045
                        : size.width * 0.01),
                SizedBox(
                    width: isMobile
                        ? size.width * 0.018
                        : size.width * 0.003),
                Text(
                  'Fast Response',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile
                        ? size.width * 0.03
                        : size.width * 0.006,
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
    bool isMobile = false,
  }) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            color: Colors.white70,
            size: isMobile ? size.width * 0.045 : size.width * 0.01), // smaller for web
        SizedBox(
            width: isMobile ? size.width * 0.021 : size.width * 0.003), // smaller for web
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white54,
                fontSize: isMobile
                    ? size.width * 0.028
                    : size.width * 0.005, // smaller for web
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2),
            SelectableText(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile
                    ? size.width * 0.032
                    : size.width * 0.007, // smaller for web
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
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : size.width * 0.55, // smaller for web
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900 && !isMobile;
            return _EqualHeightRow(
              isWide: isWide,
              buildForm: (height) => _buildAnimatedForm(height),
              buildInfo: (height) => _buildContactInfo(height),
              isMobile: isMobile,
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
  final bool isMobile;

  const _EqualHeightRow({
    required this.isWide,
    required this.buildForm,
    required this.buildInfo,
    this.isMobile = false,
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
    final size = MediaQuery.of(context).size;
    // Use screen height as a percentage for default heights and spacing
    final double defaultHeight = widget.isMobile ? size.height * 0.01 : size.height * 0.65; // e.g. 1% or 75%
    final double rowSpacing = widget.isMobile ? size.height * 0.03 : size.width * 0.035; // e.g. 3% or 4.5% of width

    final form = Container(
      key: _formKey,
      child: widget.buildForm(_maxHeight > 0 ? _maxHeight : defaultHeight),
    );
    final info = Container(
      key: _infoKey,
      child: widget.buildInfo(_maxHeight > 0 ? _maxHeight : defaultHeight),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateHeight());

    if (widget.isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          form,
          SizedBox(width: rowSpacing),
          Expanded(child: info),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          form,
          SizedBox(height: rowSpacing),
          info,
        ],
      );
    }
  }
}
