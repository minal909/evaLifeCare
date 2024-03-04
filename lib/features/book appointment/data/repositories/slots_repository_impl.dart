// import 'package:dartz/dartz.dart';
// import 'package:eva_life_care/features/book%20appointment/business/repositories/slots_list_repo.dart';
// import 'package:eva_life_care/features/book%20appointment/data/datasources/slots_list_remote_data_source.dart';
// import 'package:eva_life_care/features/book%20appointment/data/models/slots_list_model.dart';

// import '../../../../../core/connection/network_info.dart';
// import '../../../../../core/errors/exceptions.dart';
// import '../../../../../core/errors/failure.dart';
// import '../../../../core/params/params.dart';

// class SlotsListRepositoryImpl implements SlotsListRepository {
//   final SlotsListRemoteDataSource remoteDataSource;

//   final NetworkInfo networkInfo;

//   SlotsListRepositoryImpl({
//     required this.remoteDataSource,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failure, SlotsListModel>> getSlotsList(
//       {required SlotsListParams params}) async {
//     if (await networkInfo.isConnected!) {
//       try {
//         final remoteSlotsList =
//             await remoteDataSource.getSlotsList(params: params);

//         return Right(remoteSlotsList);
//       } on ServerException {
//         return Left(ServerFailure(errorMessage: 'This is a server exception'));
//       }
//     }
//     return Left(ServerFailure(errorMessage: 'This is a server exception'));
//   }
// }
