import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:post_case_study/features/cashier/home/data/model/invoice.dart';

class InvoiceTable extends StatelessWidget {
  const InvoiceTable({super.key});

  // Fetch invoices from Hive
  Future<List<Invoice>> _fetchInvoices() async {
    // Open the Hive box for invoices
    final invoicesBox = await Hive.openBox<Invoice>('invoices');
    // Retrieve the invoices directly from the box
    return invoicesBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Invoice>>(
      future: _fetchInvoices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No invoices found.'));
        }

        final invoices = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Item')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Total')),
              ],
              rows: invoices.map((invoice) {
                final items = invoice.items.map((item) => item.name).join(', ');
                final total = invoice.totalPrice;
                final date = invoice.createdAt;

                return DataRow(cells: [
                  DataCell(Text(items)),
                  DataCell(Text('\$${total.toStringAsFixed(2)}')),
                  DataCell(Text('${date.year}-${date.month}-${date.day}')),
                  DataCell(Text('\$${total.toStringAsFixed(2)}')),
                ]);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
