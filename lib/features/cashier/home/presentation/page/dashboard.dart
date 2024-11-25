import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:post_case_study/features/cashier/home/domain/usecase/get_item_usecase.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/dashboard_bloc/dashboard_cubit.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/dashboard_bloc/dashboard_state.dart';
import 'package:post_case_study/locator.dart';

class CashierDashboard extends StatelessWidget {
  const CashierDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardCubit(getItemUsecase: locator<GetItemUsecase>())..getItem(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DashboardStateLoaded) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        prefixIcon: Icon(
                          HugeIcons.strokeRoundedSearch02,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Category Title
                    const Text(
                      'Category',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    // Tab Section
                    Expanded(
                      child: DefaultTabController(
                        length: 4,
                        child: Column(
                          children: [
                            ButtonsTabBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              unselectedBackgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              unselectedLabelStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              tabs: const [
                                Tab(icon: Icon(Icons.all_inbox), text: "All"),
                                Tab(
                                    icon: Icon(Icons.computer),
                                    text: "Computer"),
                                Tab(icon: Icon(Icons.phone), text: "Phone"),
                                Tab(icon: Icon(Icons.food_bank), text: "Food"),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Tab View Content
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Center(
                                    child: Text(
                                      "All Items",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "Computer Items",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "Phone Items",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "Food Items",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
