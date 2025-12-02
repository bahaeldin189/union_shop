import 'package:flutter/material.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/models/product.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  // Collections grid with responsive layout
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      double aspectRatio = 0.9;
                      if (constraints.maxWidth > 1200) {
                        crossAxisCount = 3;
                        aspectRatio = 1.0;
                      } else if (constraints.maxWidth > 800) {
                        crossAxisCount = 2;
                        aspectRatio = 1.1;
                      } else if (constraints.maxWidth > 600) {
                        crossAxisCount = 2;
                        aspectRatio = 1.2;
                      } else {
                        aspectRatio = 1.4;
                      }
                      final collections = ProductService.getCollections();

                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: aspectRatio,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: collections
                            .map((collection) => CollectionCard(
                                  title: collection['name'] as String,
                                  description:
                                      collection['description'] as String,
                                  imageUrl: collection['imageUrl'] as String,
                                  itemCount:
                                      '${collection['productCount']} items',
                                  collectionId: collection['id'] as String,
                                  isSale: collection['id'] == 'sale',
                                ))
                            .toList(),
                      );
                    },
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

                  // Featured products grid with responsive layout
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      double aspectRatio = 1.0;
                      if (constraints.maxWidth > 1200) {
                        crossAxisCount = 4;
                        aspectRatio = 0.8;
                      } else if (constraints.maxWidth > 800) {
                        crossAxisCount = 3;
                        aspectRatio = 0.9;
                      } else if (constraints.maxWidth > 600) {
                        crossAxisCount = 2;
                        aspectRatio = 1.0;
                      } else {
                        aspectRatio = 1.2;
                      }

                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: aspectRatio,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: ProductService.getFeaturedProducts()
                            .map((product) =>
                                ProductCardWidget(product: product))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
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
    required this.isSale,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (collectionId == 'sale') {
          Navigator.pushNamed(context, '/sale');
        } else {
          Navigator.pushNamed(
            context,
            '/collection',
            arguments: {'collectionId': collectionId},
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey[200],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.collections_outlined,
                                color: Colors.grey,
                                size: 48,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (isSale)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(16),
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
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4d2963),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      itemCount,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF4d2963),
                        fontWeight: FontWeight.w600,
                      ),
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
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8)),
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
                                size: 32,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
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
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        if (product.originalPrice != null &&
                            product.originalPrice! > product.price) ...[
                          Text(
                            '£${product.originalPrice!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 3),
                        ],
                        Text(
                          product.formattedPrice,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: product.isOnSale
                                ? Colors.red
                                : const Color(0xFF4d2963),
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
