import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/list_doctor_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';

abstract class ListDoctorRemoteDataSource {
  Future<ListDoctorModel> getListDoctor({required ListDoctorParams params});
}

class ListDoctorRemoteDataSourceImpl implements ListDoctorRemoteDataSource {
  final Dio dio;

  ListDoctorRemoteDataSourceImpl({required this.dio});

  @override
  Future<ListDoctorModel> getListDoctor(
      {required ListDoctorParams params}) async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();
    List doctor = [];
    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl = 'client/$clientID/doctor?service_id=${params.serviceId}';
    final String finalurl = baseUrl + endUrl;
    WidgetHelper.startLoading('');
    final response = await dio.get(finalurl,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    if (response.statusCode == 200) {
      WidgetHelper.endLoading();
      return ListDoctorModel.fromJson(response.data);
    } else {
      WidgetHelper.endLoading();
      if (response.statusCode == 404) {
        Fluttertoast.showToast(
          msg: "Resource not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
      throw ServerException();
    }
  }
}
