import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/list_invoice_entity.dart';

abstract class ListInvoiceRepository {
  Future<Either<Failure, ListInvoiceEntity>> getListInvoice({
    required ListInvoiceParams listInvoiceParams,
  });
}
