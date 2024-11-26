import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:post_case_study/core/theme/theme.dart';
import 'package:post_case_study/features/admin/home/presentation/admin_home.dart';
import 'package:post_case_study/features/cashier/home/data/model/cart_item.dart';
import 'package:post_case_study/features/cashier/home/presentation/page/cashier_home.dart';
import 'package:post_case_study/features/common/auth/login/presentation/page/login_screen.dart';
import 'package:post_case_study/locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<CartItem>('cart');
  Hive.registerAdapter(CartItemAdapter());
  setupLocator();
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
