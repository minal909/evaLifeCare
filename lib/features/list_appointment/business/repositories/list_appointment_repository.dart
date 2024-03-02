import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/list_appointment_entity.dart';

abstract class ListAppointmentRepository {
  Future<Either<Failure, ListAppointmentEntity>> getListAppointment({
    required ListAppointmentParams listAppointmentParams,
  });
}
