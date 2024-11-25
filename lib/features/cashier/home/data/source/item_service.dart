import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';

abstract class ItemService {
  Future<Either<String, List<Item>>> getAllItems();
}

class ItemServiceImpl extends ItemService {
  @override
  Future<Either<String, List<Item>>> getAllItems() async {
    try {
      // Load JSON file from assets
      final jsonString =
          await rootBundle.loadString('assets/json_item_data.json');

      // Decode JSON string into a dynamic list
      final List<dynamic> jsonData = json.decode(jsonString);

      // Flatten and map nested items to a List<Item>
      final List<Item> items = jsonData
          .expand((category) => (category['items'] as List<dynamic>).map(
                (item) => Item.fromJson(
                    item as Map<String, dynamic>, category['category']),
              ))
          .toList();

      // Return the list wrapped in a Right (indicating success)
      return Right(items);
    } catch (e) {
      // Return an error message wrapped in a Left (indicating failure)
      return Left('Failed to load items: ${e.toString()}');
    }
  }
}
