import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/features/admin/home/domain/usecase/get_invoice_usecase.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/invoice_bloc/invoice_state.dart';
import 'package:post_case_study/locator.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceStateInital());

  getInvoice() async {
    emit(InvoiceStateLoading());
    final result = await locator<GetInvoiceUsecase>().call();
    result.fold((error) {
      emit(InvoiceStateError(error: error));
    }, (succes) {
      emit(InvoiceStateLoaded(invoice: succes));
    });
  }
}
