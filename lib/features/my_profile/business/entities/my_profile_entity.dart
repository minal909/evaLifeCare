import 'package:eva_life_care/features/my_profile/data/models/my_profile_model.dart';

class MyProfileEntity {
  String status;
  String message;
  Result result;
  MyProfileEntity({
    required this.status,
    required this.message,
    required this.result,
  });

  get isEmpty => null;
}
