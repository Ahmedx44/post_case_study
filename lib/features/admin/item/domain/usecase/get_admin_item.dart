import 'package:dartz/dartz.dart';
import 'package:post_case_study/features/admin/item/data/model/item_model.dart';
import 'package:post_case_study/features/admin/item/domain/repository/item_repository.dart';
import 'package:post_case_study/locator.dart';

class GetAdminItemUseCase {
  Future<Either<String, List<ItemModel>>> call() async {
    return await locator<ItemRepository>().getAllItem();
  }
}