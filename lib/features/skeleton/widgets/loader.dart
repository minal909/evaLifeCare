import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';

class WidgetHelper {
  static toast(String message, int i) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: i == 1 ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static String dateWithLeadingZeros(DateTime dateTime) {
    String date = "";
    date = "$date${dateTime.year}-";
    date = date +
        (dateTime.month <= 9 ? "0${dateTime.month}-" : "${dateTime.month}");
    date = date + (dateTime.day <= 9 ? "0${dateTime.day}" : "${dateTime.day}");

    return date;
  }

  static void startLoading(String message) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
    EasyLoading.show(
      status: message,
      maskType: EasyLoadingMaskType.clear,
    );
  }

  static void endLoading() {
    EasyLoading.dismiss();
  }

  static String formatDate(DateTime dateTime, String format) {
    return DateFormat(
      format,
    ).format(dateTime);
  }

  // static showDatePicker(BuildContext c) async {
  //   DateTime? date = await DatePicker.showDatePicker(c,
  //       showTitleActions: true,
  //       minTime: DateTime(DateTime.now().year-1),
  //       maxTime: DateTime(DateTime.now().year+2), onChanged: (date) {
  //     print('change $date');
  //   }, onConfirm: (date) {
  //     print('confirm $date');
  //   }, currentTime: DateTime.now(), locale: LocaleType.en);
  //   return date!;
  // }
}
