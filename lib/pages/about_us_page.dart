import 'package:flutter/material.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation bar
            const NavBar(),

            // About Us content
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page title
                  const Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // University of Portsmouth Students' Union section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'University of Portsmouth Students\' Union',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'The University of Portsmouth Students\' Union (UPSU) is the representative body for all students at the University of Portsmouth. We exist to make your student experience the best it can be.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Our mission is to represent, support, and entertain our diverse student community while providing services that enhance the overall university experience.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Our Shop section
                  const Text(
                    'Our Shop',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The UPSU Shop offers a wide range of university-branded merchandise, textbooks, stationery, and gifts. Whether you\'re looking for official Portsmouth apparel, study materials, or unique gifts for friends and family, we\'ve got you covered.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Services section
                  const Text(
                    'What We Offer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Services grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    childAspectRatio:
                        MediaQuery.of(context).size.width > 600 ? 3 : 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: const [
                      _ServiceCard(
                        icon: Icons.school_outlined,
                        title: 'University Merchandise',
                        description:
                            'Official Portsmouth branded clothing, accessories, and gifts',
                      ),
                      _ServiceCard(
                        icon: Icons.menu_book_outlined,
                        title: 'Textbooks & Stationery',
                        description:
                            'Academic materials, notebooks, and study essentials',
                      ),
                      _ServiceCard(
                        icon: Icons.palette_outlined,
                        title: 'Custom Printing',
                        description:
                            'Personalized items and custom text printing services',
                      ),
                      _ServiceCard(
                        icon: Icons.card_giftcard_outlined,
                        title: 'Gifts & Souvenirs',
                        description:
                            'Perfect presents for students, graduates, and visitors',
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Contact information
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4d2963).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Visit Our Shop',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4d2963),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Color(0xFF4d2963)),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'University House, Winston Churchill Avenue, Portsmouth PO1 2UP',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          children: [
                            Icon(Icons.phone_outlined,
                                color: Color(0xFF4d2963)),
                            SizedBox(width: 12),
                            Text(
                              '023 9284 3962',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          children: [
                            Icon(Icons.email_outlined,
                                color: Color(0xFF4d2963)),
                            SizedBox(width: 12),
                            Text(
                              'shop@upsu.net',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 32,
            color: const Color(0xFF4d2963),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
