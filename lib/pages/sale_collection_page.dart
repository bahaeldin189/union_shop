import 'package:flutter/material.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';

class SaleCollectionPage extends StatelessWidget {
  const SaleCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample sale products
    final List<Map<String, dynamic>> saleProducts = [
      {
        'title': 'Portsmouth Baseball Cap',
        'price': '£15.00',
        'originalPrice': '£20.00',
        'imageUrl':
            'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=800&q=80',
        'discount': '25% OFF',
      },
      {
        'title': 'Classic University Mug',
        'price': '£8.00',
        'originalPrice': '£12.00',
        'imageUrl':
            'https://images.unsplash.com/photo-1514228742587-6b1558fcf93a?w=800&q=80',
        'discount': '33% OFF',
      },
      {
        'title': 'Portsmouth Tote Bag',
        'price': '£10.00',
        'originalPrice': '£16.00',
        'imageUrl':
            'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&q=80',
        'discount': '37% OFF',
      },
      {
        'title': 'University Keychain',
        'price': '£3.00',
        'originalPrice': '£5.00',
        'imageUrl':
            'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80',
        'discount': '40% OFF',
      },
      {
        'title': 'Portsmouth Notebook',
        'price': '£6.00',
        'originalPrice': '£9.00',
        'imageUrl':
            'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=800&q=80',
        'discount': '33% OFF',
      },
      {
        'title': 'University Pin Badge Set',
        'price': '£7.00',
        'originalPrice': '£11.00',
        'imageUrl':
            'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&q=80',
        'discount': '36% OFF',
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation bar
            const NavBar(),

            // Sale banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red[400]!,
                    Colors.red[600]!,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    '🔥 SALE ITEMS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Limited Time Offers - Save up to 40%',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'FREE DELIVERY ON SALE ORDERS OVER £25',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Sale content
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/'),
                        child: const Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Text(' > ', style: TextStyle(color: Colors.grey)),
                      const Text(
                        'Sale Items',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Products count and info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${saleProducts.length} sale items',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.red[200]!),
                        ),
                        child: const Text(
                          'Limited Stock',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Sale products grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 1200
                          ? 4
                          : MediaQuery.of(context).size.width > 600
                              ? 3
                              : 2,
                      childAspectRatio:
                          MediaQuery.of(context).size.width > 800 ? 0.45 : 0.55,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: saleProducts.length,
                    itemBuilder: (context, index) {
                      final product = saleProducts[index];
                      return SaleProductCard(
                        title: product['title'],
                        price: product['price'],
                        originalPrice: product['originalPrice'],
                        imageUrl: product['imageUrl'],
                        discount: product['discount'],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Sale information
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange[200]!),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.orange[700]),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Sale Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '• Sale items are limited stock and may sell out quickly\n'
                          '• All sale prices are final - no additional discounts apply\n'
                          '• Sale items are eligible for standard returns policy\n'
                          '• Free delivery on orders over £25 (sale items included)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
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

class SaleProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String originalPrice;
  final String imageUrl;
  final String discount;

  const SaleProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Flexible(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8)),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 32,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Discount badge
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        discount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Sale badge
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'SALE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product details
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          originalPrice,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          size: 11,
                          color: Colors.orange[600],
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Limited time',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.orange[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
