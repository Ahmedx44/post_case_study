import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../cashier/home/data/model/invoice.dart';

abstract class InvoiceService {
  Future<Either<String, dynamic>> getInvoice();
}

class InvoiceServiceImpl extends InvoiceService {
  @override
  Future<Either<String, List<Invoice>>> getInvoice() async {
    try {
      final invoicesBox = await Hive.openBox<Invoice>('invoices');
      return Right(invoicesBox.values.toList());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
