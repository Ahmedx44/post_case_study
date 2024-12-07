import 'package:dartz/dartz.dart';
import 'package:post_case_study/admin/features/home/data/source/invoice_service.dart';
import 'package:post_case_study/admin/features/home/domain/repository/invoice_repository.dart';
import 'package:post_case_study/locator.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  @override
  Future<Either<String, dynamic>> getInvoice() async {
    return await locator<InvoiceService>().getInvoice();
  }
}
