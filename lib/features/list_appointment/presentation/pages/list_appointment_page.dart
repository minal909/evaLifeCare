// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/pages/book_apt_form.dart';
import 'package:eva_life_care/features/list_appointment/data/models/list_appointment_model.dart';
import 'package:eva_life_care/features/list_appointment/presentation/widgets/card_appointment.dart';
import 'package:eva_life_care/features/my_profile/presentation/pages/my_profile.dart';
import 'package:eva_life_care/features/skeleton/widgets/app_bar_widget.dart';
import 'package:eva_life_care/features/skeleton/widgets/bottom_app_bar.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/skeleton/widgets/navigation_drawer.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool aptBackButton = false;

class ListAppointmentPage extends StatefulWidget {
  const ListAppointmentPage({super.key});

  @override
  State<ListAppointmentPage> createState() => _ListAppointmentPageState();
}

class _ListAppointmentPageState extends State<ListAppointmentPage>
    with WidgetsBindingObserver {
  final Dio dio = Dio();
  var currentTime;

  List<ResultAptList> aptlist1 = [];
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController service = TextEditingController();
  bool isService = false;
  bool isFilter = false;

  // final   List servicelist12 = [];
  //    servicelist12 =serviceList;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    isFilter = false;
    LogInProvider provider = Provider.of<LogInProvider>(context, listen: false);
    provider.fetchService(context);
    provider.fetchId(context);

    fetchData(context);
    // aptlist1 = LogInProvider.aptlist;
    // Provider.of<ListAppointmentProvider>(context, listen: false)
    //     .eitherFailureOrListAppointment();
    // Provider.of<ListAppointmentProvider>(context, listen: false)
    //     .eitherFailureOrListAppointment();

    // TODO: implement initState

    // Initialize Dio with interceptors
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // bool changed = false;
  // @override
  // void didChangeMetrics() {
  //   changed = true;
  // }
  // WidgetsBinding.instance.addObserver(this);

  String? thisservice;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool pulledDown = false;
  fetchData(BuildContext context) async {
    aptlist1 = [];
    LogInProvider provider = Provider.of<LogInProvider>(context, listen: false);
    var result = await provider.getListAppointment(
        context: context,
        isPulledDown: pulledDown,
        isFilter: isFilter,
        name: name.text,
        mobile: mobile.text,
        service: isService == false ? service.text : thisservice.toString());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aptlist1 = result.result;
      prefs.setString('widget', 'listappointments');
    });
    print('-----+++++++++++++${aptlist1.length}');
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  // @override
  // void didChangeMetrics() {
  //   super.didChangeMetrics();
  //   // if (Navigator.of(context).canPop()) {
  //   Navigator.of(context).pop();
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    var screenOrientation1 = MediaQuery.orientationOf(context);

    LogInProvider loginprovider = LogInProvider();
    Size deviceSize = MediaQuery.of(context).size;

    // fetchData(context);

    // ignore: deprecated_member_use
    return WillPopScope(
      // onWillPop: () async {
      //   closeApp() {
      //     Navigator.of(context).popUntil((route) => route.isFirst);
      //     SystemNavigator.pop();
      //   }

      //   // Show dialog and handle back button press
      //   return profileUpdate ? null : SystemNavigator.pop();
      // },
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentTime == null ||
            now.difference(currentTime) > const Duration(seconds: 2)) {
          //add duration of press gap
          currentTime = now;
          Fluttertoast.showToast(msg: "Press back again to exit");
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text()));
          return Future.value(false);
        } else {
          SystemNavigator.pop();
          exit(0);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const NavigationDrawerWidget(),
        appBar: MyAppbar(
          widget: const ListAppointmentPage(),
        ),
        bottomNavigationBar: const BottomAppWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () async {
              WidgetHelper.endLoading();
              // fetchService(context);
              bool isConnected =
                  await NetworkInfoImpl(DataConnectionChecker()).isConnected;
              if (!isConnected) {
                Fluttertoast.showToast(msg: "No internet connection!");
                // Provider.of<MyAuthProvider>(context, listen: false)v
                //     .signOutCurrentUser();
                // wschannel.sink.close();
              } else {
                loginprovider.fetchService(context);

                loginprovider.fetchId(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BookAppointment(
                            const ListAppointmentPage(),
                            listOfService,
                            listOfidproof,
                            serviceList,
                            "listappointments")));
              }
            },
            tooltip: 'Book Appointment',
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xffd8e7e8),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  deviceSize.height * 0.005 * deviceSize.width * 0.005,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Appointment List',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenOrientation1.toString() ==
                                    "Orientation.portrait" &&
                                deviceSize.height > 650
                            ? deviceSize.width * 0.029
                            : screenOrientation1.toString() ==
                                    "Orientation.landscape"
                                ? deviceSize.width * 0.021
                                : deviceSize.width * 0.04,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        thisservice = null;
                        isFilter = false;
                        name.clear();
                        mobile.clear();
                        // changed = false;

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            // changed ? Navigator.pop(context) : null;

                            // orientationChange ? Navigator.pop(context) : null;

                            return SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: SizedBox(
                                  height: screenOrientation1.toString() ==
                                          "Orientation.portrait"
                                      ? MediaQuery.of(context).size.height *
                                          0.35
                                      : MediaQuery.of(context).size.height *
                                          0.5,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 37, right: 37),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.filter_alt_outlined,
                                                size: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                              Text(
                                                'Filters',
                                                style: TextStyle(
                                                  fontSize: screenOrientation1
                                                              .toString() ==
                                                          "Orientation.landscape"
                                                      ? deviceSize.width * 0.019
                                                      : deviceSize.width * 0.03,
                                                ),
                                              ),
                                              const Flexible(
                                                fit: FlexFit.tight,
                                                child: SizedBox(
                                                  width: 1,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  isFilter = false;
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceSize.height * 0.025,
                                              right: deviceSize.width * 0.008),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6))),
                                            height:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.045
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.07,
                                            width:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.8
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.5,
                                            child: TextFormField(
                                              textAlign: TextAlign.start,
                                              controller: name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              onChanged: (value) async {
                                                name.text = value;
                                                //   // searchdoc;
                                                //   setState(() {
                                                //     // name = value.toLowerCase();
                                                //   });
                                              },
                                              // maxLines: 2,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                labelText: 'Patient Name',
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: deviceSize.height * 0.015),
                                        // sizedbox,
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: deviceSize.width * 0.008),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6))),
                                            height:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.045
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.07,
                                            width:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.8
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.5,
                                            child: TextFormField(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,

                                              keyboardType:
                                                  TextInputType.number,
                                              controller: mobile,
                                              // maxLines: 2,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                labelText: 'Mobile',
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6))),
                                              ),
                                              onChanged: (value) async {
                                                mobile.text = value;
                                                //   // searchdoc;
                                                //   setState(() {
                                                //     // mobnosearch = value;
                                                //   });
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: deviceSize.height * 0.015),

                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: deviceSize.width * 0.012),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6))),
                                            height:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.045
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.07,
                                            width:
                                                screenOrientation1.toString() ==
                                                        "Orientation.portrait"
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.8
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.5,
                                            child: DropdownButtonFormField(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16.0),
                                                  labelText: "Service",
                                                  labelStyle: Theme.of(
                                                          context)
                                                      .textTheme
                                                      .bodySmall,
                                                  hintText: "Service",
                                                  hintStyle: Theme.of(
                                                          context)
                                                      .textTheme
                                                      .bodySmall,
                                                  errorStyle:
                                                      const TextStyle(
                                                          fontSize: 0.05),
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          4)))),
                                              items: serviceList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: thisservice,
                                              onChanged: (value) async {
                                                isService = true;
                                                thisservice = value.toString();
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter value';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: deviceSize.height * 0.015),

                                        // sizedbox,
                                        // GestureDetector(
                                        //   onTap: () async {},
                                        // child:
                                        Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 54, 232, 205),
                                                    Color.fromARGB(
                                                        255, 3, 146, 124),
                                                  ])),
                                          height:
                                              screenOrientation1.toString() ==
                                                      "Orientation.portrait"
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.07,
                                          width:
                                              screenOrientation1.toString() ==
                                                      "Orientation.portrait"
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              isFilter = true;
                                              Navigator.pop(context);
                                              await fetchData(context);
                                              pulledDown = false;
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor:
                                                    Colors.transparent),
                                            child: Text(
                                              'Apply',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: screenOrientation1
                                                              .toString() ==
                                                          "Orientation.portrait"
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.018),
                                            ),
                                          ),
                                        ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: deviceSize.width * 0.01,
                            ),
                            child: Icon(
                              Icons.filter_alt_outlined,
                              size: 15,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Filters',
                            style: TextStyle(
                              fontSize: screenOrientation1.toString() ==
                                      "Orientation.landscape"
                                  ? deviceSize.width * 0.019
                                  : deviceSize.width * 0.03,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              isFilter && aptlist1.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(left: deviceSize.width * 0.35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "-----Filter results------",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: screenOrientation1.toString() ==
                                        'Orientation.portrait'
                                    ? deviceSize.width * 0.03
                                    : deviceSize.width * 0.02),
                          ),
                          const Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox(
                              width: 1,
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                name.clear();
                                mobile.clear();
                                isFilter = false;
                                pulledDown = true;

                                await fetchData(context);
                              },
                              child: const Text('clear filters'))
                        ],
                      ),
                    )
                  : isFilter && aptlist1.isEmpty
                      ? const Text("No appointments found")
                      : const SizedBox(),
              Expanded(
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  color: Colors.white,
                  strokeWidth: 2.0,
                  backgroundColor: const Color.fromARGB(137, 23, 22, 22),
                  onRefresh: () async {
                    name.clear();
                    mobile.clear();
                    isFilter = false;
                    pulledDown = true;

                    await fetchData(context);
                    // Replace this delay with the code to be executed during refresh
                    // and return a Future when code finishes execution.
                    return Future<void>.delayed(const Duration(seconds: 1));
                  },
                  child: ListView.builder(
                    itemCount: aptlist1.length,
                    itemBuilder: (context, index) {
                      DateTime datetime =
                          aptlist1[index].appointmentTimestamp.toLocal();
                      String timestamp = aptlist1[index]
                          .appointmentTimestamp
                          .toString()
                          .substring(0, 19);
                      String time = datetime.toString().substring(11, 19);

                      DateTime inputDateTime =
                          DateFormat("HH:mm:ss").parse(time);

                      // Format the DateTime object to a time string with AM/PM and in local timezone
                      String formattedTime =
                          DateFormat("hh:mm a").format(inputDateTime.toLocal());

                      // DateFormat outputFormat = DateFormat('hh:mm a');
                      // String convertedTime = outputFormat.format(time3);
                      String date = datetime.toString().substring(0, 10);

                      return CardAppointment(
                        billAddress: aptlist1[index].billingAddress,
                        mobile: aptlist1[index].mobile,
                        docid: aptlist1[index].userId,
                        patientid: aptlist1[index].patientId,
                        timestamp: timestamp,
                        aptlist: aptlist1,
                        id: aptlist1[index].appointmentId,
                        name:
                            '${aptlist1[index].pFirstname} ${aptlist1[index].pLastname}',
                        status: aptlist1[index].appointmentStatus.name,
                        date: date,
                        time: formattedTime,
                        drname:
                            '${aptlist1[index].uFirstname} ${aptlist1[index].uLastname}',
                        service: aptlist1[index].serviceName,
                        orderSubtotal: aptlist1[index].orderSubtotal,
                        invStatus: aptlist1[index].invoiceStatus,

                        // Add more properties or customize ListTile as needed
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: deviceSize.height * 0.013,
                decoration: const BoxDecoration(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
