import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';
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
                                  // All Items
                                  _buildGridView(state.items),
                                  // Computer Items
                                  _buildGridView(state.items
                                      .where(
                                          (item) => item.category == 'Computer')
                                      .toList()),
                                  // Phone Items
                                  _buildGridView(state.items
                                      .where((item) => item.category == 'Phone')
                                      .toList()),
                                  // Food Items
                                  _buildGridView(state.items
                                      .where((item) => item.category == 'Food')
                                      .toList()),
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

  Widget _buildGridView(List<Item> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  item.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Item Name
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Item Price
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Description or other details
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
