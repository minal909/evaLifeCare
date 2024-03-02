import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/payinvoice_entity.dart';
import 'package:eva_life_care/features/list_appointment/business/usecases/pay_invoice.dart';
import 'package:eva_life_care/features/list_appointment/data/datasources/payInvoice_remote_datasource.dart';
import 'package:eva_life_care/features/list_appointment/data/repositories/payInvoiceRepository.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';

import 'package:flutter/material.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class PayInvoiceProvider extends ChangeNotifier {
  PayInvoiceEntity? payInvoice;
  Failure? failure;

  PayInvoiceProvider({
    this.payInvoice,
    this.failure,
  });

  eitherFailureOrPayInvoice({
    int? aptid,
    int? clientid,
    int? brancid,
    int? patientid,
    String? datetimegenerated,
    String? datetimedue,
    String? datetimeupdated,
    String? billingaddress,
    String? mobile,
    double? orderSubtotal,
    double? taxrate,
    double? taxamount,
    double? ordertotal,
    dynamic discAmount,
    List<Map<String, dynamic>>? discountApplication,
  }) async {
    PayInvoiceRepositoryImpl repository = PayInvoiceRepositoryImpl(
      remoteDataSource: PayInvoiceRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrListAppointment = await PayInvoice(repository).call(
        params: PayInvoiceParams(
            aptid: aptid,
            clientid: clientID,
            brancid: branchID,
            patientid: patientid,
            datetimegenerated: datetimegenerated,
            datetimedue: datetimedue,
            datetimeupdated: datetimeupdated,
            billingaddress: billingaddress,
            mobile: mobile,
            orderSubtotal: orderSubtotal,
            discountApplication: discountApplication,
            taxrate: taxrate,
            taxamount: taxamount,
            ordertotal: ordertotal,
            discAmount: discAmount));

    failureOrListAppointment.fold(
      (Failure newFailure) {
        payInvoice = null;
        failure = newFailure;
        notifyListeners();
      },
      (PayInvoiceEntity newPayInvoice) {
        payInvoice = newPayInvoice;
        failure = null;
        notifyListeners();
      },
    );
  }
}
