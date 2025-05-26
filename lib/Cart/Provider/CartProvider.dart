import 'package:flutter/material.dart';
import '../Model/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  double get totalAmount =>
      _items.values.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem({
    required String productId,
    required String name,
    required double price,
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (existing) => CartItem(
          id: existing.id,
          name: existing.name,
          quantity: existing.quantity + 1,
          price: existing.price,
        ),
      );
    } else {
      _items[productId] = CartItem(
        id: productId,
        name: name,
        quantity: 1,
        price: price,
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
