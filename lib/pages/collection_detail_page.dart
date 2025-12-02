import 'package:flutter/material.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';

class CollectionDetailPage extends StatefulWidget {
  final String collectionId;
  
  const CollectionDetailPage({super.key, required this.collectionId});

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  String selectedSort = 'Featured';
  String selectedPriceFilter = 'All';
  String selectedCategory = 'All';

  // Sample products for different collections
  Map<String, List<Map<String, dynamic>>> collectionProducts = {
    'apparel': [
      {
        'title': 'Classic Portsmouth Hoodie',
        'price': '£35.00',
        'originalPrice': null,
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'isOnSale': false,
      },
      {
        'title': 'University T-Shirt',
        'price': '£18.00',
        'originalPrice': null,
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'isOnSale': false,
      },
      {
        'title': 'Portsmouth Baseball Cap',
        'price': '£15.00',
        'originalPrice': '£20.00',
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'isOnSale': true,
      },
      {
        'title': 'University Sweatshirt',
        'price': '£28.00',
        'originalPrice': null,
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'isOnSale': false,
      },
    ],
    'stationery': [
      {
        'title': 'Portsmouth Notebook Set',
        'price': '£12.00',
        'originalPrice': null,
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'isOnSale': false,
      },
      {
        'title': 'University Pen Collection',
        'price': '£8.00',
        'originalPrice': null,
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'isOnSale': false,
      },
    ]
  };

  String getCollectionTitle() {
    switch (widget.collectionId) {
      case 'apparel':
        return 'University Apparel';
      case 'stationery':
        return 'Stationery & Books';
      case 'gifts':
        return 'Gifts & Souvenirs';
      case 'sale':
        return 'Sale Items';
      case 'autumn':
        return 'Autumn Favourites';
      case 'new':
        return 'New Arrivals';
      default:
        return 'Collection';
    }
  }

  List<Map<String, dynamic>> getProducts() {
    return collectionProducts[widget.collectionId] ?? [
      {
        'title': 'Sample Product',
        'price': '£10.00',
        'originalPrice': null,
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'isOnSale': false,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = getProducts();
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation bar
            const NavBar(),

            // Collection header
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
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/collections'),
                        child: const Text(
                          'Collections',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Text(' > ', style: TextStyle(color: Colors.grey)),
                      Text(
                        getCollectionTitle(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4d2963),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Collection title
                  Text(
                    getCollectionTitle(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${products.length} products',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Filters and sorting
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      // Sort dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedSort,
                            items: ['Featured', 'Price: Low to High', 'Price: High to Low', 'Newest']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSort = newValue!;
                              });
                            },
                          ),
                        ),
                      ),

                      // Price filter
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedPriceFilter,
                            items: ['All', 'Under £10', '£10 - £25', '£25 - £50', 'Over £50']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPriceFilter = newValue!;
                              });
                            },
                          ),
                        ),
                      ),

                      // Category filter  
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            items: ['All', 'Clothing', 'Accessories', 'Books', 'Gifts']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Products grid
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    title: product['title'],
                    price: product['price'],
                    originalPrice: product['originalPrice'],
                    imageUrl: product['imageUrl'],
                    isOnSale: product['isOnSale'],
                  );
                },
              ),
            ),

            // Pagination (static)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPaginationButton('Previous', false),
                  const SizedBox(width: 12),
                  _buildPaginationButton('1', true),
                  const SizedBox(width: 8),
                  _buildPaginationButton('2', false),
                  const SizedBox(width: 8),
                  _buildPaginationButton('3', false),
                  const SizedBox(width: 12),
                  _buildPaginationButton('Next', false),
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

  Widget _buildPaginationButton(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4d2963) : Colors.white,
        border: Border.all(
          color: isActive ? const Color(0xFF4d2963) : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? originalPrice;
  final String imageUrl;
  final bool isOnSale;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.isOnSale = false,
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
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Sale badge
                  if (isOnSale)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          'SALE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Product details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isOnSale ? Colors.red : const Color(0xFF4d2963),
                          ),
                        ),
                        if (originalPrice != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            originalPrice!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
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