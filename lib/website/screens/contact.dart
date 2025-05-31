import 'package:flutter/material.dart';
import '../widgets/contact_widgets.dart';
import '../widgets/navigation_bar_widget.dart';
import '../widgets/homepage_widgets.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    void handleSubmit() {
      // TO DO: Implement contact form submission logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent!')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF232946),
      body: Column(
        children: [
          const NavigationBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ContactTitle(),
                  ContactFormSection(
                    nameController: nameController,
                    emailController: emailController,
                    messageController: messageController,
                    onSubmit: handleSubmit,
                  ),
                  const SizedBox(height: 100),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
