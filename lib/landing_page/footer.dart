// lib/landing_page/footer_section.dart

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF9FAFB), Color(0xFFFFFFFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo and description
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(LucideIcons.bookOpen, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 8),
              Text(
                "Fluoverse",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "The future of language learning.\nPersonalized. Immersive. Powered by AI.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 24),
          
          // Links grid
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            runSpacing: 16,
            children: [
              _buildFooterColumn('Company', ['About Us','Blog']),
              _buildFooterColumn('Languages', ['Spanish']),
              _buildFooterColumn('Legal', ['Terms', 'Privacy', 'Cookies']),
            ],
          ),
          const SizedBox(height: 32),
          
          // Divider
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 20),
          
          // Copyright
          Text(
            "© $currentYear Fluoverse. All rights reserved.",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            item,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        )),
      ],
    );
  }
}
