import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/list_appointment_entity.dart';
import '../repositories/list_appointment_repository.dart';

class GetListAppointment {
  final ListAppointmentRepository listAppointmentRepository;

  GetListAppointment({required this.listAppointmentRepository});

  Future<Either<Failure, ListAppointmentEntity>> call({
    required ListAppointmentParams listAppointmentParams,
  }) async {
    return await listAppointmentRepository.getListAppointment(
        listAppointmentParams: listAppointmentParams);
  }
}
