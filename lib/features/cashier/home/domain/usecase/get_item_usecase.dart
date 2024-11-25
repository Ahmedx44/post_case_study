import 'package:dartz/dartz.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';
import 'package:post_case_study/features/cashier/home/domain/reposiotry/item_reposiotry.dart';
import 'package:post_case_study/locator.dart';

class GetItemUsecase {
  Future<Either<String, List<Item>>> call() async {
    return await locator<ItemReposiotry>().getAllItems();
  }
}
