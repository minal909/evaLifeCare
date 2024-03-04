// To parse this JSON data, do
//
//     final listDoctorModel = listDoctorModelFromJson(jsonString);


// ListDoctorModel listDoctorModelFromJson(String str) => ListDoctorModel.fromJson(json.decode(str));

// String listDoctorModelToJson(ListDoctorModel data) => json.encode(data.toJson());

class ListDoctorModel {
  String status;
  String message;
  List<DoctorResult> doctorResult;

  ListDoctorModel({
    required this.status,
    required this.message,
    required this.doctorResult,
  });

  factory ListDoctorModel.fromJson(Map<String, dynamic> json) =>
      ListDoctorModel(
        status: json["status"],
        message: json["message"],
        doctorResult: List<DoctorResult>.from(
            json["result"].map((x) => DoctorResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(doctorResult.map((x) => x.toJson())),
      };
}

class DoctorResult {
  int userId;
  int clientId;
  int branchId;
  String accessRole;
  String cognitoId;
  String firstname;
  String lastname;
  int serviceId;

  DoctorResult({
    required this.userId,
    required this.clientId,
    required this.branchId,
    required this.accessRole,
    required this.cognitoId,
    required this.firstname,
    required this.lastname,
    required this.serviceId,
  });

  factory DoctorResult.fromJson(Map<String, dynamic> json) => DoctorResult(
        userId: json["user_id"],
        clientId: json["client_id"],
        branchId: json["branch_id"],
        accessRole: json["access_role"],
        cognitoId: json["cognito_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        serviceId: json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "client_id": clientId,
        "branch_id": branchId,
        "access_role": accessRole,
        "cognito_id": cognitoId,
        "firstname": firstname,
        "lastname": lastname,
        "service_id": serviceId,
      };
}
