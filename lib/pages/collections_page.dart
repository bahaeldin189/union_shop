import 'package:flutter/material.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/models/product.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get dynamic collection data
    final collections = ProductService.getCollections();
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation bar
            const NavBar(),

            // Collections content
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page title
                  const Text(
                    'Collections',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Explore our curated collections of university merchandise, textbooks, and gifts',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Collections grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    children: collections.map((collection) => 
                      CollectionCard(
                        title: collection['name'] as String,
                        description: collection['description'] as String,
                        imageUrl: collection['imageUrl'] as String,
                        itemCount: '${collection['productCount']} items',
                        collectionId: collection['id'] as String,
                        isSale: collection['id'] == 'sale',
                      ),
                    ).toList(),
                  ),

                  const SizedBox(height: 32),

                  // Featured Products Section
                  const Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Discover our most popular items',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Featured products grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 800 ? 3 :
                        MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                    children: ProductService.getFeaturedProducts().map((product) =>
                      ProductCardWidget(product: product),
                    ).toList(),
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

class CollectionCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String itemCount;
  final String collectionId;
  final bool isSale;

  const CollectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.itemCount,
    required this.collectionId,
    this.isSale = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context, 
          '/collection',
          arguments: {'collectionId': collectionId},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Image unavailable',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Sale badge
                  if (isSale)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'SALE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Content section
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          itemCount,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4d2963),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
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

class ProductCardWidget extends StatelessWidget {
  final Product product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context, 
          '/product',
          arguments: {'productId': product.id},
        );
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
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      child: Image.network(
                        product.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (product.isOnSale) 
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'SALE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
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
                      product.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4d2963).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        product.category,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF4d2963),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        if (product.originalPrice != null && product.originalPrice! > product.price) ...[
                          Text(
                            '£${product.originalPrice!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          product.formattedPrice,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4d2963),
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
