import 'package:dartz/dartz.dart';

abstract class ItemReposiotry {
  Future<Either<String, List>> getAllItems();
  Future<Either<String, String>> addItemToCart(String name, double price,
      String imageUrl, String quantity, String category);
}
