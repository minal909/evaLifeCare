import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/core/errors/failure.dart';
import 'package:eva_life_care/core/params/params.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/order_total_entity.dart';
import 'package:eva_life_care/features/list_appointment/business/usecases/get_order_total.dart';
import 'package:eva_life_care/features/list_appointment/data/datasources/orderTotal_remoteDataSource.dart';
import 'package:eva_life_care/features/list_appointment/data/repositories/orderTotal_repository_impl.dart';
import 'package:flutter/material.dart';

class OrderTotalProvider extends ChangeNotifier {
  OrderTotalEntity? orderTotal;
  Failure? failure;

  OrderTotalProvider({
    this.orderTotal,
    this.failure,
  });

  eitherFailureOrOrderTotal({
    double? orderSubtotal,
    List<Map<String, dynamic>>? discountApplication,
  }) async {
    OrderTotalRepositoryImpl repository = OrderTotalRepositoryImpl(
      remoteDataSource: OrderTotalRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrOrderTotal =
        await GetOrderTotal(orderTotalRepository: repository).call(
            params: OrderTotalParams(
                ordersubtotal: orderSubtotal,
                discountApplication: discountApplication));

    failureOrOrderTotal.fold(
      (Failure newFailure) {
        orderTotal = null;
        failure = newFailure;
        notifyListeners();
      },
      (OrderTotalEntity newOrderTotal) {
        orderTotal = newOrderTotal;
        failure = null;
        notifyListeners();
      },
    );
  }
}
