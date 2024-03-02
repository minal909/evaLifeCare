import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_idproof.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

abstract class ListIdProofRepository {
  Future<Either<Failure, ListIdProofEntity>> getListIdProof(
      {required ListIdProofParams params});
}
