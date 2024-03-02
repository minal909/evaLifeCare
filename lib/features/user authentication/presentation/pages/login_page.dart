import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/forgot_password.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/widgets/loginModuleWidget/ReuseTextFormField.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/widgets/loginModuleWidget/reusableButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// ignore: prefer_typing_uninitialized_variables
var screenOrientation;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  //  @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    screenOrientation = MediaQuery.orientationOf(context);
    var padding = 0;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: deviceSize.height * 0.03),
                  child: SizedBox(
                    width: deviceSize.width * 0.3,
                    height:
                        screenOrientation.toString() == 'Orientation.portrait'
                            ? deviceSize.height * 0.2
                            : deviceSize.height * 0.32,
                    child: Image.asset('assets/images/eva_logo.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: deviceSize.height * 0.05,
                  ),
                  child: Text(
                    'Log In',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom:
                          screenOrientation.toString() == 'Orientation.portrait'
                              ? deviceSize.height * 0.01
                              : deviceSize.height * 0.042),
                  child: ReusableTextFormField(
                    controller: email,
                    hintText: 'Email Address',
                    labelText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    prefIcon: Icons.email_rounded,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom:
                          screenOrientation.toString() == 'Orientation.portrait'
                              ? deviceSize.height * 0.025
                              : deviceSize.height * 0.05),
                  child: ReusableTextFormField(
                    controller: password,
                    hintText: 'Password',
                    labelText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    prefIcon: Icons.lock_rounded,
                    sufIcon: Icons.remove_red_eye_outlined,
                  ),
                ),
                ReusableButton(
                    text: 'Log in',
                    onPressed: () async {
                      LogInProvider loginProvider =
                          Provider.of<LogInProvider>(context, listen: false);

                      // final connectivityResult =
                      //     await (Connectivity().checkConnectivity());
                      // connectivityResult == ConnectivityResult.none
                      //     ? Fluttertoast.showToast(
                      //         msg: "No internet connection !")
                      //     : null;

                      if (email.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Please enter email address !');
                      } else {
                        if (password.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Please enter password !');
                        } else {
                          if (email.text.isNotEmpty &&
                              password.text.isNotEmpty) {
                            // Get access to the LogInProvider

                            // Perform login action
                            bool isConnected =
                                await NetworkInfoImpl(DataConnectionChecker())
                                    .isConnected;
                            // ignore: use_build_context_synchronously

                            if (!isConnected) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NoInternet(
                                  onPressed: () async {
                                    bool isConnected = await NetworkInfoImpl(
                                            DataConnectionChecker())
                                        .isConnected;
                                    !isConnected
                                        ? Fluttertoast.showToast(
                                            msg: "No internet connection!",
                                            gravity: ToastGravity.CENTER)
                                        : Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                    // If not connected, attempt login again when retrying
                                  },
                                ),
                              ));
                            } else {
                              // ignore: use_build_context_synchronously
                              loginProvider.login(
                                  context, email.text, password.text, "", "");
                              // ignore: use_build_context_synchronously
                              await loginProvider.fetchId(context);
                            }
                            // await loginProvider.login(
                            //     context, email.text, password.text, "", "");
                            // ignore: use_build_context_synchronously

                            // ignore: use_build_context_synchronously
                            // ignore: use_build_context_synchronously
                            // ignore: use_build_context_synchronously

                            // signedIn ? const CircularProgressIndicator() : null;

                            // Check for network connectivity
                          }
                        }
                      }
                    }),
                TextButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgotPassword(),
                    ));
                  },
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: Color(0xff05668D),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
