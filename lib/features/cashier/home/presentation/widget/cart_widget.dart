import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:post_case_study/features/cashier/home/data/model/cart_item.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  final double taxRate = 0.15; // 15% tax
  final double discount = 5.0; // Flat $5 discount

  @override
  Widget build(BuildContext context) {
    Box<CartItem> cartBox = Hive.box<CartItem>('cart');

    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
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
              double subTotal = _calculateSubTotal(cartItems);
              double tax = subTotal * taxRate;
              double total = subTotal + tax - discount;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryRow('Subtotal:', subTotal),
                  _buildSummaryRow('Tax (15%):', tax),
                  _buildSummaryRow('Discount:', -discount),
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
              _handleCheckout(cartBox);
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

  double _calculateSubTotal(List<CartItem> items) {
    double subTotal = 0;
    for (var item in items) {
      subTotal += item.price;
    }
    return subTotal;
  }

  void _handleCheckout(Box<CartItem> cartBox) async {
    // Generate the PDF
    final pdf = pw.Document();

    // Get cart items
    List<CartItem> cartItems = cartBox.values.toList();

    // Build the PDF content
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Invoice',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ['Item', 'Price'],
              data: cartItems
                  .map((item) =>
                      [item.name, '\$${item.price.toStringAsFixed(2)}'])
                  .toList(),
            ),
            pw.Divider(),
            pw.Text(
              'Thank you for your purchase!',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    // Save and print the PDF
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());

    // Clear the cart
    cartBox.clear();
    debugPrint('Checkout completed and cart cleared!');
  }
}
