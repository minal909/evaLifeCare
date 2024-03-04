import 'package:dio/dio.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/my_profile/presentation/providers/update_profile_provider.dart';
import 'package:eva_life_care/features/my_profile/presentation/widgets/userProfileWidget/my_textformfield.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? selectedGender;
bool profileUpdate = false;

// ignore: must_be_immutable
class MyPofileWidget extends StatefulWidget {
  Widget widget;
  String age;
  String mobile;
  String firstName;
  String lastName;
  String accessrole;
  String email;
  String address1;
  String address2;
  String city;
  String zipcode;
  String state;
  String country;
  String department;
  String designation;

  MyPofileWidget({
    super.key,
    required this.widget,
    required this.age,
    required this.mobile,
    required this.firstName,
    required this.lastName,
    required this.accessrole,
    required this.email,
    required this.address1,
    required this.address2,
    required this.city,
    required this.zipcode,
    required this.state,
    required this.country,
    required this.department,
    required this.designation,
  });

  @override
  State<MyPofileWidget> createState() => MyPofileWidgetState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyPofileWidgetState extends State<MyPofileWidget> {
  final List listitems = ['Male', 'Female'];
  String selectedService = '';
  String selectedDesignation = '';
  String selectedDepartment = '';
  String mobileIs = '';

  TextEditingController age1 = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController accessrole = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController autoaddress = TextEditingController();

  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();

  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  TextEditingController zipcode = TextEditingController();
  TextEditingController department = TextEditingController();

  TextEditingController designation = TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyPofileWidgetState>.
  final _formKey = GlobalKey<FormState>();
  bool isInit = true;
  // MyProfileEntity? myprofile;
  // UpdateProfileEntity? updateprofile;
  // Failure? failure;

  @override
  void initState() {
    // bool light = false;

    // TODO: implement initState
    super.initState();
    profileUpdate = true;

    getValues();
    // storedContext = context;
  }

  String cognitoid = '';
  int clientid = 0;
  int userid = 0;

  getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientid = prefs.getInt('clientId')!.toInt();
    userid = prefs.getInt('userId')!.toInt();
    cognitoid = prefs.getString("cognito_id").toString();

    accessrole.text = prefs.getString("access_role").toString();
    // selectedGender = widget.gender;

    // '${widget.myprofile!.result.mobile.substring(0, 3)}${widget.myprofile!.result.mobile.substring(3)}';
    firstname.text = widget.firstName;
    lastname.text = widget.lastName;
    age1.text = widget.age;
    address1.text = widget.address1;
    address2.text = widget.address2;
    mobile.text = widget.mobile.substring(3, 13);
    mobileIs = widget.mobile;
    email.text =
        // 'minal.suryawanshi@whistlemind.com';
        widget.email;
    city.text = widget.city;
    country.text = widget.country;
    state.text = widget.state;
    zipcode.text = widget.zipcode;
    designation.text = widget.designation;
    department.text = widget.department;
    selectedService = widget.department;

    // print(
    //     'age value conrtoller---------------------${widget.myprofile!.result.age.toString()}');
  }

  // @override
  // void dispose() {
  //   age.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    var screenOrientation = MediaQuery.orientationOf(context);
    Widget sizedbox = SizedBox(
      height: deviceSize.height * 0.05,
    );
    Widget emailSpace = SizedBox(
      height: deviceSize.height * 0.04,
    );
    Widget sizedbox1 = SizedBox(
      height: deviceSize.height * 0.019,
    );
    Widget sizedbox2 = SizedBox(
      height: deviceSize.height * 0.015,
    );
    Widget sizedbox3 = SizedBox(
      height: deviceSize.height * 0.006,
    );
    // MyProfileEntity? profile =
    //     Provider.of<MyProfileProvider>(context).myProfile;

    late Widget widget1;
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

        // addressComponents[i]['types'][0] == 'postal_code'
        //     ? zipcode.text = addressComponents[i]['long_name'].toString()
        //     : addressComponents[i]['types'][0] == 'country'
        //         ? country.text == addressComponents[i]['long_name'].toString()
        //         : addressComponents[i]['types'][0] ==
        //                 'administrative_area_level_1'
        //             ? state.text = addressComponents[i]['long_name'].toString()
        //             : null;
      }
    }

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => widget.widget));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text('My profile'),
      ),
      body: widget.firstName.isEmpty
          ? widget1 = const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.orangeAccent,
                ),
              ),
            )
          : widget1 = SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: deviceSize.height * 0.04,
                    left: deviceSize.width * 0.025,
                    right: deviceSize.width * 0.025),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: firstname,
                          labelTextl: 'First name',
                          hintText: 'First name',
                          keyboardType: TextInputType.name,
                          readonly: false,
                          // onChanged: (value) {
                          //   firstname.text == value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: lastname,
                          labelTextl: 'Last name',
                          hintText: 'Last name',
                          keyboardType: TextInputType.name,
                          readonly: false,
                          // onChanged: (value) {
                          //   lastname.text == value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        // MyTextFormField(
                        //   controller: mobile,
                        //   labelTextl: 'Mobile No',
                        //   hintText: 'Mobile No',
                        //   keyboardType: TextInputType.phone,
                        //   readonly: false,
                        //   // onChanged: (value) {
                        //   //   mobile.text == value;
                        //   // },
                        // ),
                        SizedBox(
                          height: screenOrientation.toString() ==
                                  'Orientation.landscape'
                              ? MediaQuery.of(context).size.height * 0.12
                              : MediaQuery.of(context).size.height * 0.07,
                          width: deviceSize.width * 0.9,
                          // MediaQuery.of(context).size.height > 650 &&
                          //         screenOrientation.toString() ==
                          //             'Orientation.portait'
                          //      MediaQuery.of(context).size.width * 0.9
                          //     : MediaQuery.of(context).size.width * 0.775,
                          child: IntlPhoneField(
                            dropdownTextStyle:
                                Theme.of(context).textTheme.bodySmall,
                            controller: mobile,
                            disableLengthCheck: false,
                            flagsButtonPadding: const EdgeInsets.all(4),
                            dropdownIconPosition: IconPosition.trailing,
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: InputDecoration(
                              labelText: 'Mobile',
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              errorStyle: const TextStyle(fontSize: 0.05),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              mobileIs = phone.completeNumber;

                              // mobile.text = phone.completeNumber;
                            },
                          ),
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        SizedBox(
                          width: deviceSize.width * 0.9,
                          child: Row(
                            children: [
                              SizedBox(
                                width: deviceSize.width * 0.42,
                                child: MyTextFormField(
                                  inputLenght:
                                      LengthLimitingTextInputFormatter(20),

                                  controller: age1,
                                  labelTextl: 'Age',
                                  hintText: 'Age',
                                  keyboardType: TextInputType.number,
                                  readonly: false,
                                  // onChanged: (value) {
                                  //   lastname.text == value;
                                  // },
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Container(
                                height: screenOrientation.toString() ==
                                        'Orientation.landscape'
                                    ? MediaQuery.of(context).size.height * 0.08
                                    : MediaQuery.of(context).size.height * 0.07,
                                width: deviceSize.width * 0.42,

                                // screenOrientation.toString() ==
                                //         'Orientation.landscape'
                                //      MediaQuery.of(context).size.width * 0.773
                                //     : MediaQuery.of(context).size.width * 0.77,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: DropdownButtonFormField(
                                  style: Theme.of(context).textTheme.bodySmall,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      labelText: "Gender",
                                      errorStyle: TextStyle(fontSize: 0.05),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)))),
                                  items: listitems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedGender,
                                  onChanged: (value) {
                                    selectedGender = value as String;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),
                          controller: email,
                          labelTextl: 'Email address',
                          hintText: 'Email address',
                          keyboardType: TextInputType.emailAddress,
                          readonly: true,
                        ),

                        screenOrientation.toString() == 'Orientation.landscape'
                            ? emailSpace
                            : sizedbox3,
                        SizedBox(
                            height: screenOrientation.toString() ==
                                    'Orientation.landscape'
                                ? MediaQuery.of(context).size.height * 0.1
                                : MediaQuery.of(context).size.height * 0.09,
                            width: screenOrientation.toString() ==
                                    'Orientation.landscape'
                                ? deviceSize.width * 0.925
                                : deviceSize.width * 0.95,

                            // width: screenOrientation.toString() ==
                            //         'Orientation.landscape'
                            //     MediaQuery.of(context).size.width * 0.8
                            //     : MediaQuery.of(context).size.width * 0.82,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(4),
                            //   border: Border.all(
                            //       color: const Color.fromARGB(255, 162, 155,
                            //           155)), // Change the color as needed
                            // ),
                            child: GooglePlaceAutoCompleteTextField(
                              showError: false,
                              textEditingController: address1,
                              textStyle: Theme.of(context).textTheme.bodySmall
                                  as TextStyle,
                              googleAPIKey: "Add  your google API key",

                              inputDecoration: const InputDecoration(
                                hintText: 'Address line 1',
                                labelText: 'Address line 1',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(
                                            255, 162, 155, 155))),
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
                              getPlaceDetailWithLatLng:
                                  (Prediction prediction) {
                                // this method will return latlng with place detail
                              }, // this callback is called when isLatLngRequired is true
                              itemClick: (Prediction prediction) {
                                address1.text =
                                    prediction.description!.split(',').first;
                                address2.text = prediction.structuredFormatting!
                                            .secondaryText!
                                            .split(',')
                                            .length <=
                                        3
                                    ? '  '
                                    :
                                    // prediction
                                    //     .structuredFormatting!.secondaryText!;
                                    '${prediction.structuredFormatting!.secondaryText!.split(',')[1]} ${prediction.structuredFormatting!.secondaryText!.split(',')[2]}';

                                country.text =
                                    prediction.description!.split(',').last;
                                city.text = prediction.description!
                                            .split(',')
                                            .length <=
                                        3
                                    ? prediction.description!.split(',')[
                                        prediction.description!
                                                .split(',')
                                                .length -
                                            2]
                                    : prediction.description!
                                        .split(',')[prediction.description!
                                            .split(',')
                                            .length -
                                        3]; // state.text = prediction.description!.split(',')[
                                //     prediction.description!.split(',').length -
                                //         2];
                                getPlaceDetails(prediction.placeId.toString(),
                                    "Add your google API key");

                                address1.selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset: prediction.description!
                                            .split(',')
                                            .first
                                            .length));
                              },
                              // if we want to make custom list item builder
                              itemBuilder:
                                  (context, index, Prediction prediction) {
                                return Container(
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        blurRadius: 1,
                                        color:
                                            Color.fromARGB(255, 196, 248, 226))
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
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
                            ? emailSpace
                            : sizedbox2,
                        // MyTextFormField(
                        //   controller: address1,
                        //   labelTextl: 'Address line1',
                        //   hintText: 'Address line1',
                        //   keyboardType: TextInputType.streetAddress,
                        //   readonly: false,
                        //   // onChanged: (value) {
                        //   //   address1.text = value;
                        //   // },
                        // ),

                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: address2,
                          labelTextl: 'Address line2',
                          hintText: 'Address line2',
                          keyboardType: TextInputType.streetAddress,
                          readonly: false,
                          // onChanged: (value) {
                          //   address2.text = value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: city,
                          labelTextl: 'City',
                          hintText: 'City',
                          keyboardType: TextInputType.streetAddress,
                          readonly: false,
                          // onChanged: (value) {
                          //   city.text == value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: state,
                          labelTextl: 'State',
                          hintText: 'State',
                          keyboardType: TextInputType.streetAddress,
                          readonly: false,
                          // onChanged: (value) {
                          //   address2.text = value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: country,
                          labelTextl: 'Country',
                          hintText: 'Country',
                          keyboardType: TextInputType.streetAddress,
                          readonly: false,
                          // onChanged: (value) {
                          //   address2.text = value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: zipcode,
                          labelTextl: 'Zip code',
                          hintText: 'Zip code',
                          keyboardType: TextInputType.number,
                          readonly: false,
                          // onChanged: (value) {
                          //   zipcode.text == value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: accessrole,
                          labelTextl: 'Access role',
                          hintText: 'Access role',
                          keyboardType: TextInputType.name,
                          readonly: true,
                          // onChanged: (value) {
                          //   accessrole.text == value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: designation,
                          labelTextl: 'Designation',
                          hintText: 'Designation',
                          keyboardType: TextInputType.name,
                          readonly: false,
                          // onChanged: (value) {
                          //   designation.text == value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        MyTextFormField(
                          inputLenght: LengthLimitingTextInputFormatter(20),

                          controller: department,
                          labelTextl: 'Department',
                          hintText: 'Department',
                          keyboardType: TextInputType.name,
                          readonly: false,
                          // onChanged: (value) {
                          //   department.text == value;
                          // },
                        ),
                        screenOrientation.toString() == 'Orientation.landscape'
                            ? sizedbox
                            : sizedbox1,
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: deviceSize.height * 0.02),
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

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                widget.widget));
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
                                  onPressed: () async {
                                    // afterUpdate() {
                                    //   Provider.of<MyProfileProvider>(context,
                                    //           listen: false)
                                    //       .eitherFailureOrMyProfile(
                                    //           clId: clientid, usrId: userid);
                                    //   Navigator.pop(context);
                                    // }

                                    // WidgetHelper.startLoading('');

                                    // Validate returns true if the form is valid, or false otherwise.

                                    if (await NetworkInfoImpl(
                                                DataConnectionChecker())
                                            .isConnected ==
                                        false) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => NoInternet(
                                          onPressed: () async {
                                            bool isConnected =
                                                await NetworkInfoImpl(
                                                        DataConnectionChecker())
                                                    .isConnected;

                                            // updateProf() async {
                                            //   WidgetHelper.startLoading("");
                                            //   var updatedProfile = await Provider.of<UpdateProfileProvider>(context, listen: false)
                                            //       .eitherFailureOrUpdatedProfile(
                                            //           clId: clientid,
                                            //           usrId: userid,
                                            //           cognitoid: cognitoid,
                                            //           email: widget.email,
                                            //           // 'minal.suryawanshi@whistlemind.com',
                                            //           // email.text,
                                            //           mobile: mobileIs,
                                            //           firstname: firstname.text ==
                                            //                   widget.firstName
                                            //               ? null
                                            //               : firstname.text,
                                            //           lastname: lastname.text == widget.lastName
                                            //               ? null
                                            //               : lastname.text,
                                            //           age: age1.text == widget.age
                                            //               ? null
                                            //               : int.parse(
                                            //                   age1.text),
                                            //           gender: selectedGender,
                                            //           addressline1: address1.text ==
                                            //                   widget.address1
                                            //               ? null
                                            //               : address1.text,
                                            //           addressline2:
                                            //               address2.text == widget.address2
                                            //                   ? null
                                            //                   : address2.text,
                                            //           country: country.text == widget.country
                                            //               ? null
                                            //               : country.text,
                                            //           state: state.text == widget.state ? null : state.text,
                                            //           city: city.text == widget.city ? null : city.text,
                                            //           zipcode: zipcode.text == widget.zipcode ? null : zipcode.text,
                                            //           designation: designation.text == widget.designation ? null : designation.text,
                                            //           department: department.text == widget.department ? null : department.text);
                                            //   WidgetHelper.endLoading();
                                            //   updatedProfile != null
                                            //       Navigator.pop(context)
                                            //       : null;
                                            // }

                                            if (!isConnected) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "No internet connection!",
                                                  gravity: ToastGravity.CENTER);
                                              // WidgetHelper.endLoading();
                                            } else {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyPofileWidget(
                                                            widget:
                                                                widget.widget,
                                                            age: age1.text,
                                                            mobile:
                                                                widget.mobile,
                                                            firstName:
                                                                firstname.text,
                                                            lastName:
                                                                lastname.text,
                                                            accessrole:
                                                                accessrole.text,
                                                            email: widget.email,
                                                            address1:
                                                                widget.address1,
                                                            address2:
                                                                widget.address2,
                                                            city: widget.city,
                                                            zipcode:
                                                                widget.zipcode,
                                                            state: widget.state,
                                                            country:
                                                                widget.country,
                                                            department: widget
                                                                .department,
                                                            designation: widget
                                                                .designation,
                                                          )));
                                            }
                                          },
                                        ),
                                      ));

                                      // updateprofile = Provider.of<
                                      //             UpdateProfileProvider>(
                                      //         context)
                                      //     .updatedProfile;
                                      // Failure? failure2 = Provider.of<
                                      //             UpdateProfileProvider>(
                                      //         context)
                                      //     .failure;
                                      // late Widget widget2;

                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      var updatedProfile = await Provider.of<UpdateProfileProvider>(context, listen: false)
                                          .eitherFailureOrUpdatedProfile(
                                              context: context,
                                              widget: widget.widget,
                                              clId: clientid,
                                              usrId: userid,
                                              cognitoid: cognitoid,
                                              email: widget.email,
                                              // 'minal.suryawanshi@whistlemind.com',
                                              mobile: mobile.text == widget.mobile
                                                  ? widget.mobile
                                                  : mobileIs,
                                              firstname:
                                                  firstname.text == widget.firstName
                                                      ? null
                                                      : firstname.text,
                                              lastname:
                                                  lastname.text == widget.lastName
                                                      ? null
                                                      : lastname.text,
                                              age: age1.text == widget.age
                                                  ? null
                                                  : int.parse(age1.text),
                                              gender: selectedGender,
                                              addressline1:
                                                  address1.text == widget.address1
                                                      ? null
                                                      : address1.text,
                                              addressline2:
                                                  address2.text == widget.address2
                                                      ? null
                                                      : address2.text,
                                              country: country.text == widget.country
                                                  ? null
                                                  : country.text,
                                              state: state.text == widget.state ? null : state.text,
                                              city: city.text == widget.city ? null : city.text,
                                              zipcode: zipcode.text == widget.zipcode ? null : zipcode.text,
                                              designation: designation.text == widget.designation ? null : designation.text,
                                              department: department.text == widget.department ? null : department.text);

                                      print(
                                          'prof val===============$updatedProfile');

                                      updatedProfile != null
                                          // ignore: use_build_context_synchronously
                                          ? Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      widget.widget))
                                          : WidgetHelper.endLoading();

// ignore: use_build_context_synchronously
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             widget.widget)); // : null;
                                    }
                                    // WidgetHelper.endLoading();
                                  },
                                  child: const Text(
                                    'Save',
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
            ),

      // ignore: unnecessary_null_comparison
    );
  }
}
