import 'package:eva_life_care/features/book%20appointment/data/models/list_doctor_model.dart';

class ListDoctorEntity {
  String status;
  String message;
  List<DoctorResult> doctorResult;
  ListDoctorEntity({
    required this.status,
    required this.message,
    required this.doctorResult,
  });

  get isEmpty => null;
}
