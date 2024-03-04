import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/reschedule_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

abstract class RescheduleRepository {
  Future<Either<Failure, RescheduleEntity>> getReschedule({
    required RescheduleParams rescheduleParams,
  });
}
