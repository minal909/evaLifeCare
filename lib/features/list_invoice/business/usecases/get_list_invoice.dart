import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/list_invoice_entity.dart';
import '../repositories/list_invoice_repository.dart';

class GetListInvoice {
  final ListInvoiceRepository listInvoiceRepository;

  GetListInvoice({required this.listInvoiceRepository});

  Future<Either<Failure, ListInvoiceEntity>> call({
    required ListInvoiceParams listInvoiceParams,
  }) async {
    return await listInvoiceRepository.getListInvoice(
      listInvoiceParams: listInvoiceParams,
    );
  }
}
