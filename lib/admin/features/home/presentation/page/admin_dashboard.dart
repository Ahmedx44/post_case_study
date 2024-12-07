import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:post_case_study/admin/features/home/presentation/bloc/admin_cubit.dart';
import 'package:post_case_study/admin/features/home/presentation/bloc/admin_state.dart';
import 'package:post_case_study/admin/features/home/presentation/widget/invoice_table.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit()..getValues(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: BlocBuilder<AdminCubit, AdminState>(
            builder: (context, state) {
              final adminCubit = context.read<AdminCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Dashboard',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _statsCard(
                          context,
                          'Total Revenue',
                          '${adminCubit.totalrevenue.toString()}\$',
                          HugeIcons.strokeRoundedMoney03),
                      _statsCard(
                          context,
                          'Transactions',
                          adminCubit.total_transaction.toString(),
                          HugeIcons.strokeRoundedMoney03),
                      _statsCard(
                          context,
                          'Total Items',
                          adminCubit.total_item.toString(),
                          HugeIcons.strokeRoundedMoney03),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const InvoiceTable()
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _statsCard(
      BuildContext context, String title, String stats, IconData icon) {
    return Expanded(
      child: Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                radius: 20,
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                stats,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
