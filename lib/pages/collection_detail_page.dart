import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/services/cart_provider.dart';
import 'package:union_shop/models/product.dart';

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
  late Map<String, dynamic> collectionInfo;
  List<Product> products = [];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadCollectionData();
  }

  void _loadCollectionData() {
    collectionInfo = ProductService.getCollectionInfo(widget.collectionId);
    products = collectionInfo['products'] as List<Product>;
    _applyFiltersAndSort();
  }

  void _applyFiltersAndSort() {
    filteredProducts = List<Product>.from(products);

    // Apply price filter
    switch (selectedPriceFilter) {
      case 'Under £10':
        filteredProducts = filteredProducts.where((p) => p.price < 10).toList();
        break;
      case '£10 - £25':
        filteredProducts = filteredProducts
            .where((p) => p.price >= 10 && p.price <= 25)
            .toList();
        break;
      case '£25 - £50':
        filteredProducts = filteredProducts
            .where((p) => p.price >= 25 && p.price <= 50)
            .toList();
        break;
      case 'Over £50':
        filteredProducts = filteredProducts.where((p) => p.price > 50).toList();
        break;
    }

    // Apply category filter
    if (selectedCategory != 'All') {
      filteredProducts = filteredProducts
          .where((p) => p.category == selectedCategory)
          .toList();
    }

    // Apply sorting
    filteredProducts =
        ProductService.sortProducts(filteredProducts, selectedSort);

    setState(() {});
  }

  void _addToCart(Product product) {
    context.read<CartProvider>().addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${product.title} to cart'),
        backgroundColor: const Color(0xFF4d2963),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ),
    );
  }

  List<String> get availableCategories {
    final categories = ['All'];
    categories.addAll(products.map((p) => p.category).toSet().toList()..sort());
    return categories;
  }

  @override
  Widget build(BuildContext context) {
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
                        onTap: () =>
                            Navigator.pushNamed(context, '/collections'),
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
                        collectionInfo['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4d2963),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Collection title and description
                  Text(
                    collectionInfo['name'] as String,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    collectionInfo['description'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${filteredProducts.length} of ${products.length} products',
                    style: const TextStyle(
                      fontSize: 14,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedSort,
                            items: [
                              'Featured',
                              'Price: Low to High',
                              'Price: High to Low',
                              'Newest'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSort = newValue!;
                              });
                              _applyFiltersAndSort();
                            },
                          ),
                        ),
                      ),

                      // Price filter
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedPriceFilter,
                            items: [
                              'All',
                              'Under £10',
                              '£10 - £25',
                              '£25 - £50',
                              'Over £50'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPriceFilter = newValue!;
                              });
                              _applyFiltersAndSort();
                            },
                          ),
                        ),
                      ),

                      // Category filter
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            items: availableCategories.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                              });
                              _applyFiltersAndSort();
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
              child: filteredProducts.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 4 : 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.width > 600
                                ? 0.6
                                : 0.55,
                        crossAxisSpacing:
                            MediaQuery.of(context).size.width > 600 ? 16 : 12,
                        mainAxisSpacing:
                            MediaQuery.of(context).size.width > 600 ? 20 : 16,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return DynamicProductCard(
                          product: product,
                          onAddToCart: () => _addToCart(product),
                        );
                      },
                    ),
            ),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters to see more products',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedPriceFilter = 'All';
                  selectedCategory = 'All';
                });
                _applyFiltersAndSort();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
              ),
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const DynamicProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

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
                        product.imageUrl,
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
                  // Sale badge
                  if (product.isOnSale)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
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
                  // Quick add to cart button
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF4d2963),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 16,
                        ),
                        padding: const EdgeInsets.all(6),
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        onPressed:
                            product.stockQuantity > 0 ? onAddToCart : null,
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
                      product.title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4d2963).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product.category,
                        style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF4d2963),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
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
                          const SizedBox(width: 2),
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
                    if (product.stockQuantity <= 0)
                      const Text(
                        'Out of Stock',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
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
