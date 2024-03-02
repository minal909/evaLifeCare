import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/list_appointment/business/repositories/reschedule_repository.dart';
import 'package:eva_life_care/features/list_appointment/data/datasources/rescheduleApt_remote_data_source.dart';
import 'package:eva_life_care/features/list_appointment/data/models/reschedule_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class RescheduleRepositoryImpl implements RescheduleRepository {
  final RescheduleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RescheduleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RescheduleModel>> getReschedule(
      {required RescheduleParams rescheduleParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        RescheduleModel remoteReschedule =
            await remoteDataSource.getReschedule(params: rescheduleParams);

        return Right(remoteReschedule);
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
