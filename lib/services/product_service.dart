import '../models/product.dart';
import 'product_image_service.dart';

class ProductService {
  static final List<Product> _allProducts = [
    // University Apparel Collection
    Product(
      id: 'app001',
      title: 'Classic Portsmouth Hoodie',
      description:
          'Official University of Portsmouth hoodie made from premium cotton blend. Features embroidered university logo and comfortable kangaroo pocket. Perfect for campus life or casual wear.',
      price: 35.00,
      imageUrl: ProductImageService.getImageForProduct(
          'Classic Portsmouth Hoodie', 'Clothing'),
      category: 'Clothing',
      collection: 'apparel',
      isFeatured: true,
      sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
      colors: ['Navy Blue', 'Grey', 'Black'],
      stockQuantity: 25,
    ),
    Product(
      id: 'app002',
      title: 'University T-Shirt',
      description:
          'Comfortable cotton t-shirt with Portsmouth University branding. Lightweight and breathable, ideal for everyday wear.',
      price: 18.00,
      imageUrl: ProductImageService.getImageForProduct(
          'University T-Shirt', 'Clothing'),
      category: 'Clothing',
      collection: 'apparel',
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      colors: ['White', 'Navy Blue', 'Grey'],
      stockQuantity: 40,
    ),
    Product(
      id: 'app003',
      title: 'Portsmouth Baseball Cap',
      description:
          'Classic baseball cap with embroidered Portsmouth logo. Adjustable strap ensures perfect fit.',
      price: 15.00,
      originalPrice: 20.00,
      imageUrl: ProductImageService.getImageForProduct(
          'Portsmouth Baseball Cap', 'Accessories'),
      category: 'Accessories',
      collection: 'apparel',
      isOnSale: true,
      colors: ['Navy', 'Black', 'White'],
      stockQuantity: 15,
    ),
    Product(
      id: 'app004',
      title: 'University Sweatshirt',
      description:
          'Premium fleece sweatshirt with university crest. Warm and comfortable for cooler days.',
      price: 28.00,
      imageUrl: ProductImageService.getImageForProduct(
          'University Sweatshirt', 'Clothing'),
      category: 'Clothing',
      collection: 'apparel',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Navy', 'Grey'],
      stockQuantity: 20,
    ),

    // Stationery & Books Collection
    Product(
      id: 'stat001',
      title: 'Portsmouth Notebook Set',
      description:
          'Set of 3 high-quality notebooks with Portsmouth University branding. Lined pages perfect for note-taking.',
      price: 12.00,
      imageUrl: ProductImageService.getImageForProduct(
          'Portsmouth Notebook Set', 'Stationery'),
      category: 'Stationery',
      collection: 'stationery',
      stockQuantity: 30,
    ),
    Product(
      id: 'stat002',
      title: 'University Pen Collection',
      description:
          'Set of premium ballpoint pens with Portsmouth University logo. Smooth writing experience.',
      price: 8.00,
      imageUrl: ProductImageService.getImageForProduct(
          'University Pen Collection', 'Stationery'),
      category: 'Stationery',
      collection: 'stationery',
      colors: ['Blue', 'Black'],
      stockQuantity: 50,
    ),

    // Gifts & Souvenirs Collection
    Product(
      id: 'gift001',
      title: 'Portsmouth City Magnet',
      description:
          'Decorative fridge magnet featuring Portsmouth landmarks. Perfect souvenir for visitors.',
      price: 4.50,
      imageUrl: ProductImageService.getImageForProduct(
          'Portsmouth City Magnet', 'Gifts'),
      category: 'Gifts',
      collection: 'gifts',
      stockQuantity: 100,
    ),
    Product(
      id: 'gift002',
      title: 'University Mug',
      description:
          'Ceramic mug with Portsmouth University logo. Dishwasher and microwave safe.',
      price: 10.00,
      imageUrl: 'https://images.unsplash.com/photo-1514228742587-6b1558fcf93a?w=800&q=80',
      category: 'Gifts',
      collection: 'gifts',
      colors: ['White', 'Navy', 'Grey'],
      stockQuantity: 35,
    ),

    // Sale Items
    Product(
      id: 'sale001',
      title: 'Portsmouth Tote Bag',
      description:
          'Eco-friendly cotton tote bag with university logo. Perfect for shopping or books.',
      price: 10.00,
      originalPrice: 16.00,
      imageUrl: ProductImageService.getImageForProduct(
          'Portsmouth Tote Bag', 'Accessories'),
      category: 'Accessories',
      collection: 'sale',
      isOnSale: true,
      colors: ['Natural', 'Navy'],
      stockQuantity: 12,
    ),
    Product(
      id: 'sale002',
      title: 'University Keychain',
      description: 'Metal keychain with Portsmouth University logo and colors.',
      price: 3.00,
      originalPrice: 5.00,
      imageUrl: ProductImageService.getImageForProduct(
          'University Keychain', 'Accessories'),
      category: 'Accessories',
      collection: 'sale',
      isOnSale: true,
      stockQuantity: 25,
    ),

    // Autumn Favourites
    Product(
      id: 'autumn001',
      title: 'Autumn Scarf',
      description:
          'Warm woolen scarf in university colors. Perfect for the autumn season.',
      price: 22.00,
      imageUrl: 'https://images.unsplash.com/photo-1601762603332-db5e4b2cca8b?w=800&q=80',
      category: 'Accessories',
      collection: 'autumn',
      colors: ['Navy', 'Burgundy', 'Forest Green'],
      stockQuantity: 18,
    ),

    // New Arrivals
    Product(
      id: 'new001',
      title: 'Modern Portsmouth Polo',
      description:
          'Contemporary polo shirt with subtle Portsmouth branding. Professional yet casual.',
      price: 32.00,
      imageUrl: ProductImageService.getImageForProduct(
          'Modern Portsmouth Polo', 'Clothing'),
      category: 'Clothing',
      collection: 'new',
      isFeatured: true,
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['White', 'Navy', 'Light Blue'],
      stockQuantity: 20,
    ),
  ];

  // Get all products
  static List<Product> getAllProducts() => List.from(_allProducts);

  // Get products by collection
  static List<Product> getProductsByCollection(String collectionId) {
    return _allProducts
        .where((product) => product.collection == collectionId)
        .toList();
  }

  // Get featured products
  static List<Product> getFeaturedProducts() {
    return _allProducts.where((product) => product.isFeatured).toList();
  }

  // Get sale products
  static List<Product> getSaleProducts() {
    return _allProducts.where((product) => product.isOnSale).toList();
  }

  // Get product by ID
  static Product? getProductById(String id) {
    try {
      return _allProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search products
  static List<Product> searchProducts(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _allProducts
        .where((product) =>
            product.title.toLowerCase().contains(lowercaseQuery) ||
            product.description.toLowerCase().contains(lowercaseQuery) ||
            product.category.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  // Filter products
  static List<Product> filterProducts({
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? isOnSale,
    String? collection,
  }) {
    return _allProducts.where((product) {
      if (category != null && product.category != category) return false;
      if (minPrice != null && product.price < minPrice) return false;
      if (maxPrice != null && product.price > maxPrice) return false;
      if (isOnSale != null && product.isOnSale != isOnSale) return false;
      if (collection != null && product.collection != collection) return false;
      return true;
    }).toList();
  }

  // Sort products
  static List<Product> sortProducts(List<Product> products, String sortBy) {
    final sortedProducts = List<Product>.from(products);

    switch (sortBy.toLowerCase()) {
      case 'price: low to high':
        sortedProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price: high to low':
        sortedProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'title a-z':
        sortedProducts.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'title z-a':
        sortedProducts.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'newest':
        // For now, just reverse the list (assuming newer products are added later)
        return sortedProducts.reversed.toList();
      case 'featured':
      default:
        // Featured items first, then by title
        sortedProducts.sort((a, b) {
          if (a.isFeatured && !b.isFeatured) return -1;
          if (!a.isFeatured && b.isFeatured) return 1;
          return a.title.compareTo(b.title);
        });
        break;
    }

    return sortedProducts;
  }

  // Get product categories
  static List<String> getCategories() {
    return _allProducts.map((product) => product.category).toSet().toList()
      ..sort();
  }

  // Get collection info
  static Map<String, dynamic> getCollectionInfo(String collectionId) {
    final products = getProductsByCollection(collectionId);

    final collectionNames = {
      'apparel': 'University Apparel',
      'stationery': 'Stationery & Books',
      'gifts': 'Gifts & Souvenirs',
      'sale': 'Sale Items',
      'autumn': 'Autumn Favourites',
      'new': 'New Arrivals',
    };

    final collectionDescriptions = {
      'apparel': 'Official Portsmouth branded clothing and accessories',
      'stationery': 'Study essentials, notebooks, and textbooks',
      'gifts': 'Perfect presents and university memorabilia',
      'sale': 'Discounted products and special offers',
      'autumn': 'Seasonal collection with warm clothing and accessories',
      'new': 'Latest products and fresh designs',
    };

    return {
      'id': collectionId,
      'name': collectionNames[collectionId] ?? 'Unknown Collection',
      'description': collectionDescriptions[collectionId] ?? '',
      'productCount': products.length,
      'products': products,
      'imageUrl': ProductImageService.getImageForCollection(
          collectionNames[collectionId] ?? 'University Apparel'),
    };
  }

  // Get all collections
  static List<Map<String, dynamic>> getCollections() {
    const collectionIds = [
      'apparel',
      'stationery',
      'gifts',
      'sale',
      'autumn',
      'new'
    ];
    return collectionIds.map((id) => getCollectionInfo(id)).toList();
  }
}
