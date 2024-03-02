// To parse this JSON data, do
//
//     final myProfile = myProfileFromJson(jsonString);


import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';

// MyProfile myProfileFromJson(String str) => MyProfile.fromJson(json.decode(str));

// String myProfileToJson(MyProfile data) => json.encode(data.toJson());message

class MyProfile extends MyProfileEntity {
  @override
  String status;
  @override
  String message;
  @override
  Result result;

  MyProfile({
    required this.status,
    required this.message,
    required this.result,
  }) : super(status: status, message: message, result: result);

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
        status: json["status"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class Result {
  int userId;
  int clientId;
  String cognitoId;
  dynamic username;
  String emailId;
  String firstname;
  String lastname;
  String mobile;
  int age;
  String gender;
  String addressLine1;
  String addressLine2;
  String country;
  String state;
  String city;
  String zipCode;
  String designation;
  String department;
  String status;
  String access_role;

  Result(
      {required this.userId,
      required this.clientId,
      required this.cognitoId,
      required this.username,
      required this.emailId,
      required this.firstname,
      required this.lastname,
      required this.mobile,
      required this.age,
      required this.gender,
      required this.addressLine1,
      required this.addressLine2,
      required this.country,
      required this.state,
      required this.city,
      required this.zipCode,
      required this.designation,
      required this.department,
      required this.status,
      required this.access_role});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      userId: json["user_id"],
      clientId: json["client_id"],
      cognitoId: json["cognito_id"],
      username: json["username"],
      emailId: json["email_id"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      mobile: json["mobile"],
      age: json["age"],
      gender: json["gender"],
      addressLine1: json["address_line1"],
      addressLine2: json["address_line2"],
      country: json["country"],
      state: json["state"],
      city: json["city"],
      zipCode: json["zip_code"],
      designation: json["designation"],
      department: json["department"],
      status: json["status"],
      access_role: json["access_role"]);

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "client_id": clientId,
        "cognito_id": cognitoId,
        "username": username,
        "email_id": emailId,
        "firstname": firstname,
        "lastname": lastname,
        "mobile": mobile,
        "age": age,
        "gender": gender,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "country": country,
        "state": state,
        "city": city,
        "zip_code": zipCode,
        "designation": designation,
        "department": department,
        "status": status,
        "access_role": access_role
      };
}
