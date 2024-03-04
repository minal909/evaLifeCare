// ignore_for_file: unrelated_type_equality_checks

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/core/errors/failure.dart';
import 'package:eva_life_care/features/my_profile/business/entities/my_profile_entity.dart';
import 'package:eva_life_care/features/my_profile/presentation/providers/my_profile_provider.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/widgets/loginModuleWidget/ReuseTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => ChangePasswordState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldpass = TextEditingController();

  TextEditingController newpass = TextEditingController();
  TextEditingController confirmnewpass = TextEditingController();
  bool isVisible = true;

  final List<String> listitems = [
    'Male',
    'Female',
  ];
  final List<String> serviceList = ['s1', 'IT Manager', 'IT'];
  String selectedGender = 'Male';
  String selectedService = '';
  String selectedDesignation = '';
  String selectedDepartment = '';

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<ChangePasswordState>.
  final _formKey = GlobalKey<FormState>();
  MyProfileEntity? myprofile;

  @override
  void initState() {
    // bool light = false;
    init();

    // TODO: implement initState
    super.initState();
    // storedContext = context;
  }

  Future init() async {}

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    var screenOrientation = MediaQuery.orientationOf(context);
    Widget sizedbox = SizedBox(
      height: deviceSize.height * 0.04,
    );
    myprofile = Provider.of<MyProfileProvider>(context).myProfile;
    Failure? failure = Provider.of<MyProfileProvider>(context).failure;
    late Widget widget;

    // Build a Form widget using the _formKey created above.
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Change Password'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: deviceSize.height * 0.2,
                left: deviceSize.width * 0.1,
                right: deviceSize.width * 0.09,
              ),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: deviceSize.width * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ReusableTextFormField(
                              controller: oldpass,
                              hintText: 'Old password',
                              labelText: 'Old password',
                              keyboardType: TextInputType.visiblePassword,
                              prefIcon: Icons.lock_rounded,
                              sufIcon: Icons.remove_red_eye_outlined,
                            ),
                            screenOrientation.toString() ==
                                    'Orientation.landscape'
                                ? sizedbox
                                : const SizedBox(),

                            ReusableTextFormField(
                              controller: newpass,
                              hintText: 'New password',
                              labelText: 'New password',
                              keyboardType: TextInputType.visiblePassword,
                              prefIcon: Icons.lock_rounded,
                              sufIcon: Icons.remove_red_eye_outlined,
                            ),
                            screenOrientation.toString() ==
                                    'Orientation.landscape'
                                ? sizedbox
                                : const SizedBox(),
                            ReusableTextFormField(
                              controller: confirmnewpass,
                              hintText: 'Confirm new password',
                              labelText: 'Confirm new password',
                              keyboardType: TextInputType.visiblePassword,
                              prefIcon: Icons.lock_rounded,
                              sufIcon: Icons.remove_red_eye_outlined,
                            ),
                            screenOrientation.toString() ==
                                    'Orientation.landscape'
                                ? sizedbox
                                : const SizedBox(),

                            // textformfield(
                            //     oldpass,
                            //     'Old password',
                            //     'Old password',
                            //     TextInputType.text,
                            //     Icons.remove_red_eye_outlined),
                            // screenOrientation.toString() ==
                            //         'Orientation.landscape'
                            //     ? sizedbox
                            //     : const SizedBox(),
                            // textformfield(
                            //   newpass,
                            //   'New password',
                            //   'New password',
                            //   TextInputType.text,
                            //   Icons.remove_red_eye_outlined,
                            // ),
                            // screenOrientation.toString() ==
                            //         'Orientation.landscape'
                            //     ? sizedbox
                            //     : const SizedBox(),
                            // textformfield(
                            //     confirmnewpass,
                            //     'Confirm new password',
                            //     'onfirm new password',
                            //     TextInputType.text,
                            //     Icons.remove_red_eye_outlined),
                            // screenOrientation.toString() ==
                            //         'Orientation.landscape'
                            //     ? sizedbox
                            //     : const SizedBox(),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: deviceSize.height * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: deviceSize.width * 0.26,
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
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: deviceSize.width * 0.24,
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
                                        bool isConnected =
                                            await NetworkInfoImpl(
                                                    DataConnectionChecker())
                                                .isConnected;
                                        // ignore: use_build_context_synchronously

                                        if (!isConnected) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => NoInternet(
                                              onPressed: () async {
                                                bool isConnected =
                                                    await NetworkInfoImpl(
                                                            DataConnectionChecker())
                                                        .isConnected;
                                                callAgain() {
                                                  if (confirmnewpass.text !=
                                                          '' &&
                                                      newpass.text != '' &&
                                                      oldpass.text != '') {
                                                    if (newpass.text.compareTo(
                                                            confirmnewpass
                                                                .text) ==
                                                        0) {
                                                      Future<
                                                          int> result = Provider
                                                              .of<LogInProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .changepassword(
                                                              context,
                                                              oldpass.text,
                                                              confirmnewpass
                                                                  .text);
                                                      print(
                                                          'result---------------${result.toString()}');
                                                      // if (result == 0) {
                                                      //   var result1 = Provider.of<
                                                      //               LogInProvider>(
                                                      //           context,
                                                      //           listen: false)
                                                      //       .signOutCurrentUser();

                                                      //   result1
                                                      //       .whenComplete(() {
                                                      //     Navigator.of(
                                                      //             context)
                                                      //         .push(MaterialPageRoute(
                                                      //             builder:
                                                      //                 (context) =>
                                                      //                     const LoginPage()));
                                                      //   });
                                                      // }
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Password doesn't match !",
                                                          toastLength:
                                                              Toast.LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(
                                                                  255, 0, 0, 0),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 12.0);
                                                    }
                                                    // If the form is valid, display a snackbar. In the real world,
                                                    // you'd often call a server or save the information in a database.
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please enter values to update password !",
                                                        toastLength: Toast
                                                            .LENGTH_LONG,
                                                        gravity: ToastGravity
                                                            .CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(
                                                                255, 0, 0, 0),
                                                        textColor: Colors.white,
                                                        fontSize: 12.0);
                                                  }
                                                }

                                                if (!isConnected) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "No internet connection!",
                                                      gravity:
                                                          ToastGravity.CENTER);
                                                } else {
                                                  callAgain();
                                                }
                                              },
                                            ),
                                          ));
                                        } else {
                                          if (confirmnewpass.text != '' &&
                                              newpass.text != '' &&
                                              oldpass.text != '') {
                                            if (newpass.text.compareTo(
                                                    confirmnewpass.text) ==
                                                0) {
                                              Future<int> result =
                                                  // ignore: use_build_context_synchronously
                                                  Provider.of<LogInProvider>(
                                                          context,
                                                          listen: false)
                                                      .changepassword(
                                                          context,
                                                          oldpass.text,
                                                          confirmnewpass.text);
                                              // ignore: use_build_context_synchronously
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Password doesn't match !",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 0, 0, 0),
                                                  textColor: Colors.white,
                                                  fontSize: 12.0);
                                            }
                                            // If the form is valid, display a snackbar. In the real world,
                                            // you'd often call a server or save the information in a database.
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please enter values to update password !",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                textColor: Colors.white,
                                                fontSize: 12.0);
                                          }
                                          // _selectedIndex == 1;
                                          // isWidget = 'listappointments';

                                          // onItemTapped(1, const ListAppointmentPage());
                                        }
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (confirmnewpass.text != '' &&
                                            newpass.text != '' &&
                                            oldpass.text != '') {
                                          if (newpass.text.compareTo(
                                                  confirmnewpass.text) ==
                                              0) {
                                            var result =
                                                Provider.of<LogInProvider>(
                                                        context,
                                                        listen: false)
                                                    .changepassword(
                                                        context,
                                                        oldpass.text,
                                                        confirmnewpass.text);
                                            // result.whenComplete(() {
                                            //   var result1 =
                                            //       Provider.of<LogInProvider>(
                                            //               context,
                                            //               listen: false)
                                            //           .signOutCurrentUser();
                                            //   result1.whenComplete(() {
                                            //     Navigator.of(context).push(
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 const LoginPage()));
                                            //   });
                                            // });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Password doesn't match !",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                textColor: Colors.white,
                                                fontSize: 12.0);
                                          }
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please enter values to update password !",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 0, 0, 0),
                                              textColor: Colors.white,
                                              fontSize: 12.0);
                                        }
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
                      // deviceSize.height > 650 &&
                      //         screenOrientation.toString() ==
                      //             'Orientation.landscape'
                      //     ? Padding(
                      //         padding: EdgeInsets.only(
                      //             bottom: deviceSize.height * 0.04),
                      //         child: SizedBox(
                      //             height: deviceSize.height * 0.46,
                      //             width: deviceSize.width * 0.3,
                      //             child: SvgPicture.asset(
                      //                 'assets/images/change_password.svg')),
                      //       )
                      //     : deviceSize.height > 650 &&
                      //             screenOrientation.toString() ==
                      //                 'Orientation.portrait'
                      //         ? const SizedBox()
                      //         : const SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget textformfield(
          TextEditingController controller,
          String labelText,
          String hintText,
          final TextInputType keyboardType,
          final IconData? sufIcon

          // void Function(String) onChanged
          ) =>
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          style: Theme.of(context).textTheme.bodySmall,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffix: sufIcon != null
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: isVisible
                        ? const Padding(
                            padding: EdgeInsets.only(right: 5, left: 5),
                            child: Icon(
                              Icons.visibility_outlined,
                              size: 17,
                              color: Color.fromARGB(255, 47, 47, 47),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.only(right: 5, left: 5),
                            child: Icon(
                              Icons.visibility_off_outlined,
                              size: 17,
                              color: Color.fromARGB(255, 47, 47, 47),
                            ),
                          ))
                : null,
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            errorStyle: const TextStyle(fontSize: 0.05),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      );
}
