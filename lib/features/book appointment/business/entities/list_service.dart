import 'package:eva_life_care/features/book%20appointment/data/models/list_service_model.dart';

class ListServiceEntity {
  String status;
  String message;
  List<Result> result;
  ListServiceEntity({
    required this.status,
    required this.message,
    required this.result,
  });

  get isEmpty => null;
}
