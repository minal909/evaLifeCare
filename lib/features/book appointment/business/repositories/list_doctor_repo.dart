import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_doctor.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

abstract class ListDoctorRepository {
  Future<Either<Failure, ListDoctorEntity>> getListDoctor(
      {required ListDoctorParams params});
}
