// lib/widgets/pricing_widgets.dart

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:ui';
import '../screens/join_waitlist.dart';






// Background mesh/particles (improved to match the photo)
class BackgroundEffects extends StatelessWidget {
  const BackgroundEffects({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E1E2C), Color(0xFF232946)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Blurred purple circle (top left)
        Positioned(
          top: -size.height * 0.13,
          left: -size.width * 0.09,
          child: Container(
            width: size.width * 0.38,
            height: size.width * 0.38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFB16CEA).withOpacity(0.25),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: const SizedBox(),
            ),
          ),
        ),
        // Blurred blue circle (top right)
        Positioned(
          top: -size.height * 0.08,
          right: -size.width * 0.07,
          child: Container(
            width: size.width * 0.28,
            height: size.width * 0.28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF009E8F).withOpacity(0.18),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: const SizedBox(),
            ),
          ),
        ),
        // Small floating dots (stars)
        ...List.generate(18, (i) {
          final positions = [
            [0.12, 0.18], [0.22, 0.12], [0.35, 0.22], [0.48, 0.09],
            [0.62, 0.18], [0.75, 0.13], [0.88, 0.19], [0.15, 0.32],
            [0.28, 0.29], [0.41, 0.31], [0.53, 0.27], [0.67, 0.33],
            [0.81, 0.28], [0.93, 0.35], [0.18, 0.44], [0.5, 0.45],
            [0.82, 0.43], [0.7, 0.5],
          ];
          return Positioned(
            left: positions[i][0] * size.width,
            top: positions[i][1] * size.height,
            child: Container(
              width: size.width * 0.008,
              height: size.width * 0.008,
              decoration: const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ],
    );
  }
}

// Title widget as shown in the photo
class PricingTitleSection extends StatelessWidget {
  const PricingTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double fontSize = width < 600 ? 36 : (width < 900 ? 48 : 68);
    return Column(
      children: [
        // Title
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              height: 1.1,
            ),
            children: [
              TextSpan(
                text: 'Choose Your\n',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              TextSpan(
                text: 'Destiny',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [Color(0xFFB16CEA), Color(0xFFFF5E69)],
                    ).createShader(Rect.fromLTWH(0, 0, 200, 60)),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // Subtitle
        Text(
          'Unlock fluency at the speed of thought. Every plan crafted for Spanish mastery.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: width < 600 ? 15 : 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// Feature line with check icon
class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double iconSize = width < 600 ? 16 : 20;
    double fontSize = width < 600 ? 13 : 16;
    return Row(
      children: [
        Icon(Icons.check_circle, color: const Color(0xFF00FFB2), size: iconSize),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
        )
      ],
    );
  }
}

// Pricing cards row with premium hover effects and no scroll
class PricingCardsRow extends StatefulWidget {
  final bool isAnnual;

  const PricingCardsRow({super.key, required this.isAnnual});

  @override
  State<PricingCardsRow> createState() => _PricingCardsRowState();
}

class _PricingCardsRowState extends State<PricingCardsRow> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive card sizing
    double cardWidth = screenWidth < 600
        ? screenWidth * 0.92
        : screenWidth < 900
            ? screenWidth * 0.85 / 3
            : screenWidth * 0.72 / 3;
    double cardHeight = screenHeight < 900
        ? screenHeight * 0.7
        : screenHeight * 0.7;

    double middleCardWidth = cardWidth * 1.13;
    double middleCardHeight = cardHeight * 1.07;

    // Clamp min/max for usability
    cardWidth = cardWidth.clamp(260.0, 480.0);
    cardHeight = cardHeight.clamp(420.0, 860.0);
    middleCardWidth = middleCardWidth.clamp(300.0, 540.0);
    middleCardHeight = middleCardHeight.clamp(480.0, 920.0);

    final isMobile = screenWidth < 900;
    final double spacing = isMobile ? 10 : 32;

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (isMobile) {
            // Stack vertically on mobile
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCard(
                  index: 0,
                  width: cardWidth,
                  height: cardHeight,
                  child: PricingCard(
                    title: 'Explorer',
                    price: '\$14.99',
                    description: 'Perfect for curious beginners',
                    features: [
                      '1 cycle per day',
                      'Fluoverse AI coaching',
                      'Personalized content',
                    ],
                    startColor: const Color(0xFF232946),
                    endColor: const Color(0xFF232946),
                    icon: LucideIcons.zap,
                    buttonText: 'Start Explorer Journey',
                    isPopular: false,
                    priceWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PriceWidget(price: '\$14.99'),
                        const SizedBox(width: 6),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '/per month',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isHovered: hoveredIndex == 0,
                  ),
                ),
                SizedBox(height: spacing),
                _buildCard(
                  index: 1,
                  width: middleCardWidth,
                  height: middleCardHeight,
                  isMiddle: true,
                  child: PricingCard(
                    title: 'Pro',
                    price: widget.isAnnual ? '\$20.00' : '\$24.99',
                    description: 'For serious Spanish learners',
                    features: [
                      '2 cycles per day',
                      'Fluoverse AI coaching',
                      'Priority support',
                      'Personalized content',
                    ],
                    startColor: const Color(0xFFB16CEA),
                    endColor: const Color(0xFFFF5E69),
                    icon: LucideIcons.crown,
                    buttonText: 'Become Pro Now',
                    isPopular: true,
                    priceWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PriceWidget(
                          price: widget.isAnnual ? '\$20.00' : '\$24.99',
                          isGold: true,
                        ),
                        const SizedBox(width: 6),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            widget.isAnnual ? '/per month' : '/per month',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isHovered: hoveredIndex == 1,
                  ),
                ),
                SizedBox(height: spacing),
                _buildCard(
                  index: 2,
                  width: cardWidth,
                  height: cardHeight,
                  child: PricingCard(
                    title: 'Pro Annual',
                    price: '\$240',
                    description: 'Best value for committed learners',
                    features: [
                      '2 cycles per day',
                      'Fluoverse AI coaching',
                      'Priority support',
                      'Personalized content',
                    ],
                    startColor: const Color(0xFF009E8F),
                    endColor: const Color(0xFF00FFB2),
                    icon: LucideIcons.star,
                    buttonText: 'Lock in Annual Savings',
                    isPopular: false,
                    subPrice: '\$299',
                    subPriceHighlight: 'Save \$59',
                    priceWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PriceWidget(price: '\$240'),
                        const SizedBox(width: 6),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '/per year',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isHovered: hoveredIndex == 2,
                  ),
                ),
              ],
            );
          } else {
            // Row for desktop/tablet
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCard(
                  index: 0,
                  width: cardWidth,
                  height: cardHeight,
                  child: PricingCard(
                    title: 'Explorer',
                    price: '\$14.99',
                    description: 'Perfect for curious beginners',
                    features: [
                      '1 cycle per day',
                      'Fluoverse AI coaching',
                      'Personalized content',
                    ],
                    startColor: const Color(0xFF232946),
                    endColor: const Color(0xFF232946),
                    icon: LucideIcons.zap,
                    buttonText: 'Start Explorer Journey',
                    isPopular: false,
                    priceWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PriceWidget(price: '\$14.99'),
                        const SizedBox(width: 6),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '/per month',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isHovered: hoveredIndex == 0,
                  ),
                ),
                SizedBox(width: spacing),
                _buildCard(
                  index: 1,
                  width: middleCardWidth,
                  height: middleCardHeight,
                  isMiddle: true,
                  child: PricingCard(
                    title: 'Pro',
                    price: widget.isAnnual ? '\$20.00' : '\$24.99',
                    description: 'For serious Spanish learners',
                    features: [
                      '2 cycles per day',
                      'Fluoverse AI coaching',
                      'Priority support',
                      'Personalized content',
                    ],
                    startColor: const Color(0xFFB16CEA),
                    endColor: const Color(0xFFFF5E69),
                    icon: LucideIcons.crown,
                    buttonText: 'Become Pro Now',
                    isPopular: true,
                    priceWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PriceWidget(
                          price: widget.isAnnual ? '\$20.00' : '\$24.99',
                          isGold: true,
                        ),
                        const SizedBox(width: 6),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            widget.isAnnual ? '/per month' : '/per month',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isHovered: hoveredIndex == 1,
                  ),
                ),
                SizedBox(width: spacing),
                _buildCard(
                  index: 2,
                  width: cardWidth,
                  height: cardHeight,
                  child: PricingCard(
                    title: 'Pro Annual',
                    price: '\$240',
                    description: 'Best value for committed learners',
                    features: [
                      '2 cycles per day',
                      'Fluoverse AI coaching',
                      'Priority support',
                      'Personalized content',
                    ],
                    startColor: const Color(0xFF009E8F),
                    endColor: const Color(0xFF00FFB2),
                    icon: LucideIcons.star,
                    buttonText: 'Lock in Annual Savings',
                    isPopular: false,
                    subPrice: '\$299',
                    subPriceHighlight: 'Save \$59',
                    priceWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PriceWidget(price: '\$240'),
                        const SizedBox(width: 6),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '/per year',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isHovered: hoveredIndex == 2,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCard({
    required int index,
    required double width,
    required double height,
    required Widget child,
    bool isMiddle = false,
  }) {
    final hovered = hoveredIndex == index;
    final transform = hovered
        ? (Matrix4.identity()
          ..translate(0.0, isMiddle ? -24.0 : -12.0)
          ..scale(isMiddle ? 1.045 : 1.035))
        : (isMiddle
            ? (Matrix4.identity()..translate(0.0, -16.0))
            : Matrix4.identity());

    BoxDecoration? boxDecoration;
    if (isMiddle) {
      boxDecoration = BoxDecoration(
        boxShadow: hovered
            ? [
                BoxShadow(
                  color: Colors.pinkAccent.withOpacity(0.30),
                  blurRadius: 64,
                  offset: const Offset(0, 32),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.pinkAccent.withOpacity(0.25),
                  blurRadius: 48,
                  offset: const Offset(0, 24),
                ),
              ],
        borderRadius: BorderRadius.circular(32),
      );
    } else {
      boxDecoration = BoxDecoration(
        boxShadow: hovered
            ? [
                BoxShadow(
                  color: const Color(0xFF00FFB2).withOpacity(0.13),
                  blurRadius: 48,
                  offset: const Offset(0, 24),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        transform: transform,
        decoration: boxDecoration,
        child: child,
      ),
    );
  }
}

// PricingCard widget (content made bigger to fill out the card)
class PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final List<String> features;
  final Color startColor;
  final Color endColor;
  final IconData icon;
  final String buttonText;
  final bool isPopular;
  final String? subPrice;
  final String? subPriceHighlight;
  final Widget? priceWidget;
  final bool isHovered;

  const PricingCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.features,
    required this.startColor,
    required this.endColor,
    required this.icon,
    required this.buttonText,
    this.isPopular = false,
    this.subPrice,
    this.subPriceHighlight,
    this.priceWidget,
    this.isHovered = false,
  });

  @override
  Widget build(BuildContext context) {
    // 3D button style
    ButtonStyle premiumButtonStyle({bool filled = true}) {
      return ElevatedButton.styleFrom(
        backgroundColor: filled
            ? (isPopular
                ? const Color(0xFFFF5E69)
                : Colors.white)
            : Colors.transparent,
        foregroundColor: isPopular
            ? Colors.white
            : (filled ? startColor : Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: filled ? 16 : 0,
        shadowColor: filled
            ? (isPopular
                ? Colors.pinkAccent.withOpacity(0.25)
                : Colors.black.withOpacity(0.13))
            : Colors.transparent,
        side: filled
            ? null
            : const BorderSide(color: Colors.white24, width: 1.5),
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white.withOpacity(0.13);
            }
            if (states.contains(MaterialState.hovered)) {
              return isPopular
                  ? const Color(0xFFFF5E69).withOpacity(0.93)
                  : Colors.white.withOpacity(0.96);
            }
            return null;
          },
        ),
        shadowColor: MaterialStateProperty.all(
          filled
              ? (isPopular
                  ? Colors.pinkAccent.withOpacity(0.33)
                  : Colors.black.withOpacity(0.18))
              : Colors.transparent,
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isHovered
                ? Color.lerp(startColor, Colors.white, 0.04)!
                : startColor,
            isHovered
                ? Color.lerp(endColor, Colors.white, 0.04)!
                : endColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color: endColor.withOpacity(0.18),
                  blurRadius: 56,
                  offset: const Offset(0, 24),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ]
            : [
                BoxShadow(
                  color: startColor.withOpacity(0.13),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
        border: isPopular
            ? Border.all(
                color: isHovered
                    ? Colors.white.withOpacity(0.93)
                    : Colors.white,
                width: 2.2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isPopular)
            const _PopularBadge(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  startColor.withOpacity(isHovered ? 1 : 0.9),
                  endColor.withOpacity(isHovered ? 0.85 : 0.7),
                ],
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: endColor.withOpacity(0.22),
                        blurRadius: 32,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            padding: EdgeInsets.all(isHovered ? 36 : 28),
            child: Icon(icon, size: isHovered ? 72 : 60, color: Colors.white),
          ),
          const SizedBox(height: 28),
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 14),
          priceWidget ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    title == 'Pro Annual' ? '/year' : '/month',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
          if (subPrice != null && subPriceHighlight != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Text(
                '$subPrice  ($subPriceHighlight)',
                style: const TextStyle(
                  color: Color(0xFF00FFB2),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          const SizedBox(height: 14),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: features
                  .map((f) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: FeatureItemBig(f),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: premiumButtonStyle(filled: true),
              onPressed: () {},
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 3D shadow effect
                  if (isHovered)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: isPopular
                                  ? Colors.pinkAccent.withOpacity(0.22)
                                  : startColor.withOpacity(0.18),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: isPopular ? Colors.white : startColor,
                        letterSpacing: 0.2,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Golden animated "POPULAR" badge
class _PopularBadge extends StatefulWidget {
  const _PopularBadge();

  @override
  State<_PopularBadge> createState() => _PopularBadgeState();
}

class _PopularBadgeState extends State<_PopularBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 18),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.32),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
            gradient: SweepGradient(
              colors: const [
                Color(0xFFFFF9D2),
                Color(0xFFFFE066),
                Color(0xFFFFD700),
                Color(0xFFFFF6C3),
                Color(0xFFFFC700),
                Color(0xFFFFE066),
                Color(0xFFFFF9D2),
              ],
              stops: const [0.0, 0.18, 0.32, 0.5, 0.68, 0.85, 1.0],
              startAngle: 0,
              endAngle: 6.28319,
              transform: GradientRotation(_controller.value * 6.28319),
            ),
            border: Border.all(
              color: const Color(0xFFFFD700).withOpacity(0.85),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) => const LinearGradient(
                  colors: [
                	Color(0xFFB16CEA),
                  Color(0xFFFF5E69),
                  Color(0xFFB16CEA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              ShaderMask(
                shaderCallback: (Rect bounds) => const LinearGradient(
                  colors: [
                    Color(0xFFB16CEA),
                    Color(0xFFFF5E69),
                    Color(0xFFB16CEA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'MOST POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Bigger feature item for the larger card content
class FeatureItemBig extends StatelessWidget {
  final String text;

  const FeatureItemBig(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Responsive icon and font size based on screen width
    double iconSize = width < 600 ? width * 0.07 : width < 900 ? width * 0.045 : 28;
    iconSize = iconSize.clamp(20.0, 32.0);
    double fontSize = width < 600 ? width * 0.045 : width < 900 ? width * 0.032 : 20;
    fontSize = fontSize.clamp(15.0, 22.0);
    double spacing = width < 600 ? width * 0.04 : width < 900 ? width * 0.025 : 16;
    spacing = spacing.clamp(8.0, 20.0);

    return Row(
      children: [
        Icon(Icons.check_circle, color: const Color(0xFF00FFB2), size: iconSize),
        SizedBox(width: spacing),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}

// FAQ section
class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final faqs = [
      (
        'What exactly is a "cycle"?',
        'A complete learning sequence: Vocabulary → Reading → Listening → Scenario. Each cycle takes 15 – 20 minutes and builds real fluency.',
        Icons.autorenew
      ),
      (
        'Can I change plans anytime?',
        'Absolutely! Upgrade or downgrade your plan whenever you want. Changes take effect immediately.',
        Icons.swap_horiz
      ),
      (
        'Do I need special equipment?',
        'Just a microphone! Our AI works with any device that can record audio - computer, phone, or tablet.',
        Icons.mic
      ),
      (
        'When do Fluency Rooms launch?',
        'Multi-user Fluency Rooms are coming this quarter! Join our waitlist to get early access.',
        Icons.group
      ),
    ];

    final width = MediaQuery.of(context).size.width;
    // Responsive FAQ card sizing
    double maxCardWidth = width < 600 ? width * 0.92 : width < 900 ? 500 : 500;
    double cardHeight = width < 600 ? width * 0.7 : 300;
    maxCardWidth = maxCardWidth.clamp(220.0, 500.0);
    cardHeight = cardHeight.clamp(160.0, 320.0);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width < 900 ? width * 0.98 : 700),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Questions & Answers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Everything you need to know about your Spanish learning journey',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 32),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 500;
                final crossAxisCount = width < 600 ? 1 : (isWide ? 2 : 1);
                final spacing = width < 600 ? width * 0.04 : 20.0;
                return Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: faqs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: spacing,
                      crossAxisSpacing: spacing,
                      childAspectRatio: maxCardWidth / cardHeight,
                    ),
                    itemBuilder: (context, i) {
                      final e = faqs[i];
                      final isHovered = hoveredIndex == i;
                      return MouseRegion(
                        onEnter: (_) => setState(() => hoveredIndex = i),
                        onExit: (_) => setState(() => hoveredIndex = null),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutCubic,
                          width: maxCardWidth,
                          height: cardHeight,
                          padding: EdgeInsets.all(width < 600 ? width * 0.04 : 16),
                          decoration: BoxDecoration(
                            color: isHovered
                                ? const Color(0xFF2D2956)
                                : const Color(0xFF232946),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isHovered
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFFB16CEA)
                                          .withOpacity(0.18),
                                      blurRadius: 22,
                                      offset: const Offset(0, 6),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                            border: isHovered
                                ? Border.all(
                                    color: const Color(0xFFB16CEA)
                                        .withOpacity(0.22),
                                    width: 1.2,
                                  )
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(e.$3, color: const Color(0xFFFF5E69), size: width < 600 ? width * 0.07 : 28),
                              const SizedBox(height: 8),
                              Text(
                                e.$1,
                                style: TextStyle(
                                  fontSize: width < 600 ? width * 0.045 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Expanded(
                                child: Text(
                                  e.$2,
                                  style: TextStyle(
                                    fontSize: width < 600 ? width * 0.035 : 14,
                                    color: Colors.white70,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// CTA section (clean, premium style)
class FinalCtaSection extends StatelessWidget {
  const FinalCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double maxWidth = width < 900 ? width * 0.98 : 700;
    double paddingV = width < 600 ? width * 0.08 : 48;
    double paddingH = width < 600 ? width * 0.04 : 36;
    double iconSize = width < 600 ? width * 0.11 : 48;
    iconSize = iconSize.clamp(32.0, 54.0);
    double titleFont = width < 600 ? width * 0.07 : 32;
    titleFont = titleFont.clamp(20.0, 36.0);
    double descFont = width < 600 ? width * 0.045 : 17;
    descFont = descFont.clamp(13.0, 18.0);
    double buttonFont = width < 600 ? width * 0.045 : 18;
    buttonFont = buttonFont.clamp(14.0, 20.0);

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: EdgeInsets.symmetric(
            vertical: width < 600 ? width * 0.08 : 48,
            horizontal: width < 600 ? width * 0.02 : 16),
        padding: EdgeInsets.symmetric(
            vertical: paddingV, horizontal: paddingH),
        decoration: BoxDecoration(
          color: const Color(0xFF232946),
          borderRadius: BorderRadius.circular(width < 600 ? 20 : 36),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.white12, width: 1.2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.rocket,
              size: iconSize,
              color: Colors.white.withOpacity(0.93),
            ),
            SizedBox(height: width < 600 ? width * 0.04 : 18),
            Text(
              'Ready to Master Spanish?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFont,
                fontWeight: FontWeight.w800,
                color: Colors.white.withOpacity(0.97),
                letterSpacing: 1.1,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: width < 600 ? width * 0.03 : 14),
            Text(
              'Join thousands who chose fluency over memorization.\nStart your Spanish journey with the most advanced AI platform.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: descFont,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: width < 600 ? width * 0.06 : 28),
            Wrap(
              spacing: width < 600 ? width * 0.03 : 16,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  height: width < 600 ? width * 0.12 : 54,
                  child: ElevatedButton.icon(
                    icon: ShaderMask(
                      shaderCallback: (Rect bounds) => const LinearGradient(
                        colors: [Color.fromARGB(255, 118, 27, 171), Color.fromARGB(255, 118, 27, 171)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Icon(LucideIcons.zap, color: Colors.white, size: width < 600 ? width * 0.06 : 24),
                    ),
                    label: ShaderMask(
                      shaderCallback: (Rect bounds) => const LinearGradient(
                        colors: [Color.fromARGB(255, 118, 27, 171), Color.fromARGB(255, 118, 27, 171)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        'Launch Your Journey',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: buttonFont,
                          letterSpacing: 0.3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 118, 27, 171),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: width < 600 ? width * 0.08 : 36,
                          vertical: width < 600 ? width * 0.03 : 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width < 600 ? 12 : 16),
                      ),
                      elevation: 14,
                      shadowColor: Colors.pinkAccent.withOpacity(0.35),
                    ).copyWith(
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xFFB16CEA).withOpacity(0.97);
                          }
                          if (states.contains(MaterialState.hovered)) {
                            return const Color(0xFFFF5E69).withOpacity(0.93);
                          }
                          return const Color(0xFFFF5E69);
                        },
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: width < 600 ? width * 0.12 : 54,
                  child: OutlinedButton.icon(
                    icon: ShaderMask(
                      shaderCallback: (Rect bounds) => const LinearGradient(
                        colors: [Color(0xFF00FFB2), Color(0xFF009E8F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Icon(LucideIcons.mail, color: Colors.white, size: width < 600 ? width * 0.055 : 22),
                    ),
                    label: ShaderMask(
                      shaderCallback: (Rect bounds) => const LinearGradient(
                        colors: [Color(0xFF00FFB2), Color(0xFF009E8F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        'Join Waitlist',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: buttonFont,
                          letterSpacing: 0.3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF00FFB2), width: 2.2),
                      padding: EdgeInsets.symmetric(
                          horizontal: width < 600 ? width * 0.07 : 32,
                          vertical: width < 600 ? width * 0.03 : 16),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width < 600 ? 12 : 16),
                      ),
                      backgroundColor: const Color(0xFF00FFB2).withOpacity(0.10),
                      elevation: 0,
                    ).copyWith(
                      overlayColor: MaterialStateProperty.all(const Color(0xFF00FFB2).withOpacity(0.13)),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const JoinWaitlist()),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: width < 600 ? width * 0.03 : 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.shieldCheck, color: const Color(0xFF00FFB2), size: width < 600 ? width * 0.045 : 18),
                SizedBox(width: width < 600 ? width * 0.02 : 8),
                Text(
                  '7 - day free trial included',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.80),
                    fontWeight: FontWeight.w500,
                    fontSize: width < 600 ? width * 0.032 : 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Price widget for custom price display
class PriceWidget extends StatelessWidget {
  final String price;
  final bool isGold;

  const PriceWidget({super.key, required this.price, this.isGold = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double fontSize = width < 600 ? width * 0.12 : 72;
    fontSize = fontSize.clamp(36.0, 80.0);

    Shader goldGradient(Rect bounds) => const LinearGradient(
      colors: [
        Color(0xFFFFF9D2), // soft highlight
        Color(0xFFFFE066), // bright gold
        Color(0xFFFFD700), // rich gold
        Color(0xFFFFF6C3), // subtle highlight
        Color(0xFFFFC700), // deeper gold
        Color(0xFFFFE066), // bright gold
        Color(0xFFFFF9D2), // soft highlight
      ],
      stops: [0.0, 0.18, 0.32, 0.5, 0.68, 0.85, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds);

    Shader silverGradient(Rect bounds) => const LinearGradient(
      colors: [
        Color(0xFFF5F6FA), // very light silver
        Color(0xFFD7D7E0), // soft silver
        Color(0xFFBFC6D1), // mid silver
        Color(0xFFFFFFFF), // white highlight
        Color(0xFFBFC6D1), // mid silver
        Color(0xFFD7D7E0), // soft silver
        Color(0xFFF5F6FA), // very light silver
      ],
      stops: [0.0, 0.15, 0.32, 0.5, 0.68, 0.85, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds);

    return ShaderMask(
      shaderCallback: (Rect bounds) =>
          isGold ? goldGradient(bounds) : silverGradient(bounds),
      child: Text(
        price,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: -2,
          color: Colors.white, // Needed for ShaderMask
          shadows: const [
            Shadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
