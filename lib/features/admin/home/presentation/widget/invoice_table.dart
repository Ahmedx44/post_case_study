import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/invoice_bloc/invoice_cubit.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/invoice_bloc/invoice_state.dart';

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
                    final items =
                        invoice.items.map((item) => item.name).join(', ');
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
          }
          return const Center(child: Text('Unexpected state.'));
        },
      ),
    );
  }
}
