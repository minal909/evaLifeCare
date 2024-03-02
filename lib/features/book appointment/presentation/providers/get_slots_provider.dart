import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/core/errors/exceptions.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SlotsListProvider extends ChangeNotifier {
  final Dio dio = Dio();

  Future getSlotsList(
      {required int userid,
      required int branchid,
      required String date}) async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    userid == 0 && branchid == 0
        ? Fluttertoast.showToast(msg: 'Please select doctor to get time slots')
        : WidgetHelper.startLoading("Fetching slots!");

    String endUrl =
        'appointment/slots?user_id=$userid&branch_id=$branchid&date=$date';
    final String finalurl = baseUrl + endUrl;

    final response = await dio.get(finalurl,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));
    notifyListeners();

    if (response.statusCode == 200) {
      WidgetHelper.endLoading();

      return response.data;
    } else {
      WidgetHelper.endLoading();

      throw ServerException();
    }
  }
}
