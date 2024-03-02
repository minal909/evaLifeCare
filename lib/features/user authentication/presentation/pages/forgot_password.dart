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

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailverify = TextEditingController();
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
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: deviceSize.height * 0.05,
                ),
                child: Text(
                  "A verification code will be sent to the email address you provide.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom:
                        screenOrientation.toString() == 'Orientation.portrait'
                            ? deviceSize.height * 0.022
                            : deviceSize.height * 0.042),
                child: ReusableTextFormField(
                  controller: emailverify,
                  hintText: 'Email Address',
                  labelText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  prefIcon: Icons.email_rounded,
                ),
              ),
              ReusableButton(
                text: 'Send verification code',
                onPressed: () async {
                  if (emailverify.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please enter email address !');
                  } else {
                    Provider.of<LogInProvider>(context, listen: false)
                        .resetPassword(emailverify.text);
                    if (await NetworkInfoImpl(DataConnectionChecker())
                            .isConnected ==
                        false) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NoInternet(
                          onPressed: () {
                            Provider.of<LogInProvider>(context, listen: false)
                                .resetPassword(emailverify.text);
                          },
                        ),
                      ));
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
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
