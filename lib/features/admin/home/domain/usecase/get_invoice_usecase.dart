import 'package:dartz/dartz.dart';
import 'package:post_case_study/features/admin/home/domain/repository/invoice_repository.dart';
import 'package:post_case_study/locator.dart';

class GetInvoiceUsecase {
  Future<Either<String, dynamic>> call() async {
    return await locator<InvoiceRepository>().getInvoice();
  }
}
