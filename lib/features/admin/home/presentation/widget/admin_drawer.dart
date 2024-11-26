import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/admin_cubit.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/admin_state.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cashier_cubit.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        final cubit = context.read<AdminCubit>();

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
                    icon: HugeIcons.strokeRoundedInvoice,
                    index: 1),
                buildTile(
                    title: 'Items',
                    icon: HugeIcons.strokeRoundedGroupItems,
                    index: 2),
                buildTile(
                    title: 'Setting',
                    icon: HugeIcons.strokeRoundedSettings01,
                    index: 3),
              ],
            ),
          ),
        );
      },
    );
  }
}
