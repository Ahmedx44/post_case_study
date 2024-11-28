import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:post_case_study/core/bloc/theme_bloc/theme_cubit.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/admin_cubit.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/admin_state.dart';

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
                  : Theme.of(context).colorScheme.secondary,
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
                    title: 'Items',
                    icon: HugeIcons.strokeRoundedGroupItems,
                    index: 1),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
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
                ),
                Spacer(),
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    final isDarkMode = themeMode == ThemeMode.dark;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          const Icon(Icons.dark_mode),
                          const SizedBox(width: 10),
                          const Text('Dark Mode'),
                          const Spacer(),
                          Switch(
                            value: isDarkMode,
                            onChanged: (value) {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
