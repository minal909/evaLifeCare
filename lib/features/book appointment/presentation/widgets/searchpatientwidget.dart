// import 'package:eva_life_care/features/book%20appointment/data/models/existing_patient_model.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_doctor_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

// class NetworkTypeAheadPage extends StatelessWidget {
//   const NetworkTypeAheadPage({super.key});

//   @override
//   Widget build(BuildContext context) => TypeAheadField<Result?>(
//         suggestionsCallback: ListDoctorProvider.getUserSuggestions,
//         itemBuilder: (context, Result? suggestion) {
//           final user = suggestion!;

//           List pName = [];
//           String name = '';
//           name = user.firstname + user.lastname;

//           pName.add(name);

//           return ListTile(
//             title: Text(name),
//           );
//         },
//         onSelected: (Result? value) {},
//       );
// }
