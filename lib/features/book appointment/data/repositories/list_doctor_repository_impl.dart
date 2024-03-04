// import 'package:dartz/dartz.dart';
// import 'package:eva_life_care/features/book%20appointment/business/repositories/list_doctor_repo.dart';
// import 'package:eva_life_care/features/book%20appointment/data/datasources/list_doctor_remote_data_source.dart';
// import 'package:eva_life_care/features/book%20appointment/data/models/list_doctor_model.dart';

// import '../../../../../core/connection/network_info.dart';
// import '../../../../../core/errors/exceptions.dart';
// import '../../../../../core/errors/failure.dart';
// import '../../../../core/params/params.dart';

// class ListDoctorRepositoryImpl implements ListDoctorRepository {
//   final ListDoctorRemoteDataSource remoteDataSource;

//   final NetworkInfo networkInfo;

//   ListDoctorRepositoryImpl({
//     required this.remoteDataSource,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failure, ListDoctorModel>> getListDoctor(
//       {required ListDoctorParams params}) async {
//     if (await networkInfo.isConnected!) {
//       try {
//         final remoteListDoctor =
//             await remoteDataSource.getListDoctor(params: params);

//         return Right(remoteListDoctor);
//       } on ServerException {
//         return Left(ServerFailure(errorMessage: 'This is a server exception'));
//       }
//     }
//     return Left(ServerFailure(errorMessage: 'This is a server exception'));
//   }
// }
