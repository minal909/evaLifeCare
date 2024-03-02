import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/Routes/routeNames.dart';
import 'package:eva_life_care/features/list_appointment/data/models/reschedule_model.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

abstract class RescheduleRemoteDataSource {
  Future<RescheduleModel> getReschedule({
    required RescheduleParams params,
  });
}

class RescheduleRemoteDataSourceImpl implements RescheduleRemoteDataSource {
  final Dio dio;

  RescheduleRemoteDataSourceImpl({required this.dio});

  @override
  Future<RescheduleModel> getReschedule(
      {required RescheduleParams params}) async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    final Map<String, dynamic> requestParameters = {
      "client_id": clientID,
      "branch_id": branchID,
      "user_id": params.userid,
      "patient_id": params.patientid,
      "old_appointment_timestamp": params.oldtimestamp,
      "new_appointment_timestamp": params.newtimestamp
    };
    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl = '/appointment/${params.aptid}';
    final String finalurl = baseUrl + endUrl;
    final response = await dio.patch(finalurl,
        data: requestParameters,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Appointment rescheduled successfully!");
      navigatorKey.currentState!.pushNamed(listappointmentspage);
      return RescheduleModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
