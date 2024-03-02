import 'package:dio/dio.dart';
import 'package:eva_life_care/features/my_profile/data/models/update_profile_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

bool profile = false;

abstract class UpdateProfileRemoteDataSource {
  Future<UpdateProfile> getUpdateProfile(
      {required UpdateProfileParams updateProfileParams});
}

class UpdateProfileRemoteDataSourceImpl
    implements UpdateProfileRemoteDataSource {
  final Dio dio;

  UpdateProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<UpdateProfile> getUpdateProfile(
      {required UpdateProfileParams updateProfileParams}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int clientId = prefs.getInt('clientId')!.toInt();
    int userId = prefs.getInt('userId')!.toInt();

    String token = prefs.getString('authToken').toString();
    String endUrl = 'user';
    final String finalurl = baseUrl + endUrl;

    // Existing parameters that are necessary for the request
    final Map<String, dynamic> requiredParameters = {
      "client_id": updateProfileParams.clientid,
      "user_id": updateProfileParams.userid,
      "cognito_id": updateProfileParams.cognitoid,
    };

// Optional parameters that may or may not change
    Map<String, dynamic> optionalParameters = {
      "email": updateProfileParams.email,
      "mobile": updateProfileParams.mobile,
      "firstname": updateProfileParams.firstname,
      "lastname": updateProfileParams.lastname,
      "access_role": updateProfileParams.accessrole,
      "age": updateProfileParams.age,
      "gender": updateProfileParams.gender,
      "address_line1": updateProfileParams.addressline1,
      "address_line2": updateProfileParams.addressline2,
      "country": updateProfileParams.country,
      "state": updateProfileParams.state,
      "city": updateProfileParams.city,
      "zip_code": updateProfileParams.zipcode,
      "designation": updateProfileParams.designation,
      "department": updateProfileParams.department,
      "branch_id": updateProfileParams.branchid,
      // Add other optional parameters here
    };
    var response;
// Filter out null or unchanged values from optionalParameters
    optionalParameters.removeWhere(
        (key, value) => value == null || requiredParameters[key] == value);

// Combine required and optional parameters to create the final request body
    final Map<String, dynamic> requestBody = {
      ...requiredParameters,
      ...optionalParameters
    };
    response = await dio
        .patch(
      finalurl,
      data: requestBody,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    )
        .then((value) {
      WidgetHelper.startLoading("");
      print('valis ---------66--------$value');
      if (value.statusCode == 200) {
        profile = true;
        Fluttertoast.showToast(
            msg: 'Profle updated successfully !', gravity: ToastGravity.CENTER);
        Navigator.of(updateProfileParams.context).push(MaterialPageRoute(
            builder: (context) => updateProfileParams.widget));
        WidgetHelper.endLoading();

        return UpdateProfile.fromJson(value.data);
      } else if (value.statusMessage.toString() == "User not updated") {
        WidgetHelper.endLoading();

        Fluttertoast.showToast(msg: 'Profile not updated !');
      } else if (value.statusCode != 200) {
        WidgetHelper.endLoading();

        Fluttertoast.showToast(msg: 'Failed to update profile !');
      }
    });
    WidgetHelper.endLoading();

    // queryParameters: {
    //   'api_key': 'if needed',
    // },

    {
      throw ServerException();
    }
  }
}
