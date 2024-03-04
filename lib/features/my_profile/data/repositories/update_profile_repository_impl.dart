import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/my_profile/business/repositories/update_profile_repository.dart';
import 'package:eva_life_care/features/my_profile/data/datasources/update_profile_remote_data_source.dart';

import 'package:eva_life_care/features/my_profile/data/models/update_profile_model.dart';
import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class UpdateProfileRepositoryImpl implements UpdateProfileRepository {
  final UpdateProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UpdateProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UpdateProfile>> getUpdateProfile(
      {required UpdateProfileParams updateProfileParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        UpdateProfile remoteUpdateProfile = await remoteDataSource
            .getUpdateProfile(updateProfileParams: updateProfileParams);

        return Right(remoteUpdateProfile);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'This is a cache exception'));
    }
  }
}
