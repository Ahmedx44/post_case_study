import 'package:get_it/get_it.dart';
import 'package:post_case_study/features/cashier/home/data/repository/item_repository.dart';
import 'package:post_case_study/features/cashier/home/data/source/item_service.dart';
import 'package:post_case_study/features/cashier/home/domain/reposiotry/item_reposiotry.dart';
import 'package:post_case_study/features/cashier/home/domain/usecase/get_item_usecase.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //Services
  locator.registerLazySingleton<ItemService>(() => ItemServiceImpl());

  //Reposiotrys
  locator.registerLazySingleton<ItemReposiotry>(() => ItemRepositoryImpl());

  //Usecase
  locator.registerLazySingleton<GetItemUsecase>(() => GetItemUsecase());
}
