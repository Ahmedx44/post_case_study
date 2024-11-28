import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 10)
class ItemHive {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double price;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String category;

  ItemHive({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory ItemHive.fromJson(Map<String, dynamic> json, String category) {
    return ItemHive(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      category: category,
    );
  }
}
