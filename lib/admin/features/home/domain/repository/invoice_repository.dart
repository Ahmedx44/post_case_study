import 'package:dartz/dartz.dart';

abstract class InvoiceRepository {
  Future<Either<String, dynamic>> getInvoice();
}
