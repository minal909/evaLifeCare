import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
import 'package:eva_life_care/features/my_profile/business/repositories/my_profile_repository.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class GetMyProfile {
  final MyProfileRepository myProfileRepository;

  GetMyProfile({required this.myProfileRepository});

  Future<Either<Failure, MyProfileEntity>> call({
    required MyProfileParams myProfileParams,
  }) async {
    return await myProfileRepository.getMyProfile(
        myProfileParams: myProfileParams);
  }
}
