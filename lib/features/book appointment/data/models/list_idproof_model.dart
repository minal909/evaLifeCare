// To parse this JSON data, do
//
//     final listIdProofModel = listIdProofModelFromJson(jsonString);

// ListIdProofModel listIdProofModelFromJson(String str) =>
//     ListIdProofModel.fromJson(json.decode(str));

// String listIdProofModelToJson(ListIdProofModel data) =>
//     json.encode(data.toJson());

import 'package:eva_life_care/features/book%20appointment/business/entities/list_idproof.dart';

class ListIdProofModel extends ListIdProofEntity {
  @override
  String status;
  @override
  String message;
  @override
  List<Result> result;

  ListIdProofModel({
    required this.status,
    required this.message,
    required this.result,
  }) : super(message: message, status: status, result: result);

  factory ListIdProofModel.fromJson(Map<String, dynamic> json) =>
      ListIdProofModel(
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
  String documentName;

  Result({
    required this.id,
    required this.documentName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        documentName: json["document_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "document_name": documentName,
      };
}
