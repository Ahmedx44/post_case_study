import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_case_study/features/cashier/home/data/model/cart_item.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the Hive box directly in the widget
    Box<CartItem> cartBox = Hive.box<CartItem>('cart');

    return Container(
      width: MediaQuery.sizeOf(context).width * 0.25,
      color: Theme.of(context).colorScheme.surfaceVariant,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Cart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Use ValueListenableBuilder to listen for changes in the Hive box
          ValueListenableBuilder<Box<CartItem>>(
            valueListenable: cartBox.listenable(),
            builder: (context, box, _) {
              // Retrieve cart items from the Hive box
              List<CartItem> cartItems = box.values.toList();

              return Expanded(
                child: cartItems.isEmpty
                    ? const Center(child: Text('No items in the cart'))
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return ListTile(
                            leading: Image.network(cartItem.imageUrl),
                            title: Text(cartItem.name),
                            subtitle: Text(
                                '\$${cartItem.price.toStringAsFixed(2)}'), // Format price to 2 decimal places
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                cartBox.deleteAt(index);
                              },
                            ),
                          );
                        },
                      ),
              );
            },
          ),
          const Divider(),
          // Cart Total
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ValueListenableBuilder<Box<CartItem>>(
                  valueListenable: cartBox.listenable(),
                  builder: (context, box, _) {
                    List<CartItem> cartItems = box.values.toList();
                    double total = _calculateTotal(cartItems);
                    return Text(
                      '\$${total.toStringAsFixed(2)}', // Format total to 2 decimal places
                      style: const TextStyle(fontSize: 16),
                    );
                  },
                ),
              ],
            ),
          ),
          // Checkout button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                'Checkout',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotal(List<CartItem> items) {
    double total = 0;
    for (var item in items) {
      total += item.price;
    }
    return total;
  }
}
