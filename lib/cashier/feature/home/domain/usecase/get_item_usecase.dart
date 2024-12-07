import 'package:dartz/dartz.dart';
import 'package:post_case_study/cashier/feature/home/domain/reposiotry/item_reposiotry.dart';
import 'package:post_case_study/locator.dart';

class GetItemUsecase {
  Future<Either<String, List>> call() async {
    return await locator<ItemReposiotry>().getAllItems();
  }
}
