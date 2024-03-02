import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/list_appointment/business/repositories/payinvoice_repository.dart';
import 'package:eva_life_care/features/list_appointment/data/datasources/payInvoice_remote_datasource.dart';
import 'package:eva_life_care/features/list_appointment/data/models/payInvoice_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class PayInvoiceRepositoryImpl implements PayInvoiceRepository {
  final PayInvoiceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PayInvoiceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PayInvoiceModel>> getPayInvoice(
      {required PayInvoiceParams payInvoiceParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        PayInvoiceModel remotePayInvoice =
            await remoteDataSource.getPayInvoice(params: payInvoiceParams);

        return Right(remotePayInvoice);
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
