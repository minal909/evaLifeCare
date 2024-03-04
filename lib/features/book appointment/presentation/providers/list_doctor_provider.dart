import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/core/errors/exceptions.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/existing_patient_model.dart';

import 'package:eva_life_care/features/book%20appointment/data/models/list_doctor_model.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';

import 'package:flutter/material.dart';

class ListDoctorProvider extends ChangeNotifier {
  Future<ListDoctorModel> getListDoctor(
      {required int clientid, required int serviceid}) async {
    final Dio dio = Dio();

    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();
    List doctor = [];
    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl = 'client/$clientid/doctor?service_id=$serviceid';
    final String finalurl = baseUrl + endUrl;

    final response = await dio.get(finalurl,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));
    notifyListeners();

    if (response.statusCode == 200) {
      return ListDoctorModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<ExistingPatientModel> getUserSuggestions(String mobile) async {
    final Dio dio = Dio();

    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();
    List doctor = [];
    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl = 'search/patient';
    final String finalurl = baseUrl + endUrl;
    Map<String, dynamic> requestBody = {
      "client_id": clientID,
      "mobile": mobile

      // Add other optional parameters here
    };

    final response = await dio.post(finalurl,
        data: requestBody,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    if (response.statusCode == 200) {
      return ExistingPatientModel.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  // static FutureOr<List<Result?>> searchExistingPatient(String mobile) async {
  //   final Dio dio = Dio();

  //   final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
  //   CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();
  //   List doctor = [];
  //   String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
  //   String endUrl = 'search/patient';
  //   final String finalurl = baseUrl + endUrl;
  //   Map<String, dynamic> requestBody = {
  //     "client_id": clientID,
  //     "mobile": mobile

  //     // Add other optional parameters here
  //   };

  //   final response = await dio.post(finalurl,
  //       data: requestBody,
  //       options: Options(headers: {'Authorization': 'Bearer $authToken'}));

  //   if (response.statusCode == 200) {
  //     List name = response.data['result'];
  //     List number = [];
  //     for (int i = 0; i <= name.length - 1; i++) {
  //       number.add(name[i]['mobile']);
  //     }

  //     // return users.map((json) => User.fromJson(json)).where((user) {
  //     //   final nameLower = user.name.toLowerCase();
  //     //   final queryLower = query.toLowerCase();

  //     //   return nameLower.contains(queryLower);
  //     // }).toList();

  //     // return number;
  //     return number;
  //   } else {
  //     throw ServerException();
  //   }
  // }
}
