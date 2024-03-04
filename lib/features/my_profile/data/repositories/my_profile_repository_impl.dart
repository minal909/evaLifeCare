import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/my_profile/business/repositories/my_profile_repository.dart';
import 'package:eva_life_care/features/my_profile/data/datasources/my_profile_remote_data_source.dart';
import 'package:eva_life_care/features/my_profile/data/models/my_profile_model.dart';
import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class MyProfileRepositoryImpl implements MyProfileRepository {
  final MyProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MyProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, MyProfile>> getMyProfile(
      {required MyProfileParams myProfileParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        MyProfile remoteMyProfile = await remoteDataSource.getMyProfile(
            myProfileParams: myProfileParams);

        return Right(remoteMyProfile);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'This is a cache exception'));
    }
  }
}
