import 'package:flutter/material.dart';

class CartWidget extends StatelessWidget {
  final List<CartItem> cartItems;

  const CartWidget({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
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
          // Display cart items
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text('No items in the cart'))
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return ListTile(
                        leading: Image.network(cartItem.imageUrl),
                        title: Text(cartItem.name),
                        subtitle:
                            Text('\$${cartItem.price} x ${cartItem.quantity}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () {
                            // Handle removing the item from the cart
                          },
                        ),
                      );
                    },
                  ),
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
                Text(
                  '\$${_calculateTotal(cartItems)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // Checkout button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary),
            child: Center(
              child: Text(
                'Checkout',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }

  double _calculateTotal(List<CartItem> items) {
    double total = 0;
    for (var item in items) {
      total += item.price * int.parse(item.quantity);
    }
    return total;
  }
}

class CartItem {
  final String name;
  final double price;
  final String imageUrl;
  final String quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}
