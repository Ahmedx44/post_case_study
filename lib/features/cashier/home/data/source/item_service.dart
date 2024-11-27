import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:post_case_study/features/cashier/home/data/model/cart_item.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';

abstract class ItemService {
  Future<Either<String, List<Item>>> getAllItems();
  Future<Either<String, String>> addItemToCart(
    String name,
    double price,
    String imageUrl,
    String quantity,
    String category,
  );
}

class ItemServiceImpl extends ItemService {
  @override
  Future<Either<String, List<Item>>> getAllItems() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/json_item_data.json');

      final List<dynamic> jsonData = json.decode(jsonString);

      final List<Item> items = jsonData
          .expand((category) => (category['items'] as List<dynamic>).map(
                (item) => Item.fromJson(
                    item as Map<String, dynamic>, category['category']),
              ))
          .toList();

      return Right(items);
    } catch (e) {
      return Left('Failed to load items: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> addItemToCart(
    String name,
    double price,
    String imageUrl,
    String quantity, // Matches here
    String category,
  ) async {
    try {
      await Hive.box<CartItem>('cart').add(CartItem(
        name: name,
        price: price,
        imageUrl: imageUrl,
        category: category,
      ));

      print('Item added');

      return const Right('Added Successfully');
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
