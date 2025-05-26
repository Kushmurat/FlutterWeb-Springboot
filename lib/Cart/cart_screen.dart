import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/CartProvider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: cart.items.values.map((item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('${item.price} x ${item.quantity}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => cart.removeItem(item.id),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
              },
              icon: const Icon(Icons.check),
              label: Text('Оформить на ${cart.totalAmount.toStringAsFixed(2)} ₸'),
            ),
          )
        ],
      ),
    );
  }
}
