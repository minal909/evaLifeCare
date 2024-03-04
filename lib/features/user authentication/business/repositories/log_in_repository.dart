import 'package:dartz/dartz.dart';
import 'package:eva_life_care/core/errors/failure.dart';
import 'package:eva_life_care/core/params/params.dart';
import 'package:eva_life_care/features/user%20authentication/business/entities/log_in_entity.dart';

abstract class LogInRepository {
  Future<Either<Failure, LogInEntity>> getLogIn({
    required LogInParams logInParams,
  });
}
