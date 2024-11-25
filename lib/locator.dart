import 'package:get_it/get_it.dart';
import 'package:post_case_study/features/cashier/home/data/source/item_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register the ItemService implementation
  locator.registerLazySingleton<ItemService>(() => ItemServiceImpl());
}
