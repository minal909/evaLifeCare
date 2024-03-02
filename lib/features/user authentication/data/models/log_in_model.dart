// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);


import 'package:eva_life_care/features/user%20authentication/business/entities/log_in_entity.dart';

class LogInModel extends LogInEntity {
  const LogInModel({
    required super.isSignedIn,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        isSignedIn: json["isSignedIn"],
      );

  Map<String, dynamic> toJson() => {
        "isSignedIn": isSignedIn,
      };
}

// class AuthenticationResult {
//   String accessToken;
//   int expiresIn;
//   String idToken;
//   String refreshToken;
//   String tokenType;

//   AuthenticationResult({
//     required this.accessToken,
//     required this.expiresIn,
//     required this.idToken,
//     required this.refreshToken,
//     required this.tokenType,
//   });

//   factory AuthenticationResult.fromJson(Map<String, dynamic> json) =>
//       AuthenticationResult(
//         accessToken: json["AccessToken"],
//         expiresIn: json["ExpiresIn"],
//         idToken: json["IdToken"],
//         refreshToken: json["RefreshToken"],
//         tokenType: json["TokenType"],
//       );

//   Map<String, dynamic> toJson() => {
//         "AccessToken": accessToken,
//         "ExpiresIn": expiresIn,
//         "IdToken": idToken,
//         "RefreshToken": refreshToken,
//         "TokenType": tokenType,
//       };
// }

// class ChallengeParameters {
//   ChallengeParameters();

//   factory ChallengeParameters.fromJson(Map<String, dynamic> json) =>
//       ChallengeParameters();

//   Map<String, dynamic> toJson() => {};
// }
