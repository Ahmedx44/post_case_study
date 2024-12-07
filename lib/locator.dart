import 'package:get_it/get_it.dart';
import 'package:post_case_study/admin/features/home/data/repository/invoice_repository_impl.dart';
import 'package:post_case_study/admin/features/home/data/source/invoice_service.dart';
import 'package:post_case_study/admin/features/home/domain/repository/invoice_repository.dart';
import 'package:post_case_study/admin/features/home/domain/usecase/get_invoice_usecase.dart';
import 'package:post_case_study/admin/features/item/data/repository/item_repository_impl.dart';
import 'package:post_case_study/admin/features/item/data/source/item_source.dart';
import 'package:post_case_study/admin/features/item/domain/repository/item_repository.dart';
import 'package:post_case_study/admin/features/item/domain/usecase/get_admin_item.dart';
import 'package:post_case_study/cashier/feature/home/data/repository/item_repository.dart';
import 'package:post_case_study/cashier/feature/home/data/source/item_service.dart';
import 'package:post_case_study/cashier/feature/home/domain/reposiotry/item_reposiotry.dart';
import 'package:post_case_study/cashier/feature/home/domain/usecase/add_to_cart.dart';
import 'package:post_case_study/cashier/feature/home/domain/usecase/get_item_usecase.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //Services
  locator.registerLazySingleton<ItemService>(() => ItemServiceImpl());
  locator.registerLazySingleton<AdminItemService>(() => AdminItemServiceImpl());
  locator.registerLazySingleton<InvoiceService>(() => InvoiceServiceImpl());

  //Reposiotrys
  locator.registerLazySingleton<ItemReposiotry>(() => ItemRepositoryImpl());
  locator.registerLazySingleton<ItemRepository>(() => AdminItemRepository());
  locator
      .registerLazySingleton<InvoiceRepository>(() => InvoiceRepositoryImpl());

  //Usecase
  locator.registerLazySingleton<GetItemUsecase>(() => GetItemUsecase());
  locator.registerLazySingleton<AddToCartUseCase>(() => AddToCartUseCase());
  locator
      .registerLazySingleton<GetAdminItemUseCase>(() => GetAdminItemUseCase());
  locator.registerLazySingleton<GetInvoiceUsecase>(() => GetInvoiceUsecase());
}
