import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';
import 'package:eva_life_care/features/my_profile/business/entities/update_profile_entity.dart';
import 'package:eva_life_care/features/my_profile/business/usecases/update_profile.dart';
import 'package:eva_life_care/features/my_profile/data/datasources/update_profile_remote_data_source.dart';
import 'package:eva_life_care/features/my_profile/data/repositories/update_profile_repository_impl.dart';

import 'package:flutter/material.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class UpdateProfileProvider extends ChangeNotifier {
  UpdateProfileEntity? updatedProfile;
  Failure? failure;

  UpdateProfileProvider({
    this.updatedProfile,
    this.failure,
  });

  eitherFailureOrUpdatedProfile(
      {required BuildContext context,
      required Widget widget,
      required int clId,
      required int usrId,
      required String cognitoid,
      String? email,
      String? mobile,
      String? firstname,
      String? lastname,
      String? accessrole,
      int? age,
      String? gender,
      String? addressline1,
      String? addressline2,
      String? country,
      String? state,
      String? city,
      String? zipcode,
      String? designation,
      String? department,
      String? branchid}) async {
    UpdateProfileRepositoryImpl repository = UpdateProfileRepositoryImpl(
      remoteDataSource: UpdateProfileRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrUpdatedProfile =
        await GetUpdateProfile(updateProfileRepository: repository).call(
      updateProfileParams: UpdateProfileParams(
          context: context,
          widget: widget,
          clientid: clId,
          userid: usrId,
          cognitoid: cognitoid,
          email: email,
          mobile: mobile,
          firstname: firstname,
          lastname: lastname,
          age: age,
          gender: gender,
          addressline1: addressline1,
          addressline2: addressline2,
          country: country,
          state: state,
          city: city,
          zipcode: zipcode,
          designation: designation,
          department: department),
    );

    failureOrUpdatedProfile.fold(
      (Failure newFailure) {
        updatedProfile = null;
        failure = newFailure;
        notifyListeners();
      },
      (UpdateProfileEntity newUpdatedProfile) {
        updatedProfile = newUpdatedProfile;
        failure = null;
        notifyListeners();
      },
    );
  }
}
