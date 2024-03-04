import 'package:eva_life_care/features/list_appointment/presentation/pages/list_appointment_page.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/first_user_login.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/forgot_password.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/login_page.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/otp_verification.dart';
import 'package:eva_life_care/features/skeleton/widgets/cleint_inactive.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // var upcoming = [];
    // var newApts = 0;
    // var newPatients = 0;
    // var allPatients = 0;
    // var billing = '';
    // getval() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   int cId = prefs.getInt('clientId')!.toInt();

    //   final upcoming1 = await AppointmentController.upcomingApt(cId);
    //   upcoming = upcoming1['result'];
    //   final newApts1 = await AppointmentController.newAppointments(cId);
    //   newApts = newApts1['result'];
    //   final newPatients1 = await AppointmentController.newPatients(cId);
    //   newPatients = newPatients1['result'];
    //   final allPatients1 = await AppointmentController.totalPatients(cId);
    //   allPatients = allPatients1['result'];
    //   final billing1 = await AppointmentController.totalBilling(cId);
    //   billing = billing1['result'];
    // }

    // getval();

    switch (settings.name) {
      case '/firstlogin':
        return MaterialPageRoute(builder: (_) => const FirstLogin());

      // child: UserDashboard(
      //     upcoming, newApts, newPatients, allPatients, billing),

      case '/loginpage':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/listappointmentspage':
        return MaterialPageRoute(builder: (_) =>  const ListAppointmentPage());
      case '/otpverification':
        return MaterialPageRoute(builder: (_) => const OtpVerification());
      case '/clientinactive':
        return MaterialPageRoute(builder: (_) => const ClientInactive());
      case '/forgotpassword':
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child:
                        Text('There is no route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
