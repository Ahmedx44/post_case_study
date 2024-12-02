import 'package:dartz/dartz.dart';
import 'package:post_case_study/features/cashier/home/data/source/item_service.dart';
import 'package:post_case_study/features/cashier/home/domain/reposiotry/item_reposiotry.dart';
import 'package:post_case_study/locator.dart';

class ItemRepositoryImpl extends ItemReposiotry {
  @override
  Future<Either<String, List>> getAllItems() async {
    return await locator<ItemService>().getAllItems();
  }

  @override
  Future<Either<String, String>> addItemToCart(String name, double price,
      String imageUrl, String quantity, String category) async {
    return await locator<ItemService>()
        .addItemToCart(name, price, imageUrl, quantity, category);
  }
}
