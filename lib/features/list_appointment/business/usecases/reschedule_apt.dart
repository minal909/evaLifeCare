import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/reschedule_entity.dart';
import 'package:eva_life_care/features/list_appointment/business/repositories/reschedule_repository.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class Reschedule {
  final RescheduleRepository repository;

  Reschedule(this.repository);

  Future<Either<Failure, RescheduleEntity>> call(
      {required RescheduleParams params}) async {
    return await repository.getReschedule(rescheduleParams: params);
  }
}
