import 'package:eva_life_care/features/user%20authentication/presentation/widgets/loginModuleWidget/reusableButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoInternet extends StatelessWidget {
  final VoidCallback onPressed;

  NoInternet({
    super.key,
    required this.onPressed,
  });

  final TextEditingController emailverify = TextEditingController();

  //  @override
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
                padding: EdgeInsets.only(
                    top: screenOrientation.toString() == 'Orientation.portrait'
                        ? deviceSize.height * 0.2
                        : deviceSize.height * 0.075),
                child: SizedBox(
                    width: deviceSize.width * 0.3,
                    height:
                        screenOrientation.toString() == 'Orientation.portrait'
                            ? deviceSize.height * 0.2
                            : deviceSize.height * 0.32,
                    child: SvgPicture.asset(
                      'assets/images/NO net connection.svg',
                      semanticsLabel: 'No internet connection',
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: deviceSize.height * 0.05,
                    top: deviceSize.height * 0.025,
                    left: deviceSize.width * 0.015,
                    right: deviceSize.width * 0.015),
                child: Text(
                  "Something went wrong !!",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: deviceSize.height * 0.05,
                    left: deviceSize.width * 0.015,
                    right: deviceSize.width * 0.015),
                child: Text(
                  "No Internet connection was found. Check your connection or try again.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              ReusableButton(
                text: 'Try again',
                onPressed: onPressed,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
