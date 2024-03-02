import 'package:dartz/dartz.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/core/errors/exceptions.dart';
import 'package:eva_life_care/core/errors/failure.dart';
import 'package:eva_life_care/core/params/params.dart';
import 'package:eva_life_care/features/list_appointment/business/repositories/order_total_repository.dart';
import 'package:eva_life_care/features/list_appointment/data/datasources/orderTotal_remoteDataSource.dart';
import 'package:eva_life_care/features/list_appointment/data/models/order_total_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';

class OrderTotalRepositoryImpl implements OrderTotalRepository {
  final OrderTotalRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OrderTotalRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, OrderTotalModel>> getOrderTotal(
      {required OrderTotalParams orderTotalParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        OrderTotalModel remoteOrderTotal =
            await remoteDataSource.getOrderTotal(params: orderTotalParams);

        return Right(remoteOrderTotal);
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
