import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_idproof.dart';
import 'package:eva_life_care/features/book%20appointment/business/repositories/list_idproof_repo.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class GetListIdProof {
  final ListIdProofRepository repository;

  GetListIdProof(this.repository);

  Future<Either<Failure, ListIdProofEntity>> call(
      {required ListIdProofParams params}) async {
    return await repository.getListIdProof(params: params);
  }
}
