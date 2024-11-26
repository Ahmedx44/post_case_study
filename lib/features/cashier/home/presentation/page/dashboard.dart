import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';
import 'package:post_case_study/features/cashier/home/domain/usecase/get_item_usecase.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cart_bloc/cart_cubit.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/dashboard_bloc/dashboard_cubit.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/dashboard_bloc/dashboard_state.dart';
import 'package:post_case_study/features/cashier/home/presentation/widget/custom_card.dart';
import 'package:post_case_study/locator.dart';

class CashierDashboard extends StatefulWidget {
  const CashierDashboard({super.key});

  @override
  State<CashierDashboard> createState() => _CashierDashboardState();
}

class _CashierDashboardState extends State<CashierDashboard> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

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
            // Filter items based on search query
            final filteredItems = state.items
                .where((item) => item.name
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()))
                .toList();

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
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
                        color: Theme.of(context).colorScheme.onSurface,
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
                                Tab(text: "Fruits"),
                                Tab(text: "Vegetables"),
                                Tab(text: "Dairy"),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Tab View Content
                            Expanded(
                              child: TabBarView(
                                children: [
                                  // All Items
                                  _buildGridView(context, filteredItems),
                                  // Computer Items
                                  _buildGridView(
                                    context,
                                    filteredItems
                                        .where(
                                            (item) => item.category == 'Fruits')
                                        .toList(),
                                  ),
                                  // Phone Items
                                  _buildGridView(
                                    context,
                                    filteredItems
                                        .where((item) =>
                                            item.category == 'Vegetables')
                                        .toList(),
                                  ),
                                  // Food Items
                                  _buildGridView(
                                    context,
                                    filteredItems
                                        .where(
                                            (item) => item.category == 'Dairy')
                                        .toList(),
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
          } else if (state is DashboardStateError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else if (state is DashboardStateInitial) {
            return const Center(child: Text('Initializing...'));
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }

  Widget _buildGridView(BuildContext context, List<Item> items) {
    final screenWidth = MediaQuery.of(context).size.width;

    final crossAxisCount = screenWidth > 600
        ? 4
        : screenWidth > 400
            ? 3
            : 2;

    final childAspectRatio = screenWidth > 600
        ? 0.7
        : screenWidth > 400
            ? 0.9
            : 0.8;

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return BlocProvider(
            create: (context) => CartCubit(), child: CustomCard(item: item));
      },
    );
  }
}
