// To parse this JSON data, do
//
//     final payInvoiceModel = payInvoiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:eva_life_care/features/list_appointment/business/entities/payinvoice_entity.dart';

PayInvoiceModel payInvoiceModelFromJson(String str) =>
    PayInvoiceModel.fromJson(json.decode(str));

String payInvoiceModelToJson(PayInvoiceModel data) =>
    json.encode(data.toJson());

class PayInvoiceModel extends PayInvoiceEntity {
  @override
  String status;
  @override
  String message;
  @override
  dynamic result;
  PayInvoiceModel({
    required this.status,
    required this.message,
    required this.result,
  }) : super(status: status, message: message, result: result);

  factory PayInvoiceModel.fromJson(Map<String, dynamic> json) =>
      PayInvoiceModel(
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
  int invoiceId;

  Result({
    required this.invoiceId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        invoiceId: json["invoice_id"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_id": invoiceId,
      };
}
