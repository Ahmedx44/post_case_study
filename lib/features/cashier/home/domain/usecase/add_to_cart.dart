import 'package:dartz/dartz.dart';
import 'package:post_case_study/locator.dart';

import '../reposiotry/item_reposiotry.dart';

class AddToCartUseCase {
  Future<Either<String, String>> call(
      String name, double price, String imageUrl, String quantity) async {
    return await locator<ItemReposiotry>()
        .addItemToCart(name, price, imageUrl, quantity);
  }
}
