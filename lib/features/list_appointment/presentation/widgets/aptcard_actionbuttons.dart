// ignore_for_file: use_build_context_synchronously

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/Routes/routeNames.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/order_total_entity.dart';
import 'package:eva_life_care/features/list_appointment/presentation/pages/pay_now.dart';
import 'package:eva_life_care/features/list_appointment/presentation/pages/reschedule_appointment.dart';
import 'package:eva_life_care/features/list_appointment/presentation/providers/orderTotal_provider.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ActionButton extends StatelessWidget {
  final String oldDate;
  final String oldTime;
  String billAddress;
  String mobile;
  double? orderSubtotal;
  String status;
  int docid;
  int patientid;
  int aptid;
  String timestamp;
  String invStatus;
  ActionButton(
      this.oldDate,
      this.oldTime,
      this.billAddress,
      this.mobile,
      this.orderSubtotal,
      this.status,
      this.docid,
      this.patientid,
      this.aptid,
      this.timestamp,
      this.invStatus,
      {super.key});

  OrderTotalEntity? getTotal;

  @override
  Widget build(BuildContext context) {
    fetchData(BuildContext context) async {
      await Provider.of<OrderTotalProvider>(context, listen: false)
          .eitherFailureOrOrderTotal(
              orderSubtotal: orderSubtotal, discountApplication: []);
      // ignore: use_build_context_synchronously
      getTotal =
          // ignore: use_build_context_synchronously
          Provider.of<OrderTotalProvider>(context, listen: false).orderTotal;
    }

    Dio dio = Dio();

    Size deviceSize = MediaQuery.of(context).size;

    return PopupMenuButton(
      color: Colors.white,
      child: const Icon(
        Icons.more_vert,
        color: Colors.black,
        size: 25,
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          onTap: () {
            status == 'CANCELLED'
                ? null
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RescheduleAppointment(
                          oldDate: oldDate,
                          oldTime: oldTime,
                          aptid: aptid,
                          oldTimeStamp: timestamp,
                          userid: docid,
                          patientid: patientid,
                        )));
          },
          // value: "en",

          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(1),
              child: Icon(
                Icons.restore,
                size: 18,
                color: status == 'CANCELLED'
                    ? Colors.grey
                    : Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 15),
            Text("Reschedule",
                style: TextStyle(
                  color: status == 'CANCELLED'
                      ? Colors.grey
                      : Theme.of(context).colorScheme.onPrimary,
                )),
          ]),
        ),
        PopupMenuItem(
          // value: "de",
          onTap: () async {
            await fetchData(context);

            status == 'CANCELLED'
                // ignore: use_build_context_synchronously
                ? null
                : invStatus == "Paid"
                    ? Fluttertoast.showToast(
                        msg: "Payment already done",
                        gravity: ToastGravity.CENTER)
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PayNow(aptid, patientid,
                            billAddress, mobile, orderSubtotal, getTotal)));

            // Provider.of<MyAuthProvider>(context, listen: false)
            //     .signOutCurrentUser();
            // wschannel.sink.close();
          },
          child: Row(
            children: [
              Icon(Icons.payments,
                  size: 18,
                  color: status == 'CANCELLED' || invStatus == "Paid"
                      ? Colors.grey
                      : Theme.of(context).colorScheme.onPrimary

                  // color: greencolor,
                  ),
              const SizedBox(width: 15),
              Text("Pay now",
                  style: TextStyle(
                      color: status == 'CANCELLED' || invStatus == "Paid"
                          ? Colors.grey
                          : Theme.of(context).colorScheme.onPrimary)),
            ],
          ),
        ),
        PopupMenuItem(
          // value: "de",
          onTap: () {
            Future<void> showCancelDialog(BuildContext context) async {
              return showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap a button to dismiss
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(4), // Adjust the radius here
                    ),
                    title: const Text('Cancel Confirmation'),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Are you sure you want to cancel appointment?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                bool isConnected = await NetworkInfoImpl(
                                        DataConnectionChecker())
                                    .isConnected;

                                final cognitoPlugin = Amplify.Auth.getPlugin(
                                    AmplifyAuthCognito.pluginKey);
                                CognitoAuthSession result =
                                    await cognitoPlugin.fetchAuthSession();

                                String authToken = result
                                    .userPoolTokensResult.value.idToken.raw
                                    .toString();
                                String endUrl = 'appointment';
                                final String finalurl = baseUrl + endUrl;
                                Map<String, dynamic> requestBody = {
                                  "appointment_id": aptid,
                                  "client_id": clientID,
                                  "branch_id": branchID,
                                  "user_id": docid,
                                  "patient_id": patientid,
                                  "appointment_timestamp": timestamp

                                  // Add other optional parameters here
                                };

                                // Handle the "Yes" option here
                                // You can add your cancel logic or any other action
                                cancelApt() async {
                                  WidgetHelper.startLoading('Cancelling');

                                  await dio.delete(finalurl,
                                      data: requestBody,
                                      options: Options(headers: {
                                        'Authorization': 'Bearer $authToken'
                                      }));
                                  WidgetHelper.endLoading();
                                  Fluttertoast.showToast(
                                      msg: 'Cancelled!',
                                      gravity: ToastGravity.CENTER);
                                  navigatorKey.currentState!
                                      .pushNamed(listappointmentspage);
                                  WidgetHelper.endLoading();
                                }

                                showError() {
                                  Fluttertoast.showToast(
                                      msg: "No internet connection!",
                                      gravity: ToastGravity.CENTER);
                                  Navigator.pop(context);
                                }

                                isConnected ? cancelApt() : showError();
                              },
                              child: const Text('Yes'),
                            ),
                          ]),
                    ],
                  );
                },
              );
            }

            status != 'CANCELLED' ? showCancelDialog(context) : null;
          },
          child: Row(
            children: [
              Icon(
                Icons.cancel,
                size: 18,
                color: status != 'CANCELLED'
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.grey,

                // color: greencolor,
              ),
              const SizedBox(width: 15),
              Text("Cancel",
                  style: TextStyle(
                      color: status != 'CANCELLED'
                          ? Theme.of(context).colorScheme.onPrimary
                          : Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
