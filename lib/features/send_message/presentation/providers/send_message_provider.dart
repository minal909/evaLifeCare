import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';
import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
import 'package:eva_life_care/features/my_profile/business/usecases/get_my_profile.dart';
import 'package:eva_life_care/features/my_profile/data/datasources/my_profile_remote_data_source.dart';
import 'package:eva_life_care/features/my_profile/data/repositories/my_profile_repository_impl.dart';

import 'package:flutter/material.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class MyProfileProvider extends ChangeNotifier {
  MyProfileEntity? myProfile;
  Failure? failure;

  MyProfileProvider({
    this.myProfile,
    this.failure,
  });

  void eitherFailureOrMyProfile({
    required int clId,
    required int usrId,
  }) async {
    MyProfileRepositoryImpl repository = MyProfileRepositoryImpl(
      remoteDataSource: MyProfileRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrMyProfile =
        await GetMyProfile(myProfileRepository: repository).call(
      myProfileParams: MyProfileParams(clientid: clId, userid: usrId),
    );

    failureOrMyProfile.fold(
      (Failure newFailure) {
        myProfile = null;
        failure = newFailure;
        notifyListeners();
      },
      (MyProfileEntity newMyProfile) {
        myProfile = newMyProfile;
        failure = null;
        notifyListeners();
      },
    );
  }
}
