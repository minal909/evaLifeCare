import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/features/skeleton/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ClientInactive extends StatelessWidget {
  const ClientInactive({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/inactiveClient.svg',
              height: deviceSize.height * 0.25,
              width: deviceSize.width * 0.25,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Account disabled !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Text("Your account is disabled."),
            const Text("Please contact your administrator or recheck."),
            SizedBox(
              height: deviceSize.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: deviceSize.width * 0.278,
                  child: AppButton(
                    text: 'Re-check',
                    onPressed: () {
                      Provider.of<LogInProvider>(context, listen: false)
                          .getProfileStatus(context);
                    },
                  ),
                ),
                SizedBox(
                  width: deviceSize.width * 0.25,
                  child: AppButton(
                    text: 'Logout',
                    onPressed: () {
                      Provider.of<LogInProvider>(context, listen: false)
                          .signOutCurrentUser();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
