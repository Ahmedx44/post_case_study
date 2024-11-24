import 'package:flutter/material.dart';
import 'package:post_case_study/core/util/responsive.dart';
import 'package:post_case_study/features/cashier/home/presentation/widget/custom_drawer.dart';

class CashierHome extends StatelessWidget {
  const CashierHome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: isDesktop
          ? null
          : AppBar(
              title: const Text("Haron"),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
      drawer: isDesktop ? null : const CustomDrawer(),
      body: Row(
        children: [
          if (isDesktop) const CustomDrawer(),
          const Expanded(
            child: Center(
              child: Text("Cashier Home Content"), // Main content area
            ),
          ),
        ],
      ),
    );
  }
}
