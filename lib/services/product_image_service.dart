class ProductImageService {
  // Map product categories/types to appropriate images
  static const Map<String, String> _categoryImages = {
    'hoodie':
        'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=800&q=80',
    't-shirt':
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800&q=80',
    'cap':
        'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=800&q=80',
    'sweatshirt':
        'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=800&q=80',
    'polo':
        'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?w=800&q=80',
    'jacket':
        'https://images.unsplash.com/photo-1551537482-f2075a1d41f2?w=800&q=80',
    'scarf':
        'https://images.unsplash.com/photo-1601762603332-db5e4b2cca8b?w=800&q=80',
    'bag':
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&q=80',
    'bottle':
        'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=800&q=80',
    'mug':
        'https://images.unsplash.com/photo-1514228742587-6b1558fcf93a?w=800&q=80',
    'notebook':
        'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=800&q=80',
    'pen':
        'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=800&q=80',
    'keychain':
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80',
    'pin':
        'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&q=80',
    'card':
        'https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=800&q=80',
    'book':
        'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&q=80',
    'magnet':
        'https://images.unsplash.com/photo-1565728744382-61accd4aa148?w=800&q=80',
    'postcard':
        'https://images.unsplash.com/photo-1586953218777-f70b0423bd85?w=800&q=80',
    'sticker':
        'https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=800&q=80',
  };

  // Map collection names to appropriate images
  static const Map<String, String> _collectionImages = {
    'University Apparel':
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&q=80',
    'Stationery & Books':
        'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&q=80',
    'Gifts & Souvenirs':
        'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=800&q=80',
    'Sale Items':
        'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800&q=80',
    'Autumn Favourites':
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80',
    'New Arrivals':
        'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=800&q=80',
  };

  static String getImageForCollection(String collectionName) {
    return _collectionImages[collectionName] ??
        _collectionImages['University Apparel']!;
  }

  static String getImageForProduct(String title, String category) {
    String lowerTitle = title.toLowerCase();

    // Check for specific product types in title
    for (String key in _categoryImages.keys) {
      if (lowerTitle.contains(key)) {
        return _categoryImages[key]!;
      }
    }

    // Fallback based on category
    switch (category.toLowerCase()) {
      case 'clothing':
        return _categoryImages['t-shirt']!;
      case 'accessories':
        return _categoryImages['bag']!;
      case 'stationery':
        return _categoryImages['notebook']!;
      case 'souvenirs':
        return _categoryImages['magnet']!;
      default:
        return _categoryImages['t-shirt']!;
    }
  }
}
