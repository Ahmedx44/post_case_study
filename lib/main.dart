import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:post_case_study/core/theme/theme.dart';
import 'package:post_case_study/features/admin/home/presentation/page/admin_home.dart';
import 'package:post_case_study/features/admin/item/presentation/page/add_item.dart';
import 'package:post_case_study/features/cashier/home/data/model/cart_item.dart';
import 'package:post_case_study/features/cashier/home/data/model/invoice.dart';
import 'package:post_case_study/features/cashier/home/presentation/page/cashier_home.dart';
import 'package:post_case_study/features/common/auth/login/presentation/page/login_screen.dart';
import 'package:post_case_study/locator.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';
import 'package:post_case_study/model/items.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(InvoiceAdapter());
  Hive.registerAdapter(ItemsAdapter());
  await Hive.openBox<CartItem>('cart');
  await Hive.openBox<Invoice>('invoices');
  await Hive.openBox<Items>('items');

  setupLocator();
  await preloadItems(); // Preload the items into the Hive box
  runApp(const MyApp());
}

/// Function to preload items into the Hive box
Future<void> preloadItems() async {
  final itemsBox = Hive.box<Item>('items');
  if (itemsBox.isEmpty) {
    final String jsonString =
        await rootBundle.loadString('assets/json_item_data.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    // Parse and save data to Hive
    for (var category in jsonData) {
      for (var item in category['items']) {
        itemsBox.add(Item(
          id: item['id'],
          name: item['name'],
          description: item['description'],
          price: item['price'],
          imageUrl: item['image_url'],
          category: category['category'],
        ));
      }
    }
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/admin_home',
          builder: (BuildContext context, GoRouterState state) {
            return const AdminHome();
          },
        ),
        GoRoute(
          path: '/cashier_home',
          builder: (BuildContext context, GoRouterState state) {
            return const CashierHome();
          },
        ),
        GoRoute(
          path: '/add_item',
          builder: (BuildContext context, GoRouterState state) {
            return const AddItemPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
    );
  }
}
