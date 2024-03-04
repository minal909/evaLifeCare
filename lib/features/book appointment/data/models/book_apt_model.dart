import 'package:eva_life_care/features/book%20appointment/business/entities/book_apt_entity.dart';

class BookAppointmentModel extends BookAppointmentEntity {
  @override
  String status;
  @override
  String message;
  @override
  Result result;
  BookAppointmentModel({
    required this.status,
    required this.message,
    required this.result,
  }) : super(status: status, message: message, result: result);

  factory BookAppointmentModel.fromJson(Map<String, dynamic> json) =>
      BookAppointmentModel(
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
  int appointmentId;

  Result({
    required this.appointmentId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        appointmentId: json["appointment_id"],
      );

  Map<String, dynamic> toJson() => {
        "appointment_id": appointmentId,
      };
}
