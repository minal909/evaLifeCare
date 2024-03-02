// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:convert';
// import 'dart:io';

// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:dio/dio.dart';
// import 'package:eva_life_care/core/errors/exceptions.dart';
// import 'package:eva_life_care/features/Routes/routeNames.dart';
// import 'package:eva_life_care/features/book%20appointment/business/entities/list_idproof.dart';
// import 'package:eva_life_care/features/book%20appointment/business/entities/list_service.dart';
// import 'package:eva_life_care/features/book%20appointment/data/models/list_service_model.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_idproof_provider.dart';
// import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_service_provider.dart';
// import 'package:eva_life_care/features/list_appointment/data/models/list_appointment_model.dart';
// import 'package:eva_life_care/features/list_appointment/presentation/pages/list_appointment_page.dart';
// import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
// import 'package:eva_life_care/features/user%20authentication/presentation/pages/login_page.dart';
// import 'package:eva_life_care/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // ignore: depend_on_referenced_packages
// import 'package:http/http.dart' as http;
// import 'package:web_socket_channel/web_socket_channel.dart';
// import '../../../../../core/params/params.dart';

// String baseUrl = dotenv.env['baseUrlForApi'].toString();
// var wschannel;
// var mySession;
// int clientID = 0;
// int uId1 = 0;
// List<Result> listOfService = [];
// ListServiceEntity? listservice1;
// int branchID = 0;

// List listOfidproof = [];
// ListIdProofEntity? listidproof;

// List serviceList = [];

// class LogInProvider extends ChangeNotifier {
//   String clientStatus = '';
//   String branchStatus = '';
//   bool followEnable = false;
//   late AmplifyAuthCognito auth;
//   void setFollowEnable(bool f) {
//     followEnable = f;
//     notifyListeners(); // Here the magic happens
//   }

//   dynamic callApi(String url, var model, String type) async {
//     final http.Response response;
//     try {
//       await Amplify.addPlugin(auth);
// //       await Amplify.configure(

// // );

//       // String token = prefs.getString("Api-Token") ?? "No Token Avialable";
//       final mySession = await Amplify.Auth.fetchAuthSession(
//         // ignore: deprecated_member_use
//         options: const CognitoSessionOptions(getAWSCredentials: true),
//       ) as CognitoAuthSession;
//       // ignore: deprecated_member_use
//       final accessToken = mySession.userPoolTokens?.idToken;
//       // (mySession as CognitoAuthSession).userPoolTokens?.idToken ?? "N/A";

//       if (type == "GET") {
//         response = await http.get(
//           Uri.parse(url),
//           headers: {
//             "Content-Type": "application/json",
//             HttpHeaders.authorizationHeader: accessToken.toString(),
//           },
//         );
//       } else {
//         response = await http.post(Uri.parse(url),
//             headers: {
//               "Content-Type": "application/json",
//               HttpHeaders.authorizationHeader: accessToken.toString(),
//             },
//             body: jsonEncode(model));
//       }
//       return response;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<ListAppointmentModel> getListAppointment(
//       {required bool? isPulledDown,
//       required bool? isFilter,
//       required String? name,
//       required String? mobile,
//       required String? service}) async {
//     Dio dio = Dio();
//     final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
//     CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

//     String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
//     String endUrl =
//         'appointment?client_id=$clientID&branch_id=$branchID&name=$name&mobile=$mobile&service=$service';
//     final String finalurl = baseUrl + endUrl;
//     final res;
//     isPulledDown! || isFilter! ? null : WidgetHelper.startLoading('');

//     final response = await dio.get(finalurl,
//         options: Options(headers: {'Authorization': 'Bearer $authToken'}));

//     if (response.statusCode == 404) {
//       isFilter!
//           ? Fluttertoast.showToast(
//               msg: 'Data not found!', gravity: ToastGravity.TOP)
//           : null;
//       WidgetHelper.endLoading();
//     } else if (response.statusMessage.toString() == "failed!") {
//       Fluttertoast.showToast(msg: 'No data available! !');
//     } else if (response.statusCode == 200) {
//       isFilter!
//           ? Fluttertoast.showToast(
//               msg: 'Data found!', gravity: ToastGravity.TOP)
//           : null;
//       WidgetHelper.endLoading();

//       return ListAppointmentModel.fromJson(response.data);
//     }
//     WidgetHelper.endLoading();

//     {
//       WidgetHelper.endLoading();

//       throw ServerException();
//     }
//   }

//   //  if (response.statusCode == 200) {
//   //     isFilter!
//   //         ? Fluttertoast.showToast(
//   //             msg: 'Data found!', gravity: ToastGravity.TOP)
//   //         : null;
//   //     WidgetHelper.endLoading();

//   //     return ListAppointmentModel.fromJson(response.data);
//   //   } else if (response.statusMessage.toString() == "failed!") {
//   //     Fluttertoast.showToast(msg: 'No data available! !');
//   //   } else if (response.statusCode == 404) {
//   //     Fluttertoast.showToast(msg: 'No data available! !');
//   //     WidgetHelper.endLoading();
//   //   }
//   //   WidgetHelper.endLoading();

//   //   {
//   //     WidgetHelper.endLoading();

//   //     throw ServerException();
//   //   }

//   fetchService(BuildContext context) async {
//     serviceList = [];
//     Provider.of<ListServiceProvider>(context, listen: false)
//         .eitherFailureOrListService(clientid: 1);

//     listservice1 =
//         // ignore: await_only_futures
//         await Provider.of<ListServiceProvider>(context, listen: false)
//             .listservice;
//     listOfService = listservice1!.result;
//     // for (int i = 0; i <= listservice!.result.length - 1; i++) {
//     //   listOfService.add(
//     //       '${listservice!.result[i].name} ${listservice!.result[i].amount.toString()}');
//     // }

//     for (int i = 0; i <= listOfService.length - 1; i++) {
//       serviceList.add(listOfService[i].name);
//     }
//   }

//   fetchId(BuildContext context) async {
//     listOfidproof = [];

//     Provider.of<ListIdProofProvider>(context, listen: false)
//         .eitherFailureOrListIdProof(
//       clientid: clientID,
//     );

//     // ignore: await_only_futures
//     listidproof = await Provider.of<ListIdProofProvider>(context, listen: false)
//         .listidproof;
//     for (int i = 0; i <= listidproof!.result.length - 1; i++) {
//       listOfidproof.add(listidproof!.result[i].documentName);
//     }
//   }

//   // Future<ListAppointmentModel> getListAppointment() async {

//   // }

//   // getAptList(context) {
//   //   WidgetHelper.startLoading('');

//   //   ListAppointmentEntity? listApt;

//   //   aptlist = [];
//   //   Provider.of<ListAppointmentProvider>(context, listen: false)
//   //       .eitherFailureOrListAppointment();
//   //   var entity = Provider.of<ListAppointmentProvider>(context, listen: false)
//   //       .listAppointment;
//   //   listApt = entity;

//   //   for (int i = 0; i <= listApt!.result.length - 1; i++) {
//   //     aptlist.add(listApt.result[i] as ResultAptList);
//   //     print('lis apts=============$aptlist');
//   //   }
//   //   WidgetHelper.endLoading();
//   // }

//   getProfileStatus(context) async {
//     LogInProvider loginprovider = LogInProvider();

//     int clientid = 0;
//     String cognitoId = '';

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('checkid', true);

//     cognitoId = prefs.getString("cognito_id").toString();

//     // prefs.getString('cognito_id').toString();
//     String api = 'login/profile/$cognitoId';

//     var url = baseUrl + api;

//     var body = jsonEncode({'cognito_id': cognitoId});
//     final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
//     CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

//     final identityId = result.userPoolTokensResult.value.userId;
//     AuthUser authuser = await Amplify.Auth.getCurrentUser();

//     String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
//     WidgetHelper.startLoading('');

//     final response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         HttpHeaders.authorizationHeader: authToken,
//       },
//     );
//     // print('response of api ${response.statusCode}');

//     if (response.statusCode == 200) {
//       final docs = json.decode(response.body);

//       // print('response body for user prof $docs');
//       int clid = docs['result']['client_id'];
//       clientStatus =
//           //  'inactive';
//           docs['result']['client_status'].toString();
//       branchStatus =
//           // inactive';
//           docs['result']['branch_status'].toString();
//       String accessrole = docs['result']['access_role'].toString();
//       clientID = clid;
//       clientid = clid;
//       await prefs.setInt('clientId', clid);
//       final uId = docs['result']['user_id'];
//       await prefs.setInt('userId', uId);
//       await prefs.setString("access_role", accessrole);
//       int brid = docs['result']['branch_id'];
//       branchID = brid;

//       uId1 = prefs.getInt('userId')!.toInt();
//     }

//     clientStatus == 'Active' && branchStatus == 'Active'
//         ? Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const ListAppointmentPage()),
//           )
//         : navigatorKey.currentState!.pushNamed(clientinactive);
//     WidgetHelper.endLoading();
//   }

//   Future<void> login(BuildContext context, String username, String password,
//       String role, String deviceDetail) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     WidgetHelper.startLoading('');
//     try {
//       SignInResult res =
//           await Amplify.Auth.signIn(username: username, password: password);
//       bool loginresult = res.isSignedIn;
//       int clientid = 0;
//       String cognitoId = '';

//       mySession = await Amplify.Auth.fetchAuthSession(
//         // ignore: deprecated_member_use
//         options: const CognitoSessionOptions(getAWSCredentials: true),
//       ) as CognitoAuthSession;

//       await prefs.setBool("loginresult", loginresult);

//       if (res.nextStep.signInStep.name == "confirmSignInWithNewPassword") {
//         navigatorKey.currentState!.pushNamed(firstlogin);
//         WidgetHelper.endLoading();
//       } else {}
//       final cognitoPlugin =
//           Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
//       CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

//       final identityId = result.userPoolTokensResult.value.userId;
//       AuthUser authuser = await Amplify.Auth.getCurrentUser();

//       String authToken =
//           result.userPoolTokensResult.value.idToken.raw.toString();

//       await prefs.setString("AuthToken", authToken);
//       await prefs.setString("cognito_id", identityId);

//       if (res.isSignedIn) {
//         // ignore: use_build_context_synchronously
//         await getProfileStatus(context);

//         var wsChannel = WebSocketChannel.connect(
//           Uri.parse(
//               'wss://sockets.development.evalifecare.com?cognito_id=$cognitoId&client_id=$clientid'),
//         );

//         wschannel = wsChannel;
//         // ignore: use_build_context_synchronously

//         getWebSoc() {
//           wsChannel.stream.listen((message) {
//             Map<String, dynamic> responseMap = json.decode(message);
//           });
//         }

//         getWebSoc();
//       }
//     } on AuthException catch (e) {
//       // print("error : " + e.message.toString());
//       if (e.message == 'Incorrect username or password.') {
//         Fluttertoast.showToast(msg: 'Incorrect username or password');
//         WidgetHelper.endLoading();
//       } else if (e.message.toString() == 'A user is already signed in.' &&
//           clientStatus == 'Active' &&
//           branchStatus == 'Active') {
//         // ignore: use_build_context_synchronously
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const ListAppointmentPage()),
//         );
//         // navigatorKey.currentState!.pushNamed(listappointmentspage);
//       }
//       String loginMsg = e.message.toString();
//       await prefs.setString('loginmsg', loginMsg);

//       WidgetHelper.endLoading();
//     }
//     WidgetHelper.endLoading();
//   }

//   Future<dynamic> changepassword(String oldpass, String newpass) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String endurl = 'user/password';
//     String url = baseUrl + endurl;

//     // prefs.clear();s
//     final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
//     CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();
//     String authToken = result.userPoolTokensResult.value.accessToken.toString();
//     String token = prefs.getString("AuthToken").toString();
//     WidgetHelper.startLoading('');

//     final response = await Amplify.Auth.updatePassword(
//         oldPassword: oldpass, newPassword: newpass);

//     WidgetHelper.endLoading();
//   }

//   Future<void> signOutCurrentUser() async {
//     WidgetHelper.startLoading('');

//     final result = await Amplify.Auth.signOut();

//     if (result is CognitoCompleteSignOut) {
//       navigatorKey.currentState?.pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//         (route) => false,
//       );
//     } else if (result is CognitoFailedSignOut) {
//       safePrint('Error signing user out: ${result.exception.message}');
//     }
//     WidgetHelper.endLoading();
//   }

//   Future<void> resetPassword(String username) async {
//     WidgetHelper.startLoading('');

//     try {
//       final result = await Amplify.Auth.resetPassword(
//         username: username,
//       );
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       // prefs.clear();s
//       prefs.setString("username", username);
//       await _handleResetPasswordResult(result);
//     } on AuthException catch (e) {
//       safePrint('Error resetting password: ${e.message}');
//     }
//     WidgetHelper.endLoading();
//   }

//   Future<void> _handleResetPasswordResult(ResetPasswordResult result) async {
//     switch (result.nextStep.updateStep) {
//       case AuthResetPasswordStep.confirmResetPasswordWithCode:
//         final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
//         navigatorKey.currentState!.pushNamed(otpverification);

//         _handleCodeDelivery(codeDeliveryDetails);
//         break;
//       case AuthResetPasswordStep.done:
//         safePrint('Successfully reset password');
//         break;
//     }
//   }

//   void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
//     safePrint(
//       'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
//       'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
//     );
//   }

//   Future<bool> confirmlogin(
//       {required String password, required BuildContext context}) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.clear();s
//     prefs.setString("password", password);
//     WidgetHelper.startLoading('');

//     try {
//       SignInResult res =
//           await Amplify.Auth.confirmSignIn(confirmationValue: password);

//       // print('response of new login^^^^^^^^^${res.toString()}');

//       if (res.isSignedIn) {
//         final cognitoPlugin =
//             Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
//         CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

//         final identityId = result.userPoolTokensResult.value.userId;
//         await prefs.setString("cognito_id", identityId);

//         await getProfileStatus(context);
//         navigatorKey.currentState!.pushNamed(listappointmentspage);
//       }
//     } on AuthException catch (e) {
//       // print("error : " + e.message.toString());
//       Fluttertoast.showToast(msg: e.message.toString());
//       if (e.message.toString() ==
//           'Invalid session for the user, session is expired.') {
//         navigatorKey.currentState!.pushNamed(loginpage);
//       }
//     } finally {
//       WidgetHelper.endLoading();
//     }
//     return false;
//   }

//   Future<void> confirmResetPassword({
//     required String newPassword,
//     required String confirmationCode,
//   }) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.clear();s

//     String usrname = prefs.getString("username").toString();
//     WidgetHelper.startLoading('');

//     try {
//       final result = await Amplify.Auth.confirmResetPassword(
//         username: usrname,
//         newPassword: newPassword,
//         confirmationCode: confirmationCode,
//       );
//       safePrint('Password reset complete: ${result.isPasswordReset}');
//       if (result.isPasswordReset) {
//         navigatorKey.currentState!.pushNamed(loginpage);
//       }
//     } on AuthException catch (e) {
//       safePrint('Error resetting password: ${e.message}');
//       if (e.message ==
//           'Password does not conform to policy: Password not long enough') {
//         Fluttertoast.showToast(
//             msg:
//                 'Password must have: 1. 8 characters long 2. one special character 3. one number 4.  one capital letter 5. small letter',
//             timeInSecForIosWeb: 3);
//       } else if (e.message ==
//           'Attempt limit exceeded, please try after some time.') {
//         Fluttertoast.showToast(
//             msg: 'Attempt limit exceeded, please try after some time.',
//             timeInSecForIosWeb: 2);
//         navigatorKey.currentState!.pushNamed(forgotpassword);
//       }
//     }
//     WidgetHelper.endLoading();
//   }

//   void saveTokenToSharedPreferences(String token, String apiToken) async {
//     SharedPreferences prefsToken = await SharedPreferences.getInstance();
//     prefsToken.setString("Device-Token", token);
//   }
// }

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/core/errors/exceptions.dart';
import 'package:eva_life_care/features/Routes/routeNames.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_idproof.dart';
import 'package:eva_life_care/features/book%20appointment/business/entities/list_service.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/list_service_model.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_idproof_provider.dart';
import 'package:eva_life_care/features/book%20appointment/presentation/providers/list_service_provider.dart';
import 'package:eva_life_care/features/list_appointment/data/models/list_appointment_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/pages/login_page.dart';
import 'package:eva_life_care/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

String baseUrl = dotenv.env['baseUrlForApi'].toString();
var wschannel;
var mySession;
int clientID = 0;
int uId1 = 0;
List<Result> listOfService = [];
ListServiceEntity? listservice1;
int branchID = 0;

List listOfidproof = [];
ListIdProofEntity? listidproof;

List serviceList = [];
String entityName = '';

class LogInProvider extends ChangeNotifier {
  bool followEnable = false;
  late AmplifyAuthCognito auth;
  void setFollowEnable(bool f) {
    followEnable = f;
    notifyListeners(); // Here the magic happens
  }

  dynamic callApi(String url, var model, String type) async {
    final http.Response response;
    try {
      await Amplify.addPlugin(auth);
//       await Amplify.configure(

// );

      // String token = prefs.getString("Api-Token") ?? "No Token Avialable";
      final mySession = await Amplify.Auth.fetchAuthSession(
        // ignore: deprecated_member_use
        options: const CognitoSessionOptions(getAWSCredentials: true),
      ) as CognitoAuthSession;
      // ignore: deprecated_member_use
      final accessToken = mySession.userPoolTokens?.idToken;
      // (mySession as CognitoAuthSession).userPoolTokens?.idToken ?? "N/A";

      if (type == "GET") {
        response = await http.get(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: accessToken.toString(),
          },
        );
      } else {
        response = await http.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              HttpHeaders.authorizationHeader: accessToken.toString(),
            },
            body: jsonEncode(model));
      }
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<ListAppointmentModel> getListAppointment(
      {BuildContext? context,
      required bool? isPulledDown,
      required bool? isFilter,
      required String? name,
      required String? mobile,
      required String? service}) async {
    Dio dio = Dio();
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     // Do something before request is sent
    //     return handler.next(options); // continue
    //   },
    //   onResponse: (response, handler) {
    //     // Do something with response data
    //     return handler.next(response); // continue
    //   },
    //   onError: (DioError e, handler) {
    //     WidgetHelper.endLoading();
    //     // Handle DioError (including network errors)
    //     if (e.type == DioErrorType.connectTimeout ||
    //         e.type == DioErrorType.receiveTimeout ||
    //         e.type == DioErrorType.sendTimeout ||
    //         e.type == DioErrorType.other) {
    //       // Network error occurred
    //       showDialog(
    //         context: context!,
    //         builder: (context) => AlertDialog(
    //           title: const Text('Error'),
    //           content: const Text('Check your internet connection.'),
    //           actions: [
    //             TextButton(
    //               onPressed: () => Navigator.pop(context),
    //               child: const Text('OK'),
    //             ),
    //           ],
    //         ),
    //       );
    //     }
    //     return handler.next(e); // continue
    //   },
    // ));
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl =
        'appointment?client_id=$clientID&branch_id=$branchID&name=$name&mobile=$mobile&service=$service';
    final String finalurl = baseUrl + endUrl;
    final res;
    isPulledDown! || isFilter! ? null : WidgetHelper.startLoading('');
    bool isConnected =
        await NetworkInfoImpl(DataConnectionChecker()).isConnected;
    !isConnected ? WidgetHelper.endLoading() : null;

    final response = await dio.get(finalurl,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));
    WidgetHelper.endLoading();

    if (response.statusCode == 404) {
      isFilter!
          ? Fluttertoast.showToast(
              msg: 'Data not found!', gravity: ToastGravity.TOP)
          : null;
      WidgetHelper.endLoading();
    } else if (response.statusMessage.toString() == "failed!") {
      Fluttertoast.showToast(msg: 'No data available! !');
    } else if (response.statusCode == 200) {
      isFilter!
          ? Fluttertoast.showToast(
              msg: 'Data found!', gravity: ToastGravity.TOP)
          : null;
      WidgetHelper.endLoading();

      return ListAppointmentModel.fromJson(response.data);
    }

    WidgetHelper.endLoading();

    throw ServerException();
  }

  fetchService(BuildContext context) async {
    serviceList = [];
    Provider.of<ListServiceProvider>(context, listen: false)
        .eitherFailureOrListService(clientid: 1);

    listservice1 =
        // ignore: await_only_futures
        await Provider.of<ListServiceProvider>(context, listen: false)
            .listservice;
    listOfService = listservice1!.result;
    // for (int i = 0; i <= listservice!.result.length - 1; i++) {
    //   listOfService.add(
    //       '${listservice!.result[i].name} ${listservice!.result[i].amount.toString()}');
    // }

    for (int i = 0; i <= listOfService.length - 1; i++) {
      serviceList.add(listOfService[i].name);
    }
  }

  fetchId(BuildContext context) async {
    listOfidproof = [];

    Provider.of<ListIdProofProvider>(context, listen: false)
        .eitherFailureOrListIdProof(
      clientid: clientID,
    );

    // ignore: await_only_futures
    listidproof = await Provider.of<ListIdProofProvider>(context, listen: false)
        .listidproof;
    for (int i = 0; i <= listidproof!.result.length - 1; i++) {
      listOfidproof.add(listidproof!.result[i].documentName);
    }
  }

  // Future<ListAppointmentModel> getListAppointment() async {

  // }

  // getAptList(context) {
  //   WidgetHelper.startLoading('');

  //   ListAppointmentEntity? listApt;

  //   aptlist = [];
  //   Provider.of<ListAppointmentProvider>(context, listen: false)
  //       .eitherFailureOrListAppointment();
  //   var entity = Provider.of<ListAppointmentProvider>(context, listen: false)
  //       .listAppointment;
  //   listApt = entity;

  //   for (int i = 0; i <= listApt!.result.length - 1; i++) {
  //     aptlist.add(listApt.result[i] as ResultAptList);
  //     print('lis apts=============$aptlist');
  //   }
  //   WidgetHelper.endLoading();
  // }

  getProfileStatus(context) async {
    LogInProvider loginprovider = LogInProvider();

    int clientid = 0;
    String cognitoId = '';

    String clientStatus = '';
    // / docs['result']['client_status'];
    String branchStatus = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('checkid', true);

    cognitoId = prefs.getString("cognito_id").toString();

    // prefs.getString('cognito_id').toString();
    String api = 'login/profile/$cognitoId';

    var url = baseUrl + api;

    var body = jsonEncode({'cognito_id': cognitoId});
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    final identityId = result.userPoolTokensResult.value.userId;
    AuthUser authuser = await Amplify.Auth.getCurrentUser();

    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    WidgetHelper.startLoading('');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: authToken,
      },
    );
    // print('response of api ${response.statusCode}');

    if (response.statusCode == 200) {
      final docs = json.decode(response.body);

      // print('response body for user prof $docs');
      prefs.setString('Logo', docs['result']['logo']);
      print('logo============${docs['result']['logo']}');
      entityName = docs['result']['entity_name'];
      int clid = docs['result']['client_id'];
      clientStatus =
          //  'inactive';
          docs['result']['client_status'].toString();
      branchStatus =
          // inactive';
          docs['result']['branch_status'].toString();
      String accessrole = docs['result']['access_role'].toString();
      clientID = clid;
      clientid = clid;
      await prefs.setInt('clientId', clid);
      final uId = docs['result']['user_id'];
      await prefs.setInt('userId', uId);
      await prefs.setString("access_role", accessrole);
      int brid = docs['result']['branch_id'];
      branchID = brid;

      uId1 = prefs.getInt('userId')!.toInt();
    }

    clientStatus == 'Active' && branchStatus == 'Active'
        ? navigatorKey.currentState!.pushNamed(listappointmentspage)
        : navigatorKey.currentState!.pushNamed(clientinactive);
    WidgetHelper.endLoading();
  }

  Future<void> login(BuildContext context, String username, String password,
      String role, String deviceDetail) async {
    String clientStatus = '';
    // / docs['result']['client_status'];
    String branchStatus = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    WidgetHelper.startLoading('');
    try {
      SignInResult res =
          await Amplify.Auth.signIn(username: username, password: password);
      bool loginresult = res.isSignedIn;
      int clientid = 0;
      String cognitoId = '';

      mySession = await Amplify.Auth.fetchAuthSession(
        // ignore: deprecated_member_use
        options: const CognitoSessionOptions(getAWSCredentials: true),
      ) as CognitoAuthSession;

      await prefs.setBool("loginresult", loginresult);

      if (res.nextStep.signInStep.name == "confirmSignInWithNewPassword") {
        navigatorKey.currentState!.pushNamed(firstlogin);
        WidgetHelper.endLoading();
      }
      final cognitoPlugin =
          Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

      final identityId = result.userPoolTokensResult.value.userId;
      AuthUser authuser = await Amplify.Auth.getCurrentUser();

      String authToken =
          result.userPoolTokensResult.value.idToken.raw.toString();

      await prefs.setString("AuthToken", authToken);
      await prefs.setString("cognito_id", identityId);

      if (res.isSignedIn) {
        // ignore: use_build_context_synchronously
        await getProfileStatus(context);

        var wsChannel = WebSocketChannel.connect(
          Uri.parse(
              'wss://sockets.development.evalifecare.com?cognito_id=$cognitoId&client_id=$clientid'),
        );

        wschannel = wsChannel;
        // ignore: use_build_context_synchronously

        getWebSoc() {
          wsChannel.stream.listen((message) {
            Map<String, dynamic> responseMap = json.decode(message);
          });
        }

        getWebSoc();
      }
    } on AuthException catch (e) {
      // print("error : " + e.message.toString());
      if (e.message == 'Incorrect username or password.') {
        Fluttertoast.showToast(msg: 'Incorrect username or password');
        WidgetHelper.endLoading();
      } else if (e.message.toString() == 'A user is already signed in.' &&
          clientStatus == 'Active' &&
          branchStatus == 'Active') {
        navigatorKey.currentState!.pushNamed(listappointmentspage);
      }
      String loginMsg = e.message.toString();
      await prefs.setString('loginmsg', loginMsg);

      WidgetHelper.endLoading();
    }
    WidgetHelper.endLoading();
  }

  changepassword(BuildContext context, oldpass, String newpass) async {
    WidgetHelper.startLoading('');
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldpass,
        newPassword: newpass,
      ).then((value) async {
        Fluttertoast.showToast(msg: "Password updated!");
        final result = await Amplify.Auth.signOut();

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginPage()));
      });
    } on AuthException catch (e) {
      print('message---------------------${e.message}');
      WidgetHelper.endLoading();
      if (e.message != "Incorrect username or password.") {
        Fluttertoast.showToast(
            msg: "${e.message}", gravity: ToastGravity.CENTER);
      } else {
        Fluttertoast.showToast(
            msg: "Please enter correct password!",
            gravity: ToastGravity.CENTER);
      }
      safePrint('Error updating password: ${e.message}');
    }

    // UpdatePasswordResult resp = await Amplify.Auth.updatePassword(
    //     oldPassword: oldpass, newPassword: newpass);

    // print("change password---------===============-------${resp.toString()}");

    WidgetHelper.endLoading();
  }

  Future<void> signOutCurrentUser() async {
    WidgetHelper.startLoading('');

    final result = await Amplify.Auth.signOut();

    if (result is CognitoCompleteSignOut) {
      Fluttertoast.showToast(
          msg: "User logged out!", gravity: ToastGravity.CENTER);
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
    WidgetHelper.endLoading();
  }

  Future<void> resetPassword(String username) async {
    WidgetHelper.startLoading('');

    try {
      final result = await Amplify.Auth.resetPassword(
        username: username,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.clear();s
      prefs.setString("username", username);
      await _handleResetPasswordResult(result);
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
    }
    WidgetHelper.endLoading();
  }

  Future<void> _handleResetPasswordResult(ResetPasswordResult result) async {
    switch (result.nextStep.updateStep) {
      case AuthResetPasswordStep.confirmResetPasswordWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        navigatorKey.currentState!.pushNamed(otpverification);

        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthResetPasswordStep.done:
        safePrint('Successfully reset password');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<bool> confirmlogin(
      {required String password, required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();s
    prefs.setString("password", password);
    WidgetHelper.startLoading('');

    try {
      SignInResult res =
          await Amplify.Auth.confirmSignIn(confirmationValue: password);

      // print('response of new login^^^^^^^^^${res.toString()}');

      if (res.isSignedIn) {
        final cognitoPlugin =
            Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
        CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

        final identityId = result.userPoolTokensResult.value.userId;
        await prefs.setString("cognito_id", identityId);

        await getProfileStatus(context);
        navigatorKey.currentState!.pushNamed(listappointmentspage);
      }
    } on AuthException catch (e) {
      // print("error : " + e.message.toString());
      Fluttertoast.showToast(msg: e.message.toString());
      if (e.message.toString() ==
          'Invalid session for the user, session is expired.') {
        navigatorKey.currentState!.pushNamed(loginpage);
      }
    } finally {
      WidgetHelper.endLoading();
    }
    return false;
  }

  Future<void> confirmResetPassword({
    required String newPassword,
    required String confirmationCode,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();s

    String usrname = prefs.getString("username").toString();
    WidgetHelper.startLoading('');

    try {
      final result = await Amplify.Auth.confirmResetPassword(
        username: usrname,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      safePrint('Password reset complete: ${result.isPasswordReset}');
      if (result.isPasswordReset) {
        navigatorKey.currentState!.pushNamed(loginpage);
      }
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
      if (e.message ==
          'Password does not conform to policy: Password not long enough') {
        Fluttertoast.showToast(
            msg:
                'Password must have: 1. 8 characters long 2. one special character 3. one number 4.  one capital letter 5. small letter',
            timeInSecForIosWeb: 3);
      } else if (e.message ==
          'Attempt limit exceeded, please try after some time.') {
        Fluttertoast.showToast(
            msg: 'Attempt limit exceeded, please try after some time.',
            timeInSecForIosWeb: 2);
        navigatorKey.currentState!.pushNamed(forgotpassword);
      }
    }
    WidgetHelper.endLoading();
  }

  void saveTokenToSharedPreferences(String token, String apiToken) async {
    SharedPreferences prefsToken = await SharedPreferences.getInstance();
    prefsToken.setString("Device-Token", token);
  }
}
