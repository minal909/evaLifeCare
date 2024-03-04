import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/book_apt_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

abstract class BookAppointmentRepository {
  Future<Either<Failure, BookAppointmentEntity>> getBookAppointment(
      {required BookAppointmentParams params});
}
