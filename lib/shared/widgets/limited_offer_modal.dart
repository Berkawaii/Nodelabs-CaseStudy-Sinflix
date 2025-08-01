import 'package:flutter/material.dart';
import 'package:sinflix/core/constants/app_assets.dart';

class LimitedOfferModal extends StatelessWidget {
  const LimitedOfferModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF8B2635), // Dark burgundy
            Color(0xFF5D1A24), // Darker burgundy
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // Header - Sınırlı Teklif
                  Text(
                    'Sınırlı Teklif',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                        Shadow(
                          color: const Color(0xFFE91E63).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    'Jeton paketin\'ni seçerek bonus\nkazanın ve yeni bölümlerin kilidini açın!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.4,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),

                  // Bonuses Container
                  Image.asset(AppAssets.modalBonus, width: 400, height: 200, fit: BoxFit.cover),

                  // Jeton packages title
                  Text(
                    'Kilidi açmak için bir jeton paketi seçin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Jeton packages
                  Row(
                    children: [
                      Expanded(
                        child: _buildJetonPackage(
                          originalAmount: '200',
                          finalAmount: '330',
                          price: '₺99,99',
                          discount: '+10%',
                          gradientColors: [Color(0xFFB71C1C), Color(0xFF8B2635)],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildJetonPackage(
                          originalAmount: '2.000',
                          finalAmount: '3.375',
                          price: '₺799,99',
                          discount: '+70%',
                          gradientColors: [Color(0xFF6C63FF), Color(0xFF9C88FF)],
                          isPopular: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildJetonPackage(
                          originalAmount: '1.000',
                          finalAmount: '1.350',
                          price: '₺399,99',
                          discount: '+35%',
                          gradientColors: [Color(0xFFB71C1C), Color(0xFF8B2635)],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // See all jetons button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFF5722), Color(0xFFD32F2F), Color(0xFFB71C1C)],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF5722).withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(0, 6),
                        ),
                        BoxShadow(
                          color: const Color(0xFFFF5722).withOpacity(0.2),
                          blurRadius: 25,
                          spreadRadius: -5,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(28),
                        onTap: () {},
                        child: Center(
                          child: Text(
                            'Tüm Jetonları Gör',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.7),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJetonPackage({
    required String originalAmount,
    required String finalAmount,
    required String price,
    required String discount,
    required List<Color> gradientColors,
    bool isPopular = false,
  }) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [gradientColors[0], gradientColors[1], gradientColors[1].withOpacity(0.9)],
          stops: const [0.0, 0.7, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // Main shadow
          BoxShadow(
            color: gradientColors[0].withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
          // Inner glow effect
          BoxShadow(
            color: isPopular
                ? const Color(0xFF9C88FF).withOpacity(0.3)
                : gradientColors[0].withOpacity(0.2),
            blurRadius: 25,
            spreadRadius: -5,
            offset: const Offset(0, -5),
          ),
        ],
        border: Border.all(
          color: isPopular ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.1),
          width: isPopular ? 1.5 : 0.5,
        ),
      ),
      child: Stack(
        children: [
          // Background gradient overlay for more depth
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.transparent,
                  Colors.black.withOpacity(0.2),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Discount badge
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isPopular
                      ? [Colors.white.withOpacity(0.25), Colors.white.withOpacity(0.15)]
                      : [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.2)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                discount,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),

                // Original amount (crossed out)
                Text(
                  originalAmount,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.white70,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                // Final amount
                Text(
                  finalAmount,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                      if (isPopular)
                        Shadow(
                          color: const Color(0xFF9C88FF).withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                    ],
                  ),
                ),

                Text(
                  'Jeton',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Price
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),

                Text(
                  'Başına haftalık',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
