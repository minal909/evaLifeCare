import 'package:flutter/material.dart';

class NoParams {}

class TemplateParams {}

class MyProfileParams {
  final int clientid;
  final int userid;
  const MyProfileParams({
    required this.clientid,
    required this.userid,
  });
}

class SendMessageParams {
  final int clientid;
  final int userid;
  const SendMessageParams({
    required this.clientid,
    required this.userid,
  });
}

class ListServiceParams {
  final int clientid;
  const ListServiceParams({
    required this.clientid,
  });
}

class ListDoctorParams {
  final int clientid;
  final int serviceId;

  const ListDoctorParams({required this.clientid, required this.serviceId});
}

class SlotsListParams {
  final int userid;
  final int branchid;
  final String date;

  const SlotsListParams(
      {required this.userid, required this.branchid, required this.date});
}

class ListIdProofParams {
  final int clientid;

  const ListIdProofParams({required this.clientid});
}

class PayInvoiceParams {
  int? aptid;
  int? clientid;
  int? brancid;
  int? patientid;
  String? datetimegenerated;
  String? datetimedue;
  String? datetimeupdated;
  String? billingaddress;
  String? mobile;
  double? orderSubtotal;
  List<Map<String, dynamic>>? discountApplication;
  double? taxrate;
  double? taxamount;
  double? ordertotal;
  dynamic discAmount;

  PayInvoiceParams(
      {required this.aptid,
      required this.clientid,
      required this.brancid,
      required this.patientid,
      required this.datetimegenerated,
      required this.datetimedue,
      required this.datetimeupdated,
      required this.billingaddress,
      required this.mobile,
      required this.orderSubtotal,
      required this.discountApplication,
      required this.taxrate,
      required this.taxamount,
      required this.ordertotal,
      required this.discAmount});
}

class OrderTotalParams {
  final double? ordersubtotal;
  final List<Map<String, dynamic>>? discountApplication;

  const OrderTotalParams(
      {required this.ordersubtotal, this.discountApplication});
}

class BookAppointmentParams {
  final String? entityname;
  final String? appointmenttype;
  final int? patientid;
  final int? clientid;
  final int? branchid;
  final int? serviceid;
  final int? userid;
  final double? servicecharges;
  final String? referencedoctor;
  final String? appointmenttimestamp;
  final Map<String, dynamic>? patientdata;

  const BookAppointmentParams({
    required this.entityname,
    required this.appointmenttype,
    required this.patientid,
    required this.clientid,
    required this.branchid,
    required this.serviceid,
    required this.userid,
    required this.servicecharges,
    required this.referencedoctor,
    required this.appointmenttimestamp,
    required this.patientdata,
  });
}

class UpdateProfileParams {
  BuildContext context;
  Widget widget;
  final int clientid;
  final int userid;
  final String cognitoid;
  final String? email;
  final String? mobile;
  final String? firstname;
  final String? lastname;
  final String? accessrole;
  final int? age;
  final String? gender;
  final String? addressline1;
  final String? addressline2;
  final String? country;
  final String? state;
  final String? city;
  final String? zipcode;
  final String? designation;
  final String? department;
  final String? branchid;

  UpdateProfileParams(
      {required this.context,
      required this.widget,
      required this.clientid,
      required this.userid,
      required this.cognitoid,
      this.email,
      this.mobile,
      this.firstname,
      this.lastname,
      this.accessrole,
      this.age,
      this.gender,
      this.addressline1,
      this.addressline2,
      this.country,
      this.state,
      this.city,
      this.zipcode,
      this.designation,
      this.department,
      this.branchid});
}

class RescheduleParams {
  final int? aptid;
  final int? userid;
  final int? patientid;
  final String? oldtimestamp;
  final String? newtimestamp;

  const RescheduleParams({
    required this.aptid,
    required this.userid,
    required this.patientid,
    required this.oldtimestamp,
    required this.newtimestamp,
  });
}

class ListAppointmentParams {
  final int clid;
  final int branchid1;
  final String name;
  final String mobile;
  final String service;
  const ListAppointmentParams(
      {required this.clid,
      required this.branchid1,
      required this.name,
      required this.mobile,
      required this.service});
}

class ListInvoiceParams {
  final bool isPulledDown;
  final bool isFilter;
  final String name;
  final String mobile;
  const ListInvoiceParams({
    required this.isPulledDown,
    required this.isFilter,
    required this.name,
    required this.mobile,
  });
}

class LogInParams {
  final String email;
  final String password;
  const LogInParams({
    required this.email,
    required this.password,
  });
}

class PokemonParams {
  final String id;
  const PokemonParams({
    required this.id,
  });
}
