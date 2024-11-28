import 'package:dartz/dartz.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';

abstract class ItemReposiotry {
  Future<Either<String, List>> getAllItems();
  Future<Either<String, String>> addItemToCart(String name, double price,
      String imageUrl, String quantity, String category);
}
