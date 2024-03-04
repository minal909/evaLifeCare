import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

abstract class MyProfileRepository {
  Future<Either<Failure, MyProfileEntity>> getMyProfile({
    required MyProfileParams myProfileParams,
  });
}
