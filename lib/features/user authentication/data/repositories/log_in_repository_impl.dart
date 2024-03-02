import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/log_in_repository.dart';
import '../datasources/log_in_remote_data_source.dart';
import '../models/log_in_model.dart';

class LogInRepositoryImpl implements LogInRepository {
  final LogInRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LogInRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, LogInModel>> getLogIn(
      {required LogInParams logInParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        LogInModel remoteLogIn =
            await remoteDataSource.getLogIn(logInParams: logInParams);

        return Right(remoteLogIn);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(NoInternetConnection(
          errorMessage: '',
          noInternet: NoInternet(
            onPressed: () {},
          )));
    }
  }
}
