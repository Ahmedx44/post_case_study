import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 5)
class Item extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double price;

  @HiveField(2)
  late String imageUrl;

  @HiveField(3)
  late String category;

  Item({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory Item.fromJson(Map<String, dynamic> json, String category) {
    return Item(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      category: category,
    );
  }
}
