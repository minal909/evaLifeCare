import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/login_page.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/widgets/loginModuleWidget/ReuseTextFormField.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/widgets/loginModuleWidget/reusableButton.dart';
import 'package:eva_life_care/features/skeleton/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController newpassword = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  String? otp;

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
                  "OTP Verification",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: deviceSize.height * 0.05,
                ),
                child: Text(
                  "Enter the six digit verification code sent to your email address.",
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
                child:
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height:
                      screenOrientation.toString() == 'Orientation.landscape'
                          ? deviceSize.height * 0.095
                          : deviceSize.height * 0.062,
                  child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width * 0.8,
                      textFieldAlignment: MainAxisAlignment.spaceEvenly,
                      fieldWidth: 37,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 4,
                      // onChanged: (pin) {
                      //   print("Changed: " + pin);
                      // },
                      onCompleted: (code) {
                        otp = code;
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom:
                        screenOrientation.toString() == 'Orientation.portrait'
                            ? deviceSize.height * 0.022
                            : deviceSize.height * 0.042),
                child: ReusableTextFormField(
                  controller: newpassword,
                  hintText: 'New password',
                  labelText: 'New password',
                  keyboardType: TextInputType.visiblePassword,
                  prefIcon: Icons.lock_rounded,
                  sufIcon: Icons.remove_red_eye_outlined,
                ),
              ),
              ReusableButton(
                  text: 'Submit',
                  onPressed: () async {
                    if (otp == null) {
                      Fluttertoast.showToast(msg: 'Please enter OTP !');
                    } else if (newpassword.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Please enter new password !');
                    } else {
                      if (otp != null && newpassword.text.isNotEmpty) {
                        Provider.of<LogInProvider>(context, listen: false)
                            .confirmResetPassword(
                                newPassword: newpassword.text,
                                confirmationCode: otp!);
                        if (await NetworkInfoImpl(DataConnectionChecker())
                                .isConnected ==
                            false) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NoInternet(
                              onPressed: () {
                                Provider.of<LogInProvider>(context,
                                        listen: false)
                                    .confirmResetPassword(
                                        newPassword: newpassword.text,
                                        confirmationCode: otp!);
                              },
                            ),
                          ));
                        }
                      }
                    }
                  }),
              TextButton(
                onPressed: () {
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
