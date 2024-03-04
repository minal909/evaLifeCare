
  // onSelected: (value) {
  //                                         fillForm() {
  //                                           String val = value['mobile'];
  //                                           typeAheadController.text =
  //                                               val.substring(3, 13);
  //                                           int docId = 0;
  //                                           setState(() {
  //                                             patientId = value['id'];
  //                                             firstname.text =
  //                                                 value['firstname'];
  //                                             lastname.text = value['lastname'];
  //                                             age.text =
  //                                                 value['age'].toString();
  //                                             // selectedGender = value['gender'].toString();
  //                                             email.text = value['email'];
  //                                             autoaddress.text =
  //                                                 value['address1'];
  //                                             address.text = value['address2'];
  //                                             city.text = value['city'];
  //                                             state.text = value['state'];
  //                                             country.text = value['country'];
  //                                             zipcode.text = value['zipcode'];
  //                                             idnumber.text =
  //                                                 value['idproofnumber'];
  //                                             selectedGender = value['gender'];

  //                                             value['idproofid'] == 1
  //                                                 ? idselected = "Passport"
  //                                                 : value['idproofid'] == 2
  //                                                     ? idselected =
  //                                                         "Aadhaar Card"
  //                                                     : value['idproofid'] == 3
  //                                                         ? idselected =
  //                                                             "Driving License"
  //                                                         : value['idproofid'] ==
  //                                                                 4
  //                                                             ? idselected =
  //                                                                 "Voter Id"
  //                                                             : value['idproofid'] ==
  //                                                                     5
  //                                                                 ? idselected =
  //                                                                     "PAN Card"
  //                                                                 : value['idproofid'] ==
  //                                                                         6
  //                                                                     ? idselected =
  //                                                                         "Government Issued ID"
  //                                                                     : null;
  //                                             proofId = value['idproofid'];
  //                                             existingPatient = true;
  //                                           });
  //                                           Navigator.pop(context);
  //                                           // Navigator.of(context)
  //                                           //     .pop(false);
  //                                         }

  //                                         showDialog(
  //                                             context: context,
  //                                             builder: (BuildContext context) {
  //                                               return AlertDialog(
  //                                                 shape: RoundedRectangleBorder(
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           4), // Adjust the radius here
  //                                                 ),
  //                                                 title: const Text(
  //                                                   'Confirmation',
  //                                                 ),
  //                                                 content: const Text(
  //                                                     'Do you want to book appointment for same patient ?'),
  //                                                 actions: <Widget>[
  //                                                   TextButton(
  //                                                     onPressed: () {
  //                                                       // Perform action when Yes is pressed
  //                                                       fillForm();
  //                                                     },
  //                                                     child: const Text('Yes'),
  //                                                   ),
  //                                                   TextButton(
  //                                                     onPressed: () {
  //                                                       String val =
  //                                                           value['mobile'];
  //                                                       typeAheadController
  //                                                               .text =
  //                                                           val.substring(
  //                                                               3, 13);
  //                                                       // Perform action when No is pressed
  //                                                       // Navigator.of(context)
  //                                                       //     .pop(false);
  //                                                       Navigator.pop(context);
  //                                                     },
  //                                                     child: const Text('No'),
  //                                                   ),
  //                                                 ],
  //                                               );

  //                                               // selectedIdProof =
  //                                               //     value['idproofid'].toString();

  //                                               // Handle the selected suggestion
  //                                             });
  //                                       }