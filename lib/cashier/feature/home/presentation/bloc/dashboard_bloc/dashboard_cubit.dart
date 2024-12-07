import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/cashier/feature/home/domain/usecase/get_item_usecase.dart';
import 'package:post_case_study/cashier/feature/home/presentation/bloc/dashboard_bloc/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetItemUsecase getItemUsecase;

  DashboardCubit({required this.getItemUsecase})
      : super(DashboardStateInitial());

  Future getItem() async {
    emit(DashboardStateLoading());
    print('Fetching');

    final result = await getItemUsecase();
    result.fold((error) {
      print(error);
      emit(DashboardStateError(error: error));
    }, (success) {
      emit(DashboardStateLoaded(items: success));
    });
  }
}
