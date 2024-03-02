import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/repositories/book_apt_repository.dart';
import 'package:eva_life_care/features/book%20appointment/data/datasources/book_apt_remote_data_source.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/book_apt_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class BookAppointmentRepositoryImpl implements BookAppointmentRepository {
  final BookAppointmentRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  BookAppointmentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, BookAppointmentModel>> getBookAppointment(
      {required BookAppointmentParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteBookAppointment = await remoteDataSource.getBookAppointment(
            bookAppointmentParams: params);

        return Right(remoteBookAppointment);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    }
    return Left(ServerFailure(errorMessage: 'This is a server exception'));
  }
}
