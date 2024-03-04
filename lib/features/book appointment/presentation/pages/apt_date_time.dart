import 'package:eva_life_care/core/errors/failure.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/pages/apt_details.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/pages/basic_details.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/pages/book_apt_form.dart';

import 'package:eva_life_care/features/book%20appointment/presentation/providers/book_apt_provider.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/get_slots_provider.dart';
import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
import 'package:eva_life_care/features/my_profile/presentation/providers/my_profile_provider.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AppointmentDateTime extends StatefulWidget {
  Widget widget1;
  String page;
  String mobile;
  String firstname;
  String lastname;

  String age;

  String email;
  String autoaddress;

  String username;

  String address;
  String city;
  String state;
  String country;

  String zipcode;
  String idnumber;
  String refDoc;

  AppointmentDateTime(
      this.widget1,
      this.page,
      this.mobile,
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
      this.refDoc,
      {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<AppointmentDateTime> createState() => AppointmentDateTimeState(
        widget1,
        page,
        mobile,
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
        refDoc,
      );
}

// Create a corresponding State class.
// This class holds data related to the form.
class AppointmentDateTimeState extends State<AppointmentDateTime>
    with AutomaticKeepAliveClientMixin {
  Widget widget1;
  String page;
  String mobile;
  String firstname;
  String lastname;

  String age;

  String email;
  String autoaddress;

  String username;

  String address;
  String city;
  String state;
  String country;

  String zipcode;

  String idnumber;
  String refDoc;

  AppointmentDateTimeState(
    this.widget1,
    this.page,
    this.mobile,
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
    this.refDoc,
  );

  @override
  bool get wantKeepAlive => true;
  TextEditingController date = TextEditingController();
  DateTime today = DateTime.now();
  String visitTimeSlot = '';
  String focusedday = '';
  DateTime? selectedDay;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<AppointmentDateTimeState>.
  String formattedTimeString = '';

  final _formKey = GlobalKey<FormState>();
  MyProfileEntity? myprofile;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  bool isLoading = true;
  bool dateselected = false;

  List<Map<String, dynamic>> timeSlots2 = [];
  var result;
  @override
  void initState() {
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    // bool light = false;

    // TODO: implement initState
    super.initState();
    // storedContext = context;
  }

  // var hoursAvailable;
  var selectedIndex;
  String convertdate = '';
  DateTime aptdateis = DateTime.now();
  String? finaltime;
  DateTime? givenTime;
  DateTime currentTime = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) async {
    selectedDay = day;
    timeSlots2 = [];
    SlotsListProvider slotsListIs =
        Provider.of<SlotsListProvider>(context, listen: false);
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');

    focusedday = outputFormat.format(day);

    var result = await slotsListIs.getSlotsList(
        userid: userId, branchid: branchid, date: focusedday);
    Map<String, dynamic> timeSlots = result['result'][0]['slots'];
    timeSlots.forEach((key, value) {
      Map<String, dynamic> slotMap = {
        "slot": key,
        "status": value,
      };
      timeSlots2.add(slotMap);
    });

    setState(() {
      // hoursAvailable = result.slotsresult[0].slots;
      selectedIndex = null;
      // today = day;
      DateFormat outputFormat = DateFormat('yyyy-MM-dd');
      String convertedDate = outputFormat.format(today);
      // print('the hours are here..........>>>>>>>>>>>$hoursAvailable');
      convertdate = convertedDate;
      int yr = int.parse(convertdate.substring(0, 4));
      int month = int.parse(convertdate.substring(5, 7));
      int dayy = int.parse(convertdate.substring(8, 10));
      date.text = convertdate;

      aptdateis = DateTime(yr, month, dayy);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    DateFormat outputFormat1 = DateFormat('yyyy-MM-dd');
    String convertedDate = outputFormat1.format(day);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle slotsStyle = const TextStyle();

    Size deviceSize = MediaQuery.of(context).size;

    var screenOrientation = MediaQuery.orientationOf(context);
    Widget sizedbox = SizedBox(
      height: deviceSize.height * 0.02,
    );
    myprofile = Provider.of<MyProfileProvider>(context).myProfile;
    Failure? failure = Provider.of<MyProfileProvider>(context).failure;
    late Widget widget;
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    date.text = outputFormat.format(today);
    // Build a Form widget using the _formKey created above.
    super.build(context); // Ensure to call super.build

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget1));
        return false;
      },
      child: SafeArea(
          child: Scaffold(
              body: date.text.isNotEmpty
                  ? widget = SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: deviceSize.height * 0.02),
                        child: Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment:
                                  screenOrientation.toString() ==
                                          'Orientation.portrait'
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                              children: [
                                // Wrap(
                                //   children: [
                                //     Padding(
                                //       padding: EdgeInsets.only(
                                //         top: deviceSize.height * 0.02,
                                //         left: deviceSize.height < 815 &&
                                //                 screenOrientation.toString() ==
                                //                     'Orientation.portrait'
                                //              deviceSize.width * 0.15
                                //             : deviceSize.height > 815 &&
                                //                     screenOrientation
                                //                             .toString() ==
                                //                         'Orientation.portrait'
                                //                  deviceSize.width * 0.08
                                //                 : deviceSize.width * 0.115,
                                //         right: deviceSize.width * 0.12,
                                //       ),
                                //       child: const Text(
                                //           'Hey!, Please choose your preferable date and time slot'),
                                //     ),
                                //   ],
                                // ),
                                screenOrientation.toString() ==
                                        'Orientation.landscape'
                                    ? sizedbox
                                    : const SizedBox(),
                                deviceSize.width > 800 &&
                                        screenOrientation.toString() ==
                                            'Orientation.landscape'
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            bottom: deviceSize.height * 0.04,
                                            left: deviceSize.width * 0.115,
                                            top: deviceSize.height * 0.02),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            calendar(deviceSize.width * 0.37),
                                            timeSlots2.isNotEmpty
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: deviceSize.width *
                                                            0.02,
                                                        top: deviceSize.height *
                                                            0.001),
                                                    child: slotsWidget(
                                                        deviceSize.width *
                                                            0.37),
                                                  )
                                                : timeSlots2.isEmpty
                                                    ? Padding(
                                                        padding: EdgeInsets.only(
                                                            left: deviceSize
                                                                    .width *
                                                                0.05,
                                                            top: deviceSize
                                                                    .height *
                                                                0.1),
                                                        child: noSlotsWidget(),
                                                      )
                                                    : const SizedBox()
                                          ],
                                        ),
                                      )
                                    : deviceSize.width > 600 &&
                                            screenOrientation.toString() ==
                                                'Orientation.portrait'
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: deviceSize.height * 0.015,
                                                bottom:
                                                    deviceSize.height * 0.017),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  calendar(
                                                      deviceSize.width * 0.6),
                                                  timeSlots2.isNotEmpty
                                                      ? Padding(
                                                          padding: EdgeInsets.only(
                                                              top: deviceSize
                                                                      .height *
                                                                  0.015),
                                                          child: slotsWidget(
                                                              deviceSize.width *
                                                                  0.5),
                                                        )
                                                      : timeSlots2.isEmpty
                                                          ? Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: deviceSize
                                                                          .height *
                                                                      0.015),
                                                              child:
                                                                  noSlotsWidget(),
                                                            )
                                                          : const SizedBox()
                                                ]),
                                          )
                                        : deviceSize.width < 600 &&
                                                screenOrientation.toString() ==
                                                    'Orientation.portrait'
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    top: deviceSize.height *
                                                        0.015,
                                                    bottom: deviceSize.height *
                                                        0.017),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      calendar(
                                                          deviceSize.width *
                                                              0.7),
                                                      timeSlots2.isNotEmpty
                                                          ? Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: deviceSize
                                                                          .height *
                                                                      0.015),
                                                              child: slotsWidget(
                                                                  deviceSize
                                                                          .width *
                                                                      0.65),
                                                            )
                                                          : timeSlots2.isEmpty
                                                              ? Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: deviceSize
                                                                              .height *
                                                                          0.015),
                                                                  child:
                                                                      noSlotsWidget(),
                                                                )
                                                              : const SizedBox()
                                                    ]),
                                              )
                                            : deviceSize.width < 600 &&
                                                    screenOrientation
                                                            .toString() ==
                                                        'Orientation.portrait'
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            deviceSize.height *
                                                                0.04,
                                                        left: deviceSize.width *
                                                            0.115,
                                                        top: deviceSize.height *
                                                            0.02),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        calendar(
                                                            deviceSize.width *
                                                                0.37),
                                                        timeSlots2.isNotEmpty
                                                            ? Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: deviceSize
                                                                            .width *
                                                                        0.02,
                                                                    top: deviceSize
                                                                            .height *
                                                                        0.001),
                                                                child: slotsWidget(
                                                                    deviceSize
                                                                            .width *
                                                                        0.37),
                                                              )
                                                            : timeSlots2.isEmpty
                                                                ? Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: deviceSize.height *
                                                                            0.015),
                                                                    child:
                                                                        noSlotsWidget(),
                                                                  )
                                                                : const SizedBox()
                                                      ],
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            deviceSize.height *
                                                                0.04,
                                                        left: deviceSize.width *
                                                            0.115,
                                                        top: deviceSize.height *
                                                            0.023),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        calendar(
                                                            deviceSize.width *
                                                                0.37),
                                                        timeSlots2.isNotEmpty
                                                            ? Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: deviceSize
                                                                            .width *
                                                                        0.02,
                                                                    top: deviceSize
                                                                            .height *
                                                                        0.001),
                                                                child: slotsWidget(
                                                                    deviceSize
                                                                            .width *
                                                                        0.37),
                                                              )
                                                            : timeSlots2.isEmpty
                                                                ? Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: deviceSize.height *
                                                                            0.015),
                                                                    child:
                                                                        noSlotsWidget(),
                                                                  )
                                                                : const SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: deviceSize.height * 0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: deviceSize.width * 0.3,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                // Color.fromARGB(255, 7, 176, 150),
                                                Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                          ),
                                          onPressed: () {
                                            // Validate returns true if the form is valid, or false otherwise.
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: deviceSize.width * 0.3,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                // Color.fromARGB(255, 7, 176, 150),
                                                finaltime == null
                                                    ? const Color.fromARGB(
                                                        255, 207, 206, 206)
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (finaltime == null) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please select valid date/time slot");
                                            }
                                            print(
                                                'day and time ---------$focusedday  $finaltime');
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs
                                                .setString('widget', page)
                                                .toString();

                                            // Validate returns true if the form is valid, or false otherwise.
                                            if (formkey1.currentState!
                                                    .validate() &&
                                                autoaddress.isNotEmpty) {
                                              if (formKey2.currentState!
                                                  .validate()) {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                      print('mob is---------=================---$mobile');
                                                  var bookedApt;
                                                  // ignore: prefer_typing_uninitialized_variables
                                                  bookAppointment() async {
                                                    bookedApt = await Provider
                                                            .of<BookAppointmentProvider>(
                                                                context,
                                                                listen: false)
                                                        .eitherFailureOrBookAppointment(
                                                            entityname:
                                                                entityName,
                                                            appointmenttype:
                                                                existingPatient
                                                                    ? 'existing'
                                                                    : 'new',
                                                            patientid:
                                                                existingPatient
                                                                    ? patientId
                                                                    : null,
                                                            clientid: clientID,
                                                            branchid: branchid,
                                                            serviceid: sid,
                                                            userid: userId,
                                                            servicecharges:
                                                                double.parse(
                                                                    charges
                                                                        .text),
                                                            referencedoctor:
                                                                refDoc,
                                                            appointmenttimestamp:
                                                                '$focusedday $finaltime',
                                                            patientdata: {
                                                          "email": email,
                                                          "mobile": mobile,
                                                          "firstname":
                                                              firstname,
                                                          "lastname": lastname,
                                                          "age": int.parse(age),
                                                          "gender":
                                                              selectedGender,
                                                          "address_line1":
                                                              autoaddress,
                                                          "address_line2":
                                                              address,
                                                          "country": country,
                                                          "state": state,
                                                          "city": city,
                                                          "zip_code": zipcode,
                                                          "id_proof_type_id":
                                                              proofId,
                                                          "id_proof_number":
                                                              idnumber
                                                        });
                                                  }

                                                  finaltime == null
                                                      ? null
                                                      : await bookAppointment();
                                                  Navigator.pop(context);

                                                  // If the form is valid, display a snackbar. In the real world,
                                                  // you'd often call a server or save the information in a database.
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Please provide date and time to proceed! ');
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Please fill fields in appointments section! ');
                                              }
                                            }
                                          },
                                          child: const Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
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
                  : failure != null
                      ? widget = Expanded(
                          child: Center(
                            child: Text(
                              failure.errorMessage,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      : widget = const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ))),
    );
  }

  Widget calendar(double widthIs) => Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 247, 247),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3), // Offset in the x and y direction
            ),
          ],
        ),
        width: widthIs,
        child: TableCalendar(
          selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
          availableGestures: AvailableGestures.all,
          headerStyle: HeaderStyle(
            titleTextStyle: Theme.of(context).textTheme.bodySmall!,
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
              // Highlight today's date
              color: Color.fromARGB(255, 77, 167, 134),
              shape: BoxShape.circle,
            ),
            weekendTextStyle: Theme.of(context).textTheme.bodySmall!,
            defaultTextStyle: Theme.of(context).textTheme.bodySmall!,
            todayDecoration: const BoxDecoration(
              // Highlight today's date
              color: Color.fromARGB(255, 124, 201, 173),
              shape: BoxShape.circle,
            ),
          ),
          focusedDay: _focusedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030, 3, 14),
          onCalendarCreated: (focusedDay) {
            _onDaySelected(DateTime.now(), DateTime.now());
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              timeSlots2 = [];
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // Keep focus on the selected day
              dateselected = true;
            });
            _onDaySelected(selectedDay, _focusedDay);
          },
        ),
      );
  Widget slotsWidget(double widthIs) => Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 251, 252, 251),
          borderRadius: BorderRadius.circular(12),
        ),
        width: widthIs,
        child: Column(children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.3,
            ),
            shrinkWrap: true,
            itemCount: timeSlots2.length,
            //  hoursAvailable.length,
            itemBuilder: (BuildContext context, int index) {
              String time = '';

              bool tapped = true;
              String slot = timeSlots2[index]['slot'].toString();
              String availability = timeSlots2[index]['status'].toString();

              availability == "Available" ? tapped : tapped = false;
              DateFormat("yyyy-MM-dd HH:mm:ss")
                      .parse(
                          "${selectedDay!.year}-${selectedDay!.month}-${selectedDay!.day} ${timeSlots2[index]['slot']}:00")
                      .isBefore(currentTime)
                  ? tapped = false
                  : null;
              time = slot;
              DateFormat inputFormat = DateFormat('HH:mm');
              DateTime time3 = inputFormat.parse(time).toLocal();

              DateFormat outputFormat = DateFormat('hh:mm a');
              String convertedTime2 = outputFormat.format(time3);
              // Get the current time

              // Parse the given time strtimeSlots2[index]['slot']ing

              // Define text color based on whether the time is older or not

              return GestureDetector(
                onTap: () {
                  if (tapped) {
                    setState(() {
                      visitTimeSlot = time;
                    });
                    String givenTimeString =
                        "${selectedDay!.year}-${selectedDay!.month}-${selectedDay!.day} $time:00";
                    givenTime = DateFormat("yyyy-MM-dd HH:mm:ss")
                        .parse(givenTimeString);
                    print('given time-----$givenTime');
                    print('current time-----$currentTime');

                    givenTime!.isBefore(currentTime)
                        ? Fluttertoast.showToast(
                            msg: "Invalid time slot!",
                            gravity: ToastGravity.CENTER)
                        : null;
                  } else {
                    setState(() {
                      visitTimeSlot = 'empty';
                    });
                  }
                  setState(() {
                    tapped = true;
                    selectedIndex = index;
                  });
                  visitTimeSlot == 'empty'
                      ? Fluttertoast.showToast(
                          msg: "Please select available time slot !",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          // backgroundColor: const Color.fromARGB(255, 86, 5, 36),
                          textColor: Colors.white,
                          fontSize: 14.0)
                      : null;

                  DateTime originalTime = DateFormat.Hm().parse(visitTimeSlot);

                  formattedTimeString =
                      DateFormat.Hms().format(originalTime).toString();
                  print('tapped 2  ---$formattedTimeString');

                  DateTime parsedTime =
                      DateFormat("HH:mm").parse(visitTimeSlot);
                  String twentyFourHourTime =
                      DateFormat("HH:mm:ss").format(parsedTime);
                  setState(() {
                    selectedIndex = index;
                    finaltime = twentyFourHourTime;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        // height: 0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: selectedIndex == index &&
                                        timeSlots2[index]['status'] ==
                                            'Available'
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : timeSlots2[index]['status'] == 'Available'
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : timeSlots2[index]['status'] ==
                                                'Booked'
                                            ? Colors.black
                                            : Colors.transparent),
                            color: selectedIndex == index &&
                                    timeSlots2[index]['status'] ==
                                        'Available' &&
                                    DateFormat("yyyy-MM-dd HH:mm:ss")
                                        .parse(
                                            "${selectedDay!.year}-${selectedDay!.month}-${selectedDay!.day} ${timeSlots2[index]['slot']}:00")
                                        .isBefore(currentTime)
                                ? const Color.fromARGB(255, 227, 226, 226)
                                : selectedIndex == index &&
                                        timeSlots2[index]['status'] ==
                                            'Available'
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : timeSlots2[index]['status'] != 'Booked' &&
                                            DateFormat("yyyy-MM-dd HH:mm:ss")
                                                .parse(
                                                    "${selectedDay!.year}-${selectedDay!.month}-${selectedDay!.day} ${timeSlots2[index]['slot']}:00")
                                                .isBefore(currentTime)
                                        ? const Color.fromARGB(
                                            255, 227, 226, 226)
                                        : timeSlots2[index]['status'] ==
                                                'Available'
                                            ? const Color.fromARGB(
                                                255, 250, 255, 250)
                                            : timeSlots2[index]['status'] ==
                                                    'Booked'
                                                ? const Color.fromARGB(
                                                    255, 204, 200, 200)
                                                : null),
                        child: SizedBox(
                            // height: deviceSize
                            //         .height *
                            // 0.034,
                            child: Center(
                                child: Text(convertedTime2,
                                    style: selectedIndex == index &&
                                            timeSlots2[index]['status'] ==
                                                'Available' &&
                                            DateFormat("yyyy-MM-dd HH:mm:ss")
                                                .parse(
                                                    "${selectedDay!.year}-${selectedDay!.month}-${selectedDay!.day} ${timeSlots2[index]['slot']}:00")
                                                .isBefore(currentTime)
                                        ? Theme.of(context).textTheme.bodySmall
                                        : selectedIndex == index &&
                                                timeSlots2[index]['status'] ==
                                                    'Available'
                                            ? const TextStyle(
                                                color: Colors.white,
                                              )
                                            : timeSlots2[index]['status'] ==
                                                    'Available'
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodySmall))),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 5,
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.01),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.025,
                          width: MediaQuery.of(context).size.width * 0.025,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      Text(
                        'Selected',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 5,
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.01),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.025,
                          width:
                              MediaQuery.of(context).orientation.toString() ==
                                      'portrait'
                                  ? MediaQuery.of(context).size.width * 0.045
                                  : MediaQuery.of(context).size.width * 0.025,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              borderRadius: BorderRadius.circular(3),
                              color: const Color.fromARGB(255, 250, 255, 250)),
                        ),
                      ),
                      Text(
                        'Available',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.01),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.025,
                          width: MediaQuery.of(context).size.width * 0.025,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: const Color.fromARGB(255, 204, 200, 200)),
                        ),
                      ),
                      Text(
                        'Booked',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      );

  Widget noSlotsWidget() => const Center(
        child: Text(
          'No Slots Available',
          style: TextStyle(
              color: Color.fromARGB(255, 116, 160, 4),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      );
}
