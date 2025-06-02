// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/homepage_widgets.dart';
import '../widgets/navigation_bar_widget.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String _privacyPolicyContent = '';
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {};

  @override
  void initState() {
    super.initState();
    _loadPrivacyPolicy();
  }

  Future<void> _loadPrivacyPolicy() async {
    final content = await rootBundle.loadString('assets/Privacy.md');
    setState(() {
      _privacyPolicyContent = content;
    });
  }

  Future<void> _onTapLink(String? text, String? href, String title) async {
    if (href != null) {
      if (href.startsWith('#')) {
        // Internal link: Scroll to the section
        final sectionKey = _sectionKeys[href.substring(1)];
        if (sectionKey != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final context = sectionKey.currentContext;
            if (context != null) {
              final RenderBox box = context.findRenderObject() as RenderBox;
              final offset = box.localToGlobal(Offset.zero).dy;

              // Adjust for the navigation bar height with extra padding
              const double navBarHeight = kToolbarHeight + 40; // Increased padding
              _scrollController.animateTo(
                _scrollController.offset + offset - navBarHeight,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          });
        }
      } else if (await canLaunchUrl(Uri.parse(href))) {
        // External link: Open in browser
        await launchUrl(Uri.parse(href), mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open link: $href')),
        );
      }
    }
  }

  List<Widget> _buildMarkdownSections(String content) {
    final lines = content.split('\n');
    final List<Widget> widgets = [];
    String currentSection = '';
    for (final line in lines) {
      if (line.startsWith('#')) {
        // Create a new section
        if (currentSection.isNotEmpty) {
          widgets.add(MarkdownBody(
            data: currentSection,
            onTapLink: _onTapLink,
            styleSheet: _markdownStyleSheet(),
          ));
          currentSection = '';
        }
        // Generate section ID matching the format in the Markdown file
        final headingText = line.replaceAll(RegExp(r'^#+\s*'), '');
        final sectionId = headingText
            .trim()
            .toLowerCase()
            .replaceAll(RegExp(r'[^\w\s-]'), '')  // Remove non-word characters
            .replaceAll(' ', '-')                // Replace spaces with hyphens
            .replaceAll(RegExp(r'-+'), '-');     // Collapse multiple hyphens

        final sectionKey = GlobalKey();
        _sectionKeys[sectionId] = sectionKey;
        widgets.add(Container(
          key: sectionKey,
          child: MarkdownBody(
            data: line,
            styleSheet: _markdownStyleSheet(),
          ),
        ));
      } else if (line.trim() == '---') {
        // Add a divider with newlines before and after
        if (currentSection.isNotEmpty) {
          widgets.add(MarkdownBody(
            data: currentSection,
            onTapLink: _onTapLink,
            styleSheet: _markdownStyleSheet(),
          ));
          currentSection = '';
        }
        widgets.add(const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(color: Colors.white70, thickness: 1.0),
        ));
      } else if (line.trim().isEmpty) {
        // Add spacing for empty lines
        if (currentSection.isNotEmpty) {
          widgets.add(MarkdownBody(
            data: currentSection,
            onTapLink: _onTapLink,
            styleSheet: _markdownStyleSheet(),
          ));
          currentSection = '';
        }
        widgets.add(const SizedBox(height: 14.0)); // Add spacing for empty lines
      } else {
        currentSection += '$line\n';
      }
    }
    if (currentSection.isNotEmpty) {
      widgets.add(MarkdownBody(
        data: currentSection,
        onTapLink: _onTapLink,
        styleSheet: _markdownStyleSheet(),
      ));
    }
    return widgets;
  }

  MarkdownStyleSheet _markdownStyleSheet() {
    return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
      p: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
      h1: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 212, 0, 255)),
      h2: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 212, 0, 255)),
      h3: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      h4: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      listBullet: const TextStyle(color: Colors.white),
      a: const TextStyle(color: Colors.lightBlueAccent, decoration: TextDecoration.underline),
      blockquote: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
      code: const TextStyle(color: Colors.white, backgroundColor: Color.fromARGB(221, 0, 0, 0)),
      strong: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      tableHead: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      tableBody: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Background(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: kToolbarHeight + 32), // Increased top padding
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: _privacyPolicyContent.isEmpty
                            ? const CircularProgressIndicator()
                            : Align(
                                alignment: Alignment.center,
                                child: FractionallySizedBox(
                                  widthFactor: 0.8, // Adjust width as needed
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: _buildMarkdownSections(_privacyPolicyContent),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavigationBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
