import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_service.dart';
import 'package:eva_life_care/features/book%20appointment/business/usecases/get_list_service.dart';
import 'package:eva_life_care/features/book%20appointment/data/datasources/list_service_remote_data_source.dart';
import 'package:eva_life_care/features/book%20appointment/data/repositories/list_service_repository_impl%20.dart';
import 'package:flutter/material.dart';
import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class ListServiceProvider extends ChangeNotifier {
  ListServiceEntity? listservice;
  Failure? failure;

  ListServiceProvider({
    this.listservice,
    this.failure,
  });

  void eitherFailureOrListService({
    required int clientid,
  }) async {
    ListServiceRepositoryImpl repository = ListServiceRepositoryImpl(
      remoteDataSource: ListServiceRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrListService = await GetListService(repository).call(
      params: ListServiceParams(clientid: clientid),
    );

    failureOrListService.fold(
      (newFailure) {
        listservice = null;
        failure = newFailure;
        notifyListeners();
      },
      (newListService) {
        listservice = newListService;
        failure = null;
        notifyListeners();
      },
    );
  }
}
