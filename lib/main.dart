import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_case_study/core/theme/theme.dart';
import 'package:post_case_study/features/admin/home/presentation/page/admin_home.dart';
import 'package:post_case_study/features/admin/item/presentation/page/add_item.dart';
import 'package:post_case_study/features/cashier/home/data/model/cart_item.dart';
import 'package:post_case_study/features/cashier/home/data/model/invoice.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';
import 'package:post_case_study/features/cashier/home/presentation/page/cashier_home.dart';
import 'package:post_case_study/features/common/auth/login/presentation/page/login_screen.dart';
import 'package:post_case_study/locator.dart';
import 'package:post_case_study/model/item.dart';
import 'package:post_case_study/preloadItem.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(InvoiceAdapter());
  Hive.registerAdapter(
      ItemAdapter()); // Use the adapter from your main Item class

  // Open necessary Hive boxes
  await Hive.openBox<CartItem>('cart');
  await Hive.openBox<Invoice>('invoices');
  await Hive.openBox<Item>('items');

  setupLocator();
  await preloadItems();
  runApp(const MyApp());
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
