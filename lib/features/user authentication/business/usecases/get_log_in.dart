import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/log_in_entity.dart';
import '../repositories/log_in_repository.dart';

class GetLogIn {
  final LogInRepository logInRepository;

  GetLogIn({required this.logInRepository});

  Future<Either<Failure, LogInEntity>> call({
    required LogInParams logInParams,
  }) async {
    return await logInRepository.getLogIn(logInParams: logInParams);
  }
}
