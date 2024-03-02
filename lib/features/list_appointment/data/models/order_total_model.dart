// To parse this JSON data, do
//
//     final orderTotalModel = orderTotalModelFromJson(jsonString);

import 'package:eva_life_care/features/list_appointment/business/entities/order_total_entity.dart';

class OrderTotalModel extends OrderTotalEntity {
  @override
  String status;
  @override
  String message;
  @override
  Result result;
  OrderTotalModel({
    required this.status,
    required this.message,
    required this.result,
  }) : super(status: status, message: message, result: result);

  factory OrderTotalModel.fromJson(Map<String, dynamic> json) =>
      OrderTotalModel(
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
  double orderSubtotal;
  DiscountApplications discountApplications;
  double taxRate;
  double taxAmount;
  double orderTotal;
  dynamic discountAmount;

  Result({
    required this.orderSubtotal,
    required this.discountApplications,
    required this.taxRate,
    required this.taxAmount,
    required this.orderTotal,
    required this.discountAmount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        orderSubtotal: json["order_subtotal"],
        discountApplications:
            DiscountApplications.fromJson(json["discount_applications"]),
        taxRate: json["tax_rate"],
        taxAmount: json["tax_amount"],
        orderTotal: json["order_total"],
        discountAmount: json["discount_amount"],
      );

  Map<String, dynamic> toJson() => {
        "order_subtotal": orderSubtotal,
        "discount_applications": discountApplications.toJson(),
        "tax_rate": taxRate,
        "tax_amount": taxAmount,
        "order_total": orderTotal,
        "discount_amount": discountAmount,
      };
}

class DiscountApplications {
  DiscountApplications();

  factory DiscountApplications.fromJson(List<dynamic> json) =>
      DiscountApplications();

  List<dynamic> toJson() => [];
}
