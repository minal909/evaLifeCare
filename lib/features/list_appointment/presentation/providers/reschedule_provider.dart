import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/reschedule_entity.dart';
import 'package:eva_life_care/features/list_appointment/business/usecases/reschedule_apt.dart';
import 'package:eva_life_care/features/list_appointment/data/datasources/rescheduleApt_remote_data_source.dart';
import 'package:eva_life_care/features/list_appointment/data/repositories/reschedule_repository_impl.dart';

import 'package:flutter/material.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class RescheduleProvider extends ChangeNotifier {
  RescheduleEntity? rescheduleAppointment;
  Failure? failure;

  RescheduleProvider({
    this.rescheduleAppointment,
    this.failure,
  });

  eitherFailureOrReschedule({
    int? aptid,
    int? userid,
    int? patientid,
    String? oldtimestamp,
    String? newtimestamp,
  }) async {
    RescheduleRepositoryImpl repository = RescheduleRepositoryImpl(
      remoteDataSource: RescheduleRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrListAppointment = await Reschedule(repository).call(
        params: RescheduleParams(
            aptid: aptid,
            userid: userid,
            patientid: patientid,
            oldtimestamp: oldtimestamp,
            newtimestamp: newtimestamp));

    failureOrListAppointment.fold(
      (Failure newFailure) {
        rescheduleAppointment = null;
        failure = newFailure;
        notifyListeners();
      },
      (RescheduleEntity newrescheduleAppointment) {
        rescheduleAppointment = newrescheduleAppointment;
        failure = null;
        notifyListeners();
      },
    );
  }
}
