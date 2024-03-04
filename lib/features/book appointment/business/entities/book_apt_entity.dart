import 'package:eva_life_care/features/book%20appointment/data/models/book_apt_model.dart';

class BookAppointmentEntity {
  String status;
  String message;
  Result result;
  BookAppointmentEntity({
    required this.status,
    required this.message,
    required this.result,
  });
}
