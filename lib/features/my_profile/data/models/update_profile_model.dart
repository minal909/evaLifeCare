// To parse this JSON data, do
//
//     final updateProfile = updateProfileFromJson(jsonString);


import 'package:eva_life_care/features/my_profile/business/entities/update_profile_entity.dart';

// UpdateProfile updateProfileFromJson(String str) =>
//     UpdateProfile.fromJson(json.decode(str));

// String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile extends UpdateProfileEntity {
  @override
  String status;
  @override
  String message;
  @override
  Result1 result;
  UpdateProfile({
    required this.status,
    required this.message,
    required this.result,
  }) : super(status: status, message: message, result: result);

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
        status: json["status"],
        message: json["message"],
        result: Result1.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class Result1 {
  int id;

  Result1({
    required this.id,
  });

  factory Result1.fromJson(Map<String, dynamic> json) => Result1(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
