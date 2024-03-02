import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_service.dart';
import 'package:eva_life_care/features/book%20appointment/business/repositories/list_service_repo.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class GetListService {
  final ListServiceRepository repository;

  GetListService(this.repository);

  Future<Either<Failure, ListServiceEntity>> call(
      {required ListServiceParams params}) async {
    return await repository.getListService(params: params);
  }
}
