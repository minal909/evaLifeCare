// import 'package:eva_life_care/features/book%20appointment/data/models/list_service_model.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/pages/apt_date_time.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/pages/apt_details.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/pages/basic_details.dart';
// import 'package:flutter/material.dart';

// class BookAppointment extends StatefulWidget {
//   List<Result> serviceResult;
//   List idprooflist;
//   List services;
//   BookAppointment(this.serviceResult, this.idprooflist, this.services,
//       {super.key});

//   @override
//   _BookAppointmentState createState() =>
//       _BookAppointmentState(serviceResult, idprooflist, services);
// }

// class _BookAppointmentState extends State<BookAppointment> {
//   getListDoc(ListDoctorEntity? entityDoctor) {
//     for (int i = 0; i <= entityDoctor!.result.length - 1; i++) {
//       doctorList1.add(
//           '${entityDoctor.result[i].firstname} ${entityDoctor.result[i].lastname}');
//     }
//     setState(() {
//       doctorList = doctorList1;
//     });
//     print('doctor list new ++++++++++++++++ --------------$doctorList');
//   }

//   getDoc(String service) {
//     doctorList = ['Select doctor'];
//     doctorIs = 'Select doctor';
//     doctorList1 = ['Select doctor'];
//     ListDoctorEntity? doctorEntity;
//     for (int i = 0; i <= sList.length - 1; i++) {
//       if (sList[i].name == service) {
//         sid = sList[i].id;
//         charges.text = sList[i].amount.toString();
//         print('service id is===================$sid');
//       }
//     }
//     Provider.of<ListDoctorProvider>(context, listen: false)
//         .eitherFailureOrListDoctor(serviceId: sid, clientid: clientID);
//     doctorEntity =
//         Provider.of<ListDoctorProvider>(context, listen: false).listdoctor;
//     getListDoc(doctorEntity);
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Container(
//           height: MediaQuery.of(context).size.height * 0.08,
//           width: MediaQuery.of(context).size.width * 0.9,
//           decoration: const BoxDecoration(color: Colors.white),
//           child: DropdownButtonFormField(
//               style: Theme.of(context).textTheme.bodyMedium,
//               decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   labelText: "Service",
//                   labelStyle: Theme.of(context).textTheme.bodySmall,
//                   hintText: "Service",
//                   hintStyle: Theme.of(context).textTheme.bodySmall,
//                   errorStyle: const TextStyle(fontSize: 0.05),
//                   border: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)))),
//               items: servicelist12
//                   .map((item) => DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(
//                           item,
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ))
//                   .toList(),
//               value: thisservice,
//               onChanged: (value) async {
//                 getDoc(value.toString());
//                 setState(() {
//                   thisservice = value;
//                 });
//                 serviceChanged = true;
//               })),
//       Container(
//         height: MediaQuery.of(context).size.height * 0.08,
//         width: MediaQuery.of(context).size.width * 0.9,
//         decoration: const BoxDecoration(color: Colors.white),
//         child: DropdownButtonFormField(
//           style: Theme.of(context).textTheme.bodyMedium,
//           decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//               labelText: "Select doctor",
//               labelStyle: Theme.of(context).textTheme.bodySmall,
//               hintText: 'Select doctor',
//               hintStyle: Theme.of(context).textTheme.bodySmall,
//               errorStyle: const TextStyle(fontSize: 0.05),
//               border: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(4)))),
//           items: doctorList
//               .map((item) => DropdownMenuItem<String>(
//                     value: item,
//                     child: Text(
//                       item,
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                   ))
//               .toList(),
//           value: doctorIs,
//           onChanged: (value) {
//             doctorval = value.toString();
//             serviceChanged = false;
//           },
//         ),
//       ),
//     ]);
//   }
// }
