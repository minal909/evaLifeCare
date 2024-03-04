import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/list_invoice_repository.dart';
import '../datasources/list_invoice_remote_data_source.dart';
import '../models/list_invoice_model.dart';

class ListInvoiceRepositoryImpl implements ListInvoiceRepository {
  final ListInvoiceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ListInvoiceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ListInvoiceModel>> getListInvoice(
      {required ListInvoiceParams listInvoiceParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ListInvoiceModel remoteListInvoice = await remoteDataSource
            .getListInvoice(listInvoiceParams: listInvoiceParams);

        return Right(remoteListInvoice);
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
