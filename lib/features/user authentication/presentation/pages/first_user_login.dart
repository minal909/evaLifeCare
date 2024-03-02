import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/login_page.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/widgets/loginModuleWidget/ReuseTextFormField.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/widgets/loginModuleWidget/reusableButton.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FirstLogin extends StatefulWidget {
  const FirstLogin({super.key});

  @override
  State<FirstLogin> createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {
  final TextEditingController newpass = TextEditingController();
  final TextEditingController confirmpass = TextEditingController();
  //  @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    var screenOrientation = MediaQuery.orientationOf(context);
    var padding = 0;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: deviceSize.height * 0.03),
                child: SizedBox(
                  width: deviceSize.width * 0.3,
                  height: screenOrientation.toString() == 'Orientation.portrait'
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
                  'Create Password',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom:
                        screenOrientation.toString() == 'Orientation.portrait'
                            ? deviceSize.height * 0.022
                            : deviceSize.height * 0.042),
                child: ReusableTextFormField(
                  controller: newpass,
                  hintText: 'Enter password',
                  labelText: 'Enter password',
                  keyboardType: TextInputType.visiblePassword,
                  prefIcon: Icons.lock_rounded,
                  sufIcon: Icons.remove_red_eye_outlined,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom:
                        screenOrientation.toString() == 'Orientation.portrait'
                            ? deviceSize.height * 0.025
                            : deviceSize.height * 0.05),
                child: ReusableTextFormField(
                  controller: confirmpass,
                  hintText: 'Confirm password',
                  labelText: 'Confirm password',
                  keyboardType: TextInputType.visiblePassword,
                  prefIcon: Icons.lock_rounded,
                  sufIcon: Icons.remove_red_eye_outlined,
                ),
              ),
              ReusableButton(
                text: 'Save password',
                onPressed: () async {
                  if (newpass.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please enter new password !');
                  } else {
                    if (confirmpass.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Please enter cofirm password !');
                    } else {
                      if (newpass.text.isNotEmpty &&
                          confirmpass.text.isNotEmpty &&
                          newpass.text.compareTo(confirmpass.text) == 0) {
                        Provider.of<LogInProvider>(context, listen: false)
                            .confirmlogin(
                                password: newpass.text, context: context);
                        // Future<bool> isSignedInSuccess =
                        //     providerIs.
                        // ignore: unrelated_type_equality_checks

                        if (await NetworkInfoImpl(DataConnectionChecker())
                                .isConnected ==
                            false) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NoInternet(
                              onPressed: () {
                                Provider.of<LogInProvider>(context,
                                        listen: false)
                                    .confirmlogin(
                                        password: newpass.text,
                                        context: context);
                              },
                            ),
                          ));
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Both passwords doesn' "'t" ' matched !');
                      }
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginPage()));
                },
                child: const Text(
                  'Already have an account? Log in',
                  style: TextStyle(
                    color: Color(0xff05668D),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
