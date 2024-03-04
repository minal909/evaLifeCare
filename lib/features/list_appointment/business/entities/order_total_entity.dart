import 'package:eva_life_care/features/list_appointment/data/models/order_total_model.dart';

class OrderTotalEntity {
  String status;
  String message;
  Result result;
  OrderTotalEntity(
      {required this.status, required this.message, required this.result});
}
