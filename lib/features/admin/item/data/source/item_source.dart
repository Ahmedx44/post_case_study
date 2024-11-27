import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../model/item_model.dart';

abstract class AdminItemService {
  Future<Either<String, List<ItemModel>>> getAllItem();
}

class AdminItemServiceImpl extends AdminItemService {
  @override
  Future<Either<String, List<ItemModel>>> getAllItem() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/json_item_data.json');

      final List<dynamic> jsonData = json.decode(jsonString);

      final List<ItemModel> items = jsonData
          .expand((category) => (category['items'] as List<dynamic>).map(
                (item) => ItemModel.fromJson(
                    item as Map<String, dynamic>, category['category']),
              ))
          .toList();

      return Right(items);
    } catch (e) {
      return Left('Failed to load items: ${e.toString()}');
    }
  }
}
