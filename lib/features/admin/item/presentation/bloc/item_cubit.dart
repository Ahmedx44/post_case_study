import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/features/admin/item/domain/usecase/get_admin_item.dart';
import 'package:post_case_study/features/admin/item/presentation/bloc/item_state.dart';
import 'package:post_case_study/locator.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(ItemStateInitial());

  getAllItem() async {
    emit(ItemStateLoading());
    final result = await locator<GetAdminItemUseCase>().call();
    result.fold((error) {
      emit(ItemStateError(errorMessage: error));
    }, (success) {
      emit(ItemStateLoaded(item: success));
    });
  }
}
