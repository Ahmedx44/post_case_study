import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/core/util/responsive.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cart_bloc/cart_cubit.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cashier_cubit.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cashier_state.dart';
import 'package:post_case_study/features/cashier/home/presentation/page/dashboard.dart';
import 'package:post_case_study/features/cashier/home/presentation/widget/custom_drawer.dart';
import 'package:post_case_study/features/cashier/home/presentation/widget/cart_widget.dart'; // Import the CartWidget

class CashierHome extends StatelessWidget {
  const CashierHome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return BlocProvider(
      create: (_) => CashierCubit(),
      child: Scaffold(
        drawer: isDesktop ? null : const CustomDrawer(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: isDesktop
            ? null
            : AppBar(
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                actions: [
                  if (!isDesktop)
                    Badge(
                      label: Text(
                          context.read<CartCubit>().cartBox.length.toString()),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          _showCartModal(context);
                        },
                      ),
                    ),
                ],
              ),
        body: BlocBuilder<CashierCubit, CashierState>(
          builder: (context, state) {
            final cubit = context.read<CashierCubit>();
            return Container(
              child: Row(
                children: [
                  // Sidebar for Desktop
                  if (isDesktop)
                    Container(
                      width: 250,
                      color: Theme.of(context).colorScheme.surface,
                      child: const CustomDrawer(),
                    ),

                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: cubit.pageController,
                            onPageChanged: cubit.onItemTapped,
                            children: const [
                              CashierDashboard(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (isDesktop) const CartWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Method to show the cart in a modal bottom sheet
  void _showCartModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const CartWidget(); // Pass the cart items here
      },
    );
  }
}
