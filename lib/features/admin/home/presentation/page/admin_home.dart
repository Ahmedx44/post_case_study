import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/core/util/responsive.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/admin_cubit.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/admin_state.dart';
import 'package:post_case_study/features/admin/home/presentation/widget/admin_dashboard.dart';
import 'package:post_case_study/features/admin/home/presentation/widget/admin_drawer.dart';
import 'package:post_case_study/features/admin/item/presentation/page/item.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return BlocProvider(
      create: (_) => AdminCubit(),
      child: Scaffold(
        drawer: isDesktop ? null : const AdminDrawer(),
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
              ),
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            final cubit = context.read<AdminCubit>();
            return Row(
              children: [
                // Sidebar for Desktop
                if (isDesktop)
                  Container(
                    width: 250,
                    color: Theme.of(context).colorScheme.primary,
                    child: const AdminDrawer(),
                  ),

                // Main content area
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: cubit.pageController,
                          onPageChanged: cubit.onItemTapped,
                          children: [
                            AdminDashboard(),
                            const ItemPage(),
                            const Center(child: Text('People Page')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
