import 'package:hive/hive.dart';
import 'cart_item.dart';

part 'invoice.g.dart'; // Run Hive generator to generate this part file

@HiveType(typeId: 2) // Ensure a unique typeId
class Invoice extends HiveObject {
  @HiveField(0)
  final double totalPrice;

  @HiveField(1)
  final int totalItems;

  @HiveField(2)
  final List<CartItem> items;

  @HiveField(3)
  final DateTime createdAt;

  Invoice({
    required this.totalPrice,
    required this.totalItems,
    required this.items,
    required this.createdAt,
  });
}
