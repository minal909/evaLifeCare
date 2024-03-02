// // ignore_for_file: unrelated_type_equality_checks

// import 'package:dio/dio.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_doctor_provider.dart';
// import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
// import 'package:eva_life_care/features/my_profile/presentation/widgets/userProfileWidget/my_textformfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // ignore: must_be_immutable
// int proofId = 0;
// String? selectedGender;
// var formKey1 = GlobalKey<FormState>();
// bool existingPatient = false;
// int patientId = 0;

// // ignore: must_be_immutable
// class BasicDetails extends StatefulWidget {
//   Widget widget1;
//   final TextEditingController typeAheadController;
//   final TextEditingController typeAheadController2;
//   TextEditingController firstname;
//   TextEditingController lastname;

//   TextEditingController age;

//   TextEditingController email;
//   TextEditingController autoaddress;

//   TextEditingController username;

//   TextEditingController address;
//   TextEditingController city;
//   TextEditingController state;
//   TextEditingController country;

//   TextEditingController zipcode;
//   TextEditingController idnumber;

//   List idprooflist;
//   String idName;
//   String? idselected;

//   BasicDetails(
//       this.widget1,
//       this.typeAheadController,
//       this.typeAheadController2,
//       this.firstname,
//       this.lastname,
//       this.age,
//       this.email,
//       this.autoaddress,
//       this.username,
//       this.address,
//       this.city,
//       this.state,
//       this.country,
//       this.zipcode,
//       this.idnumber,
//       this.idprooflist,
//       this.idName,
//       this.idselected,
//       {super.key});

//   @override
//   // ignore: no_logic_in_create_state
//   BasicDetailsState createState() => BasicDetailsState(
//       widget1,
//       typeAheadController,
//       typeAheadController2,
//       firstname,
//       lastname,
//       age,
//       email,
//       autoaddress,
//       username,
//       address,
//       city,
//       state,
//       country,
//       zipcode,
//       idnumber,
//       idprooflist,
//       idName,
//       idselected);
// }

// // Create a corresponding State class.
// // This class holds data related to the form.
// class BasicDetailsState extends State<BasicDetails>
//     with AutomaticKeepAliveClientMixin {

//   @override
//   bool get wantKeepAlive => true;
//   Widget widget1;
//   List<Widget> widg1 = [];

//   final TextEditingController typeAheadController;
//   final TextEditingController typeAheadController2;
//   TextEditingController firstname;
//   TextEditingController lastname;

//   TextEditingController age;

//   TextEditingController email;
//   TextEditingController autoaddress;

//   TextEditingController username;

//   TextEditingController address;
//   TextEditingController city;
//   TextEditingController state;
//   TextEditingController country;

//   TextEditingController zipcode;
//   TextEditingController idnumber;
//   List idprooflist = [];
//   String idName = '';
//   String? idselected;

//   BasicDetailsState(
//     this.widget1,
//     this.typeAheadController,
//     this.typeAheadController2,
//     this.firstname,
//     this.lastname,
//     this.age,
//     this.email,
//     this.autoaddress,
//     this.username,
//     this.address,
//     this.city,
//     this.state,
//     this.country,
//     this.zipcode,
//     this.idnumber,
//     this.idprooflist,
//     this.idName,
//     this.idselected,
//   );
//   // TextEditingController mobile = TextEditingController();

//   final List<String> listitems = [
//     'Male',
//     'Female',
//   ];
//   String selectedValue = '';

//   String selectedIdProof = '';
//   String selectedService = '';
//   String selectedDesignation = '';
//   String selectedDepartment = '';
//   final TextEditingController textEditingController = TextEditingController();

//   FocusNode focusNode1 = FocusNode();
//   List<Widget> widgets = [];

//   // Create a global key that uniquely identifies the Form widget
//   // and allows validation of the form.
//   //
//   // Note: This is a GlobalKey<FormState>,
//   // not a GlobalKey<MyPofileWidgetState>.
//   MyProfileEntity? myprofile;
//   String theidis = '';
//   @override
//   void initState() {
//     typeAheadController2.text = '+91';
//     existingPatient = false;
//     init();
//     // TODO: implement initState
//     super.initState();
//     // storedContext = context;
//   }

//   init() {
//     searchPatient('');

//     theidis = idName;
//   }

//   String cognitoid = '';
//   int clientid = 0;
//   int userid = 0;

//   void getValues() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     clientid = prefs.getInt('clientId')!.toInt();
//     userid = prefs.getInt('userId')!.toInt();
//     cognitoid = prefs.getString("cognito_id").toString();

//     // selectedGender = widget.gender;

//     // '${widget.myprofile!.result.mobile.substring(0, 3)}${widget.myprofile!.result.mobile.substring(3)}';
//     // name.text = widget.firstName;
//     //   lastname.text = widget.lastName;
//     //   age1.text = widget.age;
//     //   print('age of widget====================================${widget.age}');
//     //   address1.text = widget.address1;
//     //   address2.text = widget.address2;
//     //   mobile.text = widget.mobile;
//     //   email.text = widget.email;
//     //   city.text = widget.city;
//     //   country.text = widget.country;
//     //   state.text = widget.state;
//     //   zipcode.text = widget.zipcode;
//     //   designation.text = widget.designation;
//     //   department.text = widget.department;
//     //   selectedService = widget.department;

//     // print(
//     //     'age value conrtoller---------------------${widget.myprofile!.result.age.toString()}');
//   }

//   List<Map<String, dynamic>> patients = [];

//   searchPatient(String mobile) async {
//     var provider = Provider.of<ListDoctorProvider>(context, listen: false);
//     final response = await provider.getUserSuggestions(mobile);

//     final r1 = response.result;

//     for (int i = 0; i <= r1.length - 1; i++) {
//       Map<String, dynamic> patientInfo = {
//         'id': r1[i].id,
//         'mobile': r1[i].mobile,
//         'firstname': r1[i].firstname,
//         'lastname': r1[i].lastname,
//         'age': r1[i].age,
//         'gender': r1[i].gender,
//         'email': r1[i].email,
//         'address1': r1[i].addressLine1,
//         'address2': r1[i].addressLine2,
//         'city': r1[i].city,
//         'country': r1[i].country,
//         'state': r1[i].state,
//         'zipcode': r1[i].zipCode,
//         'idproofid': r1[i].idProofTypeId,
//         'idproofnumber': r1[i].idProofNumber,
//       };
//       setState(() {
//         patients.add(patientInfo);
//       });
//     }
//   }

//   String extractSuggestionDisplay(String item) {
//     // Logic to display a specific part in the suggestion list
//     // For example, displaying characters from index 3 to 8
//     return item.substring(14); // Adjust this as per your requirement
//   }

//   String extractSelectedValueDisplay(String item) {
//     setState(() {});
//     // Logic to display a different part in the Autocomplete after selection
//     // For example, displaying characters from index 0 to 5
//     return item.substring(0, 13); // Adjust this as per your requirement
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size deviceSize = MediaQuery.of(context).size;
//     var screenOrientation = MediaQuery.orientationOf(context);
//     Widget sizedbox = SizedBox(
//       height: deviceSize.height * 0.04,
//     );
//     Widget sizedbox1 = SizedBox(
//       height: deviceSize.height * 0.001,
//     );
//     Widget sizedbox2 = SizedBox(
//       height: deviceSize.height * 0.01,
//     );
//     // myprofile = Provider.of<MyProfileProvider>(context).myProfile;
//     // Failure? failure = Provider.of<MyProfileProvider>(context).failure;
//     late Widget widget;
//     // mobile.text = '+199527796311';
//     List listIdProof = [];
//     String selVal = '';
//     listIdProof = idprooflist;
//     bool selected = false;

//     // // '${myprofile!.result.mobile.substring(0, 3)} ${myprofile!.result.mobile.substring(3)}';
//     // name.text =
//     //     'Test User'; // '${myprofile!.result.firstname} ${myprofile!.result.lastname}';
//     // age.text = '28';
//     // //  myprofile!.result.age.toString();
//     // email.text = 'user1@gamil.com';
//     // //  myprofile!.result.emailId;
//     // address.text =
//     //     '119, vision flora mall, Whistlemind Technologies'; // '${myprofile!.result.addressLine1} ${myprofile!.result.addressLine2}';
//     // state.text = 'Maharashtra';
//     // country.text = 'India';
//     // city.text = 'Pune'; // myprofile!.result.city;
//     // zipcode.text = '411012'; //  myprofile!.result.zipCode;
//     // designation.text = 'Manager'; //  myprofile!.result.designation;
//     // department.text = "IT"; // myprofile!.result.department;
//     //  myprofile!.result.gender;

//     Future<void> getPlaceDetails(String placeid, String apikey) async {
//       final Dio dio = Dio();

//       String finalurl =
//           'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$apikey';

//       final response = await dio.get(
//         finalurl,
//       );
//       List addressComponents = response.data['result']['address_components'];
//       for (int i = 0; i <= addressComponents.length; i++) {
//         // addressComponents[i]['types'][0] == 'locality'
//         //     ? city.text == addressComponents[i]['long_name'].toString()
//         // :
//         addressComponents[i]['types'][0] == 'postal_code'
//             ? zipcode.text = addressComponents[i]['long_name'].toString()
//             : addressComponents[i]['types'][0] == 'administrative_area_level_1'
//                 ? state.text = addressComponents[i]['long_name'].toString()
//                 : null;
//       }
//     }

//     // Build a Form widget using the _formKey created above.
//     super.build(context); // Ensure to call super.build

//     // ignore: deprecated_member_use
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => widget1));
//         return false;
//       },
//       child: SafeArea(
//           child: Scaffold(
//               // appBar: AppBar(
//               //   title: const Text('Book Appointment'),
//               // ),
//               body: widget = SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(
//               top: deviceSize.height * 0.04,
//               left: deviceSize.width * 0.025,
//               right: deviceSize.width * 0.025),
//           child: Center(
//             child: Form(
//               key: formKey1,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: deviceSize.width * 0.9,
//                     child: Row(
//                       children: <Widget>[
//                         SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.08,
//                             width: deviceSize.width * 0.18,
//                             child: TextFormField(
//                               textAlign: TextAlign
//                                   .center, // Set text alignment to center

//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter value';
//                                 }
//                                 return null; // Return null if the input is valid.
//                               },
//                               controller: typeAheadController2,
//                               style: Theme.of(context).textTheme.bodySmall,
//                               decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(4))),
//                             )),
//                         const Flexible(flex: 1, child: SizedBox()),
//                         Padding(
//                             padding:
//                                 EdgeInsets.only(left: deviceSize.width * 0.02),
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.08,
//                                     width: deviceSize.width * 0.7,
//                                     child: TypeAheadField(
//                                         emptyBuilder: (
//                                           context,
//                                         ) {
//                                           return Padding(
//                                             padding: const EdgeInsets.all(2),
//                                             child: Text(
//                                               'No patients found!',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .titleMedium,
//                                             ),
//                                           );
//                                         },
//                                         builder:
//                                             (context, controller, focusNode) {
//                                           return TextFormField(
//                                             inputFormatters: [
//                                               FilteringTextInputFormatter
//                                                   .digitsOnly,
//                                               LengthLimitingTextInputFormatter(
//                                                   10),
//                                             ],
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodySmall,
//                                             keyboardType: TextInputType.number,
//                                             controller: controller,
//                                             focusNode: focusNode,
//                                             autofocus: true,
//                                             decoration: InputDecoration(
//                                                 errorStyle: const TextStyle(
//                                                     fontSize: 0.05),
//                                                 hintText: 'mobile number',
//                                                 hintStyle: Theme.of(context)
//                                                     .textTheme
//                                                     .bodySmall,
//                                                 labelText: 'mobile number',
//                                                 labelStyle: Theme.of(context)
//                                                     .textTheme
//                                                     .bodySmall,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 16.0),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             4))),
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return 'Please enter value';
//                                               }
//                                               return null; // Return null if the input is valid.
//                                             },
//                                           );
//                                         },
//                                         controller: typeAheadController,
//                                         suggestionsCallback: (pattern) async {
//                                           return patients
//                                               .where((item) => item['mobile']
//                                                   .toString()
//                                                   .toLowerCase()
//                                                   .contains(
//                                                       pattern.toLowerCase()))
//                                               .toList();
//                                         },
//                                         itemBuilder: (context, patients) {
//                                           //       // Render list tiles for patients
//                                           String name = '';
//                                           name =
//                                               '${patients['firstname'] + " " + patients['lastname']}';

//                                           return ListTile(
//                                             title: Text(
//                                               name,
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodySmall,
//                                             ),
//                                           );
//                                         },

//                                         // Other properties for TypeAheadFieldr
//                                         // },
//                                         onSelected: (value) {
//                                           fillForm() {
//                                             String val = value['mobile'];
//                                             typeAheadController.text =
//                                                 val.substring(3, 13);
//                                             int docId = 0;
//                                             setState(() {
//                                               patientId = value['id'];
//                                               firstname.text =
//                                                   value['firstname'];
//                                               lastname.text = value['lastname'];
//                                               age.text =
//                                                   value['age'].toString();
//                                               // selectedGender = value['gender'].toString();
//                                               email.text = value['email'];
//                                               autoaddress.text =
//                                                   value['address1'];
//                                               address.text = value['address2'];
//                                               city.text = value['city'];
//                                               state.text = value['state'];
//                                               country.text = value['country'];
//                                               zipcode.text = value['zipcode'];
//                                               idnumber.text =
//                                                   value['idproofnumber'];
//                                               selectedGender = value['gender'];

//                                               value['idproofid'] == 1
//                                                   ? idselected = "Passport"
//                                                   : value['idproofid'] == 2
//                                                       ? idselected =
//                                                           "Aadhaar Card"
//                                                       : value['idproofid'] == 3
//                                                           ? idselected =
//                                                               "Driving License"
//                                                           : value['idproofid'] ==
//                                                                   4
//                                                               ? idselected =
//                                                                   "Voter Id"
//                                                               : value['idproofid'] ==
//                                                                       5
//                                                                   ? idselected =
//                                                                       "PAN Card"
//                                                                   : value['idproofid'] ==
//                                                                           6
//                                                                       ? idselected =
//                                                                           "Government Issued ID"
//                                                                       : null;
//                                               proofId = value['idproofid'];
//                                               existingPatient = true;
//                                             });
//                                             Navigator.pop(context);
//                                             // Navigator.of(context)
//                                             //     .pop(false);
//                                           }

//                                           showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             4), // Adjust the radius here
//                                                   ),
//                                                   title: const Text(
//                                                     'Confirmation',
//                                                   ),
//                                                   content: const Text(
//                                                       'Do you want to book appointment for same patient ?'),
//                                                   actions: <Widget>[
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         // Perform action when Yes is pressed
//                                                         fillForm();
//                                                       },
//                                                       child: const Text('Yes'),
//                                                     ),
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         String val =
//                                                             value['mobile'];
//                                                         typeAheadController
//                                                                 .text =
//                                                             val.substring(
//                                                                 3, 13);
//                                                         // Perform action when No is pressed
//                                                         // Navigator.of(context)
//                                                         //     .pop(false);
//                                                         Navigator.pop(context);
//                                                       },
//                                                       child: const Text('No'),
//                                                     ),
//                                                   ],
//                                                 );

//                                                 // selectedIdProof =
//                                                 //     value['idproofid'].toString();

//                                                 // Handle the selected suggestion
//                                               });
//                                         }))
//                               ],
//                             )),
//                       ],
//                     ),
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox1,
//                   textformfield(
//                     firstname,
//                     'First name',
//                     'First name',
//                     TextInputType.name,
//                     screenOrientation.toString(),
//                     (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter value';
//                       }
//                       return null;
//                     },
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   textformfield(
//                     lastname,
//                     'Last name',
//                     'Last name',
//                     TextInputType.name,
//                     screenOrientation.toString(),
//                     (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter value';
//                       }
//                       return null;
//                     },
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   SizedBox(
//                     width: deviceSize.width * 0.9,
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: deviceSize.width * 0.42,
//                           child: textformfield(
//                             age,
//                             'Age',
//                             'Age',
//                             TextInputType.number,
//                             screenOrientation.toString(),
//                             (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter value';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const Expanded(child: SizedBox()),
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.08,
//                           width: deviceSize.width * 0.42,
//                           decoration: const BoxDecoration(color: Colors.white),
//                           child: DropdownButtonFormField(
//                             style: Theme.of(context).textTheme.bodyMedium,
//                             decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0),
//                                 labelText: "Gender",
//                                 labelStyle:
//                                     Theme.of(context).textTheme.bodySmall,
//                                 errorStyle: const TextStyle(fontSize: 0.05),
//                                 border: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4)))),
//                             items: listitems
//                                 .map((item) => DropdownMenuItem<String>(
//                                       value: item,
//                                       child: Text(
//                                         item,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall,
//                                       ),
//                                     ))
//                                 .toList(),
//                             value: selectedGender,
//                             onChanged: (value) {
//                               selectedGender = value as String;
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter value';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   textformfield(
//                     email,
//                     'Email Address',
//                     'Email Address',
//                     TextInputType.text,
//                     screenOrientation.toString(),
//                     (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email address';
//                       }
//                       // Use a regular expression for email validation
//                       // This regex is a simplified version and may not cover all edge cases
//                       if (!RegExp(r'^[\w\+-]+(\.[\w\+-]+)*@[\w-]+(\.[\w-]+)+$')
//                           .hasMatch(value)) {
//                         return 'Please enter a valid email address';
//                       }
//                       return null; // Return null for valid input
//                     },
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : const SizedBox(),
//                   SizedBox(
//                       height: screenOrientation.toString() ==
//                               'Orientation.landscape'
//                           ? MediaQuery.of(context).size.height * 0.1
//                           : MediaQuery.of(context).size.height * 0.09,
//                       width: screenOrientation.toString() ==
//                               'Orientation.landscape'
//                           ? deviceSize.width * 0.925
//                           : deviceSize.width * 0.94,
//                       // screenOrientation.toString() == 'Orientation.portrait'
//                       //      MediaQuery.of(context).size.width * 0.82
//                       //     : MediaQuery.of(context).size.width * 0.8,
//                       child: GooglePlaceAutoCompleteTextField(
//                         textEditingController: autoaddress,
//                         textStyle:
//                             Theme.of(context).textTheme.bodySmall as TextStyle,
//                         googleAPIKey: "AIzaSyDZsx7mv_Vo_Ro4NkknYwF0rqC9ZY2-qxE",

//                         inputDecoration: InputDecoration(
//                           hintText: 'Address line 1',
//                           hintStyle: Theme.of(context).textTheme.bodySmall,
//                           labelText: 'Address line 1',
//                           labelStyle: Theme.of(context).textTheme.bodySmall,
//                           contentPadding:
//                               const EdgeInsets.symmetric(horizontal: 16.0),
//                           border: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(4)),
//                               borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 162, 155, 155))),
//                         ),

//                         boxDecoration: const BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide.none,
//                                 top: BorderSide.none,
//                                 right: BorderSide.none,
//                                 left: BorderSide.none)),
//                         countries: const [
//                           "in",
//                           "fr"
//                         ], // optional by default null is set
//                         isLatLngRequired:
//                             true, // if you required coordinates from place detail
//                         getPlaceDetailWithLatLng: (Prediction prediction) {
//                           // this method will return latlng with place detail
//                         }, // this callback is called when isLatLngRequired is true
//                         itemClick: (Prediction prediction) {
//                           autoaddress.text =
//                               prediction.description!.split(',').first;
//                           address.text = prediction
//                                       .structuredFormatting!.secondaryText!
//                                       .split(',')
//                                       .length <=
//                                   3
//                               ? '  '
//                               :
//                               // prediction
//                               //     .structuredFormatting!.secondaryText!;
//                               '${prediction.structuredFormatting!.secondaryText!.split(',')[1]} ${prediction.structuredFormatting!.secondaryText!.split(',')[2]}';

//                           country.text =
//                               prediction.description!.split(',').last;
//                           city.text = prediction.description!
//                                       .split(',')
//                                       .length <=
//                                   3
//                               ? prediction.description!.split(',')[
//                                   prediction.description!.split(',').length - 2]
//                               : prediction.description!.split(',')[prediction
//                                       .description!
//                                       .split(',')
//                                       .length -
//                                   3]; // state.text = prediction.description!.split(',')[
//                           //     prediction.description!.split(',').length -
//                           //         2];
//                           getPlaceDetails(prediction.placeId.toString(),
//                               "AIzaSyDZsx7mv_Vo_Ro4NkknYwF0rqC9ZY2-qxE");

//                           autoaddress.selection = TextSelection.fromPosition(
//                               TextPosition(
//                                   offset: prediction.description!
//                                       .split(',')
//                                       .first
//                                       .length));
//                         },
//                         // if we want to make custom list item builder
//                         itemBuilder: (context, index, Prediction prediction) {
//                           return Container(
//                             height: screenOrientation.toString() ==
//                                     'Orientation.landscape'
//                                 ? MediaQuery.of(context).size.height * 0.1
//                                 : MediaQuery.of(context).size.height * 0.09,
//                             width: screenOrientation.toString() ==
//                                     'Orientation.landscape'
//                                 ? deviceSize.width * 0.925
//                                 : deviceSize.width * 0.94,
//                             decoration: const BoxDecoration(boxShadow: [
//                               BoxShadow(
//                                   blurStyle: BlurStyle.outer,
//                                   blurRadius: 1,
//                                   color: Color.fromARGB(255, 196, 248, 226))
//                             ], color: Color.fromARGB(255, 220, 241, 230)),
//                             padding: const EdgeInsets.all(10),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.location_on,
//                                   color: Color.fromARGB(255, 225, 87, 77),
//                                 ),
//                                 const SizedBox(
//                                   width: 7,
//                                 ),
//                                 Expanded(
//                                     child: Text(
//                                   prediction.description ?? "",
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 ))
//                               ],
//                             ),
//                           );
//                         },
//                         // if you want to add seperator between list items
//                         seperatedBuilder: const Divider(),

//                         // want to show close icon
//                         isCrossBtnShown: false,
//                       )),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   MyTextFormField(
//                     controller: address,
//                     labelTextl: 'Address line2',
//                     hintText: 'Address line2',
//                     keyboardType: TextInputType.streetAddress,
//                     readonly: false,
//                     inputLenght: LengthLimitingTextInputFormatter(50),

//                     // onChanged: (value) {
//                     //   address2.text = value;
//                     // },
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   MyTextFormField(
//                     controller: city,
//                     labelTextl: 'City',
//                     hintText: 'City',
//                     keyboardType: TextInputType.streetAddress,
//                     readonly: false,
//                     inputLenght: LengthLimitingTextInputFormatter(20),

//                     // onChanged: (value) {
//                     //   city.text == value;
//                     // },
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   MyTextFormField(
//                     controller: state,
//                     labelTextl: 'State',
//                     hintText: 'State',
//                     keyboardType: TextInputType.streetAddress,
//                     readonly: false,
//                     inputLenght: LengthLimitingTextInputFormatter(20),

//                     // onChanged: (value) {
//                     //   address2.text = value;
//                     // },
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   MyTextFormField(
//                     controller: country,
//                     labelTextl: 'Country',
//                     hintText: 'Country',
//                     keyboardType: TextInputType.streetAddress,
//                     readonly: false,
//                     inputLenght: LengthLimitingTextInputFormatter(20),

//                     // onChanged: (value) {
//                     //   address2.text = value;
//                     // },
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   MyTextFormField(
//                     controller: zipcode,
//                     labelTextl: 'Zip code',
//                     hintText: 'Zip code',
//                     keyboardType: TextInputType.number,
//                     readonly: false,
//                     inputLenght: LengthLimitingTextInputFormatter(20),

//                     // onChanged: (value) {
//                     //   zipcode.text == value;
//                     // },
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   Container(
//                     height:
//                         screenOrientation.toString() == 'Orientation.landscape'
//                             ? MediaQuery.of(context).size.height * 0.08
//                             : MediaQuery.of(context).size.height * 0.07,
//                     width: deviceSize.width * 0.9,
//                     //  MediaQuery.of(context).size.height > 650 &&
//                     //         screenOrientation.toString() == 'Orientation.portait'
//                     //      MediaQuery.of(context).size.width * 0.9
//                     //     : MediaQuery.of(context).size.width * 0.775,
//                     decoration: const BoxDecoration(color: Colors.white),
//                     child: DropdownButtonFormField(
//                       style: Theme.of(context).textTheme.bodySmall,
//                       decoration: InputDecoration(
//                           contentPadding:
//                               const EdgeInsets.symmetric(horizontal: 16.0),
//                           labelText: "Id proof type",
//                           hintText: 'Id proof type',
//                           labelStyle: Theme.of(context).textTheme.bodySmall,
//                           errorStyle: const TextStyle(fontSize: 0.05),
//                           border: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(4)))),
//                       items: listIdProof
//                           .map((item) => DropdownMenuItem<String>(
//                                 value: item,
//                                 child: Text(
//                                   item,
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 ),
//                               ))
//                           .toList(),
//                       value: idselected,
//                       onChanged: (value) {
//                         idselected = value as String;

//                         idselected == "Passport"
//                             ? proofId = 1
//                             : idselected == "Aadhaar Card"
//                                 ? proofId = 2
//                                 : idselected == "Driving License"
//                                     ? proofId = 3
//                                     : idselected == "Voter Id"
//                                         ? proofId = 4
//                                         : idselected == "PAN Card"
//                                             ? proofId = 5
//                                             : idselected ==
//                                                     "Government Issued ID"
//                                                 ? proofId = 6
//                                                 : null;
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter value';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   MyTextFormField(
//                     controller: idnumber,
//                     labelTextl: 'ID proof number',
//                     hintText: 'ID proof number',
//                     keyboardType: TextInputType.streetAddress,
//                     readonly: false,
//                     inputLenght: LengthLimitingTextInputFormatter(20),

//                     // onChanged: (value) {
//                     //   zipcode.text == value;
//                     // },
//                   ),
//                   screenOrientation.toString() == 'Orientation.landscape'
//                       ? sizedbox
//                       : sizedbox2,
//                   Padding(
//                     padding: EdgeInsets.only(bottom: deviceSize.height * 0.02),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           width: deviceSize.width * 0.3,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   // Color.fromARGB(255, 7, 176, 150),
//                                   Theme.of(context).colorScheme.secondary,
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(8)),
//                               ),
//                             ),
//                             onPressed: () {
//                               // Validate returns true if the form is valid, or false otherwise.
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => widget1));
//                             },
//                             child: const Text(
//                               'Cancel',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: deviceSize.width * 0.3,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   // Color.fromARGB(255, 7, 176, 150),
//                                   Theme.of(context).colorScheme.onPrimary,
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(8)),
//                               ),
//                             ),
//                             onPressed: () {
//                               // Validate returns true if the form is valid, or false otherwise.
//                               if (formKey1.currentState!.validate()) {
//                                 // If the form is valid, display a snackbar. In the real world,
//                                 // you'd often call a server or save the information in a database.

//                                 DefaultTabController.of(context).animateTo(1);
//                               }
//                             },
//                             child: const Text(
//                               'Next',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       )
//               // : failure != null
//               //     ? widget = Expanded(
//               //         child: Center(
//               //           child: Text(
//               //             failure.errorMessage,
//               //             style: const TextStyle(fontSize: 20),
//               //           ),
//               //         ),
//               //       )
//               //     : widget = const Expanded(
//               //         child: Center(
//               //           child: CircularProgressIndicator(
//               //             backgroundColor: Colors.white,
//               //             color: Colors.orangeAccent,
//               //           ),
//               //         ),
//               //       )
//               )),
//     );
//   }

//   Widget textformfield(
//           TextEditingController controller,
//           String labelText,
//           String hintText,
//           final TextInputType keyboardType,
//           String orientation,
//           final String? Function(String?) validationFunction) =>
//       SizedBox(
//         height: orientation == 'Orientation.landscape'
//             ? MediaQuery.of(context).size.height * 0.08
//             : MediaQuery.of(context).size.height * 0.07,
//         width: MediaQuery.of(context).size.width * 0.9,

//         //  MediaQuery.of(context).size.height > 650 &&
//         //         orientation == 'Orientation.portait'
//         //      MediaQuery.of(context).size.width * 0.9
//         //     : MediaQuery.of(context).size.width * 0.775,
//         child: TextFormField(
//           style: Theme.of(context).textTheme.bodySmall,
//           controller: controller,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             labelText: labelText,
//             labelStyle: Theme.of(context).textTheme.bodySmall,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//             errorStyle: const TextStyle(fontSize: 0.05),
//             border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(4))),
//           ),
//           // The validator receives the text that the user has entered.
//           validator: validationFunction,
//         ),
//       );
// }

import 'package:dio/dio.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_doctor_provider.dart';
import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
import 'package:eva_life_care/features/my_profile/presentation/widgets/userProfileWidget/my_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
int proofId = 0;
String? selectedGender;
var formkey1 = GlobalKey<FormState>();
bool existingPatient = false;
int patientId = 0;

// ignore: must_be_immutable
class BasicDetails extends StatefulWidget {
  Widget widget1;
  final TextEditingController typeAheadController;
  final TextEditingController typeAheadController2;
  TextEditingController firstname;
  TextEditingController lastname;

  TextEditingController age;

  TextEditingController email;
  TextEditingController autoaddress;

  TextEditingController username;

  TextEditingController address;
  TextEditingController city;
  TextEditingController state;
  TextEditingController country;

  TextEditingController zipcode;
  TextEditingController idnumber;

  List idprooflist;
  String idName;
  String? idselected;

  BasicDetails(
      this.widget1,
      this.typeAheadController,
      this.typeAheadController2,
      this.firstname,
      this.lastname,
      this.age,
      this.email,
      this.autoaddress,
      this.username,
      this.address,
      this.city,
      this.state,
      this.country,
      this.zipcode,
      this.idnumber,
      this.idprooflist,
      this.idName,
      this.idselected,
      {super.key});

  @override
  // ignore: no_logic_in_create_state
  BasicDetailsState createState() => BasicDetailsState(
      widget1,
      typeAheadController,
      typeAheadController2,
      firstname,
      lastname,
      age,
      email,
      autoaddress,
      username,
      address,
      city,
      state,
      country,
      zipcode,
      idnumber,
      idprooflist,
      idName,
      idselected);
}

// Create a corresponding State class.
// This class holds data related to the form.
class BasicDetailsState extends State<BasicDetails>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Widget widget1;
  List<Widget> widg1 = [];

  final TextEditingController typeAheadController;
  final TextEditingController typeAheadController2;
  TextEditingController firstname;
  TextEditingController lastname;

  TextEditingController age;

  TextEditingController email;
  TextEditingController autoaddress;

  TextEditingController username;

  TextEditingController address;
  TextEditingController city;
  TextEditingController state;
  TextEditingController country;

  TextEditingController zipcode;
  TextEditingController idnumber;
  List idprooflist = [];
  String idName = '';
  String? idselected;

  BasicDetailsState(
    this.widget1,
    this.typeAheadController,
    this.typeAheadController2,
    this.firstname,
    this.lastname,
    this.age,
    this.email,
    this.autoaddress,
    this.username,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.idnumber,
    this.idprooflist,
    this.idName,
    this.idselected,
  );
  // TextEditingController mobile = TextEditingController();

  final List<String> listitems = [
    'Male',
    'Female',
  ];
  String selectedValue = '';

  String selectedIdProof = '';
  String selectedService = '';
  String selectedDesignation = '';
  String selectedDepartment = '';
  final TextEditingController textEditingController = TextEditingController();

  FocusNode focusNode1 = FocusNode();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyPofileWidgetState>.
  MyProfileEntity? myprofile;
  String theidis = '';
  @override
  void initState() {
    typeAheadController2.text = '+91';
    existingPatient = false;
    init();
    // TODO: implement initState
    super.initState();
    // storedContext = context;
  }

  init() {
    searchPatient('');

    theidis = idName;
  }

  String cognitoid = '';
  int clientid = 0;
  int userid = 0;

  void getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientid = prefs.getInt('clientId')!.toInt();
    userid = prefs.getInt('userId')!.toInt();
    cognitoid = prefs.getString("cognito_id").toString();

    // selectedGender = widget.gender;

    // '${widget.myprofile!.result.mobile.substring(0, 3)}${widget.myprofile!.result.mobile.substring(3)}';
    // name.text = widget.firstName;
    //   lastname.text = widget.lastName;
    //   age1.text = widget.age;
    //   print('age of widget====================================${widget.age}');
    //   address1.text = widget.address1;
    //   address2.text = widget.address2;
    //   mobile.text = widget.mobile;
    //   email.text = widget.email;
    //   city.text = widget.city;
    //   country.text = widget.country;
    //   state.text = widget.state;
    //   zipcode.text = widget.zipcode;
    //   designation.text = widget.designation;
    //   department.text = widget.department;
    //   selectedService = widget.department;

    // print(
    //     'age value conrtoller---------------------${widget.myprofile!.result.age.toString()}');
  }

  List<Map<String, dynamic>> patients = [];

  searchPatient(String mobile) async {
    var provider = Provider.of<ListDoctorProvider>(context, listen: false);
    final response = await provider.getUserSuggestions(mobile);

    final r1 = response.result;

    for (int i = 0; i <= r1.length - 1; i++) {
      Map<String, dynamic> patientInfo = {
        'id': r1[i].id,
        'mobile': r1[i].mobile,
        'firstname': r1[i].firstname,
        'lastname': r1[i].lastname,
        'age': r1[i].age,
        'gender': r1[i].gender,
        'email': r1[i].email,
        'address1': r1[i].addressLine1,
        'address2': r1[i].addressLine2,
        'city': r1[i].city,
        'country': r1[i].country,
        'state': r1[i].state,
        'zipcode': r1[i].zipCode,
        'idproofid': r1[i].idProofTypeId,
        'idproofnumber': r1[i].idProofNumber,
      };
      setState(() {
        patients.add(patientInfo);
      });
    }
  }

  String extractSuggestionDisplay(String item) {
    // Logic to display a specific part in the suggestion list
    // For example, displaying characters from index 3 to 8
    return item.substring(14); // Adjust this as per your requirement
  }

  String extractSelectedValueDisplay(String item) {
    setState(() {});
    // Logic to display a different part in the Autocomplete after selection
    // For example, displaying characters from index 0 to 5
    return item.substring(0, 13); // Adjust this as per your requirement
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    var screenOrientation = MediaQuery.orientationOf(context);
    Widget sizedbox = SizedBox(
      height: deviceSize.height * 0.04,
    );
    Widget sizedbox1 = SizedBox(
      height: deviceSize.height * 0.001,
    );
    Widget sizedbox2 = SizedBox(
      height: deviceSize.height * 0.01,
    );
    // myprofile = Provider.of<MyProfileProvider>(context).myProfile;
    // Failure? failure = Provider.of<MyProfileProvider>(context).failure;
    late Widget widget;
    // mobile.text = '+199527796311';
    List listIdProof = [];
    String selVal = '';
    listIdProof = idprooflist;
    bool selected = false;

    // // '${myprofile!.result.mobile.substring(0, 3)} ${myprofile!.result.mobile.substring(3)}';
    // name.text =
    //     'Test User'; // '${myprofile!.result.firstname} ${myprofile!.result.lastname}';
    // age.text = '28';
    // //  myprofile!.result.age.toString();
    // email.text = 'user1@gamil.com';
    // //  myprofile!.result.emailId;
    // address.text =
    //     '119, vision flora mall, Whistlemind Technologies'; // '${myprofile!.result.addressLine1} ${myprofile!.result.addressLine2}';
    // state.text = 'Maharashtra';
    // country.text = 'India';
    // city.text = 'Pune'; // myprofile!.result.city;
    // zipcode.text = '411012'; //  myprofile!.result.zipCode;
    // designation.text = 'Manager'; //  myprofile!.result.designation;
    // department.text = "IT"; // myprofile!.result.department;
    //  myprofile!.result.gender;

    Future<void> getPlaceDetails(String placeid, String apikey) async {
      final Dio dio = Dio();

      String finalurl =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$apikey';

      final response = await dio.get(
        finalurl,
      );
      List addressComponents = response.data['result']['address_components'];
      for (int i = 0; i <= addressComponents.length; i++) {
        // addressComponents[i]['types'][0] == 'locality'
        //     ? city.text == addressComponents[i]['long_name'].toString()
        // :
        addressComponents[i]['types'][0] == 'postal_code'
            ? zipcode.text = addressComponents[i]['long_name'].toString()
            : addressComponents[i]['types'][0] == 'administrative_area_level_1'
                ? state.text = addressComponents[i]['long_name'].toString()
                : null;
      }
    }

    // Build a Form widget using the _formKey created above.
    super.build(context); // Ensure to call super.build

    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   title: const Text('Book Appointment'),
            // ),
            body: widget = SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: deviceSize.height * 0.04,
            left: deviceSize.width * 0.025,
            right: deviceSize.width * 0.025),
        child: Center(
          child: Form(
            key: formkey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: deviceSize.width * 0.9,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: deviceSize.width * 0.18,
                          child: TextFormField(
                            textAlign: TextAlign
                                .center, // Set text alignment to center

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter value';
                              }
                              return null; // Return null if the input is valid.
                            },
                            controller: typeAheadController2,
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4))),
                          )),
                      const Flexible(flex: 1, child: SizedBox()),
                      Padding(
                          padding:
                              EdgeInsets.only(left: deviceSize.width * 0.02),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: deviceSize.width * 0.7,
                            child: TypeAheadField(
                                emptyBuilder: (
                                  context,
                                ) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      'No patients found!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  );
                                },
                                builder: (context, controller, focusNode) {
                                  return TextFormField(
                                    onChanged: (value) {
                                      patientId = 0;
                                      firstname.clear();
                                      lastname.clear();
                                      age.clear();
                                      // selectedGender = value['gender'].toString();
                                      email.clear();
                                      autoaddress.clear();
                                      address.clear();
                                      city.clear();
                                      state.clear();
                                      country.clear();
                                      zipcode.clear();
                                      idnumber.clear();
                                      selectedGender = null;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    keyboardType: TextInputType.number,
                                    controller: controller,
                                    focusNode: focusNode,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                        errorStyle:
                                            const TextStyle(fontSize: 0.05),
                                        hintText: 'mobile number',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        labelText: 'mobile number',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter value';
                                      }
                                      return null; // Return null if the input is valid.
                                    },
                                  );
                                },
                                controller: typeAheadController,
                                suggestionsCallback: (pattern) async {
                                  return patients
                                      .where((item) => item['mobile']
                                          .toString()
                                          .toLowerCase()
                                          .contains(pattern.toLowerCase()))
                                      .toList();
                                },
                                itemBuilder: (context, patients) {
                                  return ListTile(
                                    title: Text(
                                      "${patients['firstname']} ${patients['lastname']}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  );
                                },
                                onSelected: (value) {
                                  fillForm() {
                                    String val = value['mobile'];
                                    typeAheadController.text =
                                        val.substring(3, 13);
                                    setState(() {
                                      patientId = value['id'];
                                      firstname.text = value['firstname'];
                                      lastname.text = value['lastname'];
                                      age.text = value['age'].toString();
                                      // selectedGender = value['gender'].toString();
                                      email.text = value['email'];
                                      autoaddress.text = value['address1'];
                                      address.text = value['address2'];
                                      city.text = value['city'];
                                      state.text = value['state'];
                                      country.text = value['country'];
                                      zipcode.text = value['zipcode'];
                                      idnumber.text = value['idproofnumber'];
                                      selectedGender = value['gender'];

                                      value['idproofid'] == 1
                                          ? idselected = "Passport"
                                          : value['idproofid'] == 2
                                              ? idselected = "Aadhaar Card"
                                              : value['idproofid'] == 3
                                                  ? idselected =
                                                      "Driving License"
                                                  : value['idproofid'] == 4
                                                      ? idselected = "Voter Id"
                                                      : value['idproofid'] == 5
                                                          ? idselected =
                                                              "PAN Card"
                                                          : value['idproofid'] ==
                                                                  6
                                                              ? idselected =
                                                                  "Government Issued ID"
                                                              : null;
                                      proofId = value['idproofid'];
                                      existingPatient = true;
                                    });
                                    Navigator.pop(context);
                                    // Navigator.of(context)
                                    //     .pop(false);
                                  }

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                4), // Adjust the radius here
                                          ),
                                          title: const Text(
                                            'Confirmation',
                                          ),
                                          content: const Text(
                                              'Do you want to book appointment for same patient ?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                // Perform action when Yes is pressed
                                                fillForm();
                                              },
                                              child: const Text('Yes'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                String val = value['mobile'];
                                                typeAheadController.text =
                                                    val.substring(3, 13);

                                                patientId = 0;
                                                firstname.clear();
                                                lastname.clear();
                                                age.clear();
                                                // selectedGender = value['gender'].toString();
                                                email.clear();
                                                autoaddress.clear();
                                                address.clear();
                                                city.clear();
                                                state.clear();
                                                country.clear();
                                                zipcode.clear();
                                                idnumber.clear();
                                                selectedGender = null;
                                                // Perform action when No is pressed
                                                // Navigator.of(context)
                                                //     .pop(false);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('No'),
                                            ),
                                          ],
                                        );

                                        // selectedIdProof =
                                        //     value['idproofid'].toString();

                                        // Handle the selected suggestion
                                      });
                                }),
                          )),
                    ],
                  ),
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox1,
                textformfield(
                  firstname,
                  'First name',
                  'First name',
                  TextInputType.name,
                  screenOrientation.toString(),
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                textformfield(
                  lastname,
                  'Last name',
                  'Last name',
                  TextInputType.name,
                  screenOrientation.toString(),
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                SizedBox(
                  width: deviceSize.width * 0.9,
                  child: Row(
                    children: [
                      SizedBox(
                        width: deviceSize.width * 0.42,
                        child: textformfield(
                          age,
                          'Age',
                          'Age',
                          TextInputType.number,
                          screenOrientation.toString(),
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: deviceSize.width * 0.42,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: DropdownButtonFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              labelText: "Gender",
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              errorStyle: const TextStyle(fontSize: 0.05),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)))),
                          items: listitems
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ))
                              .toList(),
                          value: selectedGender,
                          onChanged: (value) {
                            selectedGender = value as String;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                textformfield(
                  email,
                  'Email Address',
                  'Email Address',
                  TextInputType.emailAddress,
                  screenOrientation.toString(),
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    // Use a regular expression for email validation
                    // This regex is a simplified version and may not cover all edge cases
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null; // Return null for valid input
                  },
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : const SizedBox(),
                SizedBox(
                    height:
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? MediaQuery.of(context).size.height * 0.1
                            : MediaQuery.of(context).size.height * 0.09,
                    width:
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? deviceSize.width * 0.925
                            : deviceSize.width * 0.94,
                    // screenOrientation.toString() == 'Orientation.portrait'
                    //      MediaQuery.of(context).size.width * 0.82
                    //     : MediaQuery.of(context).size.width * 0.8,
                    child: GooglePlaceAutoCompleteTextField(
                      textEditingController: autoaddress,
                      textStyle:
                          Theme.of(context).textTheme.bodySmall as TextStyle,
                      googleAPIKey: "AIzaSyDZsx7mv_Vo_Ro4NkknYwF0rqC9ZY2-qxE",

                      inputDecoration: InputDecoration(
                        hintText: 'Address line 1',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        labelText: 'Address line 1',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 162, 155, 155))),
                      ),

                      boxDecoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide.none,
                              top: BorderSide.none,
                              right: BorderSide.none,
                              left: BorderSide.none)),
                      countries: const [
                        "in",
                        "fr"
                      ], // optional by default null is set
                      isLatLngRequired:
                          true, // if you required coordinates from place detail
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        // this method will return latlng with place detail
                      }, // this callback is called when isLatLngRequired is true
                      itemClick: (Prediction prediction) {
                        autoaddress.text =
                            prediction.description!.split(',').first;
                        address.text = prediction
                                    .structuredFormatting!.secondaryText!
                                    .split(',')
                                    .length <=
                                3
                            ? '  '
                            :
                            // prediction
                            //     .structuredFormatting!.secondaryText!;
                            '${prediction.structuredFormatting!.secondaryText!.split(',')[1]} ${prediction.structuredFormatting!.secondaryText!.split(',')[2]}';

                        country.text = prediction.description!.split(',').last;
                        city.text = prediction.description!.split(',').length <=
                                3
                            ? prediction.description!.split(',')[
                                prediction.description!.split(',').length - 2]
                            : prediction.description!.split(',')[prediction
                                    .description!
                                    .split(',')
                                    .length -
                                3]; // state.text = prediction.description!.split(',')[
                        //     prediction.description!.split(',').length -
                        //         2];
                        getPlaceDetails(prediction.placeId.toString(),
                            "AIzaSyDZsx7mv_Vo_Ro4NkknYwF0rqC9ZY2-qxE");

                        autoaddress.selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: prediction.description!
                                    .split(',')
                                    .first
                                    .length));
                      },
                      // if we want to make custom list item builder
                      itemBuilder: (context, index, Prediction prediction) {
                        return Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                                blurStyle: BlurStyle.outer,
                                blurRadius: 1,
                                color: Color.fromARGB(255, 196, 248, 226))
                          ], color: Color.fromARGB(255, 220, 241, 230)),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 225, 87, 77),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                  child: Text(
                                prediction.description ?? "",
                                style: Theme.of(context).textTheme.bodySmall,
                              ))
                            ],
                          ),
                        );
                      },
                      // if you want to add seperator between list items
                      seperatedBuilder: const Divider(),

                      // want to show close icon
                      isCrossBtnShown: false,
                    )),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                MyTextFormField(
                  controller: address,
                  labelTextl: 'Address line2',
                  hintText: 'Address line2',
                  keyboardType: TextInputType.streetAddress,
                  readonly: false,
                  inputLenght: LengthLimitingTextInputFormatter(50),

                  // onChanged: (value) {
                  //   address2.text = value;
                  // },
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                MyTextFormField(
                  controller: city,
                  labelTextl: 'City',
                  hintText: 'City',
                  keyboardType: TextInputType.streetAddress,
                  readonly: false,
                  inputLenght: LengthLimitingTextInputFormatter(20),

                  // onChanged: (value) {
                  //   city.text == value;
                  // },
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                MyTextFormField(
                  controller: state,
                  labelTextl: 'State',
                  hintText: 'State',
                  keyboardType: TextInputType.streetAddress,
                  readonly: false,
                  inputLenght: LengthLimitingTextInputFormatter(20),

                  // onChanged: (value) {
                  //   address2.text = value;
                  // },
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                MyTextFormField(
                  controller: country,
                  labelTextl: 'Country',
                  hintText: 'Country',
                  keyboardType: TextInputType.streetAddress,
                  readonly: false,
                  inputLenght: LengthLimitingTextInputFormatter(20),

                  // onChanged: (value) {
                  //   address2.text = value;
                  // },
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                MyTextFormField(
                  controller: zipcode,
                  labelTextl: 'Zip code',
                  hintText: 'Zip code',
                  keyboardType: TextInputType.number,
                  readonly: false,
                  inputLenght: LengthLimitingTextInputFormatter(20),

                  // onChanged: (value) {
                  //   zipcode.text == value;
                  // },
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                Container(
                  height:
                      screenOrientation.toString() == 'Orientation.landscape'
                          ? MediaQuery.of(context).size.height * 0.08
                          : MediaQuery.of(context).size.height * 0.07,
                  width: deviceSize.width * 0.9,
                  //  MediaQuery.of(context).size.height > 650 &&
                  //         screenOrientation.toString() == 'Orientation.portait'
                  //      MediaQuery.of(context).size.width * 0.9
                  //     : MediaQuery.of(context).size.width * 0.775,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: DropdownButtonFormField(
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        labelText: "Id proof type",
                        hintText: 'Id proof type',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        errorStyle: const TextStyle(fontSize: 0.05),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                    items: listIdProof
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ))
                        .toList(),
                    value: idselected,
                    onChanged: (value) {
                      idselected = value as String;

                      idselected == "Passport"
                          ? proofId = 1
                          : idselected == "Aadhaar Card"
                              ? proofId = 2
                              : idselected == "Driving License"
                                  ? proofId = 3
                                  : idselected == "Voter Id"
                                      ? proofId = 4
                                      : idselected == "PAN Card"
                                          ? proofId = 5
                                          : idselected == "Government Issued ID"
                                              ? proofId = 6
                                              : null;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter value';
                      }
                      return null;
                    },
                  ),
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                MyTextFormField(
                  controller: idnumber,
                  labelTextl: 'ID proof number',
                  hintText: 'ID proof number',
                  keyboardType: TextInputType.streetAddress,
                  readonly: false,
                  inputLenght: LengthLimitingTextInputFormatter(20),

                  // onChanged: (value) {
                  //   zipcode.text == value;
                  // },
                ),
                screenOrientation.toString() == 'Orientation.landscape'
                    ? sizedbox
                    : sizedbox2,
                Padding(
                  padding: EdgeInsets.only(bottom: deviceSize.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: deviceSize.width * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                // Color.fromARGB(255, 7, 176, 150),
                                Theme.of(context).colorScheme.secondary,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: deviceSize.width * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                // Color.fromARGB(255, 7, 176, 150),
                                Theme.of(context).colorScheme.onPrimary,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (formkey1.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.

                              DefaultTabController.of(context).animateTo(1);
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
            // : failure != null
            //     ? widget = Expanded(
            //         child: Center(
            //           child: Text(
            //             failure.errorMessage,
            //             style: const TextStyle(fontSize: 20),
            //           ),
            //         ),
            //       )
            //     : widget = const Expanded(
            //         child: Center(
            //           child: CircularProgressIndicator(
            //             backgroundColor: Colors.white,
            //             color: Colors.orangeAccent,
            //           ),
            //         ),
            //       )
            ));
  }

  Widget textformfield(
          TextEditingController controller,
          String labelText,
          String hintText,
          final TextInputType keyboardType,
          String orientation,
          final String? Function(String?) validationFunction) =>
      SizedBox(
        height: orientation == 'Orientation.landscape'
            ? MediaQuery.of(context).size.height * 0.08
            : MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.9,

        //  MediaQuery.of(context).size.height > 650 &&
        //         orientation == 'Orientation.portait'
        //      MediaQuery.of(context).size.width * 0.9
        //     : MediaQuery.of(context).size.width * 0.775,
        child: TextFormField(
          style: Theme.of(context).textTheme.bodySmall,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            errorStyle: const TextStyle(fontSize: 0.05),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          // The validator receives the text that the user has entered.
          validator: validationFunction,
        ),
      );
}
