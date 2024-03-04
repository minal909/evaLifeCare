import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/my_profile/business/entities/update_profile_entity.dart';
import 'package:eva_life_care/features/my_profile/business/repositories/update_profile_repository.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class GetUpdateProfile {
  final UpdateProfileRepository updateProfileRepository;

  GetUpdateProfile({required this.updateProfileRepository});

  Future<Either<Failure, UpdateProfileEntity>> call({
    required UpdateProfileParams updateProfileParams,
  }) async {
    return await updateProfileRepository.getUpdateProfile(
        updateProfileParams: updateProfileParams);
  }
}
