import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_idproof.dart';
import 'package:eva_life_care/features/book%20appointment/business/usecases/get_list_idproof.dart';
import 'package:eva_life_care/features/book%20appointment/data/datasources/list_idproof_remote_data_source.dart';
import 'package:eva_life_care/features/book%20appointment/data/repositories/list_idproof_repository_Impl.dart';

import 'package:flutter/material.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class ListIdProofProvider extends ChangeNotifier {
  ListIdProofEntity? listidproof;
  Failure? failure;

  ListIdProofProvider({
    this.listidproof,
    this.failure,
  });

  void eitherFailureOrListIdProof({
    required int clientid,
  }) async {
    ListIdProofRepositoryImpl repository = ListIdProofRepositoryImpl(
      remoteDataSource: ListIdProofRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrListIdProof = await GetListIdProof(repository).call(
      params: ListIdProofParams(clientid: clientid),
    );

    failureOrListIdProof.fold(
      (newFailure) {
        listidproof = null;
        failure = newFailure;
        notifyListeners();
      },
      (newListIdProof) {
        listidproof = newListIdProof;
        failure = null;
        notifyListeners();
      },
    );
  }
}
