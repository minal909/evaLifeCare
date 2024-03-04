import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/repositories/list_idproof_repo.dart';
import 'package:eva_life_care/features/book%20appointment/data/datasources/list_idproof_remote_data_source.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/list_idproof_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class ListIdProofRepositoryImpl implements ListIdProofRepository {
  final ListIdProofRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  ListIdProofRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ListIdProofModel>> getListIdProof(
      {required ListIdProofParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteListIdProof =
            await remoteDataSource.getListIdProof(params: params);

        return Right(remoteListIdProof);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    }
    return Left(ServerFailure(errorMessage: 'This is a server exception'));
  }
}
