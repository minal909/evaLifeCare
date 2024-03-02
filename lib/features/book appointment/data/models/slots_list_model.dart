// // // To parse this JSON data, do
// // //
// // //     final slotsListModel = slotsListModelFromJson(jsonString);

// // import 'package:eva_life_care/features/book%20appointment/business/entities/slots_list.dart';

// // // SlotsListModel slotsListModelFromJson(String str) =>
// // //     SlotsListModel.fromJson(json.decode(str));

// // // String slotsListModelToJson(SlotsListModel data) => json.encode(data.toJson());

// // class SlotsListModel extends SlotsListEntity {
// //   @override
// //   String status;
// //   @override
// //   String message;
// //   @override
// //   List<SlotsResult> result;

// //   SlotsListModel({
// //     required this.status,
// //     required this.message,
// //     required this.result,
// //   }) : super(message: message, status: status, result: result);

// //   factory SlotsListModel.fromJson(Map<String, dynamic> json) => SlotsListModel(
// //         status: json["status"],
// //         message: json["message"],
// //         result: List<SlotsResult>.from(
// //             json["result"].map((x) => SlotsResult.fromJson(x))),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "status": status,
// //         "message": message,
// //         "result": List<dynamic>.from(result.map((x) => x.toJson())),
// //       };
// // }

// // class SlotsResult {
// //   String userId;
// //   String branchId;
// //   DateTime date;
// //   SlotsResult slots;

// //   SlotsResult({
// //     required this.userId,
// //     required this.branchId,
// //     required this.date,
// //     required this.slots,
// //   });

// //   factory SlotsResult.fromJson(Map<String, dynamic> json) => SlotsResult(
// //         userId: json["user_id"],
// //         branchId: json["branch_id"],
// //         date: DateTime.parse(json["date"]),
// //         slots: SlotsResult.fromJson(json["slots"]),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "user_id": userId,
// //         "branch_id": branchId,
// //         "date":
// //             "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
// //         "slots": slots.toJson(),
// //       };
// // }

// // class Slots {
// //   String the0815;
// //   String the0915;
// //   String the0800;
// //   String the0845;
// //   String the0945;
// //   String the0900;
// //   String the0830;
// //   String the0930;
// //   String the1300;
// //   String the1100;
// //   String the1345;
// //   String the1315;
// //   String the1330;

// //   Slots({
// //     required this.the0815,
// //     required this.the0915,
// //     required this.the0800,
// //     required this.the0845,
// //     required this.the0945,
// //     required this.the0900,
// //     required this.the0830,
// //     required this.the0930,
// //     required this.the1300,
// //     required this.the1100,
// //     required this.the1345,
// //     required this.the1315,
// //     required this.the1330,
// //   });

// //   factory Slots.fromJson(Map<String, dynamic> json) => Slots(
// //         the0815: json["08:15"],
// //         the0915: json["09:15"],
// //         the0800: json["08:00"],
// //         the0845: json["08:45"],
// //         the0945: json["09:45"],
// //         the0900: json["09:00"],
// //         the0830: json["08:30"],
// //         the0930: json["09:30"],
// //         the1300: json["13:00"],
// //         the1100: json["11:00"],
// //         the1345: json["13:45"],
// //         the1315: json["13:15"],
// //         the1330: json["13:30"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "08:15": the0815,
// //         "09:15": the0915,
// //         "08:00": the0800,
// //         "08:45": the0845,
// //         "09:45": the0945,
// //         "09:00": the0900,
// //         "08:30": the0830,
// //         "09:30": the0930,
// //         "13:00": the1300,
// //         "11:00": the1100,
// //         "13:45": the1345,
// //         "13:15": the1315,
// //         "13:30": the1330,
// //       };
// // }

// // To parse this JSON data, do
// //
// //     final slotsListModel = slotsListModelFromJson(jsonString);

// // SlotsListModel slotsListModelFromJson(String str) => SlotsListModel.fromJson(json.decode(str));

// // String slotsListModelToJson(SlotsListModel data) => json.encode(data.toJson());

// class SlotsListModel {
//   String status;
//   String message;
//   List<Result> slotsresult;

//   SlotsListModel({
//     required this.status,
//     required this.message,
//     required this.slotsresult,
//   });

//   factory SlotsListModel.fromJson(Map<String, dynamic> json) => SlotsListModel(
//         status: json["status"],
//         message: json["message"],
//         result: List<Slotsresult>.from(
//             json["slotsresult"].map((x) => Slotsresult.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "slotsresult": List<dynamic>.from(slotsresult.map((x) => x.toJson())),
//       };
// }

// class Slotsresult {
//   String userId;
//   String branchId;
//   DateTime date;
//   Slots slots;

//   Slotsresult({
//     required this.userId,
//     required this.branchId,
//     required this.date,
//     required this.slots,
//   });

//   factory Slotsresult.fromJson(Map<String, dynamic> json) => Slotsresult(
//         userId: json["user_id"],
//         branchId: json["branch_id"],
//         date: DateTime.parse(json["date"]),
//         slots: Slots.fromJson(json["slots"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "branch_id": branchId,
//         "date":
//             "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "slots": slots.toJson(),
//       };
// }

// class Slots {
//   String the0945;
//   String the1000;
//   String the1015;
//   String the1030;
//   String the1100;
//   String the1115;
//   String the1130;
//   String the1145;
//   String the1300;
//   String the1400;
//   String the1415;
//   String the1430;
//   String the1445;

//   Slots({
//     required this.the0945,
//     required this.the1000,
//     required this.the1015,
//     required this.the1030,
//     required this.the1100,
//     required this.the1115,
//     required this.the1130,
//     required this.the1145,
//     required this.the1300,
//     required this.the1400,
//     required this.the1415,
//     required this.the1430,
//     required this.the1445,
//   });

//   factory Slots.fromJson(Map<String, dynamic> json) => Slots(
//         the0945: json["09:45"],
//         the1000: json["10:00"],
//         the1015: json["10:15"],
//         the1030: json["10:30"],
//         the1100: json["11:00"],
//         the1115: json["11:15"],
//         the1130: json["11:30"],
//         the1145: json["11:45"],
//         the1300: json["13:00"],
//         the1400: json["14:00"],
//         the1415: json["14:15"],
//         the1430: json["14:30"],
//         the1445: json["14:45"],
//       );

//   Map<String, dynamic> toJson() => {
//         "09:45": the0945,
//         "10:00": the1000,
//         "10:15": the1015,
//         "10:30": the1030,
//         "11:00": the1100,
//         "11:15": the1115,
//         "11:30": the1130,
//         "11:45": the1145,
//         "13:00": the1300,
//         "14:00": the1400,
//         "14:15": the1415,
//         "14:30": the1430,
//         "14:45": the1445,
//       };
// }

// To parse this JSON data, do
//
//     final slotsListModel = slotsListModelFromJson(jsonString);


// SlotsListModel slotsListModelFromJson(String str) => SlotsListModel.fromJson(json.decode(str));

// String slotsListModelToJson(SlotsListModel data) => json.encode(data.toJson());

class SlotsListModel {
  String status;
  String message;
  List<Result> result;

  SlotsListModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory SlotsListModel.fromJson(Map<String, dynamic> json) => SlotsListModel(
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
  String userId;
  String branchId;
  DateTime date;
  Slots slots;

  Result({
    required this.userId,
    required this.branchId,
    required this.date,
    required this.slots,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        userId: json["user_id"],
        branchId: json["branch_id"],
        date: DateTime.parse(json["date"]),
        slots: Slots.fromJson(json["slots"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "branch_id": branchId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "slots": slots.toJson(),
      };
}

class Slots {
  String the0945;
  String the1000;
  String the1015;
  String the1030;
  String the1100;
  String the1115;
  String the1130;
  String the1145;
  String the1300;
  String the1400;
  String the1415;
  String the1430;
  String the1445;

  Slots({
    required this.the0945,
    required this.the1000,
    required this.the1015,
    required this.the1030,
    required this.the1100,
    required this.the1115,
    required this.the1130,
    required this.the1145,
    required this.the1300,
    required this.the1400,
    required this.the1415,
    required this.the1430,
    required this.the1445,
  });

  factory Slots.fromJson(Map<String, dynamic> json) => Slots(
        the0945: json["09:45"],
        the1000: json["10:00"],
        the1015: json["10:15"],
        the1030: json["10:30"],
        the1100: json["11:00"],
        the1115: json["11:15"],
        the1130: json["11:30"],
        the1145: json["11:45"],
        the1300: json["13:00"],
        the1400: json["14:00"],
        the1415: json["14:15"],
        the1430: json["14:30"],
        the1445: json["14:45"],
      );

  Map<String, dynamic> toJson() => {
        "09:45": the0945,
        "10:00": the1000,
        "10:15": the1015,
        "10:30": the1030,
        "11:00": the1100,
        "11:15": the1115,
        "11:30": the1130,
        "11:45": the1145,
        "13:00": the1300,
        "14:00": the1400,
        "14:15": the1415,
        "14:30": the1430,
        "14:45": the1445,
      };
}
