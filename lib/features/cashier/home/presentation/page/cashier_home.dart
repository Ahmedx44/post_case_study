import 'package:flutter/material.dart';
import 'package:post_case_study/core/util/responsive.dart';
import 'package:post_case_study/features/cashier/home/presentation/widget/side_menu_widget.dart';
import 'package:post_case_study/features/cashier/home/presentation/widget/summarywidget.dart';
import 'package:post_case_study/features/cashier/home/presentation/widget/dasboardWidget.dart';

class CashierHome extends StatelessWidget {
  const CashierHome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Summarywidget(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              const Expanded(
                flex: 2,
                child: SizedBox(
                  child: SideMenuWidget(),
                ),
              ),
            const Expanded(
              flex: 7,
              child: Dasboardwidget(),
            ),
            if (isDesktop)
              const Expanded(
                flex: 3,
                child: Summarywidget(),
              ),
          ],
        ),
      ),
    );
  }
}
