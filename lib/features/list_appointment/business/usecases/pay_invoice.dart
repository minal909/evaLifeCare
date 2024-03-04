import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/payinvoice_entity.dart';
import 'package:eva_life_care/features/list_appointment/business/repositories/payinvoice_repository.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class PayInvoice {
  final PayInvoiceRepository repository;

  PayInvoice(this.repository);

  Future<Either<Failure, PayInvoiceEntity>> call(
      {required PayInvoiceParams params}) async {
    return await repository.getPayInvoice(payInvoiceParams: params);
  }
}
