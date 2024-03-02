import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/my_profile/business/entities/update_profile_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

abstract class UpdateProfileRepository {
  Future<Either<Failure, UpdateProfileEntity>> getUpdateProfile({
    required UpdateProfileParams updateProfileParams,
  });
}
