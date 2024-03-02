// To parse this JSON data, do
//
//     final rescheduleModel = rescheduleModelFromJson(jsonString);

import 'package:eva_life_care/features/list_appointment/business/entities/reschedule_entity.dart';

class RescheduleModel extends RescheduleEntity {
  @override
  String status;
  @override
  String message;
  @override
  dynamic result;
  RescheduleModel({
    required this.status,
    required this.message,
    required this.result,
  }) : super(status: status, message: message, result: result);

  factory RescheduleModel.fromJson(Map<String, dynamic> json) =>
      RescheduleModel(
        status: json["status"],
        message: json["message"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result,
      };
}
