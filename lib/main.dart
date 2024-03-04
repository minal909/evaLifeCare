// import 'dart:async';

// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:eva_life_care/amplifyconfiguration.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/providers/book_apt_provider.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/providers/get_slots_provider.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_service_provider.dart';
// import 'package:eva_life_care/features/list_appointment/presentation/providers/orderTotal_provider.dart';
// import 'package:eva_life_care/features/list_appointment/presentation/providers/pay_invoice_provider.dart';
// import 'package:eva_life_care/features/list_appointment/presentation/providers/reschedule_provider.dart';
// import 'package:eva_life_care/features/list_invoice/presentation/providers/list_invoice_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:eva_life_care/features/Routes/routers.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_doctor_provider.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_idproof_provider.dart';
// import 'package:eva_life_care/features/list_appointment/presentation/pages/list_appointment_page.dart';
// import 'package:eva_life_care/features/my_profile/presentation/providers/update_profile_provider.dart';
// import 'package:eva_life_care/features/user%20authentication/presentation/pages/login_page.dart';
// import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
// import 'package:eva_life_care/features/my_profile/presentation/providers/my_profile_provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:flutter/foundation.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// dynamic authsession;

// void main() async {
//   runZonedGuarded(
//     () async {
//       WidgetsFlutterBinding.ensureInitialized();
//       await Firebase.initializeApp();

//       FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
//       if (kReleaseMode) {
//         await dotenv.load(fileName: ".env.production");
//       } else {
//         await dotenv.load(fileName: ".env.development");
//       }

//       await _initializeAmplify();
//       // Initialize Amplify

//       // Check session expiry and navigate accordingly
//       try {
//         var authsession = await Amplify.Auth.fetchAuthSession();
//         if (authsession.isSignedIn) {
//           // User is signed in and the session is valid, navigate to the dashboard
//           runApp(MultiProvider(
//               providers: [
//                 ChangeNotifierProvider<ListInvoiceProvider>(
//                   create: (context) => ListInvoiceProvider(),
//                 ),
//                 ChangeNotifierProvider<PayInvoiceProvider>(
//                   create: (context) => PayInvoiceProvider(),
//                 ),
//                 ChangeNotifierProvider<OrderTotalProvider>(
//                   create: (context) => OrderTotalProvider(),
//                 ),
//                 ChangeNotifierProvider<RescheduleProvider>(
//                   create: (context) => RescheduleProvider(),
//                 ),
//                 ChangeNotifierProvider<BookAppointmentProvider>(
//                   create: (context) => BookAppointmentProvider(),
//                 ),
//                 ChangeNotifierProvider<LogInProvider>(
//                   create: (context) => LogInProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => MyProfileProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => UpdateProfileProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => ListServiceProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => ListDoctorProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => ListIdProofProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => SlotsListProvider(),
//                 ),
//               ],
//               child: MyApp(
//                 isSignedIn: authsession.isSignedIn,
//               )));
//         } else {
//           // User session has expired or is not signed in, navigate to the login page
//           runApp(MultiProvider(
//               providers: [
//                 ChangeNotifierProvider<ListInvoiceProvider>(
//                   create: (context) => ListInvoiceProvider(),
//                 ),
//                 ChangeNotifierProvider<PayInvoiceProvider>(
//                   create: (context) => PayInvoiceProvider(),
//                 ),
//                 ChangeNotifierProvider<OrderTotalProvider>(
//                   create: (context) => OrderTotalProvider(),
//                 ),
//                 ChangeNotifierProvider<RescheduleProvider>(
//                   create: (context) => RescheduleProvider(),
//                 ),
//                 ChangeNotifierProvider<BookAppointmentProvider>(
//                   create: (context) => BookAppointmentProvider(),
//                 ),
//                 ChangeNotifierProvider<LogInProvider>(
//                   create: (context) => LogInProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => MyProfileProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => UpdateProfileProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => ListServiceProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => ListDoctorProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => ListIdProofProvider(),
//                 ),
//                 ChangeNotifierProvider(
//                   create: (context) => SlotsListProvider(),
//                 ),
//               ],
//               child: const MyApp(
//                 isSignedIn: false,
//               )));
//         }
//       } catch (e) {
//         runApp(MultiProvider(
//             providers: [
//               ChangeNotifierProvider<ListInvoiceProvider>(
//                 create: (context) => ListInvoiceProvider(),
//               ),
//               ChangeNotifierProvider<PayInvoiceProvider>(
//                 create: (context) => PayInvoiceProvider(),
//               ),
//               ChangeNotifierProvider<OrderTotalProvider>(
//                 create: (context) => OrderTotalProvider(),
//               ),
//               ChangeNotifierProvider<RescheduleProvider>(
//                 create: (context) => RescheduleProvider(),
//               ),
//               ChangeNotifierProvider<BookAppointmentProvider>(
//                 create: (context) => BookAppointmentProvider(),
//               ),
//               ChangeNotifierProvider(
//                 create: (context) => LogInProvider(),
//               ),
//               ChangeNotifierProvider(
//                 create: (context) => MyProfileProvider(),
//               ),
//               ChangeNotifierProvider(
//                 create: (context) => UpdateProfileProvider(),
//               ),
//               ChangeNotifierProvider(
//                 create: (context) => ListServiceProvider(),
//               ),
//               ChangeNotifierProvider(
//                 create: (context) => ListDoctorProvider(),
//               ),
//               ChangeNotifierProvider(
//                 create: (context) => ListIdProofProvider(),
//               ),
//               ChangeNotifierProvider(
//                 create: (context) => SlotsListProvider(),
//               ),
//             ],
//             child: const MyApp(
//               isSignedIn: false,
//             )));
//       }

//       // SharedPreferences prefs = await SharedPreferences.getInstance();

//       await Firebase.initializeApp(
//         options: FirebaseOptions(
//           apiKey: dotenv.env['apiKey'].toString(),
//           appId: dotenv.env['appId'].toString(),
//           messagingSenderId: dotenv.env['messagingSenderId'].toString(),
//           projectId: dotenv.env['projectId'].toString(),
//         ),
//       );
//       FlutterError.onError =
//           FirebaseCrashlytics.instance.recordFlutterFatalError;
//     },
//     (error, stack) async {
//       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//     },
//   );
// }

// // upcoming1 = [];
// // var newApts1 = [];
// // var newPatients1 = [];
// // var allPatient1 = [];
// // var billing1 = [];

// Future<void> _initializeAmplify() async {
//   try {
//     final authPlugin = AmplifyAuthCognito();
//     await Amplify.addPlugins([authPlugin]);
//     await Amplify.configure(amplifyconfig);
//   } catch (e) {}
// }

// callGetProfile(BuildContext context) {
//   final loginprovider = LogInProvider();
//   loginprovider.getProfileStatus(context);
// }

// class MyApp extends StatelessWidget {
//   final bool isSignedIn;

//   const MyApp({super.key, required this.isSignedIn});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveApp(builder: (context) {
//       return MultiProvider(
//           providers: [
//             ChangeNotifierProvider<ListInvoiceProvider>(
//               create: (context) => ListInvoiceProvider(),
//             ),
//             ChangeNotifierProvider<PayInvoiceProvider>(
//               create: (context) => PayInvoiceProvider(),
//             ),
//             ChangeNotifierProvider<OrderTotalProvider>(
//               create: (context) => OrderTotalProvider(),
//             ),
//             ChangeNotifierProvider<RescheduleProvider>(
//               create: (context) => RescheduleProvider(),
//             ),
//             ChangeNotifierProvider<BookAppointmentProvider>(
//               create: (context) => BookAppointmentProvider(),
//             ),
//             ChangeNotifierProvider(
//               create: (context) => SlotsListProvider(),
//             ),
//             ChangeNotifierProvider(
//               create: (context) => LogInProvider(),
//             ),
//             ChangeNotifierProvider(
//               create: (context) => MyProfileProvider(),
//             ),
//             ChangeNotifierProvider(
//               create: (context) => UpdateProfileProvider(),
//             ),
//             ChangeNotifierProvider(
//               create: (context) => ListServiceProvider(),
//             ),
//             ChangeNotifierProvider(
//               create: (context) => ListDoctorProvider(),
//             ),
//             ChangeNotifierProvider(
//               create: (context) => ListIdProofProvider(),
//             ),
//           ],
//           child: MaterialApp(
//             builder: EasyLoading.init(),
//             onGenerateRoute: Routers.generateRoute,
//             navigatorKey: navigatorKey,
//             debugShowCheckedModeBanner: false,
//             routes: {
//               'loginpage': (context) => const LoginPage(),
//               // Other named routes...
//             },
//             title: 'Eva Life Care',
//             theme: ThemeData(
//               useMaterial3: true,

//               // Define the default brightness and colors.
//               colorScheme: const ColorScheme(
//                 onPrimary: Color.fromARGB(255, 7, 176, 150),
//                 brightness: Brightness.dark,
//                 primary: Color.fromARGB(255, 41, 124, 94),
//                 secondary: Color.fromARGB(255, 235, 237, 236),
//                 onSecondary: Color.fromARGB(255, 0, 0, 0),
//                 error: Color.fromARGB(255, 170, 8, 8),
//                 onError: Color.fromARGB(255, 170, 8, 8),
//                 background: Colors.white,
//                 onBackground: Colors.grey,
//                 surface: Color.fromARGB(255, 253, 253, 253),
//                 onSurface: Color.fromARGB(255, 56, 55, 55),
//                 primaryContainer: Color.fromARGB(255, 56, 55, 55),
//               ),
//               appBarTheme: const AppBarTheme(
//                 titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
//                 backgroundColor: Color.fromARGB(255, 7, 176, 150),
//                 iconTheme: IconThemeData(
//                   color: Color.fromARGB(
//                       255, 255, 252, 252), // Set your desired color here
//                 ),
//               ),

//               // Define the default `TextTheme`. Use this to specify the default
//               // text styling for headlines, titles, bodies of text, and more.
//               textTheme: TextTheme(
//                 displayLarge: const TextStyle(
//                   fontSize: 72,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 // ···
//                 titleLarge: GoogleFonts.robotoFlex(
//                   fontSize: 30,
//                 ),
//                 bodyMedium: GoogleFonts.robotoFlex(),
//                 displaySmall: GoogleFonts.robotoFlex(),
//               ),
//             ),
//             home: isSignedIn
//                  FutureBuilder(
//                     future: callGetProfile(
//                         context), // Wait for the API calls to complete
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         // API calls are finished, navigate to UserDashboard
//                         return const ListAppointmentPage();
//                       } else {
//                         // API calls are still in progress, show a loading indicator
//                         return const Scaffold(
//                           body: Center(child: CircularProgressIndicator()),
//                         );
//                       }
//                     })
//                 : const LoginPage(),
//           ));
//     });
//   }
// }

import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:eva_life_care/amplifyconfiguration.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/book_apt_provider.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/get_slots_provider.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_service_provider.dart';
import 'package:eva_life_care/features/list_appointment/presentation/providers/orderTotal_provider.dart';
import 'package:eva_life_care/features/list_appointment/presentation/providers/pay_invoice_provider.dart';
import 'package:eva_life_care/features/list_appointment/presentation/providers/reschedule_provider.dart';
import 'package:eva_life_care/features/list_invoice/presentation/providers/list_invoice_provider.dart';
import 'package:provider/provider.dart';
import 'package:eva_life_care/features/Routes/routers.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_doctor_provider.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_idproof_provider.dart';
import 'package:eva_life_care/features/list_appointment/presentation/pages/list_appointment_page.dart';
import 'package:eva_life_care/features/my_profile/presentation/providers/update_profile_provider.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/login_page.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/features/my_profile/presentation/providers/my_profile_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/foundation.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

dynamic authsession;

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      if (kReleaseMode) {
        await dotenv.load(fileName: ".env.production");
      } else {
        await dotenv.load(fileName: ".env.development");
      }

      await _initializeAmplify();
      // Initialize Amplify

      // Check session expiry and navigate accordingly
      try {
        var authsession = await Amplify.Auth.fetchAuthSession();
        if (authsession.isSignedIn) {
          // User is signed in and the session is valid, navigate to the dashboard
          runApp(MultiProvider(
              providers: [
                ChangeNotifierProvider<ListInvoiceProvider>(
                  create: (context) => ListInvoiceProvider(),
                ),
                ChangeNotifierProvider<PayInvoiceProvider>(
                  create: (context) => PayInvoiceProvider(),
                ),
                ChangeNotifierProvider<OrderTotalProvider>(
                  create: (context) => OrderTotalProvider(),
                ),
                ChangeNotifierProvider<RescheduleProvider>(
                  create: (context) => RescheduleProvider(),
                ),
                ChangeNotifierProvider<BookAppointmentProvider>(
                  create: (context) => BookAppointmentProvider(),
                ),
                ChangeNotifierProvider<LogInProvider>(
                  create: (context) => LogInProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => MyProfileProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => UpdateProfileProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ListServiceProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ListDoctorProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ListIdProofProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => SlotsListProvider(),
                ),
              ],
              child: MyApp(
                isSignedIn: authsession.isSignedIn,
              )));
        } else {
          // User session has expired or is not signed in, navigate to the login page
          runApp(MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ListInvoiceProvider(),
                ),
                ChangeNotifierProvider<PayInvoiceProvider>(
                  create: (context) => PayInvoiceProvider(),
                ),
                ChangeNotifierProvider<OrderTotalProvider>(
                  create: (context) => OrderTotalProvider(),
                ),
                ChangeNotifierProvider<RescheduleProvider>(
                  create: (context) => RescheduleProvider(),
                ),
                ChangeNotifierProvider<BookAppointmentProvider>(
                  create: (context) => BookAppointmentProvider(),
                ),
                ChangeNotifierProvider<LogInProvider>(
                  create: (context) => LogInProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => MyProfileProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => UpdateProfileProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ListServiceProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ListDoctorProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ListIdProofProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => SlotsListProvider(),
                ),
              ],
              child: const MyApp(
                isSignedIn: false,
              )));
        }
      } catch (e) {
        runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => ListInvoiceProvider(),
              ),
              ChangeNotifierProvider<PayInvoiceProvider>(
                create: (context) => PayInvoiceProvider(),
              ),
              ChangeNotifierProvider<OrderTotalProvider>(
                create: (context) => OrderTotalProvider(),
              ),
              ChangeNotifierProvider<RescheduleProvider>(
                create: (context) => RescheduleProvider(),
              ),
              ChangeNotifierProvider<BookAppointmentProvider>(
                create: (context) => BookAppointmentProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => LogInProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => MyProfileProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => UpdateProfileProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => ListServiceProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => ListDoctorProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => ListIdProofProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => SlotsListProvider(),
              ),
            ],
            child: const MyApp(
              isSignedIn: false,
            )));
      }

      // SharedPreferences prefs = await SharedPreferences.getInstance();

      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: dotenv.env['apiKey'].toString(),
          appId: dotenv.env['appId'].toString(),
          messagingSenderId: dotenv.env['messagingSenderId'].toString(),
          projectId: dotenv.env['projectId'].toString(),
        ),
      );
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    },
    (error, stack) async {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

// upcoming1 = [];
// var newApts1 = [];
// var newPatients1 = [];
// var allPatient1 = [];
// var billing1 = [];

Future<void> _initializeAmplify() async {
  try {
    final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugins([authPlugin]);
    await Amplify.configure(amplifyconfig);
  } catch (e) {}
}

callGetProfile(BuildContext context) {
  final loginprovider = LogInProvider();
  loginprovider.getProfileStatus(context);
}

class MyApp extends StatelessWidget {
  final bool isSignedIn;

  const MyApp({super.key, required this.isSignedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(builder: (context) {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ListInvoiceProvider(),
            ),
            ChangeNotifierProvider<PayInvoiceProvider>(
              create: (context) => PayInvoiceProvider(),
            ),
            ChangeNotifierProvider<OrderTotalProvider>(
              create: (context) => OrderTotalProvider(),
            ),
            ChangeNotifierProvider<RescheduleProvider>(
              create: (context) => RescheduleProvider(),
            ),
            ChangeNotifierProvider<BookAppointmentProvider>(
              create: (context) => BookAppointmentProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => SlotsListProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => LogInProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => MyProfileProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => UpdateProfileProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ListServiceProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ListDoctorProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ListIdProofProvider(),
            ),
          ],
          child: MaterialApp(
            builder: EasyLoading.init(),
            onGenerateRoute: Routers.generateRoute,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            routes: {
              'loginpage': (context) => const LoginPage(),
              // Other named routes...
            },
            title: 'Eva Life Care',
            theme: ThemeData(
              useMaterial3: true,

              // Define the default brightness and colors.
              colorScheme: const ColorScheme(
                onPrimary: Color.fromARGB(255, 7, 176, 150),
                brightness: Brightness.dark,
                primary: Color.fromARGB(255, 41, 124, 94),
                secondary: Color.fromARGB(255, 235, 237, 236),
                onSecondary: Color.fromARGB(255, 0, 0, 0),
                error: Color.fromARGB(255, 170, 8, 8),
                onError: Color.fromARGB(255, 170, 8, 8),
                background: Colors.white,
                onBackground: Colors.grey,
                surface: Color.fromARGB(255, 253, 253, 253),
                onSurface: Color.fromARGB(255, 56, 55, 55),
                primaryContainer: Color.fromARGB(255, 56, 55, 55),
              ),
              appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
                backgroundColor: Color.fromARGB(255, 7, 176, 150),
                iconTheme: IconThemeData(
                  color: Color.fromARGB(
                      255, 255, 252, 252), // Set your desired color here
                ),
              ),

              // Define the default `TextTheme`. Use this to specify the default
              // text styling for headlines, titles, bodies of text, and more.
              textTheme: TextTheme(
                displayLarge: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                ),
                // ···
                titleLarge: GoogleFonts.robotoFlex(
                  fontSize: 30,
                ),
                bodyMedium: GoogleFonts.robotoFlex(),
                displaySmall: GoogleFonts.robotoFlex(),
              ),
            ),
            home: MultiProvider(
              providers: [
                ChangeNotifierProvider<LogInProvider>.value(
                    value: LogInProvider()),
              ],
              child: isSignedIn
                  ? FutureBuilder(
                      future: callGetProfile(
                          context), // Wait for the API calls to complete
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // API calls are finished, navigate to UserDashboard
                          return const ListAppointmentPage();
                        } else {
                          // API calls are still in progress, show a loading indicator
                          return const Scaffold(
                            body: Center(child: CircularProgressIndicator()),
                          );
                        }
                      })
                  : const LoginPage(),
            ),
          ));
    });
  }
}
