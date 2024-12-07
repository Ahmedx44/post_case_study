import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:post_case_study/core/bloc/theme_bloc/theme_cubit.dart';
import 'package:post_case_study/core/theme/theme.dart';
import 'package:post_case_study/admin/features/home/presentation/page/admin_home.dart';
import 'package:post_case_study/cashier/feature/home/presentation/bloc/cart_bloc/cart_cubit.dart';
import 'package:post_case_study/cashier/feature/home/presentation/page/cashier_home.dart';
import 'package:post_case_study/common/auth/presentation/page/login_screen.dart';
import 'package:post_case_study/locator.dart';
import 'package:post_case_study/preloadItem.dart';
import 'package:post_case_study/cashier/feature/home/data/model/cart_item.dart';
import 'package:post_case_study/cashier/feature/home/data/model/invoice.dart';
import 'package:post_case_study/cashier/feature/home/data/model/item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Hive.initFlutter();

  // Adapters
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(InvoiceAdapter());
  Hive.registerAdapter(ItemAdapter());

  // Hive Boxes
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
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, theme) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            themeMode: theme,
            theme: lightMode,
            darkTheme: darkMode,
          );
        },
      ),
    );
  }
}
