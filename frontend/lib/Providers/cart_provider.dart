import 'package:flutter/material.dart';

import '../Cart/Model/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  void addItem({required String id, required String name, required double price}) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
            (old) => CartItem(
          id: old.id,
          name: old.name,
          quantity: old.quantity + 1,
          price: old.price,
        ),
      );
    } else {
      _items[id] = CartItem(id: id, name: name, quantity: 1, price: price);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  double get total {
    return _items.values.fold(0, (sum, item) => sum + item.quantity * item.price);
  }
}
