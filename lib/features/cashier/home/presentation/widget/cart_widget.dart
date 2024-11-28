import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_case_study/features/cashier/home/data/model/invoice.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cart_bloc/cart_cubit.dart';
import 'package:post_case_study/features/cashier/home/data/model/cart_item.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = CartCubit(); // Create the CartCubit instance here.
    return BlocProvider(
      create: (_) => cartCubit,
      child: _buildCart(context, cartCubit),
    );
  }

  Widget _buildCart(BuildContext context, CartCubit cartCubit) {
    Box<CartItem> cartBox = Hive.box<CartItem>('cart');

    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Cart',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<Box<CartItem>>(
            valueListenable: cartBox.listenable(),
            builder: (context, box, _) {
              List<CartItem> cartItems = box.values.toList();

              return Expanded(
                child: cartItems.isEmpty
                    ? const Center(child: Text('No items in the cart'))
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ExtendedImage.network(
                                  cartItem.imageUrl,
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              title: Text(
                                cartItem.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price: \$${cartItem.price.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () {
                                  cartBox.deleteAt(index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
              );
            },
          ),
          const Divider(),
          ValueListenableBuilder<Box<CartItem>>(
            valueListenable: cartBox.listenable(),
            builder: (context, box, _) {
              List<CartItem> cartItems = box.values.toList();
              double subTotal = cartCubit.calculateSubTotal(cartItems);
              double tax = subTotal * cartCubit.taxRate;
              double total = subTotal + tax; // Updated calculation

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryRow('Subtotal:', subTotal),
                  _buildSummaryRow('Tax (15%):', tax),
                  const Divider(),
                  _buildSummaryRow(
                    'Total:',
                    total,
                    isBold: true,
                    fontSize: 18,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              cartCubit.handleCheckout(cartBox);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
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
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value,
      {bool isBold = false, double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
