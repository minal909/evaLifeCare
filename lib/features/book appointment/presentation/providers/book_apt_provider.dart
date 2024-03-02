import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/book_apt_entity.dart';
import 'package:eva_life_care/features/book%20appointment/business/usecases/add_new_apt.dart';
import 'package:eva_life_care/features/book%20appointment/data/datasources/book_apt_remote_data_source.dart';
import 'package:eva_life_care/features/book%20appointment/data/repositories/book_apt_repository_impl.dart';

import 'package:flutter/material.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class BookAppointmentProvider extends ChangeNotifier {
  BookAppointmentEntity? bookAppointment;
  Failure? failure;

  BookAppointmentProvider({
    this.bookAppointment,
    this.failure,
  });

  eitherFailureOrBookAppointment(
      {String? entityname,
      String? appointmenttype,
      int? patientid,
      int? clientid,
      int? branchid,
      int? serviceid,
      int? userid,
      double? servicecharges,
      String? referencedoctor,
      String? appointmenttimestamp,
      Map<String, dynamic>? patientdata}) async {
    BookAppointmentRepositoryImpl repository = BookAppointmentRepositoryImpl(
      remoteDataSource: BookAppointmentRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrBookAppointment = await GetBookAppointment(repository).call(
      params: BookAppointmentParams(
        entityname: entityname,
        appointmenttype: appointmenttype,
        patientid: patientid,
        branchid: branchid,
        serviceid: serviceid,
        servicecharges: servicecharges,
        clientid: clientid,
        userid: userid,
        referencedoctor: referencedoctor,
        appointmenttimestamp: appointmenttimestamp,
        patientdata: patientdata,
      ),
    );

    failureOrBookAppointment.fold(
      (Failure newFailure) {
        bookAppointment = null;
        failure = newFailure;
        notifyListeners();
      },
      (BookAppointmentEntity newBookAppointment) {
        bookAppointment = newBookAppointment;
        failure = null;
        notifyListeners();
      },
    );
  }
}
