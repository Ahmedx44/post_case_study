import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:post_case_study/features/cashier/home/data/model/cart_item.dart';
import 'package:post_case_study/features/cashier/home/data/model/invoice.dart';
import 'package:post_case_study/features/cashier/home/domain/usecase/add_to_cart.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:post_case_study/locator.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartStateError());

  Box<CartItem> cartBox = Hive.box<CartItem>('cart');

  final double taxRate = 0.15; // 15% tax

  Future<void> addToCart(
    String name,
    double price,
    String imageUrl,
    String quantity,
    String category,
  ) async {
    emit(CartStateLoading());
    final result = await locator<AddToCartUseCase>()
        .call(name, price, imageUrl, quantity, category);

    result.fold(
      (error) {
        emit(CartStateError());
      },
      (success) {
        emit(CartStateCartAdded(message: success));
      },
    );
  }

  void handleCheckout(Box<CartItem> cartBox) async {
    try {
      // Generate the PDF
      final pdf = pw.Document();

      // Get cart items
      List<CartItem> cartItems = cartBox.values.toList();

      // Calculate subtotal, tax, and total
      double subTotal = calculateSubTotal(cartItems);
      double tax = subTotal * taxRate;
      double total = subTotal + tax;

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
              pw.TableHelper.fromTextArray(
                headers: ['Item', 'Price'],
                data: cartItems
                    .map((item) =>
                        [item.name, '\$${item.price.toStringAsFixed(2)}'])
                    .toList(),
              ),
              pw.Divider(),
              pw.Text(
                'Subtotal: \$${subTotal.toStringAsFixed(2)}',
                style: const pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                'Tax (15%): \$${tax.toStringAsFixed(2)}',
                style: const pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                'Total: \$${total.toStringAsFixed(2)}',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Thank you for your purchase!',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );

      // Save and print the PDF
      await Printing.layoutPdf(onLayout: (format) async => pdf.save());

      // Save the invoice in the Hive
      final invoiceBox = Hive.box<Invoice>('invoices');
      final invoice = Invoice(
        totalPrice: total,
        totalItems: cartItems.length,
        items: cartItems,
        createdAt: DateTime.now(),
      );
      await invoiceBox.add(invoice);

      // Clear the cart
      cartBox.clear();
    } catch (e) {
      debugPrint('Error during checkout: $e');
    }
  }

  double calculateSubTotal(List<CartItem> items) {
    double subTotal = 0;
    for (var item in items) {
      subTotal += item.price;
    }
    return subTotal;
  }
}
