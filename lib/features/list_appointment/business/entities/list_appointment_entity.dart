import 'package:eva_life_care/features/list_appointment/data/models/list_appointment_model.dart';

class ListAppointmentEntity {
  String status;
  String message;
  List<ResultAptList> result;
  ListAppointmentEntity(
      {required this.status, required this.message, required this.result});
}
