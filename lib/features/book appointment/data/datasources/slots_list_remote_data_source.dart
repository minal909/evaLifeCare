import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/slots_list_model.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';

abstract class SlotsListRemoteDataSource {
  Future<SlotsListModel> getSlotsList({required SlotsListParams params});
}

class SlotsListRemoteDataSourceImpl implements SlotsListRemoteDataSource {
  final Dio dio;

  SlotsListRemoteDataSourceImpl({required this.dio});

  @override
  Future<SlotsListModel> getSlotsList({required SlotsListParams params}) async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl =
        'appointment/slots?user_id=${params.userid}&branch_id=${params.branchid}&date=${params.date}';
    final String finalurl = baseUrl + endUrl;
    final response = await dio.get(finalurl,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    if (response.statusCode == 200) {
      return SlotsListModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
