import 'package:get_it/get_it.dart';
import 'package:post_case_study/features/admin/item/data/repository/item_repository_impl.dart';
import 'package:post_case_study/features/admin/item/data/source/item_source.dart';
import 'package:post_case_study/features/admin/item/domain/repository/item_repository.dart';
import 'package:post_case_study/features/admin/item/domain/usecase/get_admin_item.dart';
import 'package:post_case_study/features/cashier/home/data/repository/item_repository.dart';
import 'package:post_case_study/features/cashier/home/data/source/item_service.dart';
import 'package:post_case_study/features/cashier/home/domain/reposiotry/item_reposiotry.dart';
import 'package:post_case_study/features/cashier/home/domain/usecase/add_to_cart.dart';
import 'package:post_case_study/features/cashier/home/domain/usecase/get_item_usecase.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //Services
  locator.registerLazySingleton<ItemService>(() => ItemServiceImpl());
  locator.registerLazySingleton<AdminItemService>(() => AdminItemServiceImpl());

  //Reposiotrys
  locator.registerLazySingleton<ItemReposiotry>(() => ItemRepositoryImpl());
  locator.registerLazySingleton<ItemRepository>(() => AdminItemRepository());

  //Usecase
  locator.registerLazySingleton<GetItemUsecase>(() => GetItemUsecase());
  locator.registerLazySingleton<AddToCartUseCase>(() => AddToCartUseCase());
  locator
      .registerLazySingleton<GetAdminItemUseCase>(() => GetAdminItemUseCase());
}
