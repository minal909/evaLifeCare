// To parse this JSON data, do
//
//     final listServiceModel = listServiceModelFromJson(jsonString);


import 'package:eva_life_care/features/book%20appointment/business/entities/list_service.dart';

class ListServiceModel extends ListServiceEntity {
  @override
  String status;
  @override
  String message;
  @override
  List<Result> result;

  ListServiceModel({
    required this.status,
    required this.message,
    required this.result,
  }) : super(message: message, status: status, result: result);

  factory ListServiceModel.fromJson(Map<String, dynamic> json) =>
      ListServiceModel(
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
  int clientId;
  String name;
  String description;
  double amount;
  Status status;

  Result({
    required this.id,
    required this.clientId,
    required this.name,
    required this.description,
    required this.amount,
    required this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        clientId: json["client_id"],
        name: json["name"],
        description: json["description"],
        amount: json["amount"],
        status: statusValues.map[json["status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "name": name,
        "description": description,
        "amount": amount,
        "status": statusValues.reverse[status],
      };
}

enum Status { ACTIVE }

final statusValues = EnumValues({"Active": Status.ACTIVE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
