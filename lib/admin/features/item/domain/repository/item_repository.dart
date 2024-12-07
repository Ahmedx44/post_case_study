import 'package:dartz/dartz.dart';
import 'package:post_case_study/admin/features/item/data/model/item_model.dart';

abstract class ItemRepository {
  Future<Either<String, List<ItemModel>>> getAllItem();
}
