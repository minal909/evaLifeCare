// ignore_for_file: avoid_print

import 'dart:async';

// import 'package:eva_life_care/Controller/ApiList.dart';
// import 'package:eva_life_care/main.dart';
// import 'package:eva_life_care/ui/Appointments/BookAppointment.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/core/errors/failure.dart';
import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
import 'package:eva_life_care/features/my_profile/presentation/pages/my_profile.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/change_password.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/features/my_profile/presentation/providers/my_profile_provider.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
// import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'Controller/appointmentController.dart';Flogout
// import 'Helper/auth_provider.dart';
// import 'changenot.dart';

class MyAppbar extends StatefulWidget implements PreferredSizeWidget {
  Widget widget;

  MyAppbar({required this.widget, super.key});

  @override
  State<MyAppbar> createState() => _MyAppbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // static updateCounter(String newCounter) {
  //   currentLimit = newCounter;
  // }
}

class _MyAppbarState extends State<MyAppbar> {
  String msgCounter = '';
  Color whitecolor = Colors.white;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userEmail = TextEditingController();

  TextEditingController userAddress = TextEditingController();
  TextEditingController userMobile = TextEditingController();

  TextEditingController country1 = TextEditingController();
  TextEditingController state1 = TextEditingController();
  TextEditingController city1 = TextEditingController();
  TextEditingController pncode = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  String inLimit = '';
  String cname = '';
  String? selectedState;
  bool checkid = false;
  // String? selectedCountry;

  String fname = '';
  String lname = '';
  String email = '';
  String address = '';
  String country = '';
  String state = '';
  int age = 0;
  String city = '';
  String pincode = '';
  List<int> servicelist = <int>[];
  String mobile = '';
  String gender = '';
  String designation = '';
  String department = '';

  final List<String> items = [
    'Male',
    'Female',
  ];

  // void updateStateList() async {
  //   // List countries = await AppointmentController.fetchStates(countryid);
  //   setState(() {
  //     // statesList = [];
  //     // for (int i = 0; i < countries.length; i++) {
  //     //   statesList.add(countries[i]['state_name']);
  //     // }
  //   });
  // }

  int clientid = 0;
  int userid = 0;

  Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String email = prefs.getString('email_id').toString();
    String clientname = prefs.getString('clientName').toString();
    String clientLogo = prefs.getString('cLogo').toString();
    //  String role_name = await prefs.getString('role_name').toString();
    int cId = prefs.getInt('clientId')!.toInt();
    int uid = prefs.getInt('userId')!.toInt();
    // final msglmt = await ApiCaller.messageLimit(cId);
    String cognitoId = prefs.getString("cognito_id").toString();
    // ignore: use_build_context_synchronously
    await fetchData(context);

    // String currentmsg =
    //     Provider.of<CurrentLimitProvider>(context, listen: false).currentLimit;

    // final mLimit = msglmt['result']['current-limit'];

    // String messageLimit = mLimit.toString();
    if (mounted) {
      setState(() {
        clientid = cId;
        userid = uid;
        // emailid = email;
        // clName = clientname;
        // clientLogo1 = client_logo;
        // // inLimit = mLimit.toString();
        // checkid = prefs.getBool('checkid') as bool;

        // cid1 = cId;
        // List<String> diagnostics1 = <String>['Select Service'];
      });
    }
  }

  // void resetValues() {
  //   setState(() {
  //     // c2 = <String>['Select Country'];
  //     // countryStates = <String>['Select State'];
  //   });
  // }

  @override
  void initState() {
    init();

    // TODO: implement initState
    super.initState();
  }

  MyProfileEntity? myprof;

  fetchData(BuildContext context) async {
    await Provider.of<MyProfileProvider>(context, listen: false)
        .eitherFailureOrMyProfile(clId: clientid, usrId: userid);
    // ignore: await_only_futures, use_build_context_synchronously
    myprof = Provider.of<MyProfileProvider>(context, listen: false).myProfile;
  }

  // getData(BuildContext context) {
  //   Provider.of<MyProfileProvider>(context, listen: false)
  //       .eitherFailureOrMyProfile(clId: clientid, usrId: userid);
  //   myprof = Provider.of<MyProfileProvider>(context, listen: false).myProfile;
  // }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    Failure? failure1;

    // if (NetworkInfoImpl(DataConnectionChecker()).isConnected == false) {
    //   Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => NoInternet(
    //       onPressed: () async {
    //         await fetchProfile();
    //       },
    //     ),
    //   ));
    //   print(
    //       'value is ++++++++++++++++++..............................${myprof!.result}');
    // }
    return AppBar(
      toolbarHeight: 35,
      title: Padding(
        padding: EdgeInsets.only(top: deviceSize.height * 0.02),
        child: Text(
          entityName,
          // clName,
          style: const TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(
                Icons.menu,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: PopupMenuButton(
            onOpened: () {
              fetchData(context);
              // ignore: use_build_context_synchronously
            },
            color: Colors.white,
            icon: const Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
              size: 25,
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                // value: "en",
                onTap: () async {
                  WidgetHelper.startLoading('');
                  // await fetchData(context);
                  bool isConnected =
                      await NetworkInfoImpl(DataConnectionChecker())
                          .isConnected;

                  if (!isConnected) {
                    WidgetHelper.endLoading();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoInternet(
                        onPressed: () async {
                          bool isConnected =
                              await NetworkInfoImpl(DataConnectionChecker())
                                  .isConnected;
                          isConnected == false
                              ? WidgetHelper.endLoading()
                              : WidgetHelper.startLoading("");

                          if (!isConnected) {
                            Fluttertoast.showToast(
                                msg: "No internet connection!",
                                gravity: ToastGravity.CENTER);
                          } else {
                            // ignore: use_build_context_synchronously
                            await fetchData(context);

// ignore: use_build_context_synchronously
                            // await getData(context);
                            selectedGender = myprof!.result.gender;
                            void closePopupMenu(BuildContext context) {
                              final navigator = Navigator.of(context);
                              navigator.maybePop();
                            }

                            // ignore: use_build_context_synchronously
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => MyPofileWidget(
                                          widget: widget.widget,
                                          age: myprof!.result.age.toString(),
                                          mobile: myprof!.result.mobile,
                                          firstName: myprof!.result.firstname,
                                          lastName: myprof!.result.lastname,
                                          accessrole:
                                              myprof!.result.access_role,
                                          email: myprof!.result.emailId,
                                          address1: myprof!.result.addressLine1,
                                          address2: myprof!.result.addressLine2,
                                          city: myprof!.result.city,
                                          zipcode: myprof!.result.zipCode,
                                          state: myprof!.result.state,
                                          country: myprof!.result.country,
                                          department: myprof!.result.department,
                                          designation:
                                              myprof!.result.designation,
                                        )))
                                .then((_) {
                              // This code will run when you return back from the EditScreen
                              // Close the PopupMenuButton using GlobalKey
                              closePopupMenu(context);
                            });
                            WidgetHelper.endLoading();
                          }
                          // isConnected == false
                          //     ? Fluttertoast.showToast(
                          //         msg: "No internet connection!",
                          //         gravity: ToastGravity.CENTER)
                          //     // ignore: use_build_context_synchronously
                          //     : fetchData(context);
                        },
                      ),
                    ));
                  } else {
                    // ignore: use_build_context_synchronously
                    await fetchData(context);

// ignore: use_build_context_synchronously
                    // await getData(context);
                    selectedGender = myprof!.result.gender;
                    void closePopupMenu(BuildContext context) {
                      final navigator = Navigator.of(context);
                      navigator.maybePop();
                    }

                    // ignore: use_build_context_synchronously
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => MyPofileWidget(
                                  widget: widget.widget,
                                  age: myprof!.result.age.toString(),
                                  mobile: myprof!.result.mobile,
                                  firstName: myprof!.result.firstname,
                                  lastName: myprof!.result.lastname,
                                  accessrole: myprof!.result.access_role,
                                  email: myprof!.result.emailId,
                                  address1: myprof!.result.addressLine1,
                                  address2: myprof!.result.addressLine2,
                                  city: myprof!.result.city,
                                  zipcode: myprof!.result.zipCode,
                                  state: myprof!.result.state,
                                  country: myprof!.result.country,
                                  department: myprof!.result.department,
                                  designation: myprof!.result.designation,
                                )))
                        .then((_) {
                      // This code will run when you return back from the EditScreen
                      // Close the PopupMenuButton using GlobalKey
                      closePopupMenu(context);
                    });
                    WidgetHelper.endLoading();
                  }
                },
                child: Row(children: [
                  Icon(
                    Icons.person_4_rounded,
                    size: 18,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 15),
                  Text("My Profile",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
                ]),
              ),
              PopupMenuItem(
                // value: "de",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangePassword(),
                  ));
                  // Provider.of<MyAuthProvider>(context, listen: false)
                  //     .signOutCurrentUser();
                  // wschannel.sink.close();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 18,
                      color: Theme.of(context).colorScheme.onPrimary,

                      // color: greencolor,
                    ),
                    const SizedBox(width: 15),
                    Text("Change Password",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        )),
                  ],
                ),
              ),
              PopupMenuItem(
                // value: "de",
                onTap: () async {
                  bool isConnected =
                      await NetworkInfoImpl(DataConnectionChecker())
                          .isConnected;
                  if (!isConnected) {
                    WidgetHelper.endLoading();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NoInternet(onPressed: () async {
                              bool isConnected =
                                  await NetworkInfoImpl(DataConnectionChecker())
                                      .isConnected;
                              isConnected == false
                                  ? WidgetHelper.endLoading()
                                  : WidgetHelper.startLoading("");

                              if (!isConnected) {
                                Fluttertoast.showToast(
                                    msg: "No internet connection!",
                                    gravity: ToastGravity.CENTER);
                              } else {
                                // ignore: use_build_context_synchronously
                                Provider.of<LogInProvider>(context,
                                        listen: false)
                                    .signOutCurrentUser();
// ignore: use_build_context_synchronously
                                // await getData(context);
                                void closePopupMenu(BuildContext context) {
                                  final navigator = Navigator.of(context);
                                  navigator.maybePop();
                                }
                              }
                            })));

                    // Provider.of<MyAuthProvider>(context, listen: false)
                    //     .signOutCurrentUser();
                    // wschannel.sink.close();
                  } else {
                    Provider.of<LogInProvider>(context, listen: false)
                        .signOutCurrentUser();
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.login_outlined,
                      size: 18,
                      color: Theme.of(context).colorScheme.onPrimary,

                      // color: greencolor,
                    ),
                    const SizedBox(width: 15),
                    Text("LogOut",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
