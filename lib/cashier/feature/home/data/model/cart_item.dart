import 'package:hive/hive.dart';
import 'package:post_case_study/cashier/feature/home/domain/entity/cart_item_enitity.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double price;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String category;

  CartItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  CartItemEntity toEntity() {
    return CartItemEntity(
      name: name,
      price: price,
      imageUrl: imageUrl,
      category: category,
    );
  }
}
