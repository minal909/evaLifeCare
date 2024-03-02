import 'package:eva_life_care/features/list_invoice/data/models/list_invoice_model.dart';

class ListInvoiceEntity {
  String status;
  String message;
  List<Result> result;
  ListInvoiceEntity(
      {required this.status, required this.message, required this.result});
}
