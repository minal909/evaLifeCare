import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/features/my_profile/data/models/my_profile_model.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

abstract class MyProfileRemoteDataSource {
  Future<MyProfile> getMyProfile({required MyProfileParams myProfileParams});
}

class MyProfileRemoteDataSourceImpl implements MyProfileRemoteDataSource {
  final Dio dio;

  MyProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<MyProfile> getMyProfile(
      {required MyProfileParams myProfileParams}) async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl = 'user/$clientID/$uId1';
    final String finalurl = baseUrl + endUrl;
    final response = await dio.get(finalurl,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    if (response.statusCode == 200) {
      return MyProfile.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
