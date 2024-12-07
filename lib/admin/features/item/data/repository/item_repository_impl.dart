import 'package:dartz/dartz.dart';
import 'package:post_case_study/admin/features/item/data/model/item_model.dart';
import 'package:post_case_study/admin/features/item/data/source/item_source.dart';
import 'package:post_case_study/admin/features/item/domain/repository/item_repository.dart';
import 'package:post_case_study/locator.dart';

class AdminItemRepository extends ItemRepository {
  @override
  Future<Either<String, List<ItemModel>>> getAllItem() {
    return locator<AdminItemService>().getAllItem();
  }
}
