import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/repositories/list_service_repo.dart';
import 'package:eva_life_care/features/book%20appointment/data/datasources/list_service_remote_data_source.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/list_service_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class ListServiceRepositoryImpl implements ListServiceRepository {
  final ListServiceRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  ListServiceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ListServiceModel>> getListService(
      {required ListServiceParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteListService =
            await remoteDataSource.getListService(params: params);

        return Right(remoteListService);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    }
    return Left(ServerFailure(errorMessage: 'This is a server exception'));
  }
}
