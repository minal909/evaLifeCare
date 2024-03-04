import '../../business/entities/list_appointment_entity.dart';

// class ListAppointmentModel extends ListAppointmentEntity {
//   const ListAppointmentModel({
//     required super.listappointment,
//   });

//   factory ListAppointmentModel.fromJson({required Map<String, dynamic> json}) {
//     return ListAppointmentModel(
//       listappointment: json[kListAppointment],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       kListAppointment: listappointment,
//     };
//   }
// }
// // To parse this JSON data, do
//
//     final listAppointmentModel = listAppointmentModelFromJson(jsonString);

// ListAppointmentModel listAppointmentModelFromJson(String str) =>
//     ListAppointmentModel.fromJson(json.decode(str));

// String listAppointmentModelToJson(ListAppointmentModel data) =>
//     json.encode(data.toJson());

class ListAppointmentModel extends ListAppointmentEntity {
  @override
  String status;
  @override
  String message;
  @override
  List<ResultAptList> result;
  ListAppointmentModel({
    required this.status,
    required this.message,
    required this.result,
  }) : super(status: status, message: message, result: result);

  factory ListAppointmentModel.fromJson(Map<String, dynamic> json) =>
      ListAppointmentModel(
        status: json["status"],
        message: json["message"],
        result: List<ResultAptList>.from(
            json["result"].map((x) => ResultAptList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class ResultAptList {
  int clientId;
  int userId;
  int branchId;
  int appointmentId;
  int serviceId;
  int patientId;
  String pFirstname;
  String pLastname;
  String uFirstname;
  String uLastname;
  DateTime appointmentTimestamp;
  AppointmentStatus appointmentStatus;
  String serviceName;
  double orderSubtotal;
  String billingAddress;
  String mobile;
  String invoiceStatus;

  ResultAptList(
      {required this.clientId,
      required this.userId,
      required this.branchId,
      required this.appointmentId,
      required this.serviceId,
      required this.patientId,
      required this.pFirstname,
      required this.pLastname,
      required this.uFirstname,
      required this.uLastname,
      required this.appointmentTimestamp,
      required this.appointmentStatus,
      required this.serviceName,
      required this.orderSubtotal,
      required this.billingAddress,
      required this.mobile,
      required this.invoiceStatus});

  factory ResultAptList.fromJson(Map<String, dynamic> json) => ResultAptList(
      clientId: json["client_id"],
      userId: json["user_id"],
      branchId: json["branch_id"],
      appointmentId: json["appointment_id"],
      serviceId: json["service_id"],
      patientId: json["patient_id"],
      pFirstname: json["p_firstname"],
      pLastname: json["p_lastname"],
      uFirstname: json["u_firstname"],
      uLastname: json["u_lastname"],
      appointmentTimestamp: DateTime.parse(json["appointment_timestamp"]),
      appointmentStatus:
          appointmentStatusValues.map[json["appointment_status"]]!,
      serviceName: json["service_name"],
      orderSubtotal: json["order_subtotal"],
      billingAddress: json["billing_address"],
      mobile: json["mobile"],
      invoiceStatus: json["invoice_status"]);

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "user_id": userId,
        "branch_id": branchId,
        "appointment_id": appointmentId,
        "service_id": serviceId,
        "patient_id": patientId,
        "p_firstname": pFirstname,
        "p_lastname": pLastname,
        "u_firstname": uFirstname,
        "u_lastname": uLastname,
        "appointment_timestamp": appointmentTimestamp.toIso8601String(),
        "appointment_status":
            appointmentStatusValues.reverse[appointmentStatus],
        "service_name": serviceName,
        "order_subtotal": orderSubtotal,
        "billing_address": billingAddress,
        "mobile": mobile,
        "invoice_status": invoiceStatus
      };
}

enum AppointmentStatus { CANCELLED, CONFIRMED, RESCHEDULED }

final appointmentStatusValues = EnumValues({
  "Cancelled": AppointmentStatus.CANCELLED,
  "Confirmed": AppointmentStatus.CONFIRMED,
  "Rescheduled": AppointmentStatus.RESCHEDULED
});

// enum ServiceName {
//   CBC,
//   FASTING_BLOOD_S_UGAR,
//   HB_A1_C,
//   LIPID_PROFILE,
//   THYROID_PROFILE,
//   LIVER_FUNCTION_TEST,
//   DENGUE_NS_1,
//   MALARIAL_ANTIGEN,
//   VITAMIN_B_12,
//   VITAMIN_D_PROFILE,
// }

// final serviceNameValues = EnumValues({
//   "CBC": ServiceName.CBC,
//   "Fasting Blood SUgar": ServiceName.FASTING_BLOOD_S_UGAR,
//   "HbA1c": ServiceName.HB_A1_C,
//   "Lipid Profile": ServiceName.LIPID_PROFILE,
//   "Thyroid Profile": ServiceName.THYROID_PROFILE,
//   "Liver Function Test": ServiceName.LIVER_FUNCTION_TEST,
//   "Dengue NS 1": ServiceName.DENGUE_NS_1,
//   "Malarial Antigen": ServiceName.MALARIAL_ANTIGEN,
//   "Vitamin B 12": ServiceName.VITAMIN_B_12,
//   "Vitamin D Profile": ServiceName.VITAMIN_D_PROFILE
// });

// enum UFirstname { CORBIN, MINAL, NISHTHA, RAKHI, NAZIR }

// final uFirstnameValues = EnumValues({
//   "Corbin": UFirstname.CORBIN,
//   "minal ": UFirstname.MINAL,
//   "Nishtha": UFirstname.NISHTHA,
//   "Rakhi": UFirstname.RAKHI,
//   "Nazir": UFirstname.NAZIR
// });

// enum ULastname { HARA, KUNDA, SURYAWANSHI, SUNDARAM, BALI, KUMAR_NATT }

// final uLastnameValues = EnumValues({
//   "Hara": ULastname.HARA,
//   "Kunda": ULastname.KUNDA,
//   "suryawanshi": ULastname.SURYAWANSHI,
//   "Sundaram": ULastname.SUNDARAM,
//   "Bali": ULastname.BALI,
//   "Kumar Natt": ULastname.KUMAR_NATT
// });

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
