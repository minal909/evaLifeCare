import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_doctor.dart';
import 'package:eva_life_care/features/book%20appointment/business/repositories/list_doctor_repo.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

class GetListDoctor {
  final ListDoctorRepository repository;

  GetListDoctor(this.repository);

  Future<Either<Failure, ListDoctorEntity>> call(
      {required ListDoctorParams params}) async {
    return await repository.getListDoctor(params: params);
  }
}
