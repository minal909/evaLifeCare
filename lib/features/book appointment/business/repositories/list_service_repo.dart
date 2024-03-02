import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_service.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

abstract class ListServiceRepository {
  Future<Either<Failure, ListServiceEntity>> getListService(
      {required ListServiceParams params});
}
