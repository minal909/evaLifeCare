import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/core/errors/failure.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/get_slots_provider.dart';
import 'package:eva_life_care/features/list_appointment/presentation/pages/list_appointment_page.dart';
import 'package:eva_life_care/features/list_appointment/presentation/providers/reschedule_provider.dart';
import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
import 'package:eva_life_care/features/my_profile/presentation/providers/my_profile_provider.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class RescheduleAppointment extends StatefulWidget {
  final String oldDate;
  final String oldTime;
  final int aptid;
  final String oldTimeStamp;
  final int userid;
  final int patientid;

  const RescheduleAppointment(
      {required this.oldDate,
      required this.oldTime,
      required this.aptid,
      required this.oldTimeStamp,
      required this.userid,
      required this.patientid,
      super.key});

  @override
  // ignore: no_logic_in_create_state
  State<RescheduleAppointment> createState() => RescheduleAppointmentState(
      oldDate, oldTime, aptid, oldTimeStamp, userid, patientid);
}

// Create a corresponding State class.
// This class holds data related to the form.
class RescheduleAppointmentState extends State<RescheduleAppointment> {
  final String oldDate;
  final String oldTime;
  int aptid;
  String oldTimeStamp;
  int userid;
  int patientid;
  RescheduleAppointmentState(this.oldDate, this.oldTime, this.aptid,
      this.oldTimeStamp, this.userid, this.patientid);
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  TextEditingController date = TextEditingController();
  DateTime today = DateTime.now();
  String visitTimeSlot = '';

  List<Map<String, dynamic>> timeSlots2 = [];
  String formattedTimeString = '';
  String focusedday = '';
  String focusedday2 = '';
  DateTime? selectedDay;
  DateTime? givenTime;
  DateTime currentTime = DateTime.now();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<AppointmentDateTimeState>.
  final _formKey = GlobalKey<FormState>();
  MyProfileEntity? myprofile;

  @override
  void initState() {
    // bool light = false;

    // TODO: implement initState
    super.initState();
    // storedContext = context;
  }

  var selectedIndex;
  String convertdate = '';
  DateTime aptdateis = DateTime.now();
  String? finaltime;

  void _onDaySelected(DateTime day, DateTime focusedDay) async {
    selectedDay = day;

    timeSlots2 = [];
    SlotsListProvider slotsListIs =
        Provider.of<SlotsListProvider>(context, listen: false);
    DateTime dayy = day.toLocal();

    DateFormat outputFormat = DateFormat('yyyy-MM-dd');

    focusedday = outputFormat.format(dayy);

    var result = await slotsListIs.getSlotsList(
        userid: userid, branchid: branchID, date: focusedday);
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
    DateTime previousdate = DateTime(
      int.parse(oldTimeStamp.substring(0, 4)),
      int.parse(oldTimeStamp.substring(5, 7)),
      int.parse(oldTimeStamp.substring(8, 10)),
      int.parse(oldTimeStamp.substring(11, 13)),
      int.parse(oldTimeStamp.substring(14, 16)),
    );

    String formattedTimestamp =
        DateFormat('dd MMM yyyy  hh:mm a').format(previousdate);

    // Build a Form widget using the _formKey created above.

    return Scaffold(
        appBar: AppBar(
          title: const Text('Reschedule Apppointment'),
        ),
        body: date.text.isNotEmpty
            ? widget = SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: deviceSize.height * 0.02),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: screenOrientation.toString() ==
                                'Orientation.portrait'
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: deviceSize.height * 0.02,
                                  left: deviceSize.height < 815 &&
                                          screenOrientation.toString() ==
                                              'Orientation.portrait'
                                      ? deviceSize.width * 0.15
                                      : deviceSize.height > 815 &&
                                              screenOrientation.toString() ==
                                                  'Orientation.portrait'
                                          ? deviceSize.width * 0.15
                                          : deviceSize.width * 0.115,
                                  right: deviceSize.width * 0.12,
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Appointment number: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '$aptid',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const Flexible(child: SizedBox(width: 1))
                            ],
                          ),
                          screenOrientation.toString() ==
                                  'Orientation.landscape'
                              ? sizedbox
                              : const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: deviceSize.height * 0.02,
                                  left: deviceSize.height < 815 &&
                                          screenOrientation.toString() ==
                                              'Orientation.portrait'
                                      ? deviceSize.width * 0.15
                                      : deviceSize.height > 815 &&
                                              screenOrientation.toString() ==
                                                  'Orientation.portrait'
                                          ? deviceSize.width * 0.15
                                          : deviceSize.width * 0.115,
                                  right: deviceSize.width * 0.12,
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Previous booked slot:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      ' $formattedTimestamp',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const Flexible(child: SizedBox(width: 1))
                            ],
                          ),
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
                                                  left: deviceSize.width * 0.02,
                                                  top: deviceSize.height *
                                                      0.001),
                                              child: slotsWidget(
                                                  deviceSize.width * 0.37),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  left: deviceSize.width * 0.05,
                                                  top: deviceSize.height * 0.1),
                                              child: noSlotsWidget(),
                                            )
                                    ],
                                  ),
                                )
                              : deviceSize.width > 600 &&
                                      screenOrientation.toString() ==
                                          'Orientation.portrait'
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: deviceSize.height * 0.015,
                                          bottom: deviceSize.height * 0.017),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            calendar(deviceSize.width * 0.6),
                                            timeSlots2.isNotEmpty
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        top: deviceSize.height *
                                                            0.015),
                                                    child: slotsWidget(
                                                        deviceSize.width * 0.5),
                                                  )
                                                : noSlotsWidget()
                                          ]),
                                    )
                                  : deviceSize.width < 600 &&
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
                                                    deviceSize.width * 0.7),
                                                timeSlots2.isNotEmpty
                                                    ? Padding(
                                                        padding: EdgeInsets.only(
                                                            top: deviceSize
                                                                    .height *
                                                                0.015),
                                                        child: slotsWidget(
                                                            deviceSize.width *
                                                                0.65),
                                                      )
                                                    : noSlotsWidget()
                                              ]),
                                        )
                                      : deviceSize.width < 600 &&
                                              screenOrientation.toString() ==
                                                  'Orientation.portrait'
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  bottom:
                                                      deviceSize.height * 0.04,
                                                  left:
                                                      deviceSize.width * 0.115,
                                                  top:
                                                      deviceSize.height * 0.02),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  calendar(
                                                      deviceSize.width * 0.37),
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
                                                              deviceSize.width *
                                                                  0.37),
                                                        )
                                                      : noSlotsWidget()
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  bottom:
                                                      deviceSize.height * 0.04,
                                                  left:
                                                      deviceSize.width * 0.115,
                                                  top: deviceSize.height *
                                                      0.023),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  calendar(
                                                      deviceSize.width * 0.37),
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
                                                              deviceSize.width *
                                                                  0.37),
                                                        )
                                                      : noSlotsWidget()
                                                ],
                                              ),
                                            ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: deviceSize.height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const ListAppointmentPage()));
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
                                          Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                    ),
                                    onPressed: () async {
                                      bool isConnected = await NetworkInfoImpl(
                                              DataConnectionChecker())
                                          .isConnected;
                                      if (!isConnected) {
                                        WidgetHelper.endLoading();
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NoInternet(
                                                        onPressed: () async {
                                                      bool isConnected =
                                                          await NetworkInfoImpl(
                                                                  DataConnectionChecker())
                                                              .isConnected;
                                                      isConnected == false
                                                          ? WidgetHelper
                                                              .endLoading()
                                                          : WidgetHelper
                                                              .startLoading("");

                                                      if (!isConnected) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "No internet connection!",
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER);
                                                      } else {
                                                        // ignore: use_build_context_synchronously

// ignore: use_build_context_synchronously
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    RescheduleAppointment(
                                                                      oldDate:
                                                                          oldDate,
                                                                      oldTime:
                                                                          oldTime,
                                                                      aptid:
                                                                          aptid,
                                                                      oldTimeStamp:
                                                                          oldTimeStamp,
                                                                      userid:
                                                                          userid,
                                                                      patientid:
                                                                          patientid,
                                                                    )));
                                                        // await getData(context);
                                                      }
                                                    })));

                                        // Provider.of<MyAuthProvider>(context, listen: false)
                                        //     .signOutCurrentUser();
                                        // wschannel.sink.close();
                                      } else {
                                        if (_formKey.currentState!.validate()) {
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                          // ignore: use_build_context_synchronously
                                          var rescheduled = await Provider.of<
                                                      RescheduleProvider>(
                                                  context,
                                                  listen: false)
                                              .eitherFailureOrReschedule(
                                                  aptid: aptid,
                                                  userid: userid,
                                                  patientid: patientid,
                                                  oldtimestamp: oldTimeStamp,
                                                  newtimestamp:
                                                      "$focusedday $finaltime");
                                        }
                                      }

                                      // Validate returns true if the form is valid, or false otherwise.
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
                  ));
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
          onCalendarCreated: (focusedDay) async {
            bool isConnected =
                await NetworkInfoImpl(DataConnectionChecker()).isConnected;
            isConnected == false
                ? Fluttertoast.showToast(
                    msg: "No internet connection!",
                    gravity: ToastGravity.CENTER)
                : _onDaySelected(DateTime.now(), DateTime.now());
          },
          onDaySelected: (selectedDay, focusedDay) async {
            getSlots() {
              setState(() {
                timeSlots2 = [];
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // Keep focus on the selected day
              });
              _onDaySelected(selectedDay, _focusedDay);
            }

            bool isConnected =
                await NetworkInfoImpl(DataConnectionChecker()).isConnected;
            isConnected == false
                ? Fluttertoast.showToast(
                    msg: "No internet connection!",
                    gravity: ToastGravity.CENTER)
                : getSlots();
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
              var shortestSide = MediaQuery.of(context).size.shortestSide;

              // Determine if we should use mobile layout or not, 600 here is
              // a common breakpoint for a typical 7-inch tablet.

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
              DateTime time3 = inputFormat.parse(time);

              DateFormat outputFormat = DateFormat('hh:mm a');
              String convertedTime2 = outputFormat.format(time3);

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
                  DateTime originalTime =
                      DateFormat.Hm().parse(visitTimeSlot).toUtc();

                  formattedTimeString = DateFormat.Hms().format(originalTime);

                  DateTime parsedTime =
                      DateFormat("HH:mm").parse(visitTimeSlot);
                  String twentyFourHourTime =
                      DateFormat("HH:mm:ss").format(parsedTime);
                  setState(() {
                    selectedIndex = index;
                    finaltime = twentyFourHourTime;
                  });
                  print('time selected ------$twentyFourHourTime');
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
