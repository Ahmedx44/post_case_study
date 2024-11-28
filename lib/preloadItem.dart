import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';

Future<void> preloadItems() async {
  final itemsBox = Hive.box<Item>('items');
  if (itemsBox.isEmpty) {
    final String jsonString =
        await rootBundle.loadString('assets/json_item_data.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    //parsing and saving it to hive
    for (var category in jsonData) {
      for (var item in category['items']) {
        itemsBox.add(Item(
          name: item['name'],
          price: item['price'],
          imageUrl: item['image_url'],
          category: category['category'],
        ));
      }
    }
  }
}
