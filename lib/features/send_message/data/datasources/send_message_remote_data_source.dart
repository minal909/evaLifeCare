import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/send_message/data/models/sendmessage_model.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

abstract class SendMessageRemoteDataSource {
  Future<SendMessage> getSendMessage(
      {required SendMessageParams sendMessageParams});
}

class SendMessageRemoteDataSourceImpl implements SendMessageRemoteDataSource {
  final Dio dio;

  SendMessageRemoteDataSourceImpl({required this.dio});

  @override
  Future<SendMessage> getSendMessage(
      {required SendMessageParams sendMessageParams}) async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl =
        'user/${sendMessageParams.clientid}/${sendMessageParams.userid}';
    final String finalurl = baseUrl + endUrl;

    final response = await dio.get(finalurl,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    if (response.statusCode == 200) {
      return SendMessage.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
