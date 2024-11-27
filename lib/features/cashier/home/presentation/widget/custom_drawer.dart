import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cashier_cubit.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cashier_state.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashierCubit, CashierState>(
      builder: (context, state) {
        final cubit = context.read<CashierCubit>();

        Widget buildTile({
          required String title,
          required IconData icon,
          required int index,
        }) {
          final isSelected = state.selectedIndex == index;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 206, 228, 251)
                  : Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.lightBlue : Colors.black,
                ),
              ),
              leading: Icon(
                icon,
                color: isSelected ? Colors.lightBlue : Colors.black,
              ),
              onTap: () => cubit.onItemTapped(index),
            ),
          );
        }

        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: Drawer(
            child: Column(
              children: [
                const DrawerHeader(
                  child: Text('Haron'),
                ),
                buildTile(
                    title: 'Home',
                    icon: HugeIcons.strokeRoundedHome02,
                    index: 0),
                buildTile(
                    title: 'Orders',
                    icon: HugeIcons.strokeRoundedGroupItems,
                    index: 1),
                buildTile(
                    title: 'Setting',
                    icon: HugeIcons.strokeRoundedSettings01,
                    index: 2),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: const Text(
                      'Logout',
                      style: TextStyle(),
                    ),
                    leading: const Icon(
                      HugeIcons.strokeRoundedLogout01,
                    ),
                    onTap: () {
                      context.go('/');
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
