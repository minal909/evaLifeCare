import 'package:eva_life_care/features/my_profile/data/models/update_profile_model.dart';

class UpdateProfileEntity {
  String status;
  String message;
  Result1 result;
  UpdateProfileEntity({
    required this.status,
    required this.message,
    required this.result,
  });
}
