import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  
  String get formattedTotalAmount => '£${totalAmount.toStringAsFixed(2)}';

  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;

  void addToCart(Product product, {int quantity = 1, String? selectedSize, String? selectedColor}) {
    final existingIndex = _items.indexWhere((item) => 
        item.product.id == product.id && 
        item.selectedSize == selectedSize && 
        item.selectedColor == selectedColor
    );

    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + quantity,
      );
    } else {
      _items.add(CartItem(
        product: product,
        quantity: quantity,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
      ));
    }
    
    notifyListeners();
  }

  void removeFromCart(String productId, {String? selectedSize, String? selectedColor}) {
    _items.removeWhere((item) => 
        item.product.id == productId && 
        item.selectedSize == selectedSize && 
        item.selectedColor == selectedColor
    );
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity, {String? selectedSize, String? selectedColor}) {
    final index = _items.indexWhere((item) => 
        item.product.id == productId && 
        item.selectedSize == selectedSize && 
        item.selectedColor == selectedColor
    );

    if (index >= 0) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: newQuantity);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String productId, {String? selectedSize, String? selectedColor}) {
    return _items.any((item) => 
        item.product.id == productId && 
        item.selectedSize == selectedSize && 
        item.selectedColor == selectedColor
    );
  }

  int getQuantity(String productId, {String? selectedSize, String? selectedColor}) {
    final item = _items.firstWhere(
      (item) => 
          item.product.id == productId && 
          item.selectedSize == selectedSize && 
          item.selectedColor == selectedColor,
      orElse: () => CartItem(product: Product(
        id: '',
        title: '',
        description: '',
        price: 0,
        imageUrl: '',
        category: '',
        collection: '',
      ), quantity: 0),
    );
    return item.quantity;
  }
}