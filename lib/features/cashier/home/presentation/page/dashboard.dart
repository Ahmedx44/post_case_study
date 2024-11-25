import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CashierDashboard extends StatelessWidget {
  const CashierDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      prefixIcon: Icon(HugeIcons.strokeRoundedSearch02,
                          color: Theme.of(context).iconTheme.color),
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      ButtonsTabBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        unselectedBackgroundColor: Colors.grey[300],
                        unselectedLabelStyle:
                            const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        tabs: const [
                          Tab(
                            icon: Icon(Icons.all_inbox),
                            text: "All",
                          ),
                          Tab(
                            icon: Icon(Icons.computer),
                            text: "Computer",
                          ),
                          Tab(
                            icon: Icon(Icons.phone),
                            text: "Phone",
                          ),
                          Tab(
                            icon: Icon(Icons.food_bank),
                            text: "Food",
                          ),
                        ],
                      ),
                      const TabBarView(children: [Text('All'), Text('dash')])
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
