import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/list_invoice_entity.dart';
import '../../business/usecases/get_list_invoice.dart';
import '../../data/datasources/list_invoice_remote_data_source.dart';
import '../../data/repositories/list_invoice_impl.dart';

class ListInvoiceProvider extends ChangeNotifier {
  ListInvoiceEntity? listInvoice;
  Failure? failure;

  ListInvoiceProvider({
    this.listInvoice,
    this.failure,
  });

  eitherFailureOrListInvoice(
      bool? isFilter, bool? isPulledDown, String? name, String? mobile) async {
    ListInvoiceRepositoryImpl repository = ListInvoiceRepositoryImpl(
      remoteDataSource: ListInvoiceRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrListInvoice =
        await GetListInvoice(listInvoiceRepository: repository).call(
      listInvoiceParams: ListInvoiceParams(
        isFilter: isFilter!,
        isPulledDown: isPulledDown!,
        name: name.toString(),
        mobile: mobile.toString(),
      ),
    );

    failureOrListInvoice.fold(
      (Failure newFailure) {
        listInvoice = null;
        failure = newFailure;
        notifyListeners();
      },
      (ListInvoiceEntity newListInvoice) {
        listInvoice = newListInvoice;
        failure = null;
        notifyListeners();
      },
    );
  }

  getListInvoice() {}
}
