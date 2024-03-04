import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/payinvoice_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

abstract class PayInvoiceRepository {
  Future<Either<Failure, PayInvoiceEntity>> getPayInvoice({
    required PayInvoiceParams payInvoiceParams,
  });
}
