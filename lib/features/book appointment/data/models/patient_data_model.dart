// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);


// PatientModel patientModelFromJson(String str) => PatientModel.fromJson(json.decode(str));

// String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  String status;
  String message;
  List<Result> result;

  PatientModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  String cognitoId;
  String email;
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
  int idProofTypeId;
  String idProofNumber;
  DateTime registeredSince;
  String status;
  String username;

  Result({
    required this.id,
    required this.cognitoId,
    required this.email,
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
    required this.idProofTypeId,
    required this.idProofNumber,
    required this.registeredSince,
    required this.status,
    required this.username,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        cognitoId: json["cognito_id"],
        email: json["email"],
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
        idProofTypeId: json["id_proof_type_id"],
        idProofNumber: json["id_proof_number"],
        registeredSince: DateTime.parse(json["registered_since"]),
        status: json["status"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cognito_id": cognitoId,
        "email": email,
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
        "id_proof_type_id": idProofTypeId,
        "id_proof_number": idProofNumber,
        "registered_since": registeredSince.toIso8601String(),
        "status": status,
        "username": username,
      };
}
