import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/book_apt_entity.dart';
import 'package:eva_life_care/features/book%20appointment/business/repositories/book_apt_repository.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

// class GetBookAppointment {
//   final BookAppointmentRepository repository;

//   GetBookAppointment(this.repository,);

//   Future<Either<Failure, BookAppointmentEntity>> call(
//       {required BookAppointmentParams params}) async {
//     return await repository.getBookAppointment(params: params);
//   }
// }

class GetBookAppointment {
  final BookAppointmentRepository repository;

  GetBookAppointment(this.repository);

  Future<Either<Failure, BookAppointmentEntity>> call(
      {required BookAppointmentParams params}) async {
    return await repository.getBookAppointment(params: params);
  }
}
