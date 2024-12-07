import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/admin/features/home/presentation/bloc/invoice_bloc/invoice_cubit.dart';
import 'package:post_case_study/admin/features/home/presentation/bloc/invoice_bloc/invoice_state.dart';

class InvoiceTable extends StatelessWidget {
  const InvoiceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvoiceCubit()..getInvoice(),
      child: BlocBuilder<InvoiceCubit, InvoiceState>(
        builder: (context, state) {
          if (state is InvoiceStateInital) {
            return const Center(child: Text('Loading invoices...'));
          } else if (state is InvoiceStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InvoiceStateError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is InvoiceStateLoaded) {
            final invoices = state.invoice;

            if (invoices.isEmpty) {
              return const Center(child: Text('No invoices found.'));
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Item',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Price',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: invoices.map<DataRow>((invoice) {
                      final items =
                          invoice.items.map((item) => item.name).join(', ');
                      final total = invoice.totalPrice;
                      final date = invoice.createdAt;

                      return DataRow(
                        color: (invoices.indexOf(invoice) % 2 == 0)
                            ? WidgetStateProperty.all(const Color.fromARGB(
                                255, 187, 222, 248)) // Correct usage

                            : WidgetStateProperty.all(Colors.grey.shade500),
                        cells: [
                          DataCell(Text(items)),
                          DataCell(Text('\$${total.toStringAsFixed(2)}')),
                          DataCell(
                              Text('${date.year}-${date.month}-${date.day}')),
                          DataCell(Text('\$${total.toStringAsFixed(2)}')),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }
          return const Center(child: Text('Unexpected state.'));
        },
      ),
    );
  }
}
