// To parse this JSON data, do
//
//     final listInvoiceModel = listInvoiceModelFromJson(jsonString);

import 'package:eva_life_care/features/list_invoice/business/entities/list_invoice_entity.dart';

class ListInvoiceModel extends ListInvoiceEntity {
  @override
  String status;
  @override
  String message;
  @override
  List<Result> result;
  ListInvoiceModel({
    required this.status,
    required this.message,
    required this.result,
  }) : super(status: status, message: message, result: result);

  factory ListInvoiceModel.fromJson(Map<String, dynamic> json) =>
      ListInvoiceModel(
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  int invoiceId;
  int clientId;
  int branchId;
  int appointmentId;
  int patientId;
  String datetimeGenerated;
  String datetimeDue;
  String datetimeUpdated;
  String? invoiceStatus;
  List<DiscountApplication> discountApplications;
  String? invoiceUrl;
  double? orderSubtotal;
  double? taxRate;
  double? taxAmount;
  double? orderTotal;
  String? billingAddress;
  double? discountAmount;
  String patientName;
  dynamic nextToken;

  Result({
    required this.invoiceId,
    required this.clientId,
    required this.branchId,
    required this.appointmentId,
    required this.patientId,
    required this.datetimeGenerated,
    required this.datetimeDue,
    required this.datetimeUpdated,
    required this.invoiceStatus,
    required this.discountApplications,
    required this.invoiceUrl,
    required this.orderSubtotal,
    required this.taxRate,
    required this.taxAmount,
    required this.orderTotal,
    required this.billingAddress,
    required this.discountAmount,
    required this.patientName,
    required this.nextToken,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        invoiceId: json["invoice_id"],
        clientId: json["client_id"],
        branchId: json["branch_id"],
        appointmentId: json["appointment_id"],
        patientId: json["patient_id"],
        datetimeGenerated: json["datetime_generated"],
        datetimeDue: json["datetime_due"],
        datetimeUpdated: json["datetime_updated"],
        invoiceStatus: json["invoice_status"],
        discountApplications: List<DiscountApplication>.from(
            json["discount_applications"]
                .map((x) => DiscountApplication.fromJson(x))),
        invoiceUrl: json["invoice_url"],
        orderSubtotal: json["order_subtotal"],
        taxRate: json["tax_rate"]?.toDouble(),
        taxAmount: json["tax_amount"]?.toDouble(),
        orderTotal: json["order_total"]?.toDouble(),
        billingAddress: json["billing_address"],
        discountAmount: json["discount_amount"]?.toDouble(),
        patientName: json["patient_name"],
        nextToken: json["next_token"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_id": invoiceId,
        "client_id": clientId,
        "branch_id": branchId,
        "appointment_id": appointmentId,
        "patient_id": patientId,
        "datetime_generated": datetimeGenerated,
        "datetime_due": datetimeDue,
        "datetime_updated": datetimeUpdated,
        "invoice_status": invoiceStatusValues.reverse[invoiceStatus],
        "discount_applications":
            List<dynamic>.from(discountApplications.map((x) => x.toJson())),
        "invoice_url": invoiceUrl,
        "order_subtotal": orderSubtotal,
        "tax_rate": taxRate,
        "tax_amount": taxAmount,
        "order_total": orderTotal,
        "billing_address": billingAddress,
        "discount_amount": discountAmount,
        "patient_name": patientNameValues.reverse[patientName],
        "next_token": nextToken,
      };
}

class DiscountApplication {
  String? type;
  String? valueType;
  CouponDiscount? couponDiscount;
  ManualDiscount? manualDiscount;

  DiscountApplication({
    this.type,
    this.valueType,
    this.couponDiscount,
    this.manualDiscount,
  });

  factory DiscountApplication.fromJson(Map<String, dynamic> json) =>
      DiscountApplication(
        type: json["type"],
        valueType: json["value_type"],
        couponDiscount: json["coupon_discount"] == null
            ? null
            : CouponDiscount.fromJson(json["coupon_discount"]),
        manualDiscount: json["manual_discount"] == null
            ? null
            : ManualDiscount.fromJson(json["manual_discount"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value_type": valueType,
        "coupon_discount": couponDiscount?.toJson(),
        "manual_discount": manualDiscount?.toJson(),
      };
}

class CouponDiscount {
  String id;
  String code;

  CouponDiscount({
    required this.id,
    required this.code,
  });

  factory CouponDiscount.fromJson(Map<String, dynamic> json) => CouponDiscount(
        id: json["id"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
      };
}

class ManualDiscount {
  dynamic value;
  String description;

  ManualDiscount({
    required this.value,
    required this.description,
  });

  factory ManualDiscount.fromJson(Map<String, dynamic> json) => ManualDiscount(
        value: json["value"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "description": description,
      };
}

enum InvoiceStatus { DUE, PAID }

final invoiceStatusValues =
    EnumValues({"Due": InvoiceStatus.DUE, "Paid": InvoiceStatus.PAID});

enum PatientName { CGFGF_DTDTD, TEST_USER }

final patientNameValues = EnumValues({
  "cgfgf dtdtd": PatientName.CGFGF_DTDTD,
  "Test User": PatientName.TEST_USER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
