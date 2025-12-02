class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final String category;
  final String collection;
  final bool isOnSale;
  final bool isFeatured;
  final List<String> sizes;
  final List<String> colors;
  final int stockQuantity;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.category,
    required this.collection,
    this.isOnSale = false,
    this.isFeatured = false,
    this.sizes = const [],
    this.colors = const [],
    this.stockQuantity = 0,
  });

  double get discountPercentage {
    if (originalPrice != null && originalPrice! > price) {
      return ((originalPrice! - price) / originalPrice!) * 100;
    }
    return 0.0;
  }

  String get formattedPrice => '£${price.toStringAsFixed(2)}';
  
  String? get formattedOriginalPrice => 
      originalPrice != null ? '£${originalPrice!.toStringAsFixed(2)}' : null;

  bool get hasVariations => sizes.isNotEmpty || colors.isNotEmpty;

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    String? category,
    String? collection,
    bool? isOnSale,
    bool? isFeatured,
    List<String>? sizes,
    List<String>? colors,
    int? stockQuantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      collection: collection ?? this.collection,
      isOnSale: isOnSale ?? this.isOnSale,
      isFeatured: isFeatured ?? this.isFeatured,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: $formattedPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class CartItem {
  final Product product;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;

  CartItem({
    required this.product,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
  });

  double get totalPrice => product.price * quantity;
  String get formattedTotalPrice => '£${totalPrice.toStringAsFixed(2)}';

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  @override
  String toString() {
    return 'CartItem(product: ${product.title}, quantity: $quantity, total: $formattedTotalPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.product.id == product.id &&
        other.selectedSize == selectedSize &&
        other.selectedColor == selectedColor;
  }

  @override
  int get hashCode => Object.hash(product.id, selectedSize, selectedColor);
}